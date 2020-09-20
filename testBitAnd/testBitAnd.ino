
//#define twiWait()  { while(TWCR & _BV(TWSTO)); }
//#define adcWaitI() {while((ADCSRA&(1<<ADIF))==0);}
//#define adcWaitM() {while((ADCSRA&(1<<ADSC))!=0);}
#define pciWait()  {while( ~(PCIFR & 0b00100000)); }
#define spiWait()  {while( (~SPSR) ); }
union {
  uint8_t reg;
  struct{ uint8_t b0:1,b1:1,b2:1,b3:1,b4:1,b5:1,b6:1,b7:1; } bit;
} b;

volatile   unsigned char a = 0xa5;

void setup() {
  b.bit.b0 = 1;
  
  if( ~b.bit.b0 ) SPSR = a;
  b.reg = a;
  if( ~b.bit.b1 ) SPSR = b.reg;
}

void loop() {
}
