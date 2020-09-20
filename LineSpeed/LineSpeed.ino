/**
 * Главный кусок программы: setup() + loop()
 */

#include "common.h"
#include "sensors.h"
#include "motors.h"
#include "calculator.h"
#include "fvnEEPROM.h"

void setup()
{
  setupMotors();
  setupSensors();
}

void loop()
{
  int8_t dir;

  getSensors( false );

  dir = calcDir();
  if     ( dir == 0 ){ calcForward();        } // едем прямо
  else if( dir > 0  ){ calcTurn(dir, 1, 0);  } // едем направо: правое(0) - внутреннее колесо, левое(1) - внешнее.
  else               { calcTurn(-dir, 0, 1); } // едем налево: ошибка снова >0! и колеса - наоборот..

  calcPredictor(); // предсказатель крутого поворота тут..

  moveMotors();
  delay(2);
}

