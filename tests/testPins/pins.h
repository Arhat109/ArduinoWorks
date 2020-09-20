
#include <inttypes.h>
#include <avr/pgmspace.h>

#define pin1  {&PORTB,3}
#define pin2  {1,3}

typedef struct {
  volatile uint8_t * port;
  uint8_t            mask;
} Pin1;

typedef struct{
  uint8_t port;
  uint8_t mask;
} Pin2;

typedef struct{
  uint8_t port:4;
  uint8_t mask:4;
} Pin3;

volatile uint8_t * pin2port[] =
{
  &PORTA, &PORTB, &PORTC, &PORTD, &PORTE, &PORTF, &PORTG, &PORTH, 0, &PORTJ, &PORTK, &PORTL
};

//void setPin(Pin p, uint8_t val)
#define setPin1(p, val)             \
{                                   \
  Pin1            tmp  = p;         \
  if(val) *(tmp.port) |= tmp.mask;  \
  else    *(tmp.port) &= ~tmp.mask; \
}

#define setPin2(p, val)                         \
{                                               \
  Pin2               tmp  = p;                  \
  volatile uint8_t * port = pin2port[tmp.port]; \
  if(val) *(port) |= tmp.mask;                  \
  else    *(port) &= ~tmp.mask;                 \
}

#define setPin3(p, val)                         \
{                                               \
  Pin3               tmp  = p;                  \
  volatile uint8_t * port = pin2port[tmp.port]; \
  if(val) *(port) |= 1<<tmp.mask;               \
  else    *(port) &= ~(1<<tmp.mask);            \
}

