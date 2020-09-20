#include <Arduino.h>

int lowbuffer[10] = {1,2,3,4,5,6,7,8,9,0}; // data
int buffer2[4000] __attribute__((section(".lpage2")));
int buffer4[4000] __attribute__((section(".hpage4")));

volatile int tmp; // bss

void setup() {}

void loop()
{
  for(int j=0; j<4000; j++){
      tmp = 55; // volatile!
      buffer2[j] = tmp;
      buffer4[j] = tmp*2;
  }
}

