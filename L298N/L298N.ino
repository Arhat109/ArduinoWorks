int trigPin = 8;
int echoPin = 3;
int dist1 = 80;
int dist2 = 40;
int dist3 = 20;

void setup() {
  Serial.begin (9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

int adc = 0;

void loop() {
  long duration;

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  Serial.print(duration*343/2048);
  
  Serial.print(", s1="); Serial.print(adc=(analogRead(3)-adc/4));
  Serial.print(", s2="); Serial.print(adc=(analogRead(4)-adc/4));
  Serial.print(", s3="); Serial.print(adc=(analogRead(5)-adc/4));
  Serial.print(", s4="); Serial.print(adc=(analogRead(6)-adc/4));
  Serial.print(", s5="); Serial.print(adc=(analogRead(7)-adc/4));
  Serial.println();
  delay(150);
}
