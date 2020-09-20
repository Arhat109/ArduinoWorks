#include "arhat.h"

// ====================== Настройка и чтение состояния датчиков линии ========================= //

#define sL1 15
#define sL2 16

#define BLACK HIGH
#define WHITE LOW

#define MAX_SENSORS   2              // всего датчиков
#define MAX_COUNT     8              // кол-во замеров для усреднения
#define IS_BLACK      2              // порог "это черное"

uint8_t sensors[MAX_SENSORS];        // усредненное, итоговое состояние датчиков линии
uint8_t _sens[MAX_SENSORS];          // внутреннее хранение для усреднения данных с датчиков
uint8_t sensCount = 0;               // текущий счетчик сколько раз считали датчики

/**
 * Замер и статическое усреднение датчиков линии.
 */
void getSensors()
{
  uint8_t i;

  if( sensCount == 0 ){
    i=MAX_SENSORS;
    while(i > 0){
      _sens[--i] = WHITE;
    }
  }
  _sens[0] += digitalRead(sL1);
  _sens[1] += digitalRead(sL2);
  sensCount++;

  if( sensCount >= MAX_COUNT ){
    sensCount = 0;
    for(i=0; i<MAX_SENSORS; i++){
      sensors[i] = (_sens[i] >= IS_BLACK? BLACK : WHITE );
    }
  }
}

// ====================== Настройка и работа с УЗВ датчиком ========================= //

#define MIN_DISTANCE  200
uint16_t distance;
#define PCINT         2
#define MAX_PULSES2   1
#define trigPin      14
#define echoPin      69
#define PULSE_ID      0
#include "hcsr04.h"

/**
 * Внутренние состояния УЗВ. датчика и его действия:
 */
void doHCSR04(void *_tsc)
{
    switch( ptrPulse(_tsc)->state ) {
    case HCSR04_START:
      tsc_simple((TSC_Simple *)_tsc, startTrig14, 1);   // запуск замера датчиком:
      ptrPulse(_tsc)->state = 0;                        // .. сброс состояния, чтобы ничего в switch не делать... нечего. Просто ждем.
      break;
    case PULSE_OK:                                      // замер произведен, данные - действительны:
      distance = getDistance(ptrPulse(_tsc));
      ptrPulse(_tsc)->state = HCSR04_START;             // ошибка. Перезапуск попытки замера.
      break;
    case PULSE_TIMER:                                   // или сработал КА по таймауту.
    case PULSE_ERROR:
//      distance = 5000;                                  // .. слишком далеко, заменяем на предельно измеряемое расстояние в мм.
      ptrPulse(_tsc)->state = HCSR04_START;             // ошибка. Перезапуск попытки замера.
      break;
    }
}

// ====================== Настройка и работа с поворотным серводвигателем ========================= //

#define servoPin     3
#define deg0         140
#define deg180       620
#define deg90        (deg180+deg0)/2
int     srvStep = 60;
int     srvAngle;

void addAngle(int delta)
{
  int newAngle = srvAngle + delta;
  if( delta>0 ){
    if(newAngle > deg180) newAngle = deg180;
  }else{
    if(newAngle < deg0) newAngle = deg0;
  }
  srvAngle = newAngle;
}

// ====================== Настройка и работа с маршевыми моторами ========================= //

#define M_LEFT 1
#define m1f 22
#define m1b 23
#define m1s 9

#define M_RIGHT 4
#define m4f 28
#define m4b 29
#define m4s 10

#define MAX_SPEED_L 255
#define MIN_SPEED_L 115
#define MAX_SPEED_R 255
#define MIN_SPEED_R 115
int  speedLeft;
int  speedRight;
int  delta = 10;

void addSpeedLeft(int delta)
{
  int newSpeed = (int)speedLeft + delta;
  if( delta>=0 ){
    if( newSpeed > MAX_SPEED_L ) newSpeed = MAX_SPEED_L;
  }else{
    if( newSpeed < MIN_SPEED_L ) newSpeed = MIN_SPEED_L;
  }
  speedLeft = (uint8_t)newSpeed;
}

void addSpeedRight(int delta)
{
  int newSpeed = (int)speedRight + delta;
  if( delta>=0 ){
    if( newSpeed > MAX_SPEED_R ) newSpeed = MAX_SPEED_R;
  }else{
    if( newSpeed < MIN_SPEED_R ) newSpeed = MIN_SPEED_R;
  }
  speedRight = (uint8_t)newSpeed;
}

void motorStop(uint8_t num)
{
  switch(num){
    case M_LEFT:
      digitalWrite(m1f, LOW);
      digitalWrite(m1b, LOW);
      speedLeft = MIN_SPEED_L;
      break;
    case M_RIGHT:
      digitalWrite(m4f, LOW);
      digitalWrite(m4b, LOW);
      speedRight = MIN_SPEED_R;
      break;
  }
}

void motorForward(uint8_t num)
{
  switch(num)
  {
  case M_LEFT:
    digitalWrite(m1b, LOW);
    digitalWrite(m1f, HIGH);
    analogWrite(m1s, speedLeft);
    break;
  case M_RIGHT:
    digitalWrite(m4b, LOW);
    digitalWrite(m4f, HIGH);
    analogWrite(m4s, speedRight);
    break;
  }
}

void motorBack(uint8_t num)
{
  switch(num)
  {
    case M_LEFT:
      digitalWrite(m1f, LOW);
      digitalWrite(m1b, HIGH);
      analogWrite(m1s, speedLeft);
      break;
    case M_RIGHT:
      digitalWrite(m4f, LOW);
      digitalWrite(m4b, HIGH);
      analogWrite(m4s, speedLeft);
      break;
  }
}

// ====================== Настройка и работа с временем реакции и состояниями системы ========================= //

int waitTime;         // изменять состояние: каждая 1мсек -- это 0.75мм пути на максимальной скорости!!!

enum AllStates {
  WHITES              // оба датчика видят белое
  , LEFT              // левый датчик видит черное
  , RIGHT             // правый датчик видит черное
  , BLACKS            // оба датчика видят черное - перекресток!
};
AllStates oldState = WHITES;  // предыдущее состояние изначально - "все белое".

void Brain()
{
  AllStates newState = (AllStates)(sensors[0] + 2*sensors[1]);

    switch(oldState){
      case WHITES:
      case BLACKS:
        switch(newState){
          case WHITES:
          case BLACKS:
            // как ехали прямо ТАК И едем прямо, ускоряемся:
            // 255-115=140/2=70 циклов разгона по 4мсек = 0.28сек
            // Если руль не прямо - выпрямляем постепенно:
            {
              int adding = (speedLeft - speedRight)/2;
              if( adding != 0 ) {
                addSpeedLeft(-adding);
                addSpeedRight(adding);
              }else{
                adding = 2;
                addSpeedLeft(adding);
                addSpeedRight(adding);
              }
              adding = (deg90 - srvAngle);
              if( adding > srvStep ) adding = srvStep;
              if( adding < -srvStep ) adding = -srvStep;
              addAngle(adding);
            }
            waitTime = 4;
            break;
          case LEFT:
            // ехали прямо, теперь НАЛЕВО (сбились слегка или начало поворота):
            // .. поворот только рулем, притормаживаем:
            addAngle(srvStep/2);
            addSpeedLeft(-delta);
            addSpeedRight(-delta);
            waitTime = 16;
            break;
          case RIGHT:
            // ехали прямо, теперь НАПРАВО (сбились слегка или начало поворота):
            // .. поворот только рулем, притормаживаем:
            addAngle(-srvStep/2);
            addSpeedRight(-delta);
            addSpeedLeft(-delta);
            waitTime = 16;
            break;
        }
        break;
      case LEFT:
        switch(newState){
          case LEFT:
            // был поворот налево НАДО ЕЩЁ ЛЕВЕЕ:
            addAngle(srvStep/2);
            {
              int adding = (deg90 - srvAngle)/8;
              addSpeedLeft(adding);
              addSpeedRight(-adding);
            }
            waitTime = 16;
            break;
          case WHITES:
          case BLACKS:
            // был поворот налево теперь едем прямо:
            // .. ускоряем левый и уменьшаем поворот влево
            addAngle(-srvStep/2);
            waitTime = 8;
            break;
          case RIGHT:
            // был поворот налево, теперь НАПРАВО:
        motorStop(M_LEFT);
        motorStop(M_RIGHT);
        waitTime = 3000;
            break;
        }
        break;
      case RIGHT:
        switch(newState){
          case RIGHT:
            // был поворот направо НАДО ЕЩЁ ПРАВЕЕ:
            addAngle(-srvStep/2);
            {
              int adding = (deg90 - srvAngle)/8;
              addSpeedLeft(adding);
              addSpeedRight(-adding);
            }
            waitTime = 16;
            break;
          case WHITES:
          case BLACKS:
            // был поворот направо теперь едем прямо:
            // .. ускоряем правый и уменьшаем поворот вправо
            addAngle(srvStep/2);
            waitTime = 8;
            break;
          case LEFT:
            // был поворот направо теперь теперь НАЛЕВО:
        motorStop(M_LEFT);
        motorStop(M_RIGHT);
        waitTime = 3000;
            break;
        }
    }
  
    analogWrite(servoPin, srvAngle);

    if( speedLeft > MIN_SPEED_L ){
      motorForward(M_LEFT);
    }else{
      motorStop(M_LEFT);
    }

    if( speedRight > MIN_SPEED_R ){
      motorForward(M_RIGHT);
    }else{
      motorStop(M_RIGHT);
    }

    oldState = newState;
}

void setup()
{
//  Serial.begin(9600);

  // моргалка для контроля (пере)запуска МК:
  pinMode(pinLed, OUTPUT);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);
  delay(100);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);
  delay(100);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);

  // датчики линии: "вход" и "всё белое".
  pinMode(sL1, INPUT);
  pinMode(sL2, INPUT);
  for(uint8_t i=0; i<MAX_SENSORS; i++){
    sensors[i] = WHITE;
  }
  sensCount = 0;

  pinModeOut(trigPin);
  pinModeIn(echoPin);
  pulses2[0].state = HCSR04_START;
  tsc_simple( &pulses2[0].ctrl, 0, 1);
  distance = 5000;

  // настройка рулевого серводвигателя:  
  pwmSetServo(servoPin);
  pinModeOut(servoPin);
  srvAngle = deg90;
  analogWrite(servoPin, srvAngle);

  // настройка маршевых моторов:
  pinMode(m1f, OUTPUT);
  pinMode(m1b, OUTPUT);
  pinMode(m4f, OUTPUT);
  pinMode(m4b, OUTPUT);
  motorStop(M_LEFT);
  motorStop(M_RIGHT);

  timerControl(2, B) = 1;          // частота ШИМ: 1 -- 31.25кГц, 2 -- 3,9 кГц, 3 -- 488гц(!), 4 -- 122гц, 5 -- 30гц
  pwmSet(m1s);
  pwmSet(m4s)
  pinMode(m1s, OUTPUT);
  pinMode(m4s, OUTPUT);
  speedLeft = MIN_SPEED_L;
  speedRight = MIN_SPEED_R;

  waitTime = 4;                    // реакция на события примерно каждые 4 мсек.
  oldState = WHITES;               // изначально "было"="все датчики на белом"
  delay(2000);                     // задержка setup() на случай потери питания "на ходу", чтобы сразу было видна перезагрузка МК.
}

void loop()
{
  AllStates newState;  // новое (текущее) состояние датчиков

  tsc_run( &pulses2[0].ctrl );
  doHCSR04(&pulses2[0]);
  getSensors();                      // накапливаем состояние датчиков.

  if( distance < MIN_DISTANCE )
  {
    // препятствие ближе предельной дальности, выключаем всё:
    motorStop(M_LEFT);
    motorStop(M_RIGHT);
    srvAngle = deg90;
    analogWrite(servoPin, srvAngle);
    return;
  }
  
  everyOVF(waitTime, Brain() );
}

