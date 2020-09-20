/*
 **************************  SPEEXCH / VOICE RECOGNITION - REMIX *************************
 * LINK: http://coolarduino.wordpress.com/2012/10/18/speech-voice-recognition-remix/
 *
 * Created for  Arduino LEONARDO board: Anatoly Kuzmenko 18 October 2012 
 *                                 k_anatoly@hotmail.com
 *
 * SOFTWARE COMPILES USING Arduino 1.0.1 IDE (Tested on Linux OS only).
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute copies of the Software, 
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY,  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *
 * Copyright (C) 2012 Anatoly Kuzmenko.
 * All Rights Reserved.
 ********************************************************************************************
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#define FFT_SIZE           128                    // Number of samples; FFT Size
#define SMPLTIME           499                    // 4 ksps; 2 kHz Audio.

#define LOG_2_FFT            7                    /* log2 FFT_SIZE */
#define MIRROR        FFT_SIZE / 2
#define NWAVE              256                    /* full length of Sinewave[] */

#define TIME_SZ             64                    // Quantity of Time Frames (Frame = 64 x 1/4kHz = 16 msec)
#define NBR_FRQ             16                    // Quantity of Bands on Spectrogramm
   
/***********************************************************************************************************/        
const prog_int16_t Anatoly[128]     PROGMEM = {

      +3,      +3,      +4,      +4,      +6,      +7,      +9,     +11,     +13,     +15,     +18,     +21,     +25,     +28,     +32,     +36,
     +41,     +45,     +50,     +55,     +60,     +65,     +71,     +76,     +82,     +88,     +94,    +100,    +106,    +112,    +118,    +124,
    +131,    +137,    +143,    +149,    +155,    +161,    +167,    +173,    +179,    +185,    +190,    +196,    +201,    +206,    +211,    +215,
    +220,    +224,    +228,    +232,    +235,    +238,    +241,    +244,    +246,    +249,    +250,    +252,    +253,    +254,    +255,    +255,
    +255,    +255,    +254,    +253,    +252,    +250,    +249,    +246,    +244,    +241,    +238,    +235,    +232,    +228,    +224,    +220,
    +215,    +211,    +206,    +201,    +196,    +190,    +185,    +179,    +173,    +167,    +161,    +155,    +149,    +143,    +137,    +131,
    +124,    +118,    +112,    +106,    +100,     +94,     +88,     +82,     +76,     +71,     +65,     +60,     +55,     +50,     +45,     +41,
     +36,     +32,     +28,     +25,     +21,     +18,     +15,     +13,     +11,      +9,      +7,      +6,      +4,      +4,      +3,      +3
};
const prog_int16_t Sinewave[NWAVE] PROGMEM = {

      +0,      +6,     +13,     +19,     +25,     +31,     +37,     +44,     +50,     +56,     +62,     +68,     +74,     +80,     +86,     +92,
     +98,    +103,    +109,    +115,    +120,    +126,    +131,    +136,    +142,    +147,    +152,    +157,    +162,    +167,    +171,    +176,
    +180,    +185,    +189,    +193,    +197,    +201,    +205,    +208,    +212,    +215,    +219,    +222,    +225,    +228,    +231,    +233,
    +236,    +238,    +240,    +242,    +244,    +246,    +247,    +249,    +250,    +251,    +252,    +253,    +254,    +254,    +255,    +255,
    +255,    +255,    +255,    +254,    +254,    +253,    +252,    +251,    +250,    +249,    +247,    +246,    +244,    +242,    +240,    +238,
    +236,    +233,    +231,    +228,    +225,    +222,    +219,    +215,    +212,    +208,    +205,    +201,    +197,    +193,    +189,    +185,
    +180,    +176,    +171,    +167,    +162,    +157,    +152,    +147,    +142,    +136,    +131,    +126,    +120,    +115,    +109,    +103,
     +98,     +92,     +86,     +80,     +74,     +68,     +62,     +56,     +50,     +44,     +37,     +31,     +25,     +19,     +13,      +6,
      +0,      -6,     -13,     -19,     -25,     -31,     -38,     -44,     -50,     -56,     -62,     -68,     -74,     -80,     -86,     -92,
     -98,    -104,    -109,    -115,    -121,    -126,    -132,    -137,    -142,    -147,    -152,    -157,    -162,    -167,    -172,    -177,
    -181,    -185,    -190,    -194,    -198,    -202,    -206,    -209,    -213,    -216,    -220,    -223,    -226,    -229,    -231,    -234,
    -237,    -239,    -241,    -243,    -245,    -247,    -248,    -250,    -251,    -252,    -253,    -254,    -255,    -255,    -256,    -256,
    -256,    -256,    -256,    -255,    -255,    -254,    -253,    -252,    -251,    -250,    -248,    -247,    -245,    -243,    -241,    -239,
    -237,    -234,    -231,    -229,    -226,    -223,    -220,    -216,    -213,    -209,    -206,    -202,    -198,    -194,    -190,    -185,
    -181,    -177,    -172,    -167,    -162,    -157,    -152,    -147,    -142,    -137,    -132,    -126,    -121,    -115,    -109,    -104,
     -98,     -92,     -86,     -80,     -74,     -68,     -62,     -56,     -50,     -44,     -38,     -31,     -25,     -19,     -13,      -6
};

#define mult_shf_s16x16( a, b)    \
({                        \
int prod, val1=a, val2=b; \
__asm__ __volatile__ (    \ 
"muls %B1, %B2	\n\t"     \
"mov %B0, r0    \n\t"	  \ 
"mul %A1, %A2   \n\t"	  \ 
"mov %A0, r1    \n\t"     \ 
"mulsu %B1, %A2	\n\t"     \ 
"add %A0, r0    \n\t"     \ 
"adc %B0, r1    \n\t"     \ 
"mulsu %B2, %A1	\n\t"     \ 
"add %A0, r0    \n\t"     \ 
"adc %B0, r1    \n\t"     \ 
"clr r1         \n\t"     \ 
: "=&d" (prod)            \
: "a" (val1), "a" (val2)  \
);                        \
prod;                     \
})

static inline void mult_shf_I( int c, int s, int x, int y, int &u, int &v)  __attribute__((always_inline));
static inline void mult_shf_I( int c, int s, int x, int y, int &u, int &v)
{
  u = (mult_shf_s16x16(x, c) - mult_shf_s16x16(y, s));    
  v = (mult_shf_s16x16(y, c) + mult_shf_s16x16(x, s));    // Hardcoded >>8 bits, use with 8-bits Sinewave ONLY.
}

static inline void sum_dif_I(int a, int b, int &s, int &d)  __attribute__((always_inline));
static inline void sum_dif_I(int a, int b, int &s, int &d)
{
  s = (a+b);   
  d = (a-b); 
}

void rev_bin( int *fr, int fft_n)
{
    int m, mr, nn, l;
    int tr;

    mr = 0;
    nn = fft_n - 1;

    for (m=1; m<=nn; ++m) {
            l = fft_n;
         do {
             l >>= 1;
            } while (mr+l > nn);

            mr = (mr & (l-1)) + l;

        if (mr <= m)
             continue;
            tr = fr[m];
            fr[m] = fr[mr];
            fr[mr] = tr;
    }
}

void fft8_dit_core_p1(int *fr, int *fi)
{
    int plus1a, plus2a, plus3a, plus4a, plus1b, plus2b;
    int mins1a, mins2a, mins3a, mins4a, mins1b, mins2b, mM1a, mM2a;

    sum_dif_I(fr[0], fr[1], plus1a, mins1a);
    sum_dif_I(fr[2], fr[3], plus2a, mins2a);
    sum_dif_I(fr[4], fr[5], plus3a, mins3a);
    sum_dif_I(fr[6], fr[7], plus4a, mins4a);

    sum_dif_I(plus1a, plus2a, plus1b, mins1b);
    sum_dif_I(plus3a, plus4a, plus2b, mins2b);

    sum_dif_I(plus1b, plus2b, fr[0], fr[4]);
    sum_dif_I(mins3a, mins4a, mM1a, mM2a);

    int prib1a, prib2a, prib3a, prib4a, prib1b, prib2b;
    int otnt1a, otnt2a, otnt3a, otnt4a, otnt1b, otnt2b, oT1a, oT2a;

    sum_dif_I(fi[0], fi[1], prib1a, otnt1a);
    sum_dif_I(fi[2], fi[3], prib2a, otnt2a);
    sum_dif_I(fi[4], fi[5], prib3a, otnt3a);
    sum_dif_I(fi[6], fi[7], prib4a, otnt4a);

    sum_dif_I(prib1a, prib2a, prib1b, otnt1b);
    sum_dif_I(prib3a, prib4a, prib2b, otnt2b);

    sum_dif_I(prib1b, prib2b, fi[0], fi[4]);
    sum_dif_I(otnt3a, otnt4a, oT1a, oT2a);

    mM2a   =    mult_shf_s16x16(mM2a, 181);
    sum_dif_I(mins1a,   mM2a, plus1a, plus2a);

    prib2b =    mult_shf_s16x16(oT1a, 181);
    sum_dif_I(otnt2a, prib2b, mins3a, plus3a);

    sum_dif_I(plus1a, mins3a, fr[7], fr[1]);
    sum_dif_I(mins1b, otnt2b, fr[6], fr[2]);
    sum_dif_I(plus2a, plus3a, fr[3], fr[5]);

    oT2a   =    mult_shf_s16x16(oT2a, 181);
    sum_dif_I( otnt1a,   oT2a, plus1a, plus2a);

    plus2b =    mult_shf_s16x16(mM1a, 181);
    sum_dif_I(-mins2a, plus2b, plus3a, mins3a);

    sum_dif_I(plus1a, mins3a, fi[7], fi[1]);
    sum_dif_I(otnt1b,-mins2b, fi[6], fi[2]);
    sum_dif_I(plus2a, plus3a, fi[3], fi[5]);
}

void fft_radix4_I( int *fr, int *fi, int ldn)
{
    const int n = (1UL<<ldn);
    int ldm = 0, rdx = 2;

    ldm = (ldn&1);
    if ( ldm!=0 )
    {
        for (int i0=0; i0<n; i0+=8)
        {
            fft8_dit_core_p1(fr+i0, fi+i0);
        }
    }
    else
       {
    for (int i0 = 0; i0 < n; i0 += 4)
        {
            int xr,yr,ur,vr, xi,yi,ui,vi;

            int i1 = i0 + 1;
            int i2 = i1 + 1;
            int i3 = i2 + 1;

            sum_dif_I(fr[i0], fr[i1], xr, ur);
            sum_dif_I(fr[i2], fr[i3], yr, vi);
            sum_dif_I(fi[i0], fi[i1], xi, ui);
            sum_dif_I(fi[i3], fi[i2], yi, vr);

            sum_dif_I(ui, vi, fi[i1], fi[i3]);
            sum_dif_I(xi, yi, fi[i0], fi[i2]);
            sum_dif_I(ur, vr, fr[i1], fr[i3]);
            sum_dif_I(xr, yr, fr[i0], fr[i2]);
        }
       }    
    for (ldm += 2 * rdx; ldm <= ldn; ldm += rdx)
    {
        int m = (1UL<<ldm);
        int m4 = (m>>rdx);

        int phI0 =  NWAVE / m;                            
        int phI  = 0;

        for (int j = 0; j < m4; j++)
        {
        int c,s,c2,s2,c3,s3;

         s  = pgm_read_word(&Sinewave[   phI]);
         s2 = pgm_read_word(&Sinewave[ 2*phI]);
         s3 = pgm_read_word(&Sinewave[ 3*phI]);

         c  = pgm_read_word(&Sinewave[   phI + NWAVE/4]);
         c2 = pgm_read_word(&Sinewave[ 2*phI + NWAVE/4]);
         c3 = pgm_read_word(&Sinewave[ 3*phI + NWAVE/4]);

       for (int r = 0; r < n; r += m)    
       {
                int i0 = j + r;
                int i1 = i0 + m4;
                int i2 = i1 + m4;
                int i3 = i2 + m4;

           int xr,yr,ur,vr, xi,yi,ui,vi;

             mult_shf_I( c2, s2, fr[i1], fi[i1], xr, xi);
             mult_shf_I(  c,  s, fr[i2], fi[i2], yr, vr);
             mult_shf_I( c3, s3, fr[i3], fi[i3], vi, yi);

             int t = yi - vr;
                yi += vr;
                vr = t;

                ur = fr[i0] - xr;
                xr += fr[i0];

              sum_dif_I(ur, vr, fr[i1], fr[i3]);

                 t = yr - vi;
                yr += vi;
                vi = t;

                ui = fi[i0] - xi;
                xi += fi[i0];

              sum_dif_I(ui, vi, fi[i1], fi[i3]);
              sum_dif_I(xr, yr, fr[i0], fr[i2]);
              sum_dif_I(xi, yi, fi[i0], fi[i2]);
            }
          phI += phI0;
        }
    }
}

int freeRam () {
  extern int __heap_start, *__brkval; 
  int v; 
  return (int) &v - (__brkval == 0 ? (int) &__heap_start : (int) __brkval); 
}

static inline int del_round ( int delit, int denom )  __attribute__((always_inline));
static inline int del_round ( int delit, int denom )
{
    if (delit < 0) delit = ((delit>>denom) +1);
    else delit = delit >> denom;

    return delit;
}
/***********************************************************************************************************/
/***********************************************************************************************************/

volatile int16_t  x_r[FFT_SIZE];                  // MEM: 256 Bytes
         int16_t  f_r[FFT_SIZE];                  // MEM: 256 Bytes 
         int16_t  f_i[FFT_SIZE];                  // MEM: 256 Bytes

         int8_t  TEMP[NBR_FRQ][3]      = {{ 0}};  // Spectrogram Filtering Buffer 16 x 3
         int8_t  SPG[NBR_FRQ][TIME_SZ] = {{ 0}};  // Spectrogram Array 16 x 64

const    int8_t  EE[3][3] = {                     // EDGE ENHANCEMENT HPF MATRIX 3 x 3
                  {-1, -1, -1  },
                  {-1,  8, -1  },
                  {-1, -1, -1  }
                  };

volatile uint8_t capture = 0;          // Flag "capture in progress"
volatile uint8_t process = 0;          // Flag "new samples ready"

volatile uint8_t n_sampl = 0;          // Sampling counter
         int16_t address = 0;          // EEPROM address

const    uint8_t trigger =  75;        // Trigger Level VOX (VOice Activated Capture)
         uint8_t spectro = 0;          // Spectrogramm Cycles counter
         uint8_t fltcorr = 0;          // Flag "Spectrogamm SuperCycle ready for Filtering & Cross-Corelation"

         long    cross_c = 0;          // Cross-Correlation Factor Current
         long    cross_s = 0;          // Cross-Correlation Factor Stored  

         uint8_t incomingByte;      
         uint8_t record_spg  = 0;      // Switch "RECORD" to EEPROM
         uint8_t pechat_vx   = 0;      // Switch "Prind ADC"
         uint8_t pechat_vux  = 0;      // Switch "Print FFT"
         uint8_t pechat_spg1 = 0;      // Switch "Print Pre-Filter"
         uint8_t pechat_spg2 = 0;      // Switch "Print Post-Filter"
         uint8_t pechat_eepr = 0;      // Switch "PLAY" from EEPROM
      
void  print_spg1()
{
    for ( uint8_t strok = 0; strok < TIME_SZ; strok++ ){
      for ( uint8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){
       Serial.print("\t");
       Serial.print(SPG[stolb][strok], DEC);
      } 
      Serial.print("\n");
    }
    Serial.print("\n");
}

void print_spg2()
{
    for ( uint8_t strok = 0; strok < TIME_SZ; strok++ ){
      for ( uint8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){
       Serial.print("\t");
       Serial.print(SPG[stolb][strok], DEC);
      } 
      Serial.print("\n");
    }
     Serial.print(F("\n\tCROSS-CORRELATION FACTOR: "));
     Serial.print( cross_c, DEC );
     Serial.print(F("\tSTORED: "));
     Serial.print( cross_s, DEC );
     Serial.print(F("\tMATCH: " ));
     Serial.print((((cross_c +1) * 100) / (cross_s +1)), DEC );
     Serial.println(" %.");
}


void setup() {
  Serial.begin(115200);  

	/* Setup ADC */
        ADMUX    = 0xD4;        // Gain: 0xD4 = x40.  0xCC = x10.  0xDC = x200,  
        DIDR0    = 0x00;        // Turn Off Digital Input Buffer.
	ADCSRA   = 0xA7;
	ADCSRB   = 0xA8;        // TIMER4 Auto Trigger Mode TOV4

        /* Set up TIMER 4 - ADC sampler */
        TCCR4A = 0x00;
        TCCR4B = 0x04;          // 0100 - 1/8 = 0.5 usec
        TCCR4C = 0x00;
        TCCR4D = 0x00;
        TCCR4E = 0x00; 
        
        TC4H   = (SMPLTIME >> 8); 
        OCR4C  =  (unsigned char) SMPLTIME; 

        TIMSK0 = 0x00;
        TIMSK1 = 0x00;
        TIMSK3 = 0x00;

        TIFR4 |= (1<<TOV4);
        TIMSK4 = (1<<TOV4);

  pinMode(13, OUTPUT);          // Capture In Progress Indicator 
  digitalWrite( 13, LOW);

// Check Point 
  pinMode( 2, OUTPUT);   //FFT Performance check point
  pinMode( 3, OUTPUT);   //Filter Performance check point
  pinMode( 4, OUTPUT);   //Cross_Correlation Performance check point
}

void loop()
{
 if ( process )
 {   
digitalWrite( 2, HIGH);

  uint8_t offset = 0;
 
  if ( process == 1 ) offset = MIRROR;
  
  for ( uint8_t i = 0; i < FFT_SIZE; i++, offset++ ) 
  {  
    f_r[i] = mult_shf_s16x16( x_r[offset & 0x7F], pgm_read_word(&Anatoly[i])); // Windowing
    f_i[i] = 0;                                         // Image -zero.
  }    
  
   rev_bin( f_r, FFT_SIZE);
   fft_radix4_I( f_r, f_i, LOG_2_FFT);      

   for ( int8_t  i = 0; i < MIRROR; i++) {  //Fastest Magnitude Calculation, w/o slow sqrt.

     int16_t abs_R = abs(f_r[i]);
     int16_t abs_I = abs(f_i[i]);
     int16_t tmp_M;

     if (abs_R > abs_I) tmp_M = mult_shf_s16x16( 243, abs_R) + mult_shf_s16x16( 100, abs_I);
     else               tmp_M = mult_shf_s16x16( 243, abs_I) + mult_shf_s16x16( 100, abs_R);

     f_r[i] = del_round( tmp_M, 6 );                    // Gain Reset.
    }

   for ( uint8_t s = 0; s < NBR_FRQ; s++){
     SPG[s][spectro] = 0;                               // Clear, Allow to use it as accumulator
    }    

// Non-Linear Compression 63 Bins to 16 Bands (Memory Limits: 16(bands) x 64(time cycles) = 1 K.).
/*
63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51,  * Band - 15; Bins -12; BandWidth -  384 Hz
 50, 49, 48, 47, 46, 45, 44, 43, 42,  * Band - 14; Bins - 9; BandWidth -  288 Hz
 41, 40, 39, 38, 37, 36, 35,  * Band - 13; Bins - 7; BandWidth -  224 Hz
 34, 33, 32, 31, 30, 29,  * Band - 12; Bins - 6; BandWidth -  192 Hz
 28, 27, 26, 25, 24,  * Band - 11; Bins - 5; BandWidth -  160 Hz
 23, 22, 21, 20,  * Band - 10; Bins - 4; BandWidth -  128 Hz
 19, 18, 17, 16,  * Band -  9; Bins - 4; BandWidth -  128 Hz
 15, 14, 13,  * Band -  8; Bins - 3; BandWidth -   96 Hz
 12, 11, 10,  * Band -  7; Bins - 3; BandWidth -   96 Hz
  9,  8,  * Band -  6; Bins - 2; BandWidth -   64 Hz
  7,  6,  * Band -  5; Bins - 2; BandWidth -   64 Hz
  5,  * Band -  4; Bins - 1; BandWidth -   32 Hz
  4,  * Band -  3; Bins - 1; BandWidth -   32 Hz
  3,  * Band -  2; Bins - 1; BandWidth -   32 Hz
  2,  * Band -  1; Bins - 1; BandWidth -   32 Hz
  1,  * Band -  0; Bins - 1; BandWidth -   32 Hz
*/
    for ( uint8_t  i = 63, ind = 15, mid = 51, kolch = 0; i > 0; i--)
     {
      SPG[ind][spectro] += (f_r[i]); 
      if ( i <= mid )
         {
          mid = mult_shf_s16x16( 214, mid );

          if (kolch) SPG[ind][spectro] /= kolch;
          kolch = 0;
          ind--;
         }
        kolch++;
      }

  digitalWrite( 2, LOW);                                     // All above = 6 millisec.

    spectro++; 
    if ( spectro >= TIME_SZ )
    {
      capture = 0;
      spectro = 0; 
      digitalWrite( 13, LOW );
      fltcorr = 1;
    }
    process = 0;
  }

  if ( fltcorr )
  { 
  digitalWrite( 3, HIGH);

  if ( pechat_spg1 ) {                                  //PRE-FILTERED SPECTROGRAMM DEBUG PRINT-OUT
    print_spg1();
    pechat_spg1 = 0;
    }

    for ( uint8_t strok = 0; strok < TIME_SZ; strok++ ){//FILTERING EDGE_ENHANCEMENT (HPF KERNEL 3 x 3) IN-PLACE
        for ( uint8_t tmp = 0; tmp < NBR_FRQ; tmp++ ){
                TEMP[tmp][2] = TEMP[tmp][1];
                TEMP[tmp][1] = TEMP[tmp][0];
                TEMP[tmp][0] = SPG[tmp][strok];
                SPG[tmp][strok]     = 0;
                }
            for ( uint8_t b = 0; b < 3; b++ ){
                for ( uint8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){
                    for ( uint8_t a = 0; a < 3; a++ ){
                        int c = stolb + a - 1;
                        if((c >= 0) && (c < NBR_FRQ))
                        {
                        int rounddown = EE[a][b] * TEMP[c][b];                 //SYMETRICAL  ROUNDDOWN
                            if (rounddown < 0)
                                rounddown = ( rounddown + 4 ) >> 3;
                            else
                                rounddown >>= 3;
                        SPG[stolb][strok] += rounddown;
                        }
                    }
                }
            }
        }

  digitalWrite( 3, LOW);    
  digitalWrite( 4, HIGH);    

  if ( record_spg )    //STORE SPECTROGRAMM
  {
    cross_s = 0;
    address = 0;
    
    for ( int8_t strok = 0; strok < TIME_SZ; strok++ ){
      for ( int8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){
 
        while(EECR & (1<<EEPE));
          EEAR = address;
          EEDR = SPG[stolb][strok];
          EECR |= (1<<EEMPE);
          EECR |= (1<<EEPE);

        cross_s = cross_s + (SPG[stolb][strok] * SPG[stolb][strok]);
          
        address++;
        if ( address >= 1024 )
          address = 0;  
      }
    }
  record_spg = 0;
  }
  else                 //COMPARE VIA CROSS-CORRELATION 
  {
    address = 0;
    cross_c = 0;

      for ( int8_t strok = 0; strok < TIME_SZ; strok++ ){  
        for ( int8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){

          while(EECR & (1<<EEPE));
            EEAR = address;
            EECR |= (1<<EERE);

          cross_c = cross_c + (((int8_t) EEDR) * SPG[stolb][strok]);

        address++;
        if ( address >= 1024 )
          address = 0;  
        }
     }
  }
  digitalWrite( 4, LOW);      
  if ( pechat_spg2 ) {                             //POST-FILTERED SPECTROGRAMM
    print_spg2();
    pechat_spg2 = 0;
    }
  fltcorr = 0;
  }

//DEBUG PRINTOUT
  if ( pechat_vx ) {
    for ( uint8_t i = 0; i < FFT_SIZE; i++){
      Serial.print("\t");
      Serial.print( x_r[i], DEC);
      if ((i+1)%16 == 0) Serial.print("\n");
    } 
    Serial.print("\n");
    pechat_vx = 0;
  }

  if ( pechat_vux ) {
    for ( uint8_t i = 0; i < MIRROR; i++){
      Serial.print("\t");
      Serial.print( f_r[i], DEC);
      if ((i+1)%16 == 0) Serial.print("\n");
    } 
    Serial.print("\n");
    pechat_vux = 0;
  }

  if ( pechat_eepr )
  {
    address = 0;

    for ( uint8_t strok = 0; strok < TIME_SZ; strok++ ){ 
      for ( uint8_t stolb = 0; stolb < NBR_FRQ; stolb++ ){

          while(EECR & (1<<EEPE));
            EEAR = address;
            EECR |= (1<<EERE);

       Serial.print("\t");
       Serial.print(((int8_t) EEDR), DEC);

        address++;
        if ( address >= 1024 )
          address = 0;  
      } 
    Serial.print("\n");
    }
   pechat_eepr = 0;
  }

  //CONSOLE COMMAND LINE INTERFACE
  //THERE ARE 7 COMMANDS,  1 SINGLE LETTER: 

  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if (incomingByte == 'x') {           // INPUT ADC DATA
      pechat_vx = 1;
    }
    if (incomingByte == 'f') {           // FFT OUTPUT
      pechat_vux = 1;
    }
    if (incomingByte == 's') {           // SPECROGRAMM PRE  FILTERED
      pechat_spg1 = 1;
    }
    if (incomingByte == 'g') {           // SPECROGRAMM POST FILTERED
      pechat_spg2 = 1;
    }
    if (incomingByte == 'r') {           // RECORD SPECROGRAMM TO EEPROM
      record_spg = 1;
    }
    if (incomingByte == 'p') {           // PLAY SPECROGRAMM FROM EEPROM
      pechat_eepr = 1;
    }
    if (incomingByte == 'm') {           // FREE MEMORY BYTES 
      Serial.println(freeRam());
    }
  }
}

ISR(TIMER4_OVF_vect) {

    int16_t temp  = ADCL;  
            temp += (ADCH << 8);  
            if ( temp & 0x0200) temp += 0xFC00; // Convert Back negative 16-bit word (2's comp) to Int16_t

    if ((abs(temp) > trigger) && (!capture))
    {
      capture = 1;
      n_sampl = 0;
      digitalWrite( 13, HIGH );
    }

    if ( capture )
    {
      x_r[n_sampl] = temp; 
      n_sampl++;    
    }
  
  if ( n_sampl  ==  MIRROR )
  {
    process = 1;             // Sub-cycle 1
  }

  if ( n_sampl >= FFT_SIZE )
  {
    n_sampl = 0;
    process = 2;            // Sub-cycle 2 
  }
}
