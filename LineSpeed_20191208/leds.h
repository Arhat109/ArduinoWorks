/**
 * Настройка светодиодов и моргалки разными цветами
 * 
 * Светодиоды слева-направо: красный, жеотый, синий, желтый, красный
 * По 1 светодиоду на каждый датчик
 */

#define MAX_LEDS 5

// Куда подключены светодиоды датчиков:
#define pinRed1     9
#define pinYellow1 10
#define pinBlue    11
#define pinYellow2 12
#define pinRed2    13
#define pinLed  13

/** связь лампочек с датчиками */
uint8_t snLeds[MAX_LEDS] = {9, 10, 11, 12, 13};

void setupLeds()
{
  pinMode(pinRed1, OUTPUT);
  pinMode(pinRed2, OUTPUT);
  pinMode(pinYellow1, OUTPUT);
  pinMode(pinYellow2, OUTPUT);
  pinMode(pinBlue, OUTPUT);
  pinMode(pinLed, OUTPUT);
}

/** Красная моргалка */
void blinkRed(uint8_t count, uint16_t on, uint16_t off)
{
  do{
    digitalWrite(pinRed1, HIGH);
    digitalWrite(pinRed2, HIGH);
    delay(on);
    digitalWrite(pinRed1, LOW);
    digitalWrite(pinRed2, LOW);
    delay(off);
  }while(--count);
}

/** Желтая моргалка */
void blinkYellow(uint8_t count, uint16_t on, uint16_t off)
{
  do{
    digitalWrite(pinYellow1, HIGH);
    digitalWrite(pinYellow2, HIGH);
    delay(on);
    digitalWrite(pinYellow1, LOW);
    digitalWrite(pinYellow2, LOW);
    delay(off);
  }while(--count);
}

/** Синяя моргалка */
void blinkBlue(uint8_t count, uint16_t on, uint16_t off)
{
  do{
    digitalWrite(pinBlue, HIGH);
    delay(on);
    digitalWrite(pinBlue, LOW);
    delay(off);
  }while(--count);
}

/** Белая (всеми) моргалка */
void blinkAll(uint8_t count, uint16_t on, uint16_t off)
{
  do{
    digitalWrite(pinRed1, HIGH);
    digitalWrite(pinRed2, HIGH);
    digitalWrite(pinYellow1, HIGH);
    digitalWrite(pinYellow2, HIGH);
    digitalWrite(pinBlue, HIGH);
    delay(on);
    digitalWrite(pinBlue, LOW);
    digitalWrite(pinYellow1, LOW);
    digitalWrite(pinYellow2, LOW);
    digitalWrite(pinRed1, LOW);
    digitalWrite(pinRed2, LOW);
    delay(off);
  }while(--count);
}

/** Моргалка штатная */
void blink(uint8_t count, uint16_t on, uint16_t off)
{
  while( count-- ){
    digitalWrite(pinLed, HIGH);
    delay(on);
    digitalWrite(pinLed, LOW);
    delay(off);
  }
}

