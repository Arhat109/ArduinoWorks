void setup() {
  delay(3000);
  for(uint8_t i=0; i<70; i++){ pinMode(i, OUTPUT); }
}

void loop() {
  for(int8_t j=1; j>=0; j--){
    for(uint8_t i=0; i<70; i++){ digitalWrite(i, j); }
    delay(500);
  }
}
