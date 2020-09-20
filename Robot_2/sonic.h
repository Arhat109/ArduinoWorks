/**
 * Пример библиотечного конечного автомата для ультразвукового датчика расстояний HCSR04
 *
 * Для использования надо определить одну из констант MAX_PULSES{0,1,2} -- сколько всего подключено устройств
 * и к каким прерываниям PCINT0..2, и, только затем, определить пины Ардуино, к которым подключен датчик
 * И после этого добавить в скетч #include "hcsr04.h", который создаст методы конечного автомата
 * с названиями дополненными номером пина, например: startTrig1() -- запуск начала измерения расстояния.
 * Если датчиков несколько, то можно вставлять файл последовательно несколько раз, переопределяя используемые пины
 * , например:
 *
 * #define PCINT        0       // этот датчик обслуживается этим уровнем прерываний
 * #define MAX_PULSES0  1       // и всего будет занято 1 нога прерываний уровня 0
 * #define trigPin     14       // trig первого датчика подключено к этой ноге Ардуино Мега2560
 * #define echoPin     10       // echo первого датчика подключено к PCINT0, сигнал 4 (pwm10)
 * #include "hcsr04.h"
 *
 * #define PCINT        2       // а теперь разворачиваем код для обработки на PCINT2
 * #define MAX_PULSES2  2       // тут у нас 2 прерывания в обработке
 * #define trigPin     15       // trig второго датчика подключен сюда
 * #define echoPin     63       // echo второго датчика подключен сюда, к PCINT2, сигнал 1 (Analog9)
 * #include "hcsr04.h"
 *
 * В результате, появятся функции:
 * extern "C" {
 *   void     startTrig14(void) -- запуск сигнала начала измерения и включение ожидания длительности импульса по прерыванию
 *   void     startTrig15(void) -- она же для второго датчика
 *
 * Pulses     pulses0[MAX_PULSES0] -- и структура данных КА для вычисления длительностей в мксек и отработки таймаутов измерений.
 * Pulses     pulses2[MAX_PULSES2] -- .. согласно количеству подключенных уровней и используемых ног у них.
 * }
 * Далее в скетче можно руками распределить номера структур в массивах на соотв. им датчики функцией pcint{0..2}_init();
 *
 * ПРИМЕЧАНИЕ: Если пины датчика НЕ определены или не определено MAX_PULSES{0..2} до #include "hcsr04.h", то будет ошибка компиляции:
 * *** ERROR! {MAX_PULSES,trigPin,echoPin} is not defined ***
 *
 * @examples TSC_Pulsein.ino
 */

#ifdef __cplusplus
extern "C" {
#endif

#if !defined(trigPin)
#  error *** ERROR! trigPin is not defined before include hcsr04.h ***
#elif !defined(echoPin)
#  error *** ERROR! echoPin is not defined before include hcsr04.h ***
#endif

#include "pcint.h"                                      // создает структуры и методы для обработки прерывания

#define _START_TRIG(p)  startTrig##p (void *_tsc)
#define START_TRIG(p)  _START_TRIG(p)

#define HCSR04_START           4        // номер статуса КА для запуска замеров (вручную)
#define HCSR04_MAX_DISTANCE 5000        // предельно измеряемое расстояние.

// реализация функции вкоючается только один раз!
#ifndef GET_DISTANCE
#  define GET_DISTANCE 1

uint16_t getDistance( volatile Pulse *ptr );            // преобразует время датчика в расстояние
uint16_t avgDistance( uint16_t );                       // усреднение расстояний в tmpDistances[] без 2-х крайних значений
uint16_t avgDistanceAll( void );                        // усреднение расстояния по всем значениям в tmpDistances[]
void     saveDistance( void *_tsc, uint16_t distance ); // сохранение расстояний в allDistances[]
void     doHCSR04(void *_tsc);                          // действия автомата датчика для проведения серии замеров

void   (*hcsr04_endHook)(void);                         // указатель на функцию-перехватчика "чего делать когда все сделано?"

uint16_t tmpDistances[MAX_TMPDIST];                     // Место хранения текущих замеров расстояний для повышения достоверности
uint16_t curMeasure;                                    // номер текущего замера расстояния
uint16_t allDistances[MAX_ALLDIST];                     // Все расстояния по направлениям
uint16_t curDirection;                                  // текущее направление измерения расстояния [0..MAX_ALLDIST-1]

uint16_t minDistance[(MAX_ALLDIST-1)/2] = {             // Предельные расстояния по направлениям (15шт): "габарит".
    // 0   1   2   3   4   5   6   7   8   9   10  11  12  13  14   // номер точки от поперек
    // 90  84  78  72  66  60  54  48  42  36  30  24  18  12  6    // угол поворота в грд. от вперед
    //------------------------------------------------------------
    125,126,128,132,137,144,155,168,187,213,250,307,405,601,1196
};

/**
 * Вычисляет расстояние по замеру длительности в миллиметрах!
 */
uint16_t getDistance( volatile Pulse *ptr)
{
  if(ptr->state != PULSE_OK) return 0;

  return (uint16_t)((((uint32_t)ptr->res) * 343UL) >> 11);
}
#endif // GET_DISTANCE

/**
 * определяет startTrig..(void *_tsc)
 *
 * Запуск начала замера для узв. датчика HCSR04
 * Прием и замер длительности сигнала echo на одном из (PCINT2) [62..69] силами КА "Pulse"
 * Пока для HC-SR04: макс. дальность = 5м или 29800мксек. = 29
 * пауза на прием около 4мксек = 0,335 * 4 = 1,34мм
 *
 * Параметр не используется, нужен для совместимости по вызову с TSC_Simple автоматами.
 */
void START_TRIG(trigPin)
{
  pinOutLow(trigPin);                           // ногу trigPin в 0,
  delayMicro8(11);                              // inline! ждем 2мксек: 2/0.1875 = 10.67
  pinOutHigh(trigPin);                          // подаем импульс длительностью 10мксек
  delayMicro8(53);                              // inline! остаток задержки в 10мксек: 10/0.1875 = 53.33
  pinOutLow(trigPin);                           // выключаем trigPin

// ~4мксек настраиваем прерывания и таймаут.
#if defined(PCINT) && PCINT==0
  pcint0_start( pcint0_init(PULSE_ID, echoPin, PULSE_BUSY, pcint_micros, 35) );
#elif defined(PCINT) && PCINT==1
  pcint1_start( pcint1_init(PULSE_ID, echoPin, PULSE_BUSY, pcint_micros, 35) );
#elif defined(PCINT) && PCINT==2
  pcint2_start( pcint2_init(PULSE_ID, echoPin, PULSE_BUSY, pcint_micros, 35) );
#endif
}

/**
 * Вычисление среднего расстояния по нескольким измерениям.
 * Отбрасывает только 2 измерения "самое большое" и "самое маленькое", остальные усредняет
 * параметр - последнее измеренное расстояние - его некуда складывать!
 */
uint16_t avgDistance(uint16_t distance)
{
  uint16_t maxD = 1, minD = 5000, sumD = 0;

  for(uint8_t i=0; i<MAX_TMPDIST; i++){
    if( tmpDistances[i] > maxD ){ maxD = tmpDistances[i]; }
    if( tmpDistances[i] < minD ){ minD = tmpDistances[i]; }
    sumD += tmpDistances[i];
  }
  if( distance > maxD ){ maxD = distance; }
  if( distance < minD ){ minD = distance; }
  sumD += distance;
  return (sumD - minD - maxD)/(MAX_TMPDIST-1);
}

/**
 * Вычисление среднего расстояния по нескольким измерениям.
 * Ничего не отбрасывает
 */
uint16_t avgDistanceAll()
{
  uint16_t sumD = 0;

  for(uint8_t i=0; i<MAX_TMPDIST; i++){
    sumD += tmpDistances[i];
  }
  return sumD / MAX_TMPDIST;
}

/**
 * Сохраняем текущий замер в наборе временных расстояний или уже по направлению.
 * запускаем серводвигатель на поворот
 */
void saveDistance( void *_tsc, uint16_t distance )
{
  if( curMeasure < MAX_TMPDIST )
  {
    tmpDistances[curMeasure] = distance;                // если ещё повторяем попытки замера в направлении:
    curMeasure++;
    ptrPulse(_tsc)->state = HCSR04_START;
//Serial.print(", mes");
//Serial.print(curMeasure, DEC);
//Serial.print(" = ");
//Serial.print(distance, DEC);
  } else {
    allDistances[curDirection] = avgDistance(distance); // Все замеры сделаны: усредняем и сохраняем по направлению
    curMeasure = 0;                                     // сброс попыток замера
    ptrPulse(_tsc)->state = 0;                          // Останавливаем замеры датчика. Запуск когда скажет "мозг"
    brain.state = BRAIN_SONIC_END;                      // "мозг"! Замер по направлению завершен
//Serial.print(", Distance=");
//Serial.print(allDistances[curDirection], DEC);
  }
}

/**
 * Внутренние состояния датчика и его действия:
 */
void doHCSR04(void *_tsc)
{
//Serial.print(", hcsr04 =");
//Serial.print(ptrPulse(_tsc)->state, DEC);
    switch( ptrPulse(_tsc)->state ) {
    case HCSR04_START:
      tsc_simple((TSC_Simple *)_tsc, startTrig14, 1);                 // запуск замера датчиком:
      ptrPulse(_tsc)->state = 0;                        // .. сброс состояния, чтобы ничего в switch не делать... нечего. Просто ждем.
//Serial.print(", start");
      break;
    case PULSE_OK:                                      // замер произведен, данные - действительны:
      saveDistance(_tsc, getDistance(ptrPulse(_tsc)));
//Serial.print(", ok");
      break;
    case PULSE_TIMER:                                   // или сработал КА по таймауту.
      saveDistance(_tsc, HCSR04_MAX_DISTANCE);          // .. слишком далеко, заменяем на предельно измеряемое расстояние в мм.
//Serial.print(", timer");
      break;
    case PULSE_ERROR:
      ptrPulse(_tsc)->state = HCSR04_START;             // ошибка. Перезапуск попытки замера.
//Serial.print(", error");
      break;
//    default:
//Serial.print(", default");
    }
}

#ifdef __cplusplus
}
#endif
