// Пример управления светофором через клавиатуру 4х4

#include "ka.h"
#include "myka.h"

// дополнительно будем изображать светофор в виде КА времени (пины 6,7,8)
#include "rgb.h"

// подключаем наш монитор клавиатуры
#include "kbd.h"

// ============== собственно скетч: ===================

void setup() {
  kbdSetup( &glKbd, kbdRows, kbdCols);
  rgbSetup();
  Serial.begin(115200);
}

void loop() {
  kaTimeRun( &rgb );
  kaRun( ptrKaControl(&kbdMonitor) );
}
