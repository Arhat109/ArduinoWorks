/**
 * Extended Memory Sram (ems)
 *
 * !!! ВНИМАНИЕ: требует специального скрипта для линковщика с описанием секций RAM
 *
 * Тестовый код для управления внешней SRAM 512кбайт.
 * Организация SRAM:
 * PORTA -- AD0..7 совмещенная шина адреса/данных стробируется сигналом ALE ()
 * регистры управления:
 * XMCRA (0x74):
 *    7     6     5     4     3      2      1      0
 *   SRE, SRL2, SRL1, SRL0, SRW11, SRW10, SRW01, SRW00
 *
 * SRE - enable xmem, SRL2:0 - lower/upper sectors {0,1:all upper, 2-7:0x4..0xE upper},
 * SRW1x - wait states for upper, SRW0x - wait states for lower
 *
 * XMCRB (0x75):
 *     7          2     1     0
 *   XMBK, ххх, XMM2, XMM1, XMM0
 *
 * XMBK - bus keeper enable, XMMx - Mask High Adress lines {0-all;1-PC7;2-PC6,7;..7-only 8 bit address)
 *
 * Регистр номеров страниц: старшая тетрада - 0..15 верхнее окно 0xC000, младшая тетрада - 0..15 нижнее окно 0x8000
 * Запись в регистр страниц через PORTA при !RD = !WR = 0, то есть номер проходит в регистр, если оба сигнала LOW
 * и защелкивается при записи HIGH в любой из пинов !RD, !WR.
 *
 * @author Arhat109
 */

// полезный, удобный макрос:
#define makeByte(h,l) ((((h)<<4)&0xF0)|((l)&0x0F))

// определяем где и что находится у микроконтроллера (ATmega2560):
// 19 линий интерфейса внешней SRAM:
#define EMS_ALE         PG2
#define EMS_RD          PG1
#define EMS_WR          PG0
#define EMS_PORT_BUS    PORTG
#define EMS_DDR_BUS     DDRG
#define EMS_PORT_AD     PORTA
#define EMS_DDR_AD      DDRA
#define EMS_PORT_A      PORTC

// последние адреса окон памяти и размеры окон:
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
// без указания страницы - размещается во внутренеей памяти, секции .data, .bss, .. @see avr6.x
// EMS_COMMON -- общий блок с конца internal до 32768-го байта
// EMS_LOW()  -- [0,15] -- размещение в "нижних" сегментах по 16кб с адреса 0x8000
// EMS_HIGH() -- [0,15] -- размещение в "верхних" сегментах по 16кб с адреса 0xC000
// Внимательно! последние страницы (15) - это тот же блок COMMON!
// это можно использовать для работы с экранированным куском в 8кб, через EMS_LOW(15)..
//
#define EMS_COMMON        __attribute__((section(".cpage")))
#define EMS_LOW(pageNum)  __attribute__((section(".lpage" #pageNum)))
#define EMS_HIGH(pageNum) __attribute__((section(".hpage" #pageNum)))

uint8_t emsPages; // копия регистра страниц в нижней SRAM
uint8_t emsWaits; // wait states @see emsOn(_ws);

/** 
 * ТОЛЬКО активация Extended Memory SRAM единым верхним куском без удержания шины
 * + включение упр. сигналов на выход и заодно подтяжка к +5в
 * @param uint8_t _ws -- wait states for interface
 * @time 10t (0.625usec)
 */
#define emsOn(_ws)                                     \
{                                                      \
  emsWaits = (_ws);                                    \
  XMCRA = (1 << SRE) | ((_ws)<<2);                     \
  XMCRB = 0;                                           \
  EMS_DDR_BUS |= (1<<EMS_ALE)|(1<<EMS_RD)|(1<<EMS_WR); \
}

// отключалка интерфейса extSRAM, @time 1t
#define emsOff() (XMCRA = 0)

// =========================== Только сохранение в глобал: ======================== //
// @param uint8_t lp,hp,p

// emsSetLow(),emsSetHigh() -- @time 7t
// emsSetPages() -- 2t
#define emsSetLow(lp)      (emsPages=(emsPages&0xF0) | ((uint8_t)(lp)&0x0F))
#define emsSetHigh(hp)     (emsPages=((uint8_t)(lp)&0xF0) | (emsPages&0x0F))
#define emsSetPages(p)     (emsPages=(uint8_t)(p))

// =========================== Установка И запись страниц: ======================== //
/**
 * Пишем номера страниц блоков low, high в регистр страниц вручную, отключая extSRAM
 * @time 27t (1.4375usec)
 */
void emsWritePages(void)
{
  cli();
  emsOff();                                   //  1t, отключаем интерфейс extSRAM
  EMS_DDR_AD    = 0xFF;                       //  1t, порт А (A/D) "на выход"
  EMS_PORT_AD   = emsPages;                   //  1t, номера страниц в A/D
  EMS_PORT_BUS &= ~((1<<EMS_WR)|(1<<EMS_RD)); //  3t, оба сигнала в LOW уже "на выходе"
  __asm__ __volatile__ ("nop" :::);           //  1t, ждем 1 такт (62.5нсек)
  EMS_PORT_BUS |= ((1<<EMS_WR)|(1<<EMS_RD));  //  3t, оба сигнала в HIGH
  EMS_DDR_AD    = 0;                          //  1t, освобождаем порта А
  emsOn(emsWaits);                            // 10t, включаем интерфейс, восстанавливая тайминги
  sei();                                      // 1t+1t+4t (cli,sei,ret)
}

// @param uint8_t lowPage
// @time 34t
#define emsWriteLow(lowPage) \
{                            \
  emsSetLow(lowPage);        \
  emsWritePages();           \
}

// @param uint8_t highPage
// @time 34t
#define emsWriteHigh(highPage) \
{                              \
  emsSetHigh(highPage);        \
  emsWritePages();             \
}

/**
 * Проверяет заданный буфер на совпадение с шаблоном,
 * в случае расхождения вызывает callback() и возвращает 1
 * прерывает работу, если callback() возвращает не 0.
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

// =========================== ТЕСТОВЫЙ ПРИМЕР ТУТ: ======================== //

// объявляем 3 массива в разных окнах:

uint8_t commons[SIZE_COMMONS] EMS_COMMON;  // 24064 байт от внутренней SRAM в первых 32кбайтах
uint8_t lows[SIZE_LOWS]       EMS_LOW(0);  // 16кбайт от 32к до 48к
uint8_t highs[SIZE_HIGHS]     EMS_HIGH(0); // 16кбайт от 48к до 64к

uint8_t patterns[4] = {0xFF, 0x00, 0xAA, 0x55}; // образцы записи в память

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

// =========================== SETUP() ======================== //

void setup()
{
  emsOn(2);
  Serial.begin(115200);
}

void loop()
{
  for(int8_t i=sizeof(patterns); i>=0; --i){
//    memset(commons, patterns[i], SIZE_COMMONS);
//    memset(lows, patterns[i], SIZE_LOWS);
//    memset(highs, patterns[i], SIZE_HIGHS);
    for(int page=0; page<MAX_PAGES; page++){
      Serial.println();
      Serial.print("PAGE="); Serial.print(page, DEC);
      memset(pages[page].address, patterns[i], pages[page].size);
      if(
        emsMemtest(pages[page].address, pages[page].size, patterns[i], testError) != 0
      ){
        Serial.println("..ERROR OCURED..");
      }else{
        Serial.print(" is OK :)");
      }
    }
  }
}

