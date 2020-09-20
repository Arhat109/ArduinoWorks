#include "arhat.h"
#include "tsc.h"

#define encState PULSE_RAISING

// состояния главного мозга робота:
enum BrainStates {
    BRAIN_EMPTY                                         // Пусто, лентяйничаем.
    , BRAIN_START                                       // Начало работы. Включаем все заново.
    , BRAIN_SONIC_END                                   // Замеры в данном направлении - завершены.
    , BRAIN_SERVO_MOVED                                 // Серводвигатель доехал до заданной точки. Остановлен.
    , BRAIN_SERVO_END_LEFT                              // Левый край! вертели серву ++ и уперлись.
    , BRAIN_SERVO_END_RIGHT                             // Правый край! вертели серву -- и уперлись.
    , BRAIN_SEARCH                                      // поиск направления куда ехать
    , BRAIN_FORWARD                                     // решили ехать прямо, стартуем
    , BRAIN_BACK                                        // решили ехать назад, стартуем
    , BRAIN_LEFT
    , BRAIN_RIGHT
};
#define toBrainStates(s) ((BrainStates)(s))

typedef struct {
    TSC_Simple ctrl;
    uint8_t    state;
    uint8_t    moving;
} TSC_Brain;

#define ptrBrain(p)  ((TSC_Brain *)(p))

TSC_Brain      brain;                                   // КА "Главный мозг"

// ======== Маршевые моторы ======== //

#include "motors.h"

// ======== Подключение ультразвукового датчика-измерителя расстояний HCSR-04  ======== //

#define SONIC_0         SG90_0
#define SONIC_180       SG90_180
#define SONIC_STEPS     30                              // всегда четное! шагов меньше на 1 чем положений!
#define SONIC_STEP1     (SONIC_180-SONIC_0)/SONIC_STEPS // (620-140)/30=16
#define SONIC_WAIT1     (180/SONIC_STEPS)*(120/60)+2    // (180/16)*(120/60) + 2 = 14 мсек. на поворот

#define MAX_TMPDIST     3
#define MAX_ALLDIST     (SONIC_STEPS+1)                 // ==31! Всего ячеек для измерений [0..180]
#define DIST_NUM_FORWARD    (SONIC_STEPS/2)             // ==15! Номер ячейки, содержащей расстояние строго "вперед".
#define AVG_METHOD      1                               // ==1 усреднение расстояний без 2-х крайних значений

#define MIN_DISTANCE    150                             // наименьшее расстояние сближения с препятствиями "спереду".

#define PCINT           2                               // работаем с прерыванием уровня 2
#define MAX_PULSES2     5                               // всего обслуживаем 5 прерываний: 4 от энкодеров и 1 узв. датчик.
#define trigPin         14                              // Датчик HCSR-04, сигнал trig подключен к этому пину Ардуино.
#define echoPin         66                              // .. его сигнал echo подключается сюда (Analog12)
#define PULSE_ID        4                               // .. его номер с массиве КА для измерения длительностей импульсов
#include "sonic.h"                                      // первое подключение библиотеки. tsc.h и pcint.h вызываются отсюда самостоятельно.
                                                        // + создаст функцию startTrig14()       -- для запуска датчика
                                                        // + создает структуру pulses2[PULSE_ID] -- с данными КА датчика и результата работы

#define sonicTrig       trigPin                         // Переименовываем. Так далее будет называться в программе главный сенсор расстояния.
#define sonicEcho       echoPin
#define sonicId         PULSE_ID
#define pulses          pulses2

// ======================== SONIC :: Servo для HCSR-04 ======================== //

#define pinSONIC        2                               // серводвигатель датчика подключен как серво №1
#include "servo.h"
TSC_Servo srvSonic;                                     // Место для хранения состояний серводвигателя узв. датчика

// =================== Главные мозги робота ================== //

// можно ли ехать вперед?
uint8_t canMove(uint8_t direction)
{
  return (allDistances[DIST_NUM_FORWARD] <= MIN_DISTANCE? 0 : 1 );
}

//
// Главный автомат робота "объезд препятствий
//
void doBrain(void *_tsc)
{
//Serial.print(", brain=");
//Serial.println(ptrBrain(_tsc)->state, DEC);
    brain.ctrl.timeout = 1;
    switch( toBrainStates(ptrBrain(_tsc)->state) )
    {
        case BRAIN_START:           // начальный запуск робота:
            tsc_simple( &(srvSonic.ctrl)                            // .. 1. Запускаем КА серводвигателя:
                , servo_end                                         // ..    .. на начало замеров
                , (SG90_180-SG90_0) * SG90_WAIT1 / SG90_STEP1       // ..    .. через наибольшее время поворота в крайнее правое положение!
            );
            motorStop(m0_id);
            motorStop(m3_id);
            break;

        case BRAIN_SERVO_MOVED:     // серво узв. датчика доехала до угла, начинаем замеры расстояния в этом направлении:
            curMeasure = 0;                                         // номер попытки замера дачтиком в этом направлении: "начни"
            pulses[sonicId].state = HCSR04_START;                   // запуск замеров датчиком
            break;

        case BRAIN_SERVO_END_LEFT:  // уперлись в край, разворачиваем серву датчика
        case BRAIN_SERVO_END_RIGHT:
            srvSonic.direction = (srvSonic.direction == TO_LEFT? TO_RIGHT : TO_LEFT);
            srvSonic.ctrl.command = 0;
            brain.state = BRAIN_FORWARD;
            return;

        case BRAIN_SONIC_END:       // замер по направлению завершен, крутим серву датчика дальше
            if( srvSonic.direction == TO_LEFT ){
              curDirection++;
            }else{
              curDirection--;
            }
            curMeasure = 0;                                         // все попытки в новом положении делаем заново
            tsc_simple( &srvSonic.ctrl, srvSONIC_next, 0);          // Крутим серву датчика
            break;

        case BRAIN_EMPTY:                                           // нечего делать: проверяем "а вдруг чего случилось"?
            if( (brain.moving == BRAIN_FORWARD || brain.moving == BRAIN_BACK) ){
/*              if( (pulses[m0_id].state == PULSE_TIMER && pulses[m3_id].state == PULSE_TIMER ) ){
                // О, мы едем: прямо или назад и оба энкодера посчитались - спрямляем движение
                int    delta = (long)pulses[m0_id].res - (long)pulses[m3_id].res;
                int8_t step  = (delta>10? -1 : 1);

                motorAddSpeed(m0_id,  step);
                motorAddSpeed(m3_id, -step);
              }
*/
              if( !canMove(brain.moving) ){  // Препятствие слишком близко?
                motorStop(m0_id);
                motorStop(m1_id);
                brain.moving = BRAIN_BACK;
                brain.state = BRAIN_BACK;
                return;
              }
            }
            break;
/*
        case BRAIN_SEARCH:      // поиск куда ехать:
            // @TODO: Временно! Просто едем вперед
//            brain.state = BRAIN_FORWARD;
            return;
*/
        case BRAIN_FORWARD:     // едем вперед
//            pcint2_start( pcint2_init(m0_id, m1e, encState, pcint_encoder, 100));
//            pcint2_start( pcint2_init(m3_id, m4e, encState, pcint_encoder, 100));
            brain.moving = BRAIN_FORWARD;
            tsc_simple( &srvSonic.ctrl, srvSONIC_next, 0);          // Крутим серву датчика

            motor[m0_id].speed = 250;
            motor[m3_id].speed = 250;
            motorForward(m0_id);
            motorForward(m3_id);
            break;

        case BRAIN_BACK:        // едем назад
//            pcint2_start( pcint2_init(m0_id, m1e, encState, pcint_encoder, 100));
//            pcint2_start( pcint2_init(m3_id, m4e, encState, pcint_encoder, 100));
            brain.moving = BRAIN_BACK;

            motor[m0_id].speed = 250;
            motor[m3_id].speed = 250;
            motorBack(m0_id);
            motorBack(m3_id);
            brain.ctrl.timeout = 500;
            brain.state = BRAIN_START;
            return;
    }
    brain.state = BRAIN_EMPTY;
}

// *********** начальные установки: **************** //

void setup()
{

  pinModeOut(sonicTrig);                                // нога trig датчика HCSR-04 "на выход"
  pinModeIn(sonicEcho);                                 // нога echo датчика на вход
  pulses[sonicId].state = 0;                            // выключаем датчик до завершения поворота серводвигателя
  tsc_simple( &(pulses[sonicId].ctrl)                   // запускаем КА датчика
    , 0                                                 // .. ничего не делать,
    , 1                                                 // .. но проверять каждую миллисекунду завершение замера по прерываниям
  );

  srvSonic.position  = SG90_0;                          // начинать будем с положения "0"
  srvSonic.direction = TO_LEFT;                         // "0" - справа!!
  pwmSetServo(pinSONIC);                                // включаем режим "аппаратное серво" для таймера
  pinModeOut(pinSONIC);                                 // и открываем её на "вывод"
  pwmWrite(pinSONIC, srvSonic.position);                // устанавливаем серву в правое положение
  tsc_simple( &(srvSonic.ctrl)                          // запускаем КА серводвигателя
    , 0                                                 // .. ничего не делать
    , 1                                                 // .. проверять каждую миллисекунду
  );

  curMeasure            = 0;                            // настройка номера текущего замера
  curDirection          = 0;                            // .. по направлению (самое правое!)

  pinModeOut(m0f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m0b);
  pinModeOut(m1f);
  pinModeOut(m1b);
  pinModeOut(m2f);
  pinModeOut(m2b);
  pinModeOut(m3f);
  pinModeOut(m3b);

  pinModeIn(m0e);                                       // энкодеры моторов "на вход"
  pinModeIn(m1e);
  pinModeIn(m2e);
  pinModeIn(m3e);

  pwmSet(m0s);                                          // управление скоростью моторов
  pwmSet(m1s);
  pwmSet(m2s);
  pwmSet(m3s);
  
  for(uint8_t i=0; i<MAX_MOTORS; i++){
    motor[i].num = i;                                   // сохраняем номер мотора в его КА
    motor[i].speed = 0;                                 // скорость = 0
    motorStop(i);                                       // останавливаем мотор
  }

  brain.state = BRAIN_START;
  tsc_simple(&brain.ctrl, doBrain, BRAIN_START);        // включаем "мозги" роботу

//  Serial.begin( 9600 );
}

// *********** повторяем это: ************************//
void loop()
{
//Serial.print("loop ");
//Serial.print(getOvfCount(), DEC);
  tsc_run( &srvSonic.ctrl );                            // шаг серводвигателя датчика расстояний
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

  tsc_run( &brain.ctrl );                               // главные мозги робота: поворачиваться, осматриваться, ехать, а куда?
//Serial.println("");
}

