#include "arhat.h"

// ====================== Настройка и чтение состояния датчиков линии ========================= //

#define sL1 15
#define sL2 16
//#define sM 17
//#define sR1 18
//#define sR2 19
#define BLACK HIGH
#define WHITE LOW
#define MAX_COUNT     5
#define IS_BLACK      2
#define MAX_SENSORS   2
uint8_t sensors[MAX_SENSORS];
uint8_t oldSensors[MAX_SENSORS];

uint8_t getSensors()
{
  uint8_t i,num;

  for(i=0; i<MAX_SENSORS; i++){
    sensors[i] = WHITE;
  }
  for(num=MAX_COUNT; num>0; num--){
    sensors[0] += digitalRead(sL1);
    delayMicro8(3);
    sensors[1] += digitalRead(sL2);
    delayMicro8(3);
  }
  for(i=0; i<MAX_SENSORS; i++){
    sensors[i] = (sensors[i] >= IS_BLACK? BLACK : WHITE );
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
 * Внутренние состояния датчика и его действия:
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

int addAngle(int delta)
{
  int newAngle = srvAngle + delta;
  if( delta>0 ){
    if(newAngle > deg180) return deg180;
  }else{
    if(newAngle < deg0) return deg0;
  }
  return newAngle;
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

#define MAX_SPEED_L 240
#define MIN_SPEED_L 105
#define MAX_SPEED_R 240
#define MIN_SPEED_R 105
int  speedLeft;
int  speedRight;
int  delta = 10;

uint8_t addSpeedLeft(int delta)
{
  int newSpeed = (int)speedLeft + delta;
  if( delta>=0 ){
    if( newSpeed > MAX_SPEED_L ) return MAX_SPEED_L;
  }else{
    if( newSpeed < MIN_SPEED_L ) return MIN_SPEED_L;
  }
  return (uint8_t)newSpeed;
}

uint8_t addSpeedRight(int delta)
{
  int newSpeed = (int)speedRight + delta;
  if( delta>=0 ){
    if( newSpeed > MAX_SPEED_R ) return MAX_SPEED_R;
  }else{
    if( newSpeed < MIN_SPEED_R ) return MIN_SPEED_R;
  }
  return (uint8_t)newSpeed;
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

int waitTime = 4;  // изменять состояние: каждая 1мсек -- это 0.75мм пути на максимальной скорости!!!

enum AllStates {
  WHITES              // оба датчика видят белое
  , LEFT              // левый датчик видит черное
  , RIGHT             // правый датчик видит черное
  , BLACKS            // оба датчика видят черное - перекресток!
};
AllStates oldState = WHITES;  // предыдущее состояние изначально - "все белое".

//uint8_t  isAll = 0;
//uint16_t countLoop = 0;
//uint16_t countSLW, countSLB, countSRW, countSRB;
//uint32_t startTime;

void setup()
{
//  Serial.begin(9600);
  pinMode(pinLed, OUTPUT);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);
  delay(300);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);
  delay(300);
  digitalWrite(pinLed, HIGH);
  delay(100);
  digitalWrite(pinLed, LOW);

  pinMode(sL1, INPUT);
  pinMode(sL2, INPUT);
  for(uint8_t i=0; i<MAX_SENSORS; i++){
    oldSensors[i] = WHITE;
  }

  pinModeOut(trigPin);
  pinModeIn(echoPin);
  pulses2[0].state = HCSR04_START;
  tsc_simple( &pulses2[0].ctrl, 0, 1);
  distance = 5000;
  
  pwmSetServo(servoPin);
  pinModeOut(servoPin);
  srvAngle = deg90;
  analogWrite(servoPin, srvAngle);

  pinMode(m1f, OUTPUT);
  pinMode(m1b, OUTPUT);
  pinMode(m4f, OUTPUT);
  pinMode(m4b, OUTPUT);
  motorStop(M_LEFT);
  motorStop(M_RIGHT);

  timerControl(2, B) = 5; // частота ШИМ: 1 -- 31.25кГц, 2 -- 3,9 кГц, 3 -- 488гц(!), 4 -- 122гц, 5 -- 30гц
  pwmSet(m1s);
  pwmSet(m4s)
  pinMode(m1s, OUTPUT);
  pinMode(m4s, OUTPUT);
  speedLeft = MAX_SPEED_L;
  speedRight = MAX_SPEED_R;

//  countSLW = countSLB = countSRW = countSRB = 0;
  delay(2000);
}

void loop()
{
  AllStates newState;  // новое (текущее) состояние датчиков

  tsc_run( &pulses2[0].ctrl );
  doHCSR04(&pulses2[0]);
  getSensors();

  if( distance < MIN_DISTANCE )
  {
    // препятствие ближе предельной дальности, выключаем всё:
    motorStop(M_LEFT);
    motorStop(M_RIGHT);
    srvAngle = deg90;
    analogWrite(servoPin, srvAngle);
//    isAll = 0;
//    countLoop = 0;
//    countSLW = countSLB = countSRW = countSRB = 0;
    return;
  }else{
/*    speedLeft  = 110;
    speedRight = 110;
    motorForward(M_LEFT);
    motorForward(M_RIGHT);
    return;

    if( isAll == 1 ) return;
    if( countLoop == 0 ){ startTime = getOvfCount(); }

    if( getOvfCount() - startTime >= 976 ){
      Serial.print("OvfCount=");
      Serial.print(getOvfCount(), DEC);
      Serial.print(", startTime=");
      Serial.print(startTime, DEC);
      Serial.print(", loops=");
      Serial.print(countLoop, DEC);
      Serial.print(", left-blacks=");
      Serial.print(countSLB, DEC);
      Serial.print(", left-whites=");
      Serial.print(countSLW, DEC);
      Serial.print(", right-blacks=");
      Serial.print(countSRB, DEC);
      Serial.print(", right-whites=");
      Serial.print(countSRW, DEC);
      Serial.println("");
      isAll = 1;
      return;
    }else{
      countLoop++;

      if( sensors[0] == BLACK ) countSLB++;
      else                      countSLW++;

      if( sensors[1] == BLACK ) countSRB++;
      else                      countSRW++;
    }
*/
  }
  everyOVF(waitTime,
  {
  newState = (AllStates)(sensors[0] + 2*sensors[1]);

  switch(oldState){
    case WHITES:
    case BLACKS:
      switch(newState){
        case WHITES:
        case BLACKS:
          // как ехали прямо ТАК И едем прямо, ускоряемся:
          speedLeft  = addSpeedLeft(delta);
          speedRight = addSpeedRight(delta);
          srvAngle = deg90;
          break;
        case LEFT:
          // ехали прямо, теперь НАЛЕВО (сбились слегка или начало поворота):
          // .. притормаживаем левым и увеличиваем угол:
          srvAngle = addAngle(speedLeft/2); //addAngle(srvStep);
          speedLeft  = addSpeedLeft(-8 * delta);
          speedRight = addSpeedRight(-4 * delta);
          break;
        case RIGHT:
          // ехали прямо, теперь НАПРАВО (сбились слегка или начало поворота):
          // .. притормаживаем правым и уменьшаем угол:
          srvAngle = addAngle(-1*(speedRight/2)); //addAngle(-srvStep);
          speedRight = addSpeedRight(-8 * delta);
          speedLeft  = addSpeedLeft(-4 * delta);
          break;
      }
      break;
    case LEFT:
      switch(newState){
        case WHITES:
        case BLACKS:
          // был поворот налево теперь едем прямо:
          // .. ускоряем левый и уменьшаем поворот влево
          speedLeft  = addSpeedLeft(delta);
          srvAngle = addAngle(-srvStep/4);
          break;
        case LEFT:
          // был поворот налево НАДО ЕЩЁ ЛЕВЕЕ:
          speedLeft  = addSpeedLeft(-4 * delta);
          speedRight = addSpeedRight(delta);
          srvAngle = addAngle(srvStep/2);
          break;
        case RIGHT:
          // был поворот налево, теперь НАПРАВО:
          speedLeft  = addSpeedLeft(delta);
          srvAngle = addAngle(-srvStep/4);
          break;
      }
      break;
    case RIGHT:
      switch(newState){
        case WHITES:
        case BLACKS:
          // был поворот направо теперь едем прямо:
          // .. ускоряем правый и уменьшаем поворот вправо
          speedRight = addSpeedRight(delta);
          srvAngle = addAngle(srvStep/4);
          break;
        case RIGHT:
          // был поворот направо НАДО ЕЩЁ ПРАВЕЕ:
          speedRight = addSpeedRight(-4 * delta);
          speedLeft  = addSpeedLeft (delta);
          srvAngle = addAngle(-srvStep/2);
          break;
        case LEFT:
          // был поворот направо теперь теперь НАЛЕВО:
          speedRight = addSpeedRight(delta);
          srvAngle = addAngle(srvStep/4);
          break;
      }
      break;
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
//    for(uint8_t i=0; i<MAX_SENSORS; i++){
//      oldSensors[i] = sensors[i];
//    }
  });

}

