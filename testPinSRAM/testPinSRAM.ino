//#include "arhat.h"

#define PIN 12
//#define byte unsigned char

byte state = 0; // Можно объявить локально, но мы специально делаем неоптимально

void setup() {
   byte locState = 0;
   unsigned long startTime;
  
   pinMode(PIN, OUTPUT);
   Serial.begin(9600);
// 1. Global state variable:
   startTime = millis();
   for (long i=0; i<1000000; i++) {
     state = !state;
     digitalWrite(PIN, state);        
   }
   Serial.print("Time for global state = ");
   Serial.println(millis()-startTime, DEC);

// 2. Local state control without functions:
   startTime = millis();
   for (long i=0; i<1000000; i++) {
     locState = !locState;
     digitalWrite(PIN, locState);        
   }
   Serial.print("Time for local = ");
   Serial.println(millis()-startTime, DEC);

// 3. Pin state control:
   startTime = millis();
   for (long i=0; i<1000000; i++) {
     digitalWrite(PIN, !digitalRead(PIN));        
   }
   Serial.print("Time for pin state control = ");
   Serial.println(millis()-startTime, DEC);
}

void loop() {
}

