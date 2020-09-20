
#include "arhat.h"

// ============ Данные программы ============ //

#define MAX_TMPDIST     5
uint16_t tmpDistances[MAX_TMPDIST];                             // Место хранения текущих замеров расстояний для повышения достоверности
uint16_t curMeasure;                                            // номер текущего замера расстояния

#define MAX_ALLDIST  (SONIC_STEPS+1)                            // ==31! Всего ячеек для измерений [0..180]
#define BOT_WIDTH       125                                     // Ширина робота в мм.

uint16_t minDistance[SONIC_STEPS/2] = {                         // Предельные расстояния по направлениям (15шт): "габарит".
    // 0   1   2   3   4   5   6   7   8   9   10  11  12  13  14   // номер точки от поперек
    // 90  84  78  72  66  60  54  48  42  36  30  24  18  12  6    // угол поворота в грд. от вперед
    //------------------------------------------------------------
    125,126,128,132,137,144,155,168,187,213,250,307,405,601,1196
}
uint16_t allDistances[MAX_ALLDIST];                             // Все расстояния по направлениям
uint16_t curDirection;                                          // текущее направление измерения расстояния [0..MAX_ALLDIST-1]
uint8_t  is_alldirs;                                            // все замеры в направлении - завершены?

// ============ Общие константы и енумераторы для серводвигателей дописывать сюда ============ //

#define servo1   2                                              // Серводвигатели, сразу все 8 шт.
#define servo2   3                                              // серво двигатель 2  ножка 3
#define servo3   5                                              // серво двигатель 3  ножка 5
#define servo4   6                                              // серво двигатель 4  ножка 6
#define servo5   7                                              // серво двигатель 5  ножка 7
#define servo6   8                                              // серво двигатель 6  ножка 8
#define servo7   11                                             // серво двигатель 7  ножка 11
#define servo8   12                                             // серво двигатель 8  ножка 12

enum ServoTypes { SG90 = 1, MG90, MG995, MG996 };               // типы серводвигателей:
enum ServoDirs  { TO_LEFT, TO_RIGHT };                          // направления вращения если смотреть сверху на ось

#define SG90_0        140                                       // SG90: минимальное значение ширины импульса будем считать это как "0 градусов" (вправо)
#define SG90_1          3                                       //угол в градусах при повороте на 1 шаг
#define SG90_180      620                                       // SG90: максимальное значение для моего двигателя. Будет "180 градусов" (влево)
#define SG90_STEP1      8                                       // SG90: шаг с которым будем поворачивать двигатель (3 грд.)
#define SG90_WAIT1      5                                       // SG90: =3*(120/60) + 2(запас) ТТХ сервы: за 0.12сек на 60грд!
#define SG90_STUPID   100                                       // SG90: время задержки состояния "все сделано", чтобы "не так шустро носился".

#define MG90_0        150                                       // @TODO: ПОДБИРАТЬ по реальным положениям серводвигателей .. примерные цифры.
#define MG90_1          3
#define MG90_180      614
#define MG90_STEP       8
#define MG90_WAIT       8
#define MG90_STUPID   100

#define MG995_0       150
#define MG995_1         3
#define MG995_180     614
#define MG995_STEP      8
#define MG995_WAIT      8
#define MG995_STUPID  100

#define MG996_0       150
#define MG995_1         3
#define MG996_180     614
#define MG996_STEP      8
#define MG996_WAIT      8
#define MG996_STUPID  100

// ======================== SONIC :: Servo для HCSR-04 ======================== //

#define SONIC_0         SG90_0
#define SONIC_180       SG90_180
#define SONIC_STEPS     30
#define SONIC_STEP1     (SONIC_180-SONIC_0)/SONIC_STEPS         // (620-140)/30=16
#define SONIC_WAIT1     (180/SONIC_STEPS)*(120/60)+2            // (180/16)*(120/60) + 2 = 14 мсек. на поворот

typedef struct {
  TSC_Simple      ctrl;                                         // тут будем хранить текущее состояние КА серводвигателя
  uint16_t        position;                                     // текущ ее положение серводвигателя
  ServoDirs       direction;                                    // текущее направление куда крутимся вправо или влево?
} TSC_Servo;

#define ptrServo(ptr) ((TSC_Servo *)(ptr))                      // преобразование в указатель на структуру КА для серводвигателей:

#define pinServoHCSR04 servo1                                   // серводвигатель датчика подключен как серво №1
TSC_Servo servoHCSR04;                                          // Место для хранения состояний серводвигателя узв. датчика

/**
 * Завершение текущей команды серводвигателя: останов сервы и запуск измерений датчиком расстояний
 */
void servoHCSR04_end(void *_ctrl)
{
  tsc_simple( &(ptrServo(_ctrl)->ctrl), 0, 0);
  curMeasure = 0;
  pulses[sonicId].state = HCSR04_START;
}

/**
 * Поворот серводвигателя (N1) датчика HCSR-04 на 1 шаг вперед (влево, TO_LEFT) или назад (вправо, TO_RIGHT):
 */
void servoHCSR04_next(void *_ctrl)
{
  uint16_t tmpPos;

  if( ptrServo(_ctrl)->direction == TO_LEFT )
  {
    tmpPos = ptrServo(_ctrl)->position + SONIC_STEP1;

    if( tmpPos <= SONIC_180 ){
        ptrServo(_ctrl)->position = tmpPos;
        curDirection++;
        pwmWrite(pinServoHCSR04, ptrServo(_ctrl)->position);    // поворачиваем серводвигатель на угол
    } else {
        // Движение влево закончено, все замеры произведены.
        is_alldirs = 1;
    }
  }
  else if( ptrServo(_ctrl)->direction == TO_RIGHT )
  {
    tmpPos = ptrServo(_ctrl)->position - SONIC_STEP1;

    if( tmpPos >= SONIC_0 ){
      ptrServo(_ctrl)->position = tmpPos;
      curDirection--;
      pwmWrite(pinServoHCSR04, ptrServo(_ctrl)->position);      // поворачиваем серводвигатель на угол
    } else {
        // Движение вправо закончено, все замеры произведены.
        is_alldirs = 1;
    }
  }
  tsc_simple( &(ptrServo(_ctrl)->ctrl), servoHCSR04_end, SONIC_WAIT1);
}

/* ======== Подключение ультразвукового датчика-измерителя расстояний HCSR-04  ======== */

#define PCINT           2                                       // работаем с прерыванием уровня 2
#define MAX_PULSES2     5                                       // всего обслуживаем 5 прерываний: 4 от энкодеров и 1 узв. датчик.
#define pulses          pulses2                                 // .. чтобы не искать по всему тексту прораммы.

#define trigPin         14                                      // Датчик HCSR-04, сигнал trig подключен к этому пину Ардуино.
#define echoPin         66                                      // .. его сигнал echo подключается сюда (Analog12)
#define PULSE_ID        4                                       // .. его номер с массиве КА для измерения длительностей импульсов
#include "hcsr04.h"                                             // первое подключение библиотеки. tsc.h и pcint.h вызываются отсюда самостоятельно.
                                                                // + создаст функцию startTrig14()       -- для запуска датчика
                                                                // + создает структуру pulses2[PULSE_ID] -- с данными КА датчика и результата работы

#define sonicTrig       trigPin                                 // Переименовываем. Так далее будет называться в программе главный сенсор расстояния.
#define sonicEcho       echoPin
#define sonicId         PULSE_ID

/**
 * Вычисление среднего расстояния по нескольким измерениям.
 * Отбрасывает только 2 измерения "самое большое" и "самое маленькое", остальные усредняет
 */
uint16_t avgDistance()
{
  uint16_t maxD = 1, minD = 5000, sumD = 0;

  for(uint8_t i=0; i<MAX_TMPDIST; i++){
    if( tmpDistances[i] > maxD ){ maxD = tmpDistances[i]; }
    if( tmpDistances[i] < minD ){ minD = tmpDistances[i]; }
    sumD += tmpDistances[i];
  }
  return (sumD - minD - maxD)/(MAX_TMPDIST-2);
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
void saveDistance( uint16_t distance )
{
  if( curMeasure < MAX_TMPDIST )
  {                                                             // если замер ещё в направлении:
    tmpDistances[curMeasure] = distance;
    curMeasure++;
    pulses[sonicId].state = HCSR04_START;
  } else {
    allDistances[curDirection] = avgDistance();
//    Serial.print("Distance=");
//    Serial.println(allDistances[curDirection], DEC);
    curMeasure = 0;

    tsc_simple( &servoHCSR04.ctrl, servoHCSR04_next, 0);
    pulses[sonicId].state = 0;
  }
}

/**
 * Анализ состояния датчика и управление зависимыми устройствами от него:
 */
void doHCSR04()
{
    switch( pulses[sonicId].state ) {
    case HCSR04_START:                                          // запуск замера через 1мсек:
      tsc_simple( &pulses[sonicId].ctrl, startTrig14, 1);
      pulses[sonicId].state = 0;                                // .. сброс состояния, чтобы ничего в switch не делать... нечего. Просто ждем.
      break;
    case PULSE_OK:                                              // замер произведен, данные - действительны:
      saveDistance(getDistance(&pulses[sonicId]));
      break;
    case PULSE_TIMER:                                           // или сработал КА по таймауту.
      saveDistance(HCSR04_MAX_DISTANCE);                        // .. слишком далеко, заменяем на предельно измеряемое расстояние в мм.
      break;
    case PULSE_ERROR:
      pulses[sonicId].state = HCSR04_START;                     // и сбрасываем состояние датчика на запуск с ожиданием просмотра.
      break;
    }
}

/* ======== Маршевые моторы ======== */

#define MAX_MOTORS      4                                       // Всего моторов можно подключить

#define m1f     22                                              // Управление 4-я моторами "f" - вперед, "b" - назад
#define m1b     23                                              // мотор назад ножка 23

#define m2f     24                                              //мотор 2 вперёт ножка 24
#define m2b     25                                              //мотор 2 назад ножка 25
#define m3f     26                                              //мотор 3 вперёт ножка 26
#define m3b     27                                              //мотор 3 назад ножка 27
#define m4f     28                                              //мотор 4 вперёт ножка 28
#define m4b     29                                              //мотор 4 назад ножка 29

#define m1e     65                                              // Энкодеры моторов тут PCINT2[0,1,2,3]
#define m2e     64                                              //мотор 1 инкодер ножка 64
#define m3e     63                                              //мотор 2 инкодер ножка 63
#define m4e     62                                              //мотор 3 инкодер ножка 62

#define m1_id    0                                              // номера моторов в структуре pulses
#define m2_id    1
#define m3_id    2
#define m4_id    3

#define MAX_SPEED               100                             // Наибольшая задаваемая скорость мотора < 127!(удобнее  100 )
#define STEP_SPEED               10                             // Шаг изменения скорости "по умолчанию''" изменить скорость"
#define SHIFT_SPEED_TIME          3                             // Сдвиг скорости при переводе в микросекунды
#define MAX_SPEED_TIME   (MAX_SPEED<<SHIFT_SPEED_TIME)          // наибольший период времени для программного ШИМ скорости

typedef struct{
  TSC_Control     ctrl;                                         // тут будем хранить текущее состояние КА
  uint8_t         num;                                          // номер мотора для распознавания "чей" получен указатель
  int8_t          speed;                                        // заданная скорость разгона "до" [-MAX_SPEED .. MAX_SPEED]

//private:
  uint8_t         by;                                           // шаг времени разгона
  uint8_t         cur;                                          // текущая скорость разгона
} TSC_Motor;

#define ptrMotor(ptr) ((TSC_Motor *)(ptr))

TSC_Motor     motor[MAX_MOTORS];                                // тут будем хранить текущее состояние КА моторов [0..3]

/**
 * Включаем мотор "вперед" с заданной скоростью ШИМ
 */
void motorForward(void *_tsc)
{
    switch(ptrMotor(_tsc)->num){                                 // переключатель (от номера мотора)
      case 0: pinOutLow(m1b); pinOutHigh(m1f); break;            //в случае номер мотора равен нулю мотор включаем первый
    case 1: pinOutLow(m2b); pinOutHigh(m2f); break;              //в случае номер мотора равен одному мотор включаем второй
    case 2: pinOutLow(m3b); pinOutHigh(m3f); break;              //в случае номер мотора равен двум мотор включаем третий
    case 3: pinOutLow(m4b); pinOutHigh(m4f); break;              //в случае номер мотора равен трём мотор включаем четвёртый
  }
  ptrMotor(_tsc)->ctrl.timeout = ((int)(ptrMotor(_tsc)->speed)) << SHIFT_SPEED_TIME; //" скорость умножаем на число"
//  ptrMotor(_tsc)->ctrl.timeout = ptrMotor(_tsc)->speed;
}

/**
 * Включаем мотор "назад" с заданной скоростью ШИМ
 */
void motorBack(void *_tsc)                                        //имя действия motor back назад
{
    switch(ptrMotor(_tsc)->num){                                  // переключатель (от номера мотора)
        case 0: pinOutLow(m1f); pinOutHigh(m1b); break;           //в случае номер мотора равен нулю мотор включаем первый
        case 1: pinOutLow(m2f); pinOutHigh(m2b); break;           //в случае номер мотора равен одному мотор включаем второй
        case 2: pinOutLow(m3f); pinOutHigh(m3b); break;           //в случае номер мотора равен двум мотор включаем третий
        case 3: pinOutLow(m4f); pinOutHigh(m4b); break;           //в случае номер мотора равен трём мотор включаем четвёртый
  }
  ptrMotor(_tsc)->ctrl.timeout = ((int)(ptrMotor(_tsc)->speed)) << SHIFT_SPEED_TIME;
//  ptrMotor(_tsc)->ctrl.timeout = 0 - ptrMotor(_tsc)->speed;
}

/**
 * Отработка паузы для получения заданной скорости мотора
 */
void motorStop(void *_tsc)
{
  int speed = ptrMotor(_tsc)->speed;

  if( speed<0 ){
      speed = MAX_SPEED + speed;
  }else{
      speed = MAX_SPEED - speed;
  }
  if( !speed )
  {
    // Если остаток времени > 0 (была задана не наибольшая скорость):

    ptrMotor(_tsc)->ctrl.timeout = ((int)speed) << SHIFT_SPEED_TIME;
//    ptrMotor(_tsc)->ctrl.timeout = speed;

    switch(ptrMotor(_tsc)->num){                                    // переключатель (от номера мотора)
        case 0: pinOutLow(m1f); pinOutLow(m1b); break;              //в случае номер мотора равен нулю мотор включаем первый
        case 1: pinOutLow(m2f); pinOutLow(m2b); break;              //в случае номер мотора равен одному мотор включаем второй
        case 2: pinOutLow(m3f); pinOutLow(m3b); break;              //в случае номер мотора равен двум мотор включаем третий
        case 3: pinOutLow(m4f); pinOutLow(m4b); break;              //в случае номер мотора равен трём мотор включаем четвёртый
    }
  }
}

const TSC_Step PROGMEM        tblMotor[] = {
/* {   command,  timeout, next} */
   { empty,         1,     0 }                                       // 0: ожидание внешнего запуска.
   ,{ motorForward,  1,     2 }                                      // 1: "вперед": запуск мотора.
   ,{ motorStop,     1,     1 }                                      // 2: останов, регулировка скорости.
   ,{ motorBack,     1,     4 }                                      // 3: "назад": запуск мотора.
   ,{ motorStop,     1,     3 }                                      // 4: останов, регулировка скорости.
};
#define MOTOR_STOP      0         //мотор стоп 0
#define MOTOR_FORWARD   1         //мотор вперёд 1
#define MOTOR_BACK      3         //мотор назад 3

// =================== Главные мозги робота ================== //

#define WAIT_BRAIN 100                                              // думаем 1 раз в 100 миллисекунд
enum { BRAIN_EMPTY, BRAIN_START, BRAIN_ALLDIRS }
struct{
    TSC_Simple ctrl;
    uint8_t    state;
} TSC_Brain;
#define ptrBrain(p)  ((TSC_Brain *)(p))

TSC_Brain      brain;

#define encState PULSE_RAISING

#define LAB_STEP        300                                         // шаг в лабиринте, размер одной клетки 300 мм

void doBrain(void *_tsc)
{
            switch( ptrBrain(_tsc).state ){
            case BRAIN_START:                                       // начальный запуск робота:
            is_alldirs = 0;                                         // .. 1. Все замеры недействительны.
            tsc_simple( &(servoHCSR04.ctrl)                         // .. 2. Запускаем КА серводвигателя:
                , servoHCSR04_end                                   // ..    .. на начало замеров
                , (SG90_180-SG90_0) * SG90_WAIT1 / SG90_STEP1       // ..    .. через наибольшее время поворота в крайнее правое положение!
            );
            tsc_micro_next(&motor[m1_id].ctrl, MOTO_STOP);          // .. 3. Останавливаем левый
            tsc_micro_next(&motor[m4_id].ctrl, MOTO_STOP);          // .. 4. .. и правый моторы.
            ptrBrain(_tsc).state = BRAIN_EMPTY;                     // .. 5. Переходим в состояние "ждем завершения команд"
            break;
            case BRAIN_ALLDIRS:                                     // "осмотрелись": ищем куда можно ехать
            for(uint8_t int=0; int<){}
            break;
    }
    if( is_alldirs == 0 ){                                          // замеры не сделаны: крутим датчиком, осматриваемся.

    }

    // определяем можно ли ехать вперед:
    if( motor[m1_id].ctrl.state == MOTO_STOP )
    {
        tsc_micro_next(&motor[m1_id].ctrl, MOTO_FORWARD);
        pcint2_start( pcint2_init(m1_id, m1e, encState, pcint_encoder, 100));
    }

  if( motor[m1_id].speed >= 0 && motor[m1_id].speed <= MAX_SPEED ){
      motor[m1_id].speed += STEP_SPEED;
  }

  if( motor[m1_id].speed > MAX_SPEED ){ motor[m1_id].speed = STEP_SPEED; }

  Serial.print("state1 = ");
  Serial.println( pulses[m1_id].state, DEC );
  Serial.print("encoder1 = ");
  Serial.println( pulses[m1_id].res, DEC );
  Serial.println("");

  pulses[m1_id].res = 0;
  pulses[m1_id].state = encState;
  pcint2_start(3);

  switch( pulses[m1_id].state ){
  case encState:
      Serial.println( pulses[m1_id].res, DEC );
      break;
  case PULSE_TIMER:
      Serial.print( "timeout. res=" );
      Serial.println( pulses[m1_id].res, DEC );
      pcint2_start(PCINT_pin2number(PCINT, m1e));
  }

}

// *********** начальные установки: **************** //

void setup()
{
  pinModeOut(pinLed);

  servoHCSR04.position  = SG90_0;                       // начинать будем с положения "0"
  servoHCSR04.direction = TO_LEFT;                      // "0" - справа!!
  pwmSetServo(pinServoHCSR04);                          // включаем режим "аппаратное серво" для таймера
  pinModeOut(pinServoHCSR04);                           // и открываем её на "вывод"
  pwmWrite(pinServoHCSR04, servoHCSR04.position);       // устанавливаем серву в правое положение
  tsc_simple( &(servoHCSR04.ctrl)                       // запускаем КА серводвигателя
    , 0                                                 // .. ничего не делать
    , 1                                                 // .. проверять каждую миллисекунду
  );

  pinModeOut(sonicTrig);                                // нога trig датчика HCSR-04 "на выход"
  pinModeIn(sonicEcho);                                 // нога echo датчика на вход
  pulses[sonicId].state = 0;                            // выключаем датчик до завершения поворота серводвигателя

  curMeasure            = 0;                            // настройка номера текущего замера
  curDirection          = 0;                            // .. по направлению (самое правое!)
  is_alldirs            = 0;                            // все замеры НЕ завершены.

  pinModeOut(m1f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m1b);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m2f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m2b);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m3f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m3b);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m4f);                                      // управление моторами тоже ставим "на выход"
  pinModeOut(m4b);                                      // управление моторами тоже ставим "на выход"

  pinModeIn(m1e);                                       // энкодеры моторов "на вход"
  pinModeIn(m2e);                                       // энкодеры моторов "на вход"
  pinModeIn(m3e);                                       // энкодеры моторов "на вход"
  pinModeIn(m4e);                                       // энкодеры моторов "на вход"

  for(uint8_t i=0; i<MAX_MOTORS; i++){
    tsc_init(&motor[i].ctrl,   tblMotor,   0);          // настраиваем КА "Motor" для каждого маршевого мотора
    motor[i].num = i;                                   // сохраняем номер мотора в его КА
    motor[i].speed = 0;                                 // останавливаем мотор
    motor[i].ctrl.started_at = 0;                       // интервалы по 4мксек! "начни сразу как только"
  }

  tsc_simple(&brain, doBrain, 1);                       // выключаем "мозги" роботу

  Serial.begin( 9600 );
}

// *********** повторяем это: ************************//
void loop()
{
  tsc_run( &servoHCSR04.ctrl );                         // шаг серводвигателя датчика расстояний
  tsc_run( &pulses[sonicId].ctrl   );                   // шаг КА датчика: таймаут, запуск, или ничего не делает.
  doHCSR04();                                           // смотрим на состояние датчика и делаем чего надо.
  for(uint8_t i=0; i<MAX_MOTORS; i++){
    tsc_micro_step( &motor[i].ctrl );
//    tsc_step( &motor[i].ctrl );                       // крутим моторы если надо
    tsc_run( &pulses[i].ctrl );                         // контроль таймаута энкодеров моторов
  }
  tsc_run( &brain );                                    // главные мозги робота: ехать, а куда?
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define MOTO_FORWARD                                     //мотор вперёд вкл
#define (m4f)                                            //мотор 4 вперёд
#define (m1f)                                            //мотор 1 вперёд
#define (m2f)                                            //мотор 2 вперёд
#define (m3f)                                            //мотор 3 вперед
#define MOTO_STOp

pinModeOut(m1f);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m1b);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m2f);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m2b);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m3f);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m3b);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m4f);                                         // управление моторами тоже ставим "на выход"
pinModeOut(m4b);                                         // управление моторами тоже ставим "на выход"

switch(ptrMotor(_tsc)->num){                             // переключатель (от номера мотора)
    case 0: pinOutLow(m1f); pinOutLow(m1b); break;       //в случае номер мотора равен нулю мотор включаем первый
    case 1: pinOutLow(m2f); pinOutLow(m2b); break;       //в случае номер мотора равен одному мотор включаем второй
    case 2: pinOutLow(m3f); pinOutLow(m3b); break;       //в случае номер мотора равен двум мотор включаем третий
    case 3: pinOutLow(m4f); pinOutLow(m4b); break;       //в случае номер мотора равен трём мотор включаем четвёртый

switch(ptrMotor(_tsc)->num){                             // переключатель (от номера мотора)
    case 0: pinOutLow(m1f); pinOutLow(m1b); break;       //в случае номер мотора равен нулю мотор включаем первый
    case 1: pinOutLow(m2f); pinOutLow(m2b); break;       //в случае номер мотора равен одному мотор включаем второй
    case 2: pinOutLow(m3f); pinOutLow(m3b); break;       //в случае номер мотора равен двум мотор включаем третий
    case 3: pinOutLow(m4f); pinOutLow(m4b); break;       //в случае номер мотора равен трём мотор включаем четвёртый

pinModeIn(m1e);                                          // энкодеры моторов "на вход"
pinModeIn(m2e);                                          // энкодеры моторов "на вход"
pinModeIn(m3e);                                          // энкодеры моторов "на вход"
pinModeIn(m4e);                                          // энкодеры моторов "на вход"

//#define MAX_SPEED               100                      //максимальная скорость -<100
//#define STEP_SPEED               10                      // Шаг изменения скорости "по умолчанию''" изменить скорость"
//#define SHIFT_SPEED_TIME          3                      // Сдвиг скорости при переводе в микросекунды
//#define MAX_SPEED_TIME   (MAX_SPEED<<SHIFT_SPEED_TIME)   // наибольший период времени для программного ШИМ скорости
//#define MOTOR_STOP      0                               //мотор стоп 0
//#define MOTOR_FORWARD   1                               //мотор вперёд 1
//#define MOTOR_BACK      3                               //мотор назад 3





































