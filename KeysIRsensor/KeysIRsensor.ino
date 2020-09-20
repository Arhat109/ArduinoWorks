int inIRpin = 22;
int enIRpin = 23;
byte IRsensor;

int count = 0;

void setup() {                
  pinMode(inIRpin, INPUT);
  pinMode(enIRpin, OUTPUT);
  
  digitalWrite(enIRpin, LOW);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(13, HIGH);
  delay(100);
  IRsensor = digitalRead(inIRpin);
  if(IRsensor == LOW) { Serial.print("..Ah!.."); Serial.println(++count); }
  digitalWrite(13, LOW);
  delay(100);
}
