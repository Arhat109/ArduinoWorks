/**
 * Extended Memory Sram (ems)
 *
 * !!! ВНИМАНИЕ: требует специального скрипта для линковщика с описанием секций RAM
 *
 * Тестовый код для управления внешней SRAM 512кбайт.
 * Организация SRAM:
 * PORTA -- AD0..7 совмещенная шина адреса/данных стробируется сигналом ALE
 * регистры управления:
 * XMCRA (0x0074):
 *    7     6     5     4     3      2      1      0
 *   SRE, SRL2, SRL1, SRL0, SRW11, SRW10, SRW01, SRW00
 *
 * SRE - разрешает работу интерфейса,
 * SRL2:0 - граница нижнего/верхнего сегмента (адресного пространства {0,1:all upper, 2-7:0x4000..0xE000 upper},
 * SRW1x - количество доп. тактов ожидания для верхнего сегмента,
 * SRW0x - оно же для нижнего, если он есть.
 *
 * XMCRB (0x0075):
 *     7          2     1     0
 *   XMBK, ххх, XMM2, XMM1, XMM0
 *
 * XMBK - удекрживать данные на шине между тактами и адресом/данных (не переводить в Hz),
 * XMMx - ширина шины адреса {0-all 16бит = 64k;1-PC7 не исп. 15бит 32k; 2-PC6 16k,..7-only 8 bit address без порта C)
 *
 * SRAM512kb имеет дополнительно:
 * 1. Регистр номеров страниц: старшая тетрада - 0..15 верхнее окно 0xC000, младшая тетрада - 0..15 нижнее окно 0x8000
 *    Запись в регистр страниц: вручную, через PORTA при !RD = !WR = 0, то есть номер проходит в регистр, если оба сигнала LOW
 *      и защелкивается при записи HIGH в любой из пинов !RD, !WR или оба сразу.
 *    Чтение регистра страниц - не предусмотрено.
 *    Но из него есть комбинированный вывод 4 бит (0xF, старших или младших), в зависимости от PC7,PC6:00|01=>F, 10=>low, 11=>high;
 *    то есть, младшие 32к адресов (PC7=0) выдают F, а старшие (PC7=1) в зависимости от PC6 младшую или старшую тетраду.
 * 2. Регистр защелка сладшей части адреса. Используется интерфейсом самостоятельно, но можно использовать вручную при дополнительно,
 *    при отключенном интерфейсе: PORTA записывается в регистр при ALE=1 и защелкивается в нем при ALE=0. Этот регистр имеет свои
 *    отдельные выводы на шине расширения памяти, также как регистр страниц.
 *    
 * @author Arhat109
 */
#include <util/delay.h>
// полезный, удобный макрос: собирает байт из младших полубайтов со сдвигами..
#define makeByte(h,l) (((((uint8_t)(h))<<4)&0xF0)|(((uint8_t)(l))&0x0F))

// определяем где и что находится у микроконтроллера (ATmega2560):
// 19 линий интерфейса внешней SRAM:
#define EMS_ALE         PG2
#define EMS_RD          PG1
#define EMS_WR          PG0
#define EMS_PORT_BUS    PORTG
#define EMS_DDR_BUS     DDRG
#define EMS_PORT_AD     PORTA
#define EMS_DDR_AD      DDRA
#define EMS_PORT_ADR    PORTC
#define EMS_DDR_ADR     DDRC

// последние адреса окон памяти и размеры окон:
// [0-8.5k[ - "own page"(internal SRAM); [8.5k-32k[ - "common page";
// [32k-48k[ - "low page"; [48k-64k[ - "high page".
#define EMS_OWN_END     (0x21FF)
#define EMS_COMMON_END  (0x7FFF)
#define EMS_LP_END      (0xBFFF)
#define EMS_HP_END      (0xFFFF)

#define SIZE_COMMONS (EMS_COMMON_END - EMS_OWN_END)
#define SIZE_LOWS    (EMS_LP_END - EMS_COMMON_END)
#define SIZE_HIGHS   (EMS_HP_END - EMS_LP_END)

// Доступные секции памяти (удобства для), см. спец. секции в расширении файла линковщика:
// На самом деле есть только 4 типа адресов (окон у процессора):
// внутренняя память, общий блок до 32кбайт и нижние/верхние окна для подключения страниц..
// Данные, обьявленные:
// а) без указания страницы - размещается во внутренеей памяти (секции .data, .bss, @see avr6.x):
// б) EMS_COMMON -- в общем блоке от конца internal до 32767-го байта включительно;
// в) EMS_LOW()  -- [0,15] -- размещение в "нижних" сегментах по 16кб с адреса 0x8000
// г) EMS_HIGH() -- [0,15] -- размещение в "верхних" сегментах по 16кб с адреса 0xC000
// Внимательно! последние страницы (15) - это тот же блок что и COMMON,
// но так можно иметь доступ к его младшим адресам, перекрытым внутренней памятью
//
#define EMS_COMMON        __attribute__((section(".cpage")))
#define EMS_LOW(pageNum)  __attribute__((section(".lpage" #pageNum)))
#define EMS_HIGH(pageNum) __attribute__((section(".hpage" #pageNum)))

uint8_t emsPages; // копия регистра страниц в нижней SRAM
uint8_t emsWaits; // количество тактов ожидания интерфейса @see emsOn(_ws);

/** 3t: установка служебных ног интерфейса "на выход" */
#define emsBusOut() (EMS_DDR_BUS |= (1<<EMS_ALE)|(1<<EMS_RD)|(1<<EMS_WR))

/** 3t: разрешение записи в регистр страницы (интерфейс д.быть отключен!) */
#define emsPagesOpen()   (EMS_PORT_BUS &= ~((1<<EMS_WR)|(1<<EMS_RD)))

/** 3t: защелкивание в регистре страниц значения с шины AD (интерфейс д.быть отключен!) */
#define emsPagesLock()   (EMS_PORT_BUS |= ((1<<EMS_WR)|(1<<EMS_RD)))

/** 3t: снятие сигнала ALE при ручном управлении */
#define emsAleOff()      (EMS_PORT_BUS &= ~(1<<EMS_ALE))

/** 3t: установка ALE при ручном управлении */
#define emsAleOn()       (EMS_PORT_BUS |= (1<<EMS_WR))

/**
 * Настройка шины на ручное управление (запись номеров страниц)
 * 
 * @param uint8_t _ws -- wait states for interface
 * @time 6t
 */
#define emsSetup()    \
{                     \
  EMS_DDR_AD = 0xFF;  \
  EMS_DDR_ADR = 0xFF; \
  emsBusOut();        \
}

/** 
 * ТОЛЬКО активация Extended Memory SRAM единым верхним куском без удержания шины
 * ничего другого по даташиту не надо.. само.
 * 
 * @param uint8_t _ws -- wait states for interface
 * @time 8t(const _ws)/7t(register _ws)
 */
#define emsOn(_ws)                            \
{                                             \
  emsWaits = (_ws);                           \
  XMCRA = (1 << SRE) | (((uint8_t)(_ws))<<2); \
  XMCRB = 0;                                  \
}
/**
 * отключалка интерфейса extSRAM
 * @time 1t
 */
#define emsOff() (XMCRA = 0)

/**
 * =================== Макросы сохранения номера страницы в глобал: ================ //
 * @param uint8_t lp,hp,p
 * @time 7t для emsStoreLow(),emsStoreHigh()
 * @time 2t для emsStorePages()
 */
#define emsStoreLow(lp)      (emsPages=(emsPages&0xF0) | ((uint8_t)(lp)&0x0F))
#define emsStoreHigh(hp)     (emsPages=((uint8_t)(hp)&0xF0) | (emsPages&0x0F))
#define emsStorePages(p)     (emsPages=(uint8_t)(p))

/**
 * Собственно запись номеров страниц в регистр для тестирования
 * @time 10t
 */
#define _emsWritePages()            \
{                                   \
  emsPagesOpen();                   \
  EMS_PORT_AD = emsPages;           \
  _delay_loop_1(32);               \
  emsPagesLock();                   \
}

/**
 * =========================== Установка И запись страниц: ======================== //
 * Пишем номера страниц блоков low, high в регистр страниц вручную, отключая extSRAM
 * 
 * @time 35t
 */
void emsWritePages(void)
{
  cli();
  emsOff();         //  1t, отключаем интерфейс extSRAM
  emsSetup();       //  5t, настройка шин для ручной работы
  _emsWritePages(); // 10t, запись страниц в регистр
  emsOn(emsWaits);  // 2+7t, включаем интерфейс, восстанавливая тайминги
  sei();            // 1t+1t+4t+4t (cli+sei+ret+call)
}

/**
 * Запись в регистр страниц номер low page [0..15]
 * 
 * @param uint8_t lowPage
 * @time 38t
 */
#define emsWriteLow(lowPage) \
{                            \
  emsStoreLow(lowPage);      \
  emsWritePages();           \
}

/**
 * Запись в регистр страниц номер high page [0..15]
 * 
 * @param uint8_t highPage
 * @time 38t
 */
#define emsWriteHigh(highPage) \
{                              \
  emsStoreHigh(highPage);      \
  emsWritePages();             \
}

/**
 * Проверяет заданный буфер на совпадение с шаблоном,
 * в случае расхождения вызывает callback().
 * Прерывает работу, если callback() возвращает не 0.
 * 
 * @param void (*)callback(uint16_t _addr, uint8_t _pattern, uint8_t _readed)
 * @return count summary errors
 */
uint16_t emsMemtest(
  uint8_t * _buffer,  // буфер поиска расхождения
  uint16_t  _size,    // размер буфера
  uint8_t   _pattern, // искомый образец
  uint8_t (*callback)(uint8_t *_addr, uint8_t _pattern, uint8_t _readed) // нашел тут это!
){
  uint16_t res = 0;

  do{
    uint8_t tmp = *_buffer;

    if( tmp != _pattern ){
      res++;
      if( callback(_buffer, _pattern, tmp) ) return res;
    }
    _buffer++;
  }while( --_size > 0 );

  return res;
}

// ========================== ТЕСТЫ РУЧНОГО УПРАВЛЕНИЯ: ======================== //

/**
 * в loop():
 * Функция медленной и ручной побитной установки значений на шинах для
 * проверки светодиодами работоспосоности пайки и платы в целом..
 * щелкает сигналом ALE для проверки записи в регистр защелки адреса.
 * Также можно проверить работу мультиплексора адреса от PC6,7
 */
void manualTest()
{
  for(uint8_t bit=0; bit<=7; bit++){
    EMS_PORT_BUS |= (1<<EMS_ALE);  // разрешаем запись
    emsPagesOpen();                // открываем регистр страниц на запись
    EMS_PORT_AD = (1<<bit);        // младшая часть адреса в защелку
    EMS_PORT_BUS &= ~(1<<EMS_ALE); // защелкиваем младшую часть адреса (шина AD)
    delay(500);                    // на посмотреть..
    emsPagesLock();                // защелкиваем и в регистр страниц тоже
    EMS_PORT_ADR = (1<<bit);       // старшая часть адреса отдельно
    delay(500);
  }
}
/**
 * Имитация записи/четния SRAM вручную.
 * Старшая часть адреса - не нужна.
 * Светодиоды: PA0..PA7, ALE, WR, RD
 */
void manualTest2()
{
  PORTC = 0x80;
  for(uint8_t bit=0; bit<=7; bit++){
    EMS_PORT_AD = (1<<bit);        // младшая часть адреса (bit) в защелку
    EMS_PORT_BUS |= (1<<EMS_ALE);  // разрешаем запись адреса
//    delay(250);                    // на посмотреть..
    EMS_PORT_BUS &= ~(1<<EMS_ALE); // защелкиваем младшую часть адреса (шина AD)

    EMS_PORT_AD = ~(1<<bit);       // данные на шину (кроме bit)
    EMS_PORT_BUS &= ~(1<<EMS_WR);  // запись
//    delay(250);
    EMS_PORT_BUS |= (1<<EMS_WR);   // типа записали

//    EMS_PORT_AD = 0;               // гасим все после записи
//    delay(250);

    EMS_PORT_AD = (1<<bit);        // младшая часть адреса снова в защелку
    EMS_PORT_BUS |= (1<<EMS_ALE);  // разрешаем запись адреса
//    delay(250);                    // на посмотреть..
    EMS_PORT_BUS &= ~(1<<EMS_ALE); // защелкиваем младшую часть адреса (шина AD)

    EMS_DDR_AD = 0;                // шина AD на ввод
    EMS_PORT_BUS &= ~(1<<EMS_RD);  // чтение
    delay(300);                    // смотрим что прочли
    EMS_PORT_BUS |= (1<<EMS_RD);   // типа прочли

    EMS_DDR_AD = 0xFF;             // шина AD на вывод
    EMS_PORT_AD = 0;               // гасим все после чтения
  }
}

/**
 * Имитация записи/четния регистра страниц вручную
 * доп. светодиоды на выводах PC6,PC7 и page0..3
 */
void manualTest3()
{
  uint8_t adr=0xC0;

  do{
    EMS_PORT_ADR = adr;  // доступ к первому байту окна

    for(uint8_t page=0; page<=15; page++){
      emsStoreLow(page); // только сохранение номеров страниц!
      _emsWritePages();  // запись, без смены режимов
      manualTest2();     // смотрим чтение/запись и номера страниц
    }
    adr += 0x40;         // второе окно
  }while( (adr==0x80) || (adr==0xC0) );

  do{
    EMS_PORT_ADR = adr;  // доступ к первому байту окна

    for(uint8_t page=0; page<=15; page++){
      emsStoreHigh(page); // только сохранение номеров страниц!
      _emsWritePages();  // запись, без смены режимов
      manualTest2();     // смотрим чтение/запись и номера страниц
    }
    adr += 0x40;         // второе окно
  }while( (adr==0x80) || (adr==0xC0) );
}

// ============================= Простейший тест: ========================== //
volatile uint8_t *adr; // volatile иначе сьест оптимизатор

void simpleTest(void)
{
  uint8_t tmp;

  Serial.println("Simple test started..");
  for( adr=(uint8_t*)(EMS_OWN_END+1); adr<=(uint8_t*)(EMS_OWN_END+10); adr++){
//  for( adr=(uint8_t*)(0x1000); adr<=(uint8_t*)(0x1000+10); adr++){
    *adr = 0xAA;
    tmp = *adr;
    if( tmp != 0xAA ){ Serial.println(tmp, DEC); }
    else             { Serial.println("ok");     }
  }
  Serial.println("Simple test ended");
}

// =========================== ТЕСТОВЫЙ ПРИМЕР ТУТ: ======================== //

// объявляем 3 массива в разных окнах:

uint8_t commons[SIZE_COMMONS] EMS_COMMON;  // 24064 байт от внутренней SRAM в первых 32кбайтах
uint8_t lows[SIZE_LOWS]       EMS_LOW(0);  // 16кбайт от 32к до 48к
uint8_t highs[SIZE_HIGHS]     EMS_HIGH(0); // 16кбайт от 48к до 64к

uint8_t patterns[4] = {0xFF, 0x00, 0xAA, 0x55}; // образцы записи в память

/** собираем из обьявленных массивов пакет для тестирования */
#define MAX_PAGES 3
struct{
  uint8_t * address;
  uint16_t  size;
} pages[MAX_PAGES] = {{commons, SIZE_COMMONS}, {lows, SIZE_LOWS}, {highs, SIZE_HIGHS}};

/**
 * callback() для вывода ошибки сохранения на монитор (и прервать работу)
 */
uint8_t testError(uint8_t *_addr, uint8_t _pattern, uint8_t _readed)
{
  Serial.println();
  Serial.print("ERROR at 0x"); Serial.print((uint16_t)_addr, HEX);
  Serial.print(", pattern="); Serial.print(_pattern, DEC);
  Serial.print(", readed="); Serial.print(_readed, DEC);
  return 0;
}

/**
 * Собственно тест памяти:
 * перебираем образцы, и страницы в пакете, заливаем страницу образцом
 * и проверяем на совпадение с шаблоном
 */
void test(void){
  uint16_t errors;
  uint32_t start;
  
  for(int8_t i=sizeof(patterns)-1; i>=0; --i){
    Serial.println();
    Serial.print(", p="); Serial.print(patterns[i], HEX); 
    for(int page=0; page<MAX_PAGES; page++){
      Serial.print(", PAGE="); Serial.print(page, DEC);
      errors=0;
      start = micros();
      memset(pages[page].address, patterns[i], pages[page].size);
      Serial.print(", t="); Serial.print(micros()-start, DEC);
      start=micros();
      errors = emsMemtest(pages[page].address, pages[page].size, patterns[i], testError);
      Serial.print(", t="); Serial.print(micros()-start, DEC);
      if( errors != 0 ){
        Serial.print(" .. ERROR OCURED=");
        Serial.println(errors, DEC);
      }else{
        Serial.print(" is OK)");
      }
    }
  }
}

// =========================== SETUP() ======================== //

void setup()
{
//  emsSetup();
//  emsAleOff();
//  emsPagesLock();
  emsOn(0);
  Serial.begin(115200);

//  simpleTest();
  test();
}

void loop()
{
//  manualTest();  // ручной тест для проверки пайки
//  manualTest2(); // ручной тест для проверки записи/четния
//  manualTest3();   // листаем страницы и исп. manualTest2()
}

