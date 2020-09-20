#include "arhat.h"

//#define TWI_ON    15
//#include "arhat_twi.h"

// ******* #include "utility/twi.h" ************ //

#include <compat/twi.h>

#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif

#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif

  #include <inttypes.h>

  //#define ATMEGA8

  #ifndef TWI_FREQ
  #define TWI_FREQ 100000L
  #endif

  #ifndef TWI_BUFFER_LENGTH
  #define TWI_BUFFER_LENGTH 32
  #endif

  #define TWI_READY 0
  #define TWI_MRX   1
  #define TWI_MTX   2
  #define TWI_SRX   3
  #define TWI_STX   4
  
  void twi_init(void);
  void twi_setAddress(uint8_t);
  uint8_t twi_readFrom(uint8_t, uint8_t*, uint8_t, uint8_t);
  uint8_t twi_writeTo(uint8_t, uint8_t*, uint8_t, uint8_t, uint8_t);
  uint8_t twi_transmit(const uint8_t*, uint8_t);
  void twi_attachSlaveRxEvent( void (*)(uint8_t*, int) );
  void twi_attachSlaveTxEvent( void (*)(void) );
  void twi_reply(uint8_t);
  void twi_stop(void);
  void twi_releaseBus(void);

static volatile uint8_t twi_state;
static volatile uint8_t twi_slarw;
static volatile uint8_t twi_sendStop;			// should the transaction end with a stop
static volatile uint8_t twi_inRepStart;			// in the middle of a repeated start

static void (*twi_onSlaveTransmit)(void);
static void (*twi_onSlaveReceive)(uint8_t*, int);

static uint8_t twi_masterBuffer[TWI_BUFFER_LENGTH];
static volatile uint8_t twi_masterBufferIndex;
static volatile uint8_t twi_masterBufferLength;

static uint8_t twi_txBuffer[TWI_BUFFER_LENGTH];
static volatile uint8_t twi_txBufferIndex;
static volatile uint8_t twi_txBufferLength;

static uint8_t twi_rxBuffer[TWI_BUFFER_LENGTH];
static volatile uint8_t twi_rxBufferIndex;

static volatile uint8_t twi_error;

void twi_init(void)
{
  twi_state = TWI_READY;
  twi_sendStop = true;		// default value
  twi_inRepStart = false;
  digitalWrite(I2C_SDA, 1);
  digitalWrite(I2C_SCL, 1);
  cbi(TWSR, TWPS0);
  cbi(TWSR, TWPS1);
  TWBR = ((F_CPU / TWI_FREQ) - 16) / 2;
  TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWEA);
}

void twi_setAddress(uint8_t address)
{
  TWAR = address << 1;
}

uint8_t twi_readFrom(uint8_t address, uint8_t* data, uint8_t length, uint8_t sendStop)
{
  uint8_t i;

  if(TWI_BUFFER_LENGTH < length){
    return 0;
  }
  while(TWI_READY != twi_state){
    continue;
  }
  twi_state = TWI_MRX;
  twi_sendStop = sendStop;
  twi_error = 0xFF;
  twi_masterBufferIndex = 0;
  twi_masterBufferLength = length-1;  // This is not intuitive, read on...
  twi_slarw = TW_READ;
  twi_slarw |= address << 1;

  if (true == twi_inRepStart) {
    twi_inRepStart = false;			// remember, we're dealing with an ASYNC ISR
    TWDR = twi_slarw;
    TWCR = _BV(TWINT) | _BV(TWEA) | _BV(TWEN) | _BV(TWIE);	// enable INTs, but not START
  }else
    TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWEA) | _BV(TWINT) | _BV(TWSTA);

  while(TWI_MRX == twi_state){continue;}

  if (twi_masterBufferIndex < length)    length = twi_masterBufferIndex;

  for(i = 0; i < length; ++i){
    data[i] = twi_masterBuffer[i];
  }
  return length;
}

uint8_t twi_writeTo(uint8_t address, uint8_t* data, uint8_t length, uint8_t wait, uint8_t sendStop)
{
  uint8_t i;

  if(TWI_BUFFER_LENGTH < length){ return 1;}

  while(TWI_READY != twi_state){
    continue;
  }
  twi_state = TWI_MTX;
  twi_sendStop = sendStop;
  twi_error = 0xFF;
  twi_masterBufferIndex = 0;
  twi_masterBufferLength = length;

  for(i = 0; i < length; ++i){
    twi_masterBuffer[i] = data[i];
  }
  
  twi_slarw = TW_WRITE;
  twi_slarw |= address << 1;

  if (true == twi_inRepStart) {
    twi_inRepStart = false;			// remember, we're dealing with an ASYNC ISR
    TWDR = twi_slarw;				
    TWCR = _BV(TWINT) | _BV(TWEA) | _BV(TWEN) | _BV(TWIE);	// enable INTs, but not START
  }
  else
    TWCR = _BV(TWINT) | _BV(TWEA) | _BV(TWEN) | _BV(TWIE) | _BV(TWSTA);	// enable INTs

  while(wait && (TWI_MTX == twi_state)){
    continue;
  }
  
  if (twi_error == 0xFF)
    return 0;	// success
  else if (twi_error == TW_MT_SLA_NACK)
    return 2;	// error: address send, nack received
  else if (twi_error == TW_MT_DATA_NACK)
    return 3;	// error: data send, nack received
  else
    return 4;	// other twi error
}

uint8_t twi_transmit(const uint8_t* data, uint8_t length)
{
  uint8_t i;

  if(TWI_BUFFER_LENGTH < length){
    return 1;
  }
  
  if(TWI_STX != twi_state){
    return 2;
  }
  
  twi_txBufferLength = length;
  for(i = 0; i < length; ++i){
    twi_txBuffer[i] = data[i];
  }
  
  return 0;
}

void twi_attachSlaveRxEvent( void (*function)(uint8_t*, int) )
{
  twi_onSlaveReceive = function;
}

void twi_attachSlaveTxEvent( void (*function)(void) )
{
  twi_onSlaveTransmit = function;
}

void twi_reply(uint8_t ack)
{
  if(ack){
    TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWINT) | _BV(TWEA);
  }else{
	  TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWINT);
  }
}

void twi_stop(void)
{
  TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWEA) | _BV(TWINT) | _BV(TWSTO);

  while(TWCR & _BV(TWSTO)){
    continue;
  }
  twi_state = TWI_READY;
}

void twi_releaseBus(void)
{
  TWCR = _BV(TWEN) | _BV(TWIE) | _BV(TWEA) | _BV(TWINT);

  twi_state = TWI_READY;
}

ISR(TWI_vect)
{
  switch(TW_STATUS){
    // All Master
    case TW_START:     // sent start condition
    case TW_REP_START: // sent repeated start condition
      // copy device address and r/w bit to output register and ack
      TWDR = twi_slarw;
      twi_reply(1);
      break;

    // Master Transmitter
    case TW_MT_SLA_ACK:  // slave receiver acked address
    case TW_MT_DATA_ACK: // slave receiver acked data
      // if there is data to send, send it, otherwise stop 
      if(twi_masterBufferIndex < twi_masterBufferLength){
        // copy data to output register and ack
        TWDR = twi_masterBuffer[twi_masterBufferIndex++];
        twi_reply(1);
      }else{
	if (twi_sendStop)
          twi_stop();
	else {
	  twi_inRepStart = true;	// we're gonna send the START
	  // don't enable the interrupt. We'll generate the start, but we 
	  // avoid handling the interrupt until we're in the next transaction,
	  // at the point where we would normally issue the start.
	  TWCR = _BV(TWINT) | _BV(TWSTA)| _BV(TWEN) ;
	  twi_state = TWI_READY;
	}
      }
      break;
    case TW_MT_SLA_NACK:  // address sent, nack received
      twi_error = TW_MT_SLA_NACK;
      twi_stop();
      break;
    case TW_MT_DATA_NACK: // data sent, nack received
      twi_error = TW_MT_DATA_NACK;
      twi_stop();
      break;
    case TW_MT_ARB_LOST: // lost bus arbitration
      twi_error = TW_MT_ARB_LOST;
      twi_releaseBus();
      break;

    // Master Receiver
    case TW_MR_DATA_ACK: // data received, ack sent
      // put byte into buffer
      twi_masterBuffer[twi_masterBufferIndex++] = TWDR;
    case TW_MR_SLA_ACK:  // address sent, ack received
      // ack if more bytes are expected, otherwise nack
      if(twi_masterBufferIndex < twi_masterBufferLength){
        twi_reply(1);
      }else{
        twi_reply(0);
      }
      break;
    case TW_MR_DATA_NACK: // data received, nack sent
      // put final byte into buffer
      twi_masterBuffer[twi_masterBufferIndex++] = TWDR;
	if (twi_sendStop)
          twi_stop();
	else {
	  twi_inRepStart = true;	// we're gonna send the START
	  // don't enable the interrupt. We'll generate the start, but we 
	  // avoid handling the interrupt until we're in the next transaction,
	  // at the point where we would normally issue the start.
	  TWCR = _BV(TWINT) | _BV(TWSTA)| _BV(TWEN) ;
	  twi_state = TWI_READY;
	}    
	break;
    case TW_MR_SLA_NACK: // address sent, nack received
      twi_stop();
      break;
    // TW_MR_ARB_LOST handled by TW_MT_ARB_LOST case

    // Slave Receiver
    case TW_SR_SLA_ACK:   // addressed, returned ack
    case TW_SR_GCALL_ACK: // addressed generally, returned ack
    case TW_SR_ARB_LOST_SLA_ACK:   // lost arbitration, returned ack
    case TW_SR_ARB_LOST_GCALL_ACK: // lost arbitration, returned ack
      // enter slave receiver mode
      twi_state = TWI_SRX;
      // indicate that rx buffer can be overwritten and ack
      twi_rxBufferIndex = 0;
      twi_reply(1);
      break;
    case TW_SR_DATA_ACK:       // data received, returned ack
    case TW_SR_GCALL_DATA_ACK: // data received generally, returned ack
      // if there is still room in the rx buffer
      if(twi_rxBufferIndex < TWI_BUFFER_LENGTH){
        // put byte in buffer and ack
        twi_rxBuffer[twi_rxBufferIndex++] = TWDR;
        twi_reply(1);
      }else{
        // otherwise nack
        twi_reply(0);
      }
      break;
    case TW_SR_STOP: // stop or repeated start condition received
      // put a null char after data if there's room
      if(twi_rxBufferIndex < TWI_BUFFER_LENGTH){
        twi_rxBuffer[twi_rxBufferIndex] = '\0';
      }
      // sends ack and stops interface for clock stretching
      twi_stop();
      // callback to user defined callback
      twi_onSlaveReceive(twi_rxBuffer, twi_rxBufferIndex);
      // since we submit rx buffer to "wire" library, we can reset it
      twi_rxBufferIndex = 0;
      // ack future responses and leave slave receiver state
      twi_releaseBus();
      break;
    case TW_SR_DATA_NACK:       // data received, returned nack
    case TW_SR_GCALL_DATA_NACK: // data received generally, returned nack
      // nack back at master
      twi_reply(0);
      break;
    
    // Slave Transmitter
    case TW_ST_SLA_ACK:          // addressed, returned ack
    case TW_ST_ARB_LOST_SLA_ACK: // arbitration lost, returned ack
      // enter slave transmitter mode
      twi_state = TWI_STX;
      // ready the tx buffer index for iteration
      twi_txBufferIndex = 0;
      // set tx buffer length to be zero, to verify if user changes it
      twi_txBufferLength = 0;
      // request for txBuffer to be filled and length to be set
      // note: user must call twi_transmit(bytes, length) to do this
      twi_onSlaveTransmit();
      // if they didn't change buffer & length, initialize it
      if(0 == twi_txBufferLength){
        twi_txBufferLength = 1;
        twi_txBuffer[0] = 0x00;
      }
      // transmit first byte from buffer, fall
    case TW_ST_DATA_ACK: // byte sent, ack returned
      // copy data to output register
      TWDR = twi_txBuffer[twi_txBufferIndex++];
      // if there is more to send, ack, otherwise nack
      if(twi_txBufferIndex < twi_txBufferLength){
        twi_reply(1);
      }else{
        twi_reply(0);
      }
      break;
    case TW_ST_DATA_NACK: // received nack, we are done 
    case TW_ST_LAST_DATA: // received ack, but we are done already!
      // ack future responses
      twi_reply(1);
      // leave slave receiver state
      twi_state = TWI_READY;
      break;

    // All
    case TW_NO_INFO:   // no state information
      break;
    case TW_BUS_ERROR: // bus error, illegal stop/start
      twi_error = TW_BUS_ERROR;
      twi_stop();
      break;
  }
}

// ******* #include "lcd1602.h" ************ //
#define LCD_I2C_SPEED    100000

// LCD on chip HD44780 команды или их коды операций:
#define LCD_CLEAR          0x01
#define LCD_HOME           0x02
#define LCD_SHIFTS         0x04  // часть!
#define LCD_SHOWS          0x08  // часть!
#define LCD_MODES          0x20  // часть!
#define LCD_FONT_RAM       0x40  // адрес в таблицу шрифтов 6бит
#define LCD_SHOW_RAM       0x80  // адрес текущей позиции 7бит

#define LCD_CURSOR_LEFT    0x10  // команда сдвига курсора влево
#define LCD_CURSOR_RIGHT   0x14  // команда сдвига курсора вправо
#define LCD_ROW_LEFT       0x18  // команда сдвига всей строки влево
#define LCD_ROW_RIGHT      0x1C  // команда сдвига всей строки вправо

// for LCD_SHIFTS:
#define LCD_INC            0x02  // Инкремент: сдвиг вправо при записи байта
#define LCD_SHIFT_ON       0x01  // сдвиг и строки тоже при записи байта (в обратную сторону! Курсор как-бы на месте)

// for LCD_SHOWS:
#define LCD_SHOW_ON        0x04  // включить отображение
#define LCD_CURSOR_UL      0x02  // включить курсор подчерком
#define LCD_CURSOR_BLINK   0x01  // включить мигание курсора

// for LCD_MODES:
#define LCD_8BIT           0x10  // шина 8бит/4бит
#define LCD_2LINE          0x08  // память 2/1 строки
#define LCD_5x10           0x04  // фонт 5х10 / 5х8 точек

// Пустышки для полноты картины:
#define LCD_DEC        0 // сдвиг курсора/экрана влево
#define LCD_SHIFT_OFF  0 // сдвиг строки отключен
#define LCD_SHOW_OFF   0 // дисплей выключен
#define LCD_CURSOR_OFF 0 // курсор выключен
#define LCD_5x8        0
#define LCD_1LINE      0 // только одна строка (1 буфер 80символов, иначе 2х40)
#define LCD_4BIT       0 // 4бита: каждый байт идет 2 посылками "подряд" по линиям D7..D4

// Маски бит данных (D3,D2,D1,D0), управляющие сигналами напрямую:
#define LCD_BACK      B00001000  // bit D3 управляет подсветкой экрана при каждом выводе в I2C!
#define LCD_E         B00000100  // Enable bit - Strobe for read/write >230msec.
#define LCD_RW        B00000010  // Read/Write bit - ==0 всегда!
#define LCD_RS        B00000001  // Команда(0) или данные(1)

#define LCD_WAIT_BOOT0       15  // тиков Т0:  >15мсек пауза на включение
#define LCD_WAIT_BOOT1        5  // тиков Т0:  >4,1мсек пауза повторной 0x30
#define LCD_WAIT_BOOT2      400  // (по 250нсек) >100мксек пауза третьей 0x30
#define LCD_WAIT_1            5  // тиков Т0: 4мксек - мало! (>37мксек пауза на команду "в среднем")

/**
 * Отправка буфера дисплею по 4-битному протоколу с "ручным" стробированием
 * и типовой задержкой на выполнение команды
 */
//  twiWrite(lcdAddress, lcdBuffer, (uint8_t)(len)); \
#define lcdSend(len)                               \
{                                                  \
  twi_writeTo(lcdAddress, lcdBuffer, (uint8_t)(len), 1, 1); \
  delay(LCD_WAIT_1);                               \
}

#define lcdWrite1(d)     {lcdPrepare((uint8_t)(d), 1); lcdSend(6);}
#define lcdCommand(p)    {lcdPrepare((uint8_t)(p), 0); lcdSend(6);}
#define lcdClear()       {lcdCommand(LCD_CLEAR); delay(16);}
#define lcdHome()         lcdCommand(LCD_HOME)
#define lcdCursorLeft()   lcdCommand(LCD_CURSOR_LEFT)
#define lcdCursorRight()  lcdCommand(LCD_CURSOR_RIGHT)
#define lcdRowLeft()      lcdCommand(LCD_ROW_LEFT)
#define lcdRowRight()     lcdCommand(LCD_ROW_RIGHT)
#define lcdFontAddress(f) lcdCommand(LCD_FONT_RAM | ((uint8_t)(f)&0x3F))
#define lcdShowAddress(a) lcdCommand(LCD_SHOW_RAM | ((uint8_t)(a)&0x7F))

/**
 * Установить абсолютную позицию курсора
 */
#define lcdSetCursor(_col,_row) \
(lcdCommand(LCD_SHOW_RAM | (((_row)? 0x40 : 0x00) + (uint8_t)(_col) & 0x7f)))

/**
 * Установить позицию записи в память шрифтов
 */
#define lcdGoChar5x8(_ch) (lcdCommand(LCD_FONT_RAM | ((uint8_t)(_ch))<<3)&0x3f)

#ifdef __cplusplus
  extern "C" {
#endif

uint8_t lcdModes  = LCD_MODES | LCD_8BIT;               // PowerON: 8bit mode, 1 line, 5x8 font
uint8_t lcdShifts = LCD_SHIFTS | LCD_INC;               // PowerON: cursor shift to right, not screen!
uint8_t lcdShows  = LCD_SHOWS;                          // PowerON: show off, cursor off, blink off
uint8_t lcdBackLight = LCD_BACK;                        // PowerON: Backlight is ON

uint8_t lcdAddress = 0x27;       // for myLCD1602 parameters as default
uint8_t lcdCols = 16;
uint8_t lcdRows = 2;
uint8_t lcdBuffer[6];            // Буфер для потоковой тетрадной записи в дисплей

/**
 * Подготовка байта в буфер потоковой записи
 * @param _rs=[0 -- команда,!0 -- данные]
 */
void lcdPrepare(uint8_t _data, uint8_t _rs)
{
  uint8_t nibble = (_data&0xf0) | lcdBackLight;

  if( _rs ) nibble |= LCD_RS;
  lcdBuffer[2] = lcdBuffer[0] = nibble;
  nibble |= LCD_E;
  lcdBuffer[1] = nibble;

  nibble = ((_data&0x0f)<<4) | lcdBackLight;

  if( _rs ) nibble |= LCD_RS;
  lcdBuffer[5] = lcdBuffer[3] = nibble;
  nibble |= LCD_E;
  lcdBuffer[4] = nibble;
}

/**
 * Вывод строки заданной длины (буфера) на экран.
 * Повторная установка скорости работы дисплея по I2C и режима (мало ли кто и как работает ещё)
 */
void lcdWrite(const void *buf, uint8_t len)
{
  uint8_t *_b = (uint8_t *)buf;
  uint8_t  _l = len;

//  twiMode |= TWI_SEND_STOP;
  while(_l--)
      lcdWrite1(*_b++);
}

/**
 * Полная перенастройка экрана по текущим значениям режимов.
 */
void lcdInit()
{
  lcdCommand(lcdModes);           // повторяем режим: 4 бита, но уже + сколько строк и какой шрифт
  lcdCommand(lcdShows);           // включаем дисплей и курсор
  lcdCommand(lcdShifts);          // настройка режимов сдвига курсора/экрана
  lcdClear();                     // очень долго очищаем экран (>15.2мсек)
  lcdHome();
}

/**
 * for setup(): powerON initialization for LCD with Hitachi HD44780 (up to 40 cols, 2 rows)
 */
void lcdSetup(uint8_t _address, uint8_t _cols, uint8_t _rows, uint8_t _backLight)
{
  lcdAddress   = _address;
  lcdCols      = _cols;
  lcdRows      = _rows;
  lcdBackLight = (_backLight? LCD_BACK : 0);
  lcdModes     = LCD_MODES;
  lcdShifts    = LCD_SHIFTS | LCD_INC;
  lcdShows     = LCD_SHOWS  | LCD_SHOW_ON;

#ifndef TWI_SETUP
  twi_init();
//  twiSetup(LCD_I2C_SPEED, TWI_READY|TWI_SEND_STOP); // только если не запущен ранее!
  #define TWI_SETUP "lcd1602.h"                     // фиксим, что I2C инициализируется этой библиотекой
#endif

  if( _rows>1 )          { lcdModes |= LCD_2LINE; } // else 1 line

  // @see datasheet: power on sequence
  {
    lcdPrepare(0x30, 0);          // HD44780: RS=0 запись в регистр команд дисплея.

    delay(LCD_WAIT_BOOT0);        // powerOn it needs wait from 15 upto 50msec
    lcdSend(3);                   // 1x3 отправка: по включению режим 8-бит - вторая тетрада не нужна!
    delay(LCD_WAIT_BOOT1);        // ждем >4.1ms
    lcdSend(3);                   // вторая отправка согласно даташит 8-бит..
    delayMicro16(LCD_WAIT_BOOT2); // ждем >100us
    lcdSend(3);                   // третья отправка 8-бит..

    lcdPrepare(0x20, 0);          // и только теперь переводим в режим 4-бита
    lcdSend(3);                   // и только теперь режим 4-бита и отправляем тетрады попарно!
  }
  lcdInit();
  delay(500);                     // чтобы было заметно глазом.. один раз.
}

#ifdef __cplusplus
  } // extern "C"
#endif

// ************* Example *********** //

void setup() {
  uint16_t time;
//  char     buf[16];

  lcdSetup(0x27, 16, 2, 1);
  lcdWrite("Hello, AAAAAA", 13);
//  lcdSetCursor(0,1);
//  lcdWrite("Bye, Bye.1", 10);
//  sprintf(buf, "%dBye, Bye..", 10);
//  lcdWrite(buf, 16);
}
void loop()  {}

