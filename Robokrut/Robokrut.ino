#include "arhat.h"
#include "tcs3200.h"
#include "Wire.h"
#include <LiquidCrystal_I2C.h>

//задаем адрес LCD экрана 0x27, 16 символов, 2 строки
LiquidCrystal_I2C lcd(0x27,16,2); 

// ====================== Настройка и работа с моторами     ========================= //
#include "motors.h"

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

// ====================== Настройка и работа с датчиками цвета ========================= //

#define BW_LEVEL 100

uint8_t sensors[2];

void getSensors()
{
    if(tcsCurrent != 0 && tcsCurrent != 1 ){
      lcd.setCursor(0, 0);
      lcd.print("ERR=");
      lcd.print(tcsCurrent);
      lcd.print("  ");
      return;
    }

  if( tcsColor == TCS_NOCOLOR )
  {
    lcd.setCursor(0, 0);
    lcd.print(tcsWait);
    lcd.print(" ");
    lcd.print(tcsCurrent);
    lcd.print(" ");
    lcd.setCursor(0, 1);
    lcd.print(tcsColors[tcsCurrent][0]);
    lcd.print("  ");

    sensors[tcsCurrent] = (tcsColors[tcsCurrent][0] > BW_LEVEL? 0 : 1);

    if( ++ tcsCurrent >= TCS_MAX_SENSORS ) tcsCurrent = 0;

    tcsPrepare(tcsCurrent);
  }
}

// ====================== Настройка и работа с временем реакции и состояниями системы ========================= //

int     waitTime;         // изменять состояние: каждая 1мсек -- это 0.75мм пути на максимальной скорости!!!
uint8_t isGo;             // признак продолжения работы или принудительный останов для отладки

enum AllStates {
  WHITES              // оба датчика видят белое
  , LEFT              // левый датчик видит черное
  , RIGHT             // правый датчик видит черное
  , BLACKS            // оба датчика видят черное - перекресток!
};
AllStates oldState = WHITES;  // предыдущее состояние изначально - "все белое".
uint8_t   oldCount = 0;       // количество повторов предыдущего состояния "подряд"
uint8_t   maxCount = 0;       // количество пропусков предыдущего этого же состояния "подряд" (задержка пред. команды)

void Brain()
{
  AllStates newState = (AllStates)(sensors[0] + 2*sensors[1]);
/*
  Serial.println("");
  Serial.print("loop=");
  Serial.print(getOvfCount(), DEC);
  Serial.print("old=");
  Serial.print(oldState, DEC);
  Serial.print("::");
  Serial.print(oldCount, DEC);
  Serial.print(", new=");
  Serial.print(newState, DEC);
*/
  switch(newState){
    case BLACKS:
    case WHITES:
    {
      // едем прямо, медленно ускоряемся:
      int adding = (speedLeft - speedRight)*3/4;  // слегка восстанавливаем обратное движение
      if( adding != 0 ) {
        if(oldCount >= 2){                       // точно выравниваем скорость только на второй раз!
          adding = (speedLeft - speedRight)/2;
        }
        addSpeedLeft(-adding);
        addSpeedRight(adding);
      }else{
        if( oldCount>=1 ){
          adding = 2;                  // ЭТО скорость разгона по прямой!
          addSpeedLeft(adding);
          addSpeedRight(adding);
          oldCount = 0;
        }
      }
    }
/*
      Serial.print(", F: l=");
      Serial.print(speedLeft, DEC);
      Serial.print(", r=");
      Serial.print(speedRight, DEC);
*/
      lcd.setCursor(10,0);            // поз.=3, строка=1 (0,0)
      lcd.print(" ^ ");
      lcd.setCursor(10,1);            // поз.=3, строка=1 (0,0)
      lcd.print(" I ");

      break;

    case LEFT:
      // если впервые:
      if( oldState != newState )
      {
        // ехали куда-то, первый раз НАЛЕВО (сбились слегка или начало поворота):
        int adding = speedLeft+speedRight;
        int subs;

        if( adding <= (MIN_SPEED_L+MIN_SPEED_R)*2 )
        {
          // ехали медленно: сумма скоростей меньше минимальной -- малый доворот
          adding /= 8;
          subs = adding/2;
          maxCount = 4;
        }else if( adding < (MAX_SPEED_L+MAX_SPEED_R-(MAX_SPEED_L+MAX_SPEED_R)/4))
        {
          // ехали пошустрее: от минимальной до 3/4 максимальной!
          adding /= 4;
          subs = -adding/4;
          maxCount = 3;
        }else{
          // скорость выше критической! резкое торможение, иначе проскочим линию!
          motorStop(M_LEFT);         // останавливаем левый
          addSpeedRight(-adding/4);  // тормозим правый на половину его скорости (четверть суммы!)
          maxCount = 5;
          oldCount = 1;
          oldState = newState;
          return;
        }
        addSpeedLeft(-adding);
        addSpeedRight(subs);
      } else {                                        // УЖЕ было НАЛЕВО: sl/sr=[<76/<100; <94/<164; stop/<94], max/min=220/50
        int dcount = oldCount - maxCount;             // номер попытки, если больше maxCount

        if( dcount > 0 ){
//        Serial.print(", LO: old=");
//        Serial.print(oldCount, DEC);
          everyOVF(12,{
//            Serial.print(" ovf ");
            if( dcount == 1 ){                         // 1 попытка: выравниваем скорость поворота:
              speedLeft = MIN_SPEED_L-1;
              speedRight = MIN_SPEED_R+MIN_SPEED_R/2;
            }else{                                     // 2 и далее: мало, увеличиваем скорость поворота:
              addSpeedRight(4);
            }
          });
        }
      }
/*
      Serial.print(", L: l=");
      Serial.print(speedLeft, DEC);
      Serial.print(", r=");
      Serial.print(speedRight, DEC);
*/
      lcd.setCursor(10,0);            // поз.=3, строка=1 (0,0)
      lcd.print("<  ");
      lcd.setCursor(10,1);            // поз.=3, строка=1 (0,0)
      lcd.print(" I ");

      break;

    case RIGHT:
      if( oldState != newState ) {    // ехали куда-то, а теперь НАПРАВО (сбились слегка или начало поворота):
        // ехали куда-то, первый раз НАПРАВО (сбились слегка или начало поворота):
        int adding = speedLeft+speedRight;

        if( adding <= (MIN_SPEED_L+MIN_SPEED_R)*2 )
        {
          // ехали медленно: сумма скоростей меньше минимальной -- малый доворот
          adding /= 8;
          maxCount = 4;
        }else if( adding < (MAX_SPEED_L+MAX_SPEED_R-(MAX_SPEED_L+MAX_SPEED_R)/4))
        {
          // ехали пошустрее: от минимальной до 3/4 максимальной!
          adding /= 4;
          maxCount = 3;
        }else{
          // скорость выше критической! резкое торможение, иначе проскочим линию!
          motorStop(M_RIGHT);       // останавливаем правый
          addSpeedLeft(-adding/4);  // тормозим левый на половину его скорости (четверть суммы!)
          oldCount = 1;
          oldState = newState;
          maxCount = 5;
          return;
        }
        addSpeedRight(-adding);
        addSpeedLeft(adding/4);
      } else {                             // уже было НАПРАВО: как давно длится требование поворота? выполняем крутой поворот
        int dcount = oldCount - maxCount;  // номер попытки, если больше maxCount

        if( dcount > 0 ){
//        Serial.print(", RO: old=");
//        Serial.print(oldCount, DEC);
          everyOVF(12,{
//            Serial.print(" ovf ");
            if( dcount == 1 ){                         // 1 попытка: выравниваем скорость поворота:
              speedRight = MIN_SPEED_R-1;
              speedLeft  = MIN_SPEED_L+MIN_SPEED_L/2;
            }else{                                     // 2 и далее: мало, увеличиваем скорость поворота:
              addSpeedLeft(4);
            }
          });
        }
      }
/*
      Serial.print(", R: l=");
      Serial.print(speedLeft, DEC);
      Serial.print(", r=");
      Serial.print(speedRight, DEC);
*/
      lcd.setCursor(10,0);            // поз.=3, строка=1 (0,0)
      lcd.print("  >");
      lcd.setCursor(10,1);            // поз.=3, строка=1 (0,0)
      lcd.print(" I ");

      break;
    }

    lcd.setCursor(5,0);
    lcd.print(speedLeft);
    lcd.print(" ");
    lcd.setCursor(5,1);
    lcd.print(speedRight);
    lcd.print(" ");

    lcd.setCursor(15,0);
    if( speedLeft > MIN_SPEED_L ){
      motorForward(M_LEFT);
      lcd.print(" ");
    }else{
      motorStop(M_LEFT);
      lcd.print("S");
    }

    lcd.setCursor(15,1);
    if( speedRight > MIN_SPEED_R ){
      motorForward(M_RIGHT);
      lcd.print(" ");
    }else{
      motorStop(M_RIGHT);
      lcd.print("S");
    }

    if( oldState != newState ){ oldCount = 1; }
    else                      { oldCount++;   }
    oldState = newState;
}

void setup()
{
//  Serial.begin(115200);
  lcd.init();                          // Инициализируем экран
  lcd.backlight();                     // включаем подсветку
  lcd.setCursor(0,0);
  lcd.print("Hi, Andrey!");  // выводим строку 1
  lcd.setCursor(0,1);
  lcd.print("loading ...");  // выводим строку 1

  tcsSetup();
  tcsModes = TCS_SPEED_CONST | TCS_NOT_LUKSES | TCS_WB_ONLY;
  tcsCurrent = 0;

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

  pinModeOut(trigPin);
  pinModeIn(echoPin);
  pulses2[0].state = HCSR04_START;
  tsc_simple( &pulses2[0].ctrl, 0, 1);
  distance = 5000;

  // настройка маршевых моторов:
  pinMode(m1f, OUTPUT);
  pinMode(m1b, OUTPUT);
  pinMode(m4f, OUTPUT);
  pinMode(m4b, OUTPUT);
  motorStop(M_LEFT);
  motorStop(M_RIGHT);

  timerControl(2, B) = 4;          // частота ШИМ: 1 -- 31.25кГц, 2 -- 3,9 кГц, 3 -- 488гц(!), 4 -- 122гц, 5 -- 30гц
  pwmSet(m1s);
  pwmSet(m4s)
  pinMode(m1s, OUTPUT);
  pinMode(m4s, OUTPUT);
  speedLeft = MIN_SPEED_L;
  speedRight = MIN_SPEED_R;

  waitTime = 4;                    // реакция на события примерно каждые 4 мсек.
  isGo = 1;
  oldState = WHITES;               // изначально "было"="все датчики на белом"
  delay(2000);                     // задержка setup() на случай потери питания "на ходу", чтобы сразу было видна перезагрузка МК.

  lcd.setCursor(0,0);
  lcd.print("               ");
  lcd.setCursor(0,1);
  lcd.print("               ");
}

//unsigned long startTime=0;       // только отладка: проверка скорости за 1 сек!

void loop()
{
  getSensors();
  tsc_run( &pulses2[0].ctrl );
  doHCSR04(&pulses2[0]);

  if( isGo == 0 ) {                // принудительный останов для отладки
    motorStop(M_LEFT);
    motorStop(M_RIGHT);
    return;
  }

  if( distance < MIN_DISTANCE )
  {
    lcd.setCursor(14,0);
    lcd.print("D");
    // препятствие ближе предельной дальности, выключаем всё:
    motorStop(M_LEFT);
    motorStop(M_RIGHT);
    return;
  }
/*
  if( startTime == 0 )   startTime = getOvfCount();
  if( getOvfCount() - startTime > 976 ){
    motorStop(M_LEFT);
    motorStop(M_RIGHT);
    return;
  }
  speedLeft = 250; //MIN_SPEED_L;
  speedRight = 250; //MIN_SPEED_R;
  motorForward(M_LEFT);
  motorForward(M_RIGHT);
  return;
*/
  everyOVF(waitTime, Brain() );
}

