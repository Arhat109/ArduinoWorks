#include "arhat.h"
#include "tsc.h"

// ======== Маршевые моторы ======== //

#define m0f     14                                      // Управление 4-я моторами "f" - вперед, "b" - назад
#define m0b     15
#define m0s      5                                      // управление скоростью моторов через 8-бит ШИМ

#define m1f     16
#define m1b     17
#define m1s      6

#define m0       0                                      // номера моторов в структуре pulses
#define m1       1

#define MIN_SPEED                50                     // наименьшая скорость моторов
#define MAX_SPEED               255                     // Наибольшая задаваемая скорость мотора
#define MOTOR_WAIT_STOP          10                     // *3 тактов МК. Задержка на рассасывание зарядов в драйвере.

typedef struct{
  TSC_Simple      ctrl;                                 // тут будем хранить текущее состояние КА
  uint8_t         num;                                  // номер мотора для распознавания "чей" получен указатель
  uint8_t         speed;                                // заданная скорость разгона "до" [MIN_SPEED .. MAX_SPEED]
} TSC_Motor;
#define ptrMotor(ptr) ((TSC_Motor *)(ptr))

#define MAX_MOTORS      2                               // Всего моторов
TSC_Motor     motor[MAX_MOTORS];                        // тут будем хранить текущее состояние КА моторов [0..3]

/**
 * Останов мотора
 */
void motorStop(uint8_t num)
{
  switch(num){
    case 0: pinOutLow(m0f); pinOutLow(m0b); break;
    case 1: pinOutLow(m1f); pinOutLow(m1b); break;
  }
  delayMicro8(MOTOR_WAIT_STOP);
}

/**
 * Устанавливает заданную скорость мотора
 */
void motorSpeed(uint8_t num)
{
  switch(num){
    case 0: pwmWrite(m0s, motor[num].speed); break;
    case 1: pwmWrite(m1s, motor[num].speed); break;
  }
}

/**
 * Включаем мотор "вперед"
 */
void motorForward(uint8_t num)
{
  motorStop(num);
  switch(num){
    case 0: pinOutHigh(m0f); break;
    case 1: pinOutHigh(m1f); break;
  }
  motorSpeed(num);
}

/**
 * Включаем мотор "назад"
 */
void motorBack(uint8_t num)
{
  motorStop(num);
  switch(num){
    case 0: pinOutHigh(m0b); break;
    case 1: pinOutHigh(m1b); break;
  }
  motorSpeed(num);
}

/**
 * Изменяет скорость мотора на заданный шаг
 */
void motorAddSpeed(uint8_t num, char step)
{
    int speed = motor[num].speed;

    speed += step;
    if( speed < MIN_SPEED ){ speed = MIN_SPEED; }
    if( speed > MAX_SPEED ){ speed = MAX_SPEED; }
    motor[num].speed = (uint8_t)speed;
    motorSpeed(num);
}

// ======== Подключение ультразвукового датчика-измерителя расстояний HCSR-04  ======== //

#define PCINT           2                               // работаем с прерыванием уровня 2
#define MAX_PULSES2     1                               // всего обслуживаем 5 прерываний: 4 от энкодеров и 1 узв. датчик.
#define trigPin         4                               // Датчик HCSR-04, сигнал trig подключен к этому пину Ардуино.
#define echoPin         7                               // .. его сигнал echo подключается сюда (Analog12)
#define PULSE_ID        0                               // .. его номер с массиве КА для измерения длительностей импульсов
#include "hcsr04.h"                                     // первое подключение библиотеки. tsc.h и pcint.h вызываются отсюда самостоятельно.
                                                        // + создаст функцию startTrig4()        -- для запуска датчика
                                                        // + создает структуру pulses2[PULSE_ID] -- с данными КА датчика и результата работы
#define pulses          pulses2
#define sonicId         PULSE_ID

// ======================== Servo для HCSR-04 ======================== //

#define pinSONIC        9                               // серводвигатель датчика подключен как серво №1

enum ServoTypes { SG90 = 1, MG90, MG995, MG996 };       // типы серводвигателей:
enum ServoDirs  { TO_LEFT, TO_RIGHT };                  // направления вращения если смотреть сверху на ось

#define SG90_0        140                               // SG90: минимальное значение ширины импульса будем считать это как "0 градусов" (вправо)
#define SG90_1          3                               // SG90: угол в градусах при повороте на 1 шаг
#define SG90_180      620                               // SG90: максимальное значение для моего двигателя. Будет "180 градусов" (влево)
#define SG90_STEP1      8                               // SG90: шаг с которым будем поворачивать двигатель (3 грд.)
#define SG90_WAIT1      5                               // SG90: =3*(120/60) + 2(запас) ТТХ сервы: за 0.12сек на 60грд!

#define SONIC_STEPS     30                              // всегда четное! шагов меньше на 1 чем положений!
#define SONIC_STEP1     (SG90_180-SG90_0)/SONIC_STEPS   // (620-140)/30=16
#define SONIC_WAIT1     (180/SONIC_STEPS)*(120/60)+2    // (180/16)*(120/60) + 2 = 14 мсек. на поворот

#define MAX_TMPDIST     5                               // количество замеров в одном направлении для усреднения показаний (минимально 3, поскольку 2 отбросятся!)
#define MAX_ALLDIST     (SONIC_STEPS+1)                 // ==31! Всего ячеек для измерений [0..180]
#define DIST_NUM_FORWARD    (SONIC_STEPS/2)             // ==15! Номер ячейки, содержащей расстояние строго "вперед".

typedef struct {
  TSC_Simple      ctrl;                                 // тут будем хранить текущее состояние КА серводвигателя
  uint16_t        position;                             // текущее положение серводвигателя
  ServoDirs       direction;                            // текущее направление куда крутимся вправо или влево?
} TSC_Servo;
#define ptrServo(ptr) ((TSC_Servo *)(ptr))              // преобразование в указатель на структуру КА для серводвигателей:

TSC_Servo srvSonic;                                     // Место для хранения состояний серводвигателя узв. датчика

uint16_t tmpDistances[MAX_TMPDIST];                     // Место хранения текущих замеров расстояний для повышения достоверности
uint16_t curMeasure;                                    // номер текущего замера расстояния
uint16_t allDistances[MAX_ALLDIST];                     // Все расстояния по направлениям
uint16_t curDirection;                                  // текущее направление измерения расстояния [0..MAX_ALLDIST-1]

/**
 * Завершение текущей команды серводвигателя датчика: останов сервы и запуск измерений датчиком расстояний
 */
void servo_end(void *_ctrl)
{
//  Serial.print(", servo end");
  tsc_simple( &(ptrServo(_ctrl)->ctrl), 0, 1);            // серве датчика: ничего не делать, проверять состояние каждую миллисекунду
  curMeasure = 0;                                         // номер попытки замера дачтиком в этом направлении: "начни"
  pulses[sonicId].state = HCSR04_START;                   // запуск замеров датчиком
}

/**
 * Поворот серводвигателя на заданный угол:
 */
uint8_t srvServo_move(void *_tsc, uint16_t step)
{
    uint16_t tmpPos = ptrServo(_tsc)->position + step;

    if( (tmpPos >= SG90_0) && (tmpPos <= SG90_180) )
    {
        ptrServo(_tsc)->position = tmpPos;
        pwmWrite(pinSONIC, ptrServo(_tsc)->position);      // поворачиваем серводвигатель на угол
//Serial.print(", pos=");
//Serial.print(ptrServo(_tsc)->position);
        return 1;
    }
    return 0;
}

/**
 * Поворот серводвигателя на 1 шаг вперед (влево, TO_LEFT) или назад (вправо, TO_RIGHT):
 */
void srvSONIC_next(void *_tsc)
{
//Serial.print(", servo next ");
  if( ptrServo(_tsc)->direction == TO_LEFT )
  {
    if( !srvServo_move(_tsc, SG90_STEP1) ){
        // Движение влево закончено, все замеры произведены.
        ptrServo(_tsc)->direction = TO_RIGHT;
        ptrServo(_tsc)->ctrl.command = 0;
    }
  }
  else if( ptrServo(_tsc)->direction == TO_RIGHT )
  {
    if( !srvServo_move( _tsc, -SONIC_STEP1) ){
        // Движение вправо закончено, все замеры произведены.
        ptrServo(_tsc)->direction = TO_LEFT;
        ptrServo(_tsc)->ctrl.command = 0;
    }
  } else return;                                                // иначе ничего не делаем .. мало ли.

  tsc_simple( &(ptrServo(_tsc)->ctrl), servo_end, SONIC_WAIT1); // запуск обработки "серва повернулась" через SOINC_WAIT1
}

/**
 * Вычисление среднего расстояния по нескольким измерениям.
 * Отбрасывает только 2 измерения "самое большое" и "самое маленькое", остальные усредняет
 * параметр - последнее измеренное расстояние - его уже некуда складывать!
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
    allDistances[curDirection] = avgDistance(distance); // Все замеры сделаны: усредняем и сохраняем по направлению. Последний (+1) замер отдаем как параметр!
    curMeasure = 0;                                     // сброс попыток замера
    ptrPulse(_tsc)->state = 0;                          // Останавливаем замеры датчика. Запуск когда скажет "мозг"

    if( srvSonic.direction == TO_LEFT ) curDirection++;
    else                                curDirection--;

    tsc_simple( &srvSonic.ctrl, srvSONIC_next, 0);          // Крутим серву датчика "как только, так сразу"
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
//Serial.print(", start");
      tsc_simple((TSC_Simple *)_tsc, startTrig4, 1);    // запуск замера датчиком:
      ptrPulse(_tsc)->state = 0;                        // .. сброс состояния, чтобы ничего в switch не делать... нечего. Просто ждем.
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

// *********** начальные установки: **************** //
/**
 * задержка-моргалка 13 ногой. Диагностика перезагрузки МК по питанию
 * если перезагрузка, то робот встает "колом" на 7.5сек. - ЗАМЕТНО!!
 */
void doBlink()
{
  for(uint8_t i=5; i>0; i--){
    pinOutHigh(pinLed);
    delay(300);
    pinOutLow(pinLed);
    delay(200);
  }
  delay(2000);
}

void setup()
{
  pinModeOut(trigPin);                                  // нога trig датчика HCSR-04 "на выход"
  pinModeIn(echoPin);                                   // нога echo датчика на вход
  pulses[sonicId].state = 0;                            // выключаем датчик до завершения поворота серводвигателя
  tsc_simple( &(pulses[sonicId].ctrl)                   // запускаем КА датчика
    , 0                                                 // .. ничего не делать,
    , 1                                                 // .. но проверять каждую миллисекунду завершение замера по прерываниям
  );

  srvSonic.position  = SG90_0;                          // начинать будем с положения "0"
  srvSonic.direction = TO_LEFT;                         // "0" - справа!!
  pwmSetServo(pinSONIC);                                // включаем режим "аппаратное серво" для таймера этого пина
  pinModeOut(pinSONIC);                                 // и открываем её на "вывод"
  pwmWrite(pinSONIC, srvSonic.position);                // устанавливаем серву в правое положение
  tsc_simple( &(srvSonic.ctrl)                          // запускаем КА серводвигателя
    , servo_end                                         // .. доехал в "0"
    , SONIC_WAIT1*SONIC_STEPS                           // .. мало ли куда стояла серва до включения..
  );

  curMeasure            = 0;                            // настройка номера текущего замера
  curDirection          = 0;                            // .. по направлению (самое правое!)

  pinModeOut(m0f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m0b);
  pinModeOut(m1f);
  pinModeOut(m1b);

  pwmSet(m0s);                                          // разрешаем управление скоростью моторов
  pwmSet(m1s);
  
  for(uint8_t i=0; i<MAX_MOTORS; i++){
    motor[i].num = i;                                   // сохраняем номер мотора в его КА
    motor[i].speed = 0;                                 // скорость = 0
    motorStop(i);                                       // останавливаем мотор
  }

//  Serial.begin( 9600 );
  doBlink();
}

// *********** повторяем это: ************************//
void loop()
{
//Serial.print("loop ");
//Serial.print(getOvfCount(), DEC);
  tsc_run( &srvSonic.ctrl );                            // шаг КА серводвигателя датчика расстояний
  tsc_run( &pulses[sonicId].ctrl   );                   // шаг КА датчика: таймаут, запуск, или ничего не делает.
  doHCSR04(&pulses[sonicId]);                           // отдельно исполняем логику автомата "узв. датчик".

//Serial.print(", run:");
//Serial.print((uint16_t)(brain.ctrl.command), DEC);
//Serial.print(":");
//Serial.print(tsc_getTime(), DEC);
//Serial.print(",");
//Serial.print(brain.ctrl.started_at, DEC);
//Serial.print(",");
//Serial.print(brain.ctrl.timeout, DEC);
//Serial.println("");
}

