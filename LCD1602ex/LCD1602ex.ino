#include "arhat.h"

//#define TWI_ON    15
//#include "arhat_twi.h"

//#define LCD_I2C_SPEED 100000
#include "lcd1602.h"

// ************* Example *********** //

void setup() {
  uint16_t time;

  lcdSetup(0x27, 16, 2, 1);
  lcdWrite("Hello, Arhat!", 13);
  lcdSetCursor(0,1);
  lcdWrite("Bye, Bye..", 10);
}
void loop()  {}

