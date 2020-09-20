#include "arhat.h"
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

//задаем адрес LCD экрана 0x27, 16 символов, 2 строки
LiquidCrystal_I2C lcd(0x27,16,2); 

void setup() {
  lcd.init();               // Инициализируем экран
  lcd.backlight();          //включаем подсветку
  lcd.setCursor(2,0);       // поз.=3, строка=1 (0,0)
  lcd.print("Hi, Andrey!"); //выводим строку 1
  delay(1000);
  lcd.clear();
  lcd.home();
}

char str[2] = {0,0};
void loop() {
  int chr;
  uint8_t row=1;

  for(chr=0; chr<256; chr++){
    if( chr%32 == 0 ){
      delay(5000);
      lcd.clear();
      lcd.home();
      lcd.print(chr);
      delay(1000);
      lcd.clear();
      lcd.home();
    }
    if( chr%16 == 0 ){
      row = 1-row;
      lcd.setCursor(0,row);
    }
    str[0] = (char)chr;
    lcd.print(str);
  }
}
