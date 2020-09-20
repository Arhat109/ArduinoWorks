#include "arhat.h"

#define tcsOut    47  // T5in   => выход обоих датчиков out
#define tcsS2     44  // T5outC => управление цветом обоих датчиков
#define tcsS3     46  // T5outB => управление цветом обоих датчиков
#define tcsOE1    49  // T5outA => !OE for TCS3200 1-й датчик
#define tcsOE2    45  // T5icp  => !OE for TCS3200 2-й датчик
#define tcsTimer   5

#define TCS_MAX_MEASURES 1          // [1,2,4,8,..] для автозамены деления сдвигами
#define TCS_WAIT           2
//#define TCS_WAIT         4          // мсек на разовый подсчет частоты. Итого fmin=250hz (4лк), замер 4 цветов = 62.5Гц
//#define TCS_WAIT         8          // мсек на разовый подсчет частоты. Итого fmin=125hz (1.5лк), замер 4 цветов = 31.25Гц
//#define TCS_WAIT        16          // мсек на разовый подсчет частоты. Итого fmin=62.5hz (0.9лк), замер 4 цветов = 15.6Гц
//#define TCS_WAIT        32          // мсек на разовый подсчет частоты. Итого fmin=31.25hz (0.4лк), замер 4 цветов = 7.8Гц
#define TCS_MAX_WAIT    4*TCS_WAIT  // время, к которому приводим подсчитанные величины для повышения качества в темноте
#define TCS_CONTRAST     8          // делитель для повышения контраста цвета (1/2,1/4,1/8)

#define TCS_WHITE    0       // порядок цветов в рез. массиве
#define TCS_GREEN    1
#define TCS_RED      2
#define TCS_BLUE     3

#define TCS_NOCOLOR  4       // состояние "замер завершен"
#define TCS_START    5       // команда конечному автомату "начать замер"

/**
 * Макрос повторного запуска того же датчика:
 */
#define tcsRestart() {tcsColor = TCS_START;}

/**
 * Макрос переноса из временных значений в окончательные без обработки
 * @global tcsTemp[],tcsColors[]
 */
#define tcsRaw()             \
{                            \
  tcsColors[0] = tcsTemp[0]; \
  tcsColors[1] = tcsTemp[1]; \
  tcsColors[2] = tcsTemp[2]; \
  tcsColors[3] = tcsTemp[3]; \
}

/**
 * Макрос простого усреднения накопленных данных
 * @global tcsColors[]
 */
#define tcsAvg()                        \
{                                       \
  uint8_t i=4;                          \
  do{                                   \
    tcsColors[--i] /= TCS_MAX_MEASURES; \
  }while( i>0 );                        \
}

/**
 * Макрос перевода яркостного канала из частоты в люксы
 * @global tcsColors[0]
 */
#define tcsLukses()           \
{                             \
  int tg = tcsColors[0];      \
  tcsColors[0] = tg + (tg/4); \
}

enum TCS_Modes {
      TCS_AUTO         =  0 // авторежим: коррекция + усреднение + люксометр + вн.баланс + цв. контраст
    , TCS_NOT_CORRECT  =  1 // режим без коррекции данных
    , TCS_NOT_AVERAGE  =  2 // режим без усреднения результатов
    , TCS_NOT_LUKSES   =  4 // режим без перевода яркости в люксы
    , TCS_NOT_WHITE    =  8 // режим без коррекции баланса от вн. светодиодов
    , TCS_NOT_CONTRAST = 16 // режим без повышения цветового контраста
    , TCS_SPEED_CONST  = 32 // режим без адаптации скорости работы (всегда фикс.)
    , TCS_WB_ONLY      = 64 // режим замера только яркостного канала!
};

int      tcsColors[4];       // итоговые и усредненные данные замера
int      tcsTemp[4];         // внутреннее хранение данных при усреднениях и замерах
int      minVal,maxVal;      // мин и макс. уровни каналов цвета
uint16_t tcsCount;           // номер завершенного замера
uint8_t  tcsColor;           // текущий измеряемый цвет в попытке или состояние КА
uint8_t  tcsMeasure;         // номер текущей усредняемой попытки замера
uint8_t  tcsWait;            // текущая длительность одного замера частоты от датчика
uint8_t  tcsIsBright;        // Пересвет? (и прочие возвращаемые статусы на будущее)
uint8_t  tcsModes;           // Биты определяют режимы работы драйвера

/**
 * Настройка таймера и выводов на работу с датчиком
 * @global tcsWait -- настройка времени первого замера
 */
void tcsSetup()
{
  // обе ноги разрешения датчиков на выход и запрет работы
  pinModeOut(tcsOE1);
  pinModeOut(tcsOE2);
  pinOutHigh(tcsOE1);
  pinOutHigh(tcsOE2);

  timerControl(tcsTimer, A) = 0;  // нормальный режим счета, счет по спадающесу(6),нарастающему(7) фронту на входе T5
  timerControl(tcsTimer, B) = 6;  // нормальный режим счета, все выходы счетчика отключены.
  pinModeIn(tcsOut);              // счет импульсов счетчиком T5

  // ноги управления цветом на выход и режим s2=1,s3=0 -- анализ белого
  pinModeOut(tcsS2);
  pinModeOut(tcsS3);
  pinOut(tcsS2, HIGH);
  pinOut(tcsS3, LOW);

  tcsWait = TCS_WAIT;
}

/**
 * настройка заданного датчика на чтение данных о цвете
 * @global tcsColor -- перевод КА в состояние "начать замеры"
 */
void tcsPrepare(uint8_t num)
{
  switch(num){
    case 1:
      pinOut(tcsOE2, HIGH);
      delayMicro8(5);
      pinOut(tcsOE1, LOW);
      break;
    case 2:
      pinOut(tcsOE1, HIGH);
      delayMicro8(5);
      pinOut(tcsOE2, LOW);
      break;
  }
  tcsColor = TCS_START;
}

/**
 * переключение датчика на текущий цвет и сброс таймера для нового замера
 * @global tcsColor -- текущий цвет замера
 */
void tcsNextColor(){
  uint8_t color = tcsColor+2; // изменяем порядок цветов: первым опрашиваем общий канал!

  if( color & 2 ){ pinOutHigh(tcsS2); }else{ pinOutLow(tcsS2); }
  if( color & 1 ){ pinOutHigh(tcsS3); }else{ pinOutLow(tcsS3); }
  timerCount(tcsTimer) = 0;
}

/**
 * Коррекция показаний по усредненной обратной матрице чувствительности из даташит:
 * заодно и перенос итогов из tcsTemp[] в tcsColors[]
 * @global tcsColors[]
 */
void tcsCorrect()
{
    int      tg = tcsColors[1]/2
            ,tr = tcsColors[2]/2
            ,tb = tcsColors[3]/2
    ;
    tcsColors[1] += tg;             // 1/2
    tcsColors[3] += tb;

    tg >>= 1; tr>>=1; tb>>=1;       // 1/4
    tcsColors[1] -= (tb+tb+tb);
    tcsColors[2] -= tg;
    tcsColors[3] -= tg;
    tg >>= 1; tr>>=1; tb>>=1;       // 1/8
    tcsColors[1] += tg;
    tcsColors[3] -= tr;
    tg >>= 1; tr>>=1; tb>>=1;       // 1/16
    tcsColors[2] += tr-tg;
    tcsColors[3] -= tg-tr;
    tg >>= 1; tb>>=1;               // 1/32
    tcsColors[1] += tg;
    tcsColors[3] += tb-tg;
    tcsColors[2] += tb+tg/4;        // +1/128tg (0.18%), иначе большая ошибка в красном (1.02%)!

    if( tcsColors[1]<0 ) tcsColors[1] = 0;  // устраняем отрицательные значения из-за ошибок округления
    if( tcsColors[2]<0 ) tcsColors[2] = 0;
    if( tcsColors[3]<0 ) tcsColors[3] = 0;
}

/**
 * Усреднение попыток замера, перевод в люксы и подсчет мин/мах уровней каналов цвета
 * @global int minVal,maxVal,tcsColors[]
 */
void tcsMinMax()
{
    int      val;

    minVal = 32767; maxVal = 0;
    for(uint8_t i=3; i>0; i--){
      val = tcsColors[i];
      if( minVal > val ) minVal = val;
      if( maxVal < val ) maxVal = val;
    }
}

/**
 * коррекция баланса встроенных светодиодов:
 * ! под замену при иных параметрах освещения !
 * @global tcsColors[]
 */
void tcsWhiteLocal(){
    int      val;

    val = tcsColors[1];
    tcsColors[1] = val + val   - val/8;
    val = tcsColors[2];
    tcsColors[2] = val + val/2 + val/32;
    val = tcsColors[3];
    tcsColors[3] = val - val/8 - val/16;
}

/**
 * повышение контраста
 * @global minVal,maxVal,tcsColors[]
 */
void tcsContrast()
{
	int     delta;
    uint8_t val = TCS_CONTRAST*2;

    tcsMinMax();
    delta = maxVal - minVal;
         if( delta < minVal   ) val = TCS_CONTRAST;
    else if( delta > 2*minVal ) val = TCS_CONTRAST*4;

    tcsColors[1] += (tcsColors[1] - minVal)/val;
    tcsColors[2] += (tcsColors[2] - minVal)/val;
    tcsColors[3] += (tcsColors[3] - minVal)/val;
}

/**
 * попытка замера цвета датчиком
 */
void tcsRun(uint8_t num)
{
  if( tcsColor == TCS_NOCOLOR ) return;  // не запущен замер/останов, выход.

  if( tcsColor == TCS_START ){
    // начало очередного замера
    tcsColor=0;
    tcsMeasure = 0;
    tcsIsBright = 0;
    for(uint8_t c=0; c<4; c++)
            tcsTemp[c] = 0;
  }else{
    // замер: приводим текущий замер к эфф. времени
    uint16_t counter = timerCount(tcsTimer);
    tcsTemp[tcsColor] += counter * (TCS_MAX_WAIT / tcsWait);
    if( counter > 590*tcsWait ){ tcsIsBright = 1; }      // Очень ярко! Частота выше 600кГц !!!
//Serial.print("c=");
//Serial.print(counter, DEC);
//Serial.print("c=");
//Serial.print(tcsColor, DEC);
//Serial.print("m=");
//Serial.print(tcsMeasure, DEC);
    if( tcsColor == 0 && !(tcsModes & TCS_SPEED_CONST) ){
      // первым замеряли яркостный канал: смотрим надо ли менять время замеров (удерживаем точность 0.5%):
           if( counter < 150 ){ tcsWait = TCS_WAIT * 4; }  // совсем темно, макс. длительность.
      else if( counter < 300 ){ tcsWait = TCS_WAIT * 2; }  // темновато, удвоенная длительность.
      else if( tcsWait>1 ){ tcsWait /= 2; }                // пробуем сократить время замера
//Serial.print(",w=");
//Serial.print(tcsWait, DEC);
    }

    if( (tcsModes & TCS_WB_ONLY) || (++tcsColor) == TCS_NOCOLOR ){
      tcsColor = TCS_NOCOLOR;
      if( tcsMeasure >= TCS_MAX_MEASURES-1 )                   // Завершены все попытки:
      {
        tcsRaw();                                              // .. переносим значения в результат
        if( tcsModes & TCS_WB_ONLY ){
          tcsColors[0] /= TCS_MAX_MEASURES;
        }else{
          if( tcsModes & TCS_NOT_CORRECT  == 0) tcsCorrect();    // .. восстанавливаем баланс белого (R=0.18%,G=0.41%,B=-0.05%)
          if( tcsModes & TCS_NOT_AVERAGE  == 0) tcsAvg();        // .. усредняем цвет
          if( tcsModes & TCS_NOT_WHITE    == 0) tcsWhiteLocal(); // .. коррекция баланса белого от внутренних светодиодов
          if( tcsModes & TCS_NOT_CONTRAST == 0) tcsContrast();   // .. повышение контрастности цветов
        }
        if( tcsModes & TCS_NOT_LUKSES   == 0) tcsLukses();     // .. масштабируем частоту в люксы

        tcsCount++;                                            // .. конец работы, новый номер замера.
        return;
      }else{
        tcsMeasure++;
        tcsColor = 0;
      }
    }
  } // if START
  tcsNextColor();
}

void setup() {
  Serial.begin(115200);

  tcsSetup();
  tcsPrepare(1);
  tcsModes = TCS_SPEED_CONST | TCS_NOT_LUKSES | TCS_WB_ONLY;
}

void loop() {
  everyOVF(tcsWait, tcsRun(1) );
  if( tcsColor == TCS_NOCOLOR ){
    // замер завершен.
    Serial.print(", count=");
    Serial.print(tcsCount, DEC);
    Serial.print(", W=");
    Serial.print(tcsColors[TCS_WHITE], DEC);
    Serial.print(", R=");
    Serial.print(tcsColors[TCS_RED], DEC);
    Serial.print(", G=");
    Serial.print(tcsColors[TCS_GREEN], DEC);
    Serial.print(", B=");
    Serial.print(tcsColors[TCS_BLUE], DEC);
    Serial.print(", time=");
    Serial.print(tcsWait, DEC);
    Serial.print(", isBright? ");
    Serial.print(tcsIsBright, DEC);
    Serial.println("");
    tcsColor = TCS_START;
  }
}

