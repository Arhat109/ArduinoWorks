/*****************************************************************************
*
* - File              : BLDC.h
*
* - Compiler          : gcc version 3.4.6
*
* - Support mail      : Koryagin Andrey
*                     : andre@avislab.com
*
* - Supported devices : ATmega168
*
* - Description       : ATmega168 for sensorless BLDC
*                       control of a three phase brushless DC motor.
*                     : This is a modified example avr444
*
*****************************************************************************/

#ifndef __BLDC_H__
#define __BLDC_H__

#define PWM_TOP_VALUE_16K            (F_CPU / 8 / 16000 / 2)

// Boolean FALSE value
#define FALSE     0

// Boolean TRUE expression. Can be used both for test and assignment
#define TRUE      1

// Port pin connected to phase U, low side enable switch
#define UL    PB2

// Port pin connected to phase U, high side enable switch
#define UH    PB5

// Port pin connected to phase V, low side enable switch
#define VL    PB1

// Port pin connected to phase V, high side enable switch
#define VH    PB4

// Port pin connected to phase W, low side enable switch
#define WL    PB0

// Port pin connected to phase W, high side enable switch
#define WH    PB3

// Clockwise rotation flag. Used only in macros
#define CW    0

// Counterclockwise rotation flag. Used only in macros
#define CCW   1

// Drive pattern for commutation step 1, CCW rotation
#define DRIVE_PATTERN_STEP1_CCW      ((1 << UL) | (1 << VH))

// Drive pattern for commutation step 2, CCW rotation
#define DRIVE_PATTERN_STEP2_CCW      ((1 << UL) | (1 << WH))

// Drive pattern for commutation step 3, CCW rotation
#define DRIVE_PATTERN_STEP3_CCW      ((1 << VL) | (1 << WH))

// Drive pattern for commutation step 4, CCW rotation
#define DRIVE_PATTERN_STEP4_CCW      ((1 << VL) | (1 << UH))

// Drive pattern for commutation step 5, CCW rotation
#define DRIVE_PATTERN_STEP5_CCW      ((1 << WL) | (1 << UH))

// Drive pattern for commutation step 6, CCW rotation
#define DRIVE_PATTERN_STEP6_CCW      ((1 << WL) | (1 << VH))

// Drive pattern for commutation step 1, CW rotation
#define DRIVE_PATTERN_STEP1_CW      ((1 << VH) | (1 << WL))

// Drive pattern for commutation step 2, CW rotation
#define DRIVE_PATTERN_STEP2_CW      ((1 << UH) | (1 << WL))

// Drive pattern for commutation step 3, CW rotation
#define DRIVE_PATTERN_STEP3_CW      ((1 << UH) | (1 << VL))

// Drive pattern for commutation step 4, CW rotation
#define DRIVE_PATTERN_STEP4_CW      ((1 << WH) | (1 << VL))

// Drive pattern for commutation step 5, CW rotation
#define DRIVE_PATTERN_STEP5_CW      ((1 << WH) | (1 << UL))

// Drive pattern for commutation step 6, CW rotation
#define DRIVE_PATTERN_STEP6_CW      ((1 << VH) | (1 << UL))


// Zero crossing polarity flag value for falling zero crossing
#define EDGE_FALLING          1

// Zero crossing polarity flag value for rinsing zero crossing
#define EDGE_RISING           0

// PORT register for drive pattern output
#define DRIVE_PORT  PORTB

// Data direction register for drive pattern output
#define DRIVE_DDR   DDRB

#define LED_DDR		DDRD
#define LED_PORT	PORTD
#define LED_PIN		PIND4
#define LED_OFF		LED_PORT |= (1<<LED_PIN);
#define LED_ON		LED_PORT &= ~(1<<LED_PIN);

#define BTN_DDR		DDRD
#define BTN_PORT	PORTD
#define BTN_PORT_IN	PIND
#define BTN_PIN		PIND3
#define BTN_IS_DOWN		((BTN_PORT_IN & (1<<BTN_PIN)) == 0)

// ADMUX register value for channel U sampling
#define ADMUX_U             0x0

// ADMUX register value for channel V sampling
#define ADMUX_V             0x1

// ADMUX register value for channel W sampling
#define ADMUX_W             0x2

// ADMUX register value for speed reference sampling.
#define ADMUX_SPEED_REF     0x4

// ADMUX register value for current sampling.
#define ADMUX_CURRENT       0x3

// ADMUX register value for reference voltage sampling
#define ADMUX_BATTERY_VOLTAGE  0x5

/* Number of commutations performed during startup. Also specifies
 *  size of \ref startupDelays. Do not change without also changing
 *  \ref MakeTables().
 */
#define STARTUP_NUM_COMMUTATIONS  8

// Startup delays are given in milliseconds times STARTUP_DELAY_MULTIPLIER
#define STARTUP_DELAY_MULTIPLIER  200

/*  Number of milliseconds to lock rotor in first commutation step before
 *  the timed startup sequence is initiated.
 */
#define STARTUP_LOCK_DELAY        100

// Macro that sets a new duty cycle by changing the PWM compare value
#define SET_PWM_COMPARE_VALUE(compareValue)          (OCR0B = compareValue)

// Macro that clears all Timer/counter0 interrupt flags
#define CLEAR_ALL_TIMER0_INT_FLAGS    (TIFR0 = TIFR0)

// Macro that disables all Timer/Counter0 interrupts
#define DISABLE_ALL_TIMER0_INTS       (TIMSK0 = 0)

// Macro that enables Timer/Counter0 interrupt where zero crossings are detected
#define SET_TIMER0_INT_ZC_DETECTION   (TIMSK0 = (1 << TOIE0))

// Macro that clears all Timer/Counter1 interrupt flags
#define CLEAR_ALL_TIMER1_INT_FLAGS    (TIFR1 = TIFR1)

// Macro that disables all Timer/Counter1 interrupts
#define DISABLE_ALL_TIMER1_INTS       (TIMSK1 = 0)

// Macro that enable Timer/Counter1 interrupt responsible for commutation
#define SET_TIMER1_INT_COMMUTATION    (TIMSK1 = (1 << OCIE1A))

// Macro that enables Timer/Counter1 interrupt responsible for enabling ADC sampling after ADC holdoff period
#define SET_TIMER1_INT_HOLDOFF        (TIMSK1 = (1 << OCIE1B))

// External reference voltage in milliVolts
#define EXTERNAL_REF_VOLTAGE      5000

// The ADC resolution used
#define ADC_RESOLUTION   256

/*  The number of Timer/Counter1 ticks per second. Equals
 *  MCU clock frequency / Timer/counter1 prescaler.
 */
#define TICKS_PER_SECOND	F_CPU/8

// The number of Timer/Counter1 ticks per minute
#define TICKS_PER_MINUTE    (TICKS_PER_SECOND * 60)

/*  Input value relative gain in IIR filter.
 *
 *  This value specifies the relative gain given to the input value in the IIR filter.
 *  The value should be an integer. Make sure that COEFF_A + COEFF_B is a power of 2,
 *  to avoid instability.
 */
#define COMMUTATION_TIMING_IIR_COEFF_A      1

/*  Relative feedback gain in IIR filter.
 *
 *  This value specifies the relative feedback gain given to the input value in the IIR filter.
 *  The value should be an integer. Make sure that COEFF_A + COEFF_B is a power of 2,
 *  to avoid instability.
 */
#define COMMUTATION_TIMING_IIR_COEFF_B      3

// Macro that cuts all power to the motor
#define DISABLE_DRIVING               (DRIVE_PORT = 0x00)

// Start and stop speedReferenceADC is deferent for nice starting (fix speedReferenceADC rebouncing)
#define POT_START_REF	7
#define POT_STOP_REF	2

static void InitPorts(void);
static void InitTimers(void);
static void InitAnalogComparator(void);
static void MakeTables(void);
unsigned char GetPosition(void);
static void StartMotor(void);
static void ALARMStopMotor(unsigned char mode);
static void PWMControl(void);
static void StartupDelay(unsigned int delay);
void CalculateSpeed();
void CalculateCurrent();
void Beep();
unsigned char get_speedReference(void);

#endif

