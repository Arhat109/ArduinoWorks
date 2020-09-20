/**
 * Главный кусок программы: setup() + loop()
 */

#include "leds.h"
#include "motors.h"
#include "sonic.h"
#include "fvnEEPROM.h"
#include "sensors.h"
#include "calculator.h"

#include "tests.h"

unsigned long distTime = 0;

void setup()
{
  setupLeds();
  setupMotors();
  setupSensors();
  setupSonic();
  blinkAll(3, 250, 250);
  delay(3000);

//  setupTests();
  getLevels(); // настройка датчиков и порогов срабатывания
//  printSensors();
//  testMotors1(); // разгон и движение 1сек ШИМ=255. Замер пройденного.
//  testMotors2(); // разгон и движение с минимальным радиусом 30см.

  blinkAll(3, 500, 500);
}

uint8_t isRun = 0; // 0 - останов, 1 - движемся

void loop()
{
//  Serial.println("");
  getSensors();
  calcSpeed();
  if( millis() - distTime > 100 ){ // замер узв. датчиком каждые 100мсек по 2мсек!
    distance = getDistance();
    distTime = millis();
  }else{
    delay(2); // как-бы замеряем расстояние
  }
  if( distance > 300 ){
    isRun = 1;
    drvMoveMotors();
  }else{
    if(isRun == 1){
      drvAbsStop(4);
      isRun = 0;
    }
    blinkAll(3, 150, 150);
    drvStopMotors();
  }
//  delay(1); // цикл движения 3мсек! пролет около 9мм на макс скорости..
}

