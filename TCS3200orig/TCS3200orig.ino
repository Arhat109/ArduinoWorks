#include "arhat.h"

#define out 2
#define s0 3
#define s1 4
#define s2 5
#define s3 6
#define oe 7

uint32_t red=0, green=0, blue=0, white=0;

volatile uint32_t counter=0;

void ISR(INTO)
{
  counter++;
}

void setup()
{
  Serial.begin(115200);

  pinMode(s0,OUTPUT);
  pinMode(s1,OUTPUT);
  pinMode(s2,OUTPUT);
  pinMode(s3,OUTPUT);
  pinMode(oe,OUTPUT);

  digitalWrite(s1,HIGH);
  digitalWrite(s0,HIGH);
  digitalWrite(s2,LOW);
  digitalWrite(s3,LOW);
  digitalWrite(oe, HIGH);

//  attachInterrupt(0, ISR_INTO, LOW);
}

unsigned long prev = 0;

void loop()
{
  if( millis() - prev > 10 ){
    prev = millis();
    cli();
      red = counter;
      counter=0;
    sei();
    digitalWrite(oe,HIGH);
      Serial.print("red=");
      Serial.println(counter, DEC);
    digitalWrite(oe, LOW);
    delayMicroseconds(2);
  }
}
