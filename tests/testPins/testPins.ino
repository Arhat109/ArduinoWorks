
#include "pins.h"

Pin1 varPin1 = pin1;
Pin2 varPin2 = pin2;
Pin3 varPin3;
uint8_t varPin4 = 13;


void setup() {
}

volatile uint8_t val = 0;

void loop() {
  val = 1-val;
  varPin3 = {2,2};

  digitalWrite(varPin4, val);
  setPin1(pin1, val);
  setPin1(varPin1, val);
  setPin2(pin2, val);
  setPin2(varPin2, val);
  setPin3(pin2, val);
  setPin3(varPin3, val);
}

