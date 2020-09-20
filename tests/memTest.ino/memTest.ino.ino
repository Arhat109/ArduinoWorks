void setup() {
  DDRA = 0xFF;
  DDRB = 0xFF;
  DDRC = 0xFF;
  DDRD = 0xFF;
  DDRE = 0xFF;
  DDRF = 0xFF;
  DDRG = 0x3F;
//  DDRH = 0xFF;
//  DDRJ = 0xFF;
//  DDRK = 0xFF;
//  DDRL = 0xFF;
}

void loop() {
  for(uint8_t bit=0; bit<8; bit++)
  {
    PORTA = _BV(bit);
    PORTB = _BV(bit);
    PORTC = _BV(bit);
    PORTD = _BV(bit);
    PORTE = _BV(bit);
    PORTF = _BV(bit);
//    PORTH = _BV(bit);
//    PORTJ = _BV(bit);
//    PORTK = _BV(bit);
//    PORTL = _BV(bit);
//    if( bit<6 ){ PORTG = _BV(bit); }
    if( bit<5 ){ PORTG = _BV(bit); }
    else       { PORTG = 0;   }

    delay(500);

    PORTA = 0;
    PORTB = 0;
    PORTC = 0;
    PORTD = 0;
    PORTE = 0;
    PORTF = 0;
    PORTG = 0;
//    PORTH = 0;
//    PORTJ = 0;
//    PORTK = 0;
//    PORTL = 0;
  }
}
