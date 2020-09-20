#include "arhat.h"

//#define TWI_ON    15    // Debug: Включить все режимы обработчика I2C
//#include "arhat_twi.h"  // Debug: Подключить явно тут с заданным комплектом режимов

/**
 * Замена для delay() -- вместо Serial.writeln(); можно воткнуть любой иной код
 * который будет работать пока вывод ждет готовности дисплея, если это долго..
 *//*
#define delay(vrema)                               \
{                                                  \
  static uint8_t t = (uint8_t)millis();            \
  while( (uint8_t)millis() - t < ((uint8_t)vrema)) \
  {                                                \
    Serial.println(vrema);                         \
  }                                                \
}
*/
#define LCD_I2C_SPEED 880000 // Установить типовую скорость (внутри задано 800кгц!)
#define LCD_WAIT_1  26
#include "lcd1602.h"

// ************* Example *********** //

void setup() {
    lcdSetup(0x27, 16, 2, 1);
//    lcdWrite("Hello, Arhat!", 13);
//    lcdSetCursor(0,1);
//    lcdWrite("Bye, Bye..", 10);
//    Serial.begin(115200);
}

void loop()
{
  const char *s=(char *)"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  char ss[16];
  uint32_t  m,om;
  int l;
  float mm;

  delay(1000);

  lcdSetCursor(0,1);
  lcdWrite("                ", 16);

  om=getOvfCount();
  for( uint8_t j=0,jj=0; j < 100; j++){
    lcdSetCursor(0,0);
    lcdWrite(s+jj, 10);
    if( jj++ > 24 ) jj=0;
  }
  m=getOvfCount()-om;

  itoa((int)m, ss, 10);

  lcdSetCursor(0,1);
  l=0;
  while(ss[++l]);
  lcdWrite(ss,l);
}

