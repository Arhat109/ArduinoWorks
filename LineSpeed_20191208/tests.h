#define speedLeft  drvSpeed(0)
#define speedRight drvSpeed(1)

void setupTests()
{
  Serial.begin(115200);
}

/** Разгон моторов с текущим шагом до заданной скорости */
void testUpSpeed(int maxLeft, int maxRight)
{
  do{
    speedLeft  = addSpeed(speedLeft, maxLeft);
    speedRight = addSpeed(speedRight, maxRight);
    drvPrintMotors(true);
    drvMoveMotors();
  }while( speedLeft < 255 );
}

/** проверка работы моторов и драйвера */
void testMotors1()
{
  // 1. Разгон и движение 1сек по прямой макс. скорость
  STEP = 20;
  testUpSpeed(255, 255);

  // 2. Едем 1 секунду на этой скорости
  {
    unsigned long start;

    start = millis();
    Serial.println("start="); Serial.print(start, DEC);
    while( millis() - start < 1000UL ); // до переполнения, иначе неверно!!!
    Serial.print(", millis"); Serial.println(millis(), DEC);
  }

  // 3. Тормозим
  drvAbsStop(7);
}

/** Проверка расчета минимального радиуса 30см */
void testMotors2()
{
  STEP = 10;
  testUpSpeed(129, 36);
  delay(2000);
  drvStopMotors();
}


