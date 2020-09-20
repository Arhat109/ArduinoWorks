#include "arhat.h"
extern "C" {
unsigned long millis(){ return time_millis(); }
}

void setup() {

  Serial.begin(9600);
  Serial.setTimeout(20);
}

void loop() {

  if (Serial.available() > 0) {

    int i = Serial.parseInt();
    char c = Serial.parseInt();
    Serial.print(i);
    Serial.print("  ");
    Serial.println(c);
  }
}
