/*****************************************************************************
*
* - File              : main.c
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
#include "BLDC.h"

#include <stdio.h>
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>

// Flag
unsigned char				FLAGS[7];
#define FLAG_WD				FLAGS[0]
#define FLAG_WD_EN			FLAGS[1]
#define FLAG_RUN			FLAGS[2]
#define FLAG_RefUpdated		FLAGS[3]
#define FLAG_SpeedUpdated	FLAGS[4]
#define FLAG_CurrentUpdated	FLAGS[5]
#define FLAG_STARTING		FLAGS[6]

// Start Mode
#define ALIGN					0
#define ABSTRAKT_ALIGN			1
#define ABSTRAKT				2

// LED Mode
#define LED_MODE_OFF			0
#define LED_MODE_ON				1
#define LED_MODE_BLINK			2
#define LED_MODE_FAST_BLINK		3
#define LED_MODE_SPLASH			4

// Alert Mode
#define ALERT_NULL				0
#define ALERT_SPEED				1
#define ALERT_CURRENT			2

// WORK
typedef struct {
	unsigned char	Direction;
	unsigned char	Duty;
	unsigned int	Current;
	unsigned int	Current_max;
	unsigned char	PWM_Min_Value;
	unsigned char	PWM_Startup_Value;
	unsigned char	Start_Ref;
	unsigned char	Stop_Ref;
	unsigned char	Resolution;
	unsigned char	Alert_Mode;
} motor_var;
motor_var Motor;

// SETTINGS
typedef struct {
	unsigned char	DutyDamper;
	unsigned char	PWM_Startup; // (%)
	unsigned char	PWM_Min; // (%)
	unsigned char	Start_Type; // ALIGN/ABSTRAKT_ALIGN/ABSTRAKT
	unsigned char	Start_Time; // 1...255	
	unsigned char	Timing; // From 0 to 30
	unsigned char	Pot_Min;
	unsigned char	Pot_Max;
	unsigned char	Current_Max;
	unsigned char	Sound; // TRUE / FALSE
	unsigned char	DeadTime; // 

} motor_settings;
motor_settings Settings;

// Set default settings
void DefaultSettings() {
	Settings.DutyDamper = 10;
	Settings.PWM_Startup = 25;
	Settings.PWM_Min = 10;
	Settings.Start_Type = ALIGN;
	Settings.Start_Time = 10; //10
	Settings.Timing = 30;//20;
	Settings.Pot_Min = 0;
	Settings.Pot_Max = 255;
	Settings.Current_Max = 180;
	Settings.Sound = TRUE;
	Settings.DeadTime = 2;
}

// Preset motor data
void PrepareSettings() {
	Motor.Direction = CCW;
	Motor.Duty = 0;

	// Вычисляем реальный PWM STARTUP для старта из настроек
	Motor.PWM_Startup_Value = (unsigned char) ((Settings.PWM_Startup*PWM_TOP_VALUE_16K)/100);
    // Вычисляем реальный PWM MIN из настроек
    Motor.PWM_Min_Value = (unsigned char) ((Settings.PWM_Min*PWM_TOP_VALUE_16K)/100);

	Motor.Start_Ref = POT_START_REF;
	Motor.Stop_Ref = POT_STOP_REF;
	Motor.Resolution = (Settings.Pot_Max - Settings.Pot_Min);
}

volatile unsigned char duty_damper_counter;
volatile unsigned char starttime_counter;

// Array of power stage enable signals for each commutation step
unsigned char driveTable[6];

// Array of ADC channel selections for each commutation step
volatile unsigned char ADMUXValue;
unsigned char ADMUXTable[6];
volatile unsigned char ADMUXIndex=0;

// Array holding the intercommutation delays used during startup.
unsigned int startupDelays[STARTUP_NUM_COMMUTATIONS];

/* Filtered commutation timer variable and speed indicator.
 *  This value equals half the time of one commutation step. It is filtered
 *  through an IIR filter, so the value stored is not the most recent measuremnt.
 */
volatile unsigned int filteredTimeSinceCommutation;
volatile unsigned int filteredTimeSinceCommutationCopy;

volatile unsigned int filteredTimeSinceCorrection = 0;
volatile unsigned int filteredTimeSinceCorrectionCopy = 0;

/* The power stage enable signals that will be output to the motor drivers
 *  at next commutation.
 *
 *  This variable holds the pattern of enable signals that will be output to the
 *  power stage at next commutation.
 */
volatile unsigned char nextDrivePattern;

/* Polarity of the expected zero crossing.
 *
 *  The polarity of the expected zero crossing.
 *  Could be eiter \ref EDGE_FALLING or \ref EDGE_RISING.
 */
volatile unsigned char zcPolarity;

/* The commutation step that starts at next commutation.
 *
 *  The commutation step that starts at next commutation. This is used to keep
 *  track on where in the commutation cycle we are.
 */
volatile unsigned char nextCommutationStep;

// ADC reading of external analog speed reference
volatile unsigned char speedReference;

// ADC reading of shunt voltage
volatile unsigned char currentVoltageADC;

volatile unsigned char LED_Mode;
volatile unsigned char LED_Enabled;
volatile unsigned char LED_ON_Time;
volatile unsigned char LED_OFF_Time;
volatile unsigned char LED_Counter;

// Read ADC
unsigned char adc_read(unsigned char ch) {
	ADMUX = (1 << REFS0) | (1 << ADLAR) | (ch & 0x1F);	// set channel (VREF = VCC) , left align, chennel

	// Start first ADC conversion
	ADCSRA = (1 << ADEN) | (1 << ADSC) | (0 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (0 << ADPS0);
	while(ADCSRA & (1 << ADSC));		// wait until conversion complete

	// Result is not correct after first conversation
	// Restart ADC conversion
	ADCSRA = (1 << ADEN) | (1 << ADSC) | (0 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
	while(ADCSRA & (1 << ADSC));		// wait until conversion complete	

	return ADCH;
}

// Set LED mode
void Set_LED_Mode(unsigned char mode) {
	LED_Mode = mode;

	if (mode==LED_MODE_OFF) {
		LED_OFF;
	}
	
	if (mode==LED_MODE_ON) {
		LED_ON;
	}

	if (mode==LED_MODE_BLINK) {
		LED_ON;
		LED_Enabled = TRUE;
		LED_ON_Time = 200;
		LED_OFF_Time = 200;
	}

	if (mode==LED_MODE_FAST_BLINK) {
		LED_ON;
		LED_Enabled = TRUE;
		LED_ON_Time = 20;
		LED_OFF_Time = 20;
	}

	if (mode==LED_MODE_SPLASH) {
		LED_ON;
		LED_Enabled = TRUE;
		LED_ON_Time = 20;
		LED_OFF_Time = 200;
	}

	LED_Counter = 0;
}


// Main
int main(void)
{
	DefaultSettings();
	PrepareSettings();

	InitPorts();
	InitTimers();
	InitAnalogComparator();
	
	MakeTables();

	FLAG_RUN = FALSE;
	sei();

	StartupDelay(STARTUP_LOCK_DELAY);
	Beep();

	Set_LED_Mode(LED_MODE_ON);
  
	speedReference = get_speedReference();
	speedReference = get_speedReference();

	for(;;)
	{
		// Motor
		if (FLAG_RUN == FALSE) {
			currentVoltageADC = adc_read(ADMUX_CURRENT);
			speedReference = get_speedReference();

			CalculateCurrent();

			if ((Motor.Alert_Mode ==0) & (speedReference > Motor.Start_Ref)) {
				if (BTN_IS_DOWN) {
					Motor.Direction = CW;
				}
				else {
					Motor.Direction = CCW;
				}

				MakeTables();
				StartMotor();
				FLAG_RUN = TRUE;
			}
		}
		else {
			PWMControl();
		}

		// Current Calculate
		if (FLAG_CurrentUpdated == TRUE) {
			CalculateCurrent();
			FLAG_CurrentUpdated = FALSE;
		}

		// Speed Calculate
		if (FLAG_SpeedUpdated == TRUE) {
			CalculateSpeed();
			FLAG_SpeedUpdated = FALSE;
		}

		// Alerts
		// Speed Limit
		if (Motor.Alert_Mode == ALERT_SPEED) {
			ALARMStopMotor(LED_MODE_SPLASH);
		}

		//Current Limit
		if (Motor.Alert_Mode == ALERT_CURRENT) {
			ALARMStopMotor(LED_MODE_FAST_BLINK);
		}
	}
}


// Initializes I/O ports
 static void InitPorts(void)
{
	// Init DRIVE_DDR for motor driving.
	DRIVE_DDR = (1 << UL) | (1 << UH) | (1 << VL) | (1 << VH) | (1 << WL) | (1 << WH);

	// Init PORTD for PWM on PD5.
	DDRD |= (1 << PD5);

	// Disable digital input buffers on ADC channels.
	DIDR0 = (1 << ADC4D) | (1 << ADC3D) | (1 << ADC2D) | (1 << ADC1D) | (1 << ADC0D);
  
	// Disable digital input buffers on AIN0, AIN1
	DIDR1 |= (1<<AIN1D) | (1<<AIN0D);

	// Init LED Port
	LED_DDR |= (1<<LED_PIN);
	LED_OFF;

	// Init Revers Button Port
	BTN_PORT |= (1<<BTN_PIN);
}


// Initializes timers (for commutation timing and PWM)
static void InitTimers(void)
{
	// Set up Timer/counter0 for PWM, output on OCR0B, OCR0A as TOP value, prescaler = 1.
	TCCR0A = (0 << COM0A1) | (0 << COM0A0) | (1 << COM0B1) | (0 << COM0B0) | (0 << WGM01) | (1 << WGM00);
	TCCR0B = (1 << WGM02) | (0 << CS02) | (1 << CS01) | (0 << CS00);
	OCR0A = PWM_TOP_VALUE_16K;

	TIMSK0 = (0 << TOIE0);

	// Set up Timer/counter1 for commutation timing, prescaler = 8.
	TCCR1B = (1 << CS11) | (0 << CS10);

	// Set up Timer2
	TCCR2B = ((1<<CS22) | (0<<CS21) | (1<<CS20)); // prescaler = 128
	TIMSK2|=(1<<TOIE2);
}


// Initializes the analog comparator
static void InitAnalogComparator(void)
{
	ADCSRA &= ~(1<<ADEN); // Disable ADC
	ADCSRB |= (1<<ACME); // Enable multiplexer select
	ACSR = (0<<ACD) | (0 << ACBG) | (1 << ACI) | (0 << ACIE) | (0 << ACIC) | (0 << ACIS1) | (0 << ACIS0);
}

// Initializes arrays for motor driving and AD channel selection
static void MakeTables(void)
{
  if (Motor.Direction == CCW) {
    driveTable[0] = DRIVE_PATTERN_STEP1_CCW;
    driveTable[1] = DRIVE_PATTERN_STEP2_CCW;
    driveTable[2] = DRIVE_PATTERN_STEP3_CCW;
    driveTable[3] = DRIVE_PATTERN_STEP4_CCW;
    driveTable[4] = DRIVE_PATTERN_STEP5_CCW;
    driveTable[5] = DRIVE_PATTERN_STEP6_CCW;

    ADMUXTable[0] = ADMUX_W;
    ADMUXTable[1] = ADMUX_V;
    ADMUXTable[2] = ADMUX_U;
    ADMUXTable[3] = ADMUX_W;
    ADMUXTable[4] = ADMUX_V;
    ADMUXTable[5] = ADMUX_U;
  }
  else {
	driveTable[0] = DRIVE_PATTERN_STEP1_CW;
   	driveTable[1] = DRIVE_PATTERN_STEP2_CW;
   	driveTable[2] = DRIVE_PATTERN_STEP3_CW;
   	driveTable[3] = DRIVE_PATTERN_STEP4_CW;
   	driveTable[4] = DRIVE_PATTERN_STEP5_CW;
   	driveTable[5] = DRIVE_PATTERN_STEP6_CW;

    ADMUXTable[0] = ADMUX_U;
    ADMUXTable[1] = ADMUX_V;
    ADMUXTable[2] = ADMUX_W;
    ADMUXTable[3] = ADMUX_U;
    ADMUXTable[4] = ADMUX_V;
    ADMUXTable[5] = ADMUX_W;
  }

  startupDelays[0] = 800;
  startupDelays[1] = 400;
  startupDelays[2] = 200;
  startupDelays[3] = 160;
  startupDelays[4] = 140;
  startupDelays[5] = 120;
  startupDelays[6] = 100;
  startupDelays[7] = 80;
}


// Set port value, using deadtime
static void SET_DRIVE_PORT(unsigned char DrivePattern) {
  char i;

  DRIVE_PORT = (DRIVE_PORT && DrivePattern);

  for (i=0; i<Settings.DeadTime; i++) {
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");

		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
		asm("nop");
	}

	DRIVE_PORT = DrivePattern;

}

// Get rotor position. Used before motor starting.
// This function may be unsuitable for some motors
unsigned char GetPosition() {
	unsigned char i;
	unsigned char V[6];
	int F1, F2, F3;

	DISABLE_DRIVING;
	SET_PWM_COMPARE_VALUE(PWM_TOP_VALUE_16K);

	StartupDelay(1);

	for (i=0; i<6; i++)
	{
		cli();
		DRIVE_PORT = driveTable[i];
		V[i] = adc_read(ADMUXTable[i]);
		DISABLE_DRIVING;
		sei();
		StartupDelay(1);
	}

	F1 = (V[0]+V[3]+V[4]+V[1]) - (V[5]+V[2])*2;
	F2 = (V[0]+V[3]+V[5]+V[2]) - (V[4]+V[1])*2;
	F3 = (V[4]+V[1]+V[5]+V[2]) - (V[0]+V[3])*2;

	i = 0;
	if (F1>0) i |= (1<<2);
	if (F2>0) i |= (1<<1);
	if (F3>0) i |= (1<<0);

	if (i==5) return 0;
	if (i==4) return 1;
	if (i==6) return 2;
	if (i==2) return 3;
	if (i==3) return 4;
	if (i==1) return 5;
	
	return 0;
}

// Executes the motor startup sequence
static void StartMotor(void)
{
	unsigned char i;

	if (Settings.Start_Type == ALIGN) {
		nextCommutationStep = 0;
	} else {
		nextCommutationStep = GetPosition();
	}

	FLAG_WD = 0;
	FLAG_WD_EN = FALSE;
	Motor.Duty = Motor.PWM_Startup_Value;
	SET_PWM_COMPARE_VALUE(Motor.Duty);

	//Preposition.
	DRIVE_PORT = driveTable[nextCommutationStep];

	//StartupDelay(STARTUP_LOCK_DELAY);

	nextCommutationStep++;
	nextDrivePattern = driveTable[nextCommutationStep];

	if (Settings.Start_Type != ABSTRAKT) {
		for (i = 0; i < STARTUP_NUM_COMMUTATIONS; i++) {
			//DRIVE_PORT = nextDrivePattern;
			SET_DRIVE_PORT(nextDrivePattern);
			StartupDelay(startupDelays[i]);

			ADMUX = ADMUXTable[nextCommutationStep];

			// Use LSB of nextCommutationStep to determine zero crossing polarity.
			zcPolarity = nextCommutationStep & 0x01;

			nextCommutationStep++;
			if (nextCommutationStep >= 6)
			{
				nextCommutationStep = 0;
			}
			nextDrivePattern = driveTable[nextCommutationStep];
		}
	}

	// Switch to sensorless commutation.
	TCNT1 = 0;
	TIMSK1 = (1 << OCIE1A);

	// Set filteredTimeSinceCommutation to the time to the next commutation.
	filteredTimeSinceCommutation = startupDelays[STARTUP_NUM_COMMUTATIONS - 1] * (STARTUP_DELAY_MULTIPLIER  / 2);

	FLAG_WD_EN = TRUE;
	FLAG_STARTING = TRUE;
	starttime_counter = 0;
	Motor.Alert_Mode = ALERT_NULL;
}

// Stop  motor
static void StopMotor(void)
{
	FLAG_RUN = FALSE;
	DISABLE_DRIVING;
	DISABLE_ALL_TIMER0_INTS;
	DISABLE_ALL_TIMER1_INTS;
	Motor.Duty = 0;
	SET_PWM_COMPARE_VALUE(0);
}

// Stop motor and enable LED blink mode
static void ALARMStopMotor(unsigned char mode)
{
	StopMotor();
	Set_LED_Mode(mode);
	while (get_speedReference() > Motor.Start_Ref) {
	}
	StartupDelay(100); // Delay after set REF to zero.
	Motor.Alert_Mode = 0;
	Set_LED_Mode(LED_MODE_ON);
}

/* Timer/counter0 bottom overflow. Used for zero-cross detection.
 *
 *  This interrupt service routine is called every time the up/down counting
 *  PWM counter reaches bottom. An ADC reading on the active channel is
 *  automatically triggered at the same time as this interrupt is triggered.
 *  This is used to detect a zero crossing.
 *
 *  In the event of a zero crossing, the time since last commutation is stored
 *  and Timer/counter1 compare A is set up to trigger at the next commutation
 *  instant.
 */
ISR(TIMER0_OVF_vect)
{
	unsigned char temp;

	temp = (ACSR & (1<<ACO));

	if (((zcPolarity == EDGE_RISING) && (temp == 0)) || ((zcPolarity == EDGE_FALLING) && (temp > 0)))
	{
		// Disable Timer/Counter0 overflow ISR.
		DISABLE_ALL_TIMER0_INTS;

		unsigned int timeSinceCommutation;

		// Find time since last commutation
		timeSinceCommutation = TCNT1;
		//TCNT1 = 50;
		TCNT1 =  filteredTimeSinceCorrection;

		// Filter the current ZC detection with earlier measurements through an IIR filter.
		filteredTimeSinceCommutation = (COMMUTATION_TIMING_IIR_COEFF_A * timeSinceCommutation
										+ COMMUTATION_TIMING_IIR_COEFF_B * filteredTimeSinceCommutation)
										/ (COMMUTATION_TIMING_IIR_COEFF_A + COMMUTATION_TIMING_IIR_COEFF_B);

		OCR1A = filteredTimeSinceCommutation;
   		SET_TIMER1_INT_COMMUTATION;
   		CLEAR_ALL_TIMER1_INT_FLAGS;
		FLAG_SpeedUpdated = TRUE;
	}
	temp = ADMUX;

	if (ADMUXIndex == 0) {
		//currentVoltageADC = adc_read(ADMUX_CURRENT);
		currentVoltageADC = adc_read(ADMUX_CURRENT);

		if (currentVoltageADC > Settings.Current_Max) {
			StopMotor();
			Motor.Alert_Mode = ALERT_CURRENT;
			return;
		}

		FLAG_CurrentUpdated = TRUE;
	}

	if (ADMUXIndex == 1) {
		speedReference = get_speedReference();
		FLAG_RefUpdated = TRUE;
	}
  
	ADMUXIndex++;
	if (ADMUXIndex > 1) {
		ADMUXIndex = 0;
	}

	InitAnalogComparator();
	ADMUX = temp;
}


/* Commutates and prepares for new zero-cross detection.
 *
 *  This interrupt service routine is triggered exactly when a commutation
 *  is scheduled. The commutation is performed instantly and Timer/counter0
 *  is reset to measure the delay between commutation and zero-cross detection.
 *
 *  Commutation causes large transients on all phases for a short while that could
 *  cause false zero-cross detections. A zero cross detection hold-off period is
 *  therefore used to avoid any false readings. This is performed by using Timer/counter1
 *  compare B. The compare is set to happen after the specified hold-off period.
 *  Timer/counter1 compare B interrupt handler then enables the zero-cross detection.
 */
ISR(TIMER1_COMPA_vect)
{
	// Commutate and clear commutation timer.
	SET_DRIVE_PORT(nextDrivePattern);
	TCNT1 = 0;

	zcPolarity = nextCommutationStep & 0x01;

	// Set zero-cross detection holdoff time.
	CLEAR_ALL_TIMER1_INT_FLAGS;

	OCR1B = filteredTimeSinceCommutationCopy / 2;

	SET_TIMER1_INT_HOLDOFF;

	FLAG_WD = 0;
}


/* Enables zero-cross detection.
 *
 *  This interrupt service routine is triggered when the zero cross detection
 *  hold-off time after commutation is over. All Timer/counter1 interrupts are
 *  disabled and Timer/counter0 (PWM) overflow interrupt is enabled to allow
 *  the ADC readings to be used for zero-cross detection.
 */
ISR(TIMER1_COMPB_vect)
{
	// Enable TCNT0 overflow ISR.
	CLEAR_ALL_TIMER0_INT_FLAGS;
	CLEAR_ALL_TIMER1_INT_FLAGS;
	SET_TIMER0_INT_ZC_DETECTION;
	DISABLE_ALL_TIMER1_INTS;

	// Set up ADC for zero-cross detection
	ADMUX = ADMUXTable[nextCommutationStep];

	// Rotate commutation step counter.
	nextCommutationStep++;
	if (nextCommutationStep >= 6)
	{
		nextCommutationStep = 0;
	}
	nextDrivePattern = driveTable[nextCommutationStep];
}


// Timer2 overflow
ISR(TIMER2_OVF_vect) {

	if (FLAG_STARTING == TRUE) {
		starttime_counter++;
		if (starttime_counter > Settings.Start_Time) {
			FLAG_STARTING = FALSE;
		}
	}

	if (FLAG_WD_EN == TRUE) {
		if (FLAG_WD > 40) {
			StopMotor();
		}
		else {
			FLAG_WD++;
		}
	}

	if (LED_Mode > 1) {
		LED_Counter++;
		if (LED_Enabled==TRUE) {
			if (LED_Counter > LED_ON_Time) {
				LED_OFF;
				LED_Enabled=FALSE;
				LED_Counter = 0;
			}
		}
		else {
			if (LED_Counter > LED_OFF_Time) {
				LED_ON;
				LED_Enabled=TRUE;
				LED_Counter = 0;
			}
		}
	}
}

// Generates a delay used during startup
void StartupDelay(unsigned int delay)
{
	CLEAR_ALL_TIMER1_INT_FLAGS;
	do
	{
		TCNT1 = 0xffff - STARTUP_DELAY_MULTIPLIER;
		// Wait for timer to overflow.
		while (!(TIFR1 & (1 << TOV1)))
		{

		}

		CLEAR_ALL_TIMER1_INT_FLAGS;
		delay--;
	} while (delay);
}

static void PWMControl(void)
{
	unsigned char duty;
  
	// Only update duty cycle if a new speed reference measurement has been made. (Done right after speed measurement is ready)
	if (FLAG_RefUpdated)
	{
		if (speedReference < Motor.Stop_Ref) {
			SET_PWM_COMPARE_VALUE(2);
			Motor.Duty = 2;
		}
		else {
			if (FLAG_STARTING == FALSE) {
				// Calculate duty cycle from speed reference value
				duty = (unsigned char) (Motor.PWM_Min_Value + speedReference * (PWM_TOP_VALUE_16K - Motor.PWM_Min_Value) / Motor.Resolution);
  				if (duty_damper_counter > Settings.DutyDamper) {
	  				if (duty > Motor.Duty) {
	  					Motor.Duty++;
	  				}
	  				else {
						Motor.Duty--;
	  				}
    				duty_damper_counter = 0;
  				}
  				duty_damper_counter++;
				SET_PWM_COMPARE_VALUE(Motor.Duty);
			}
		}
	}
	FLAG_RefUpdated = FALSE;
}

/* Calculates the current speed in electrical RPM.
 *
 *  This function calculates the current speed in electrical rotations per
 *  minute from the global variable \ref filteredTimeSinceCommutation.
 */
void CalculateSpeed()
{
	// Copy used to minimize period where interrupts are disabled.
	cli();
	filteredTimeSinceCommutationCopy = filteredTimeSinceCommutation;
	sei();

	filteredTimeSinceCorrectionCopy = filteredTimeSinceCommutationCopy*Settings.Timing/60;

	cli();
	filteredTimeSinceCorrection = filteredTimeSinceCorrectionCopy;
	sei();
}

/* Calculates current consumption.
 *
 *  This function calculates the current consumption in milliAmperes from the
 *  global variable \ref currentVoltageADC. The external know reference voltage
 *  is used to compensate for varying AREF voltage.
 */
void CalculateCurrent()
{
	Motor.Current = abs((int)(currentVoltageADC) - 127) * 1;

	if (Motor.Current > Motor.Current_max)
		Motor.Current_max = Motor.Current;
}


void Beep() {
	unsigned char i;
	if (Settings.Sound == TRUE) {
		StopMotor();
		SET_PWM_COMPARE_VALUE(Motor.PWM_Startup_Value);
		for (i = 0; i < 250; i++)
		{
			DRIVE_PORT = driveTable[0];
			StartupDelay(1);
			DRIVE_PORT = driveTable[3];
			StartupDelay(1);
		}
		StopMotor();
	}
}


unsigned char get_speedReference(void) {
	unsigned char tmp;

	tmp = adc_read(ADMUX_SPEED_REF);
	if (tmp > Settings.Pot_Min) {
		return (tmp - Settings.Pot_Min);
	}
	else {
		return 0;
	}
}
