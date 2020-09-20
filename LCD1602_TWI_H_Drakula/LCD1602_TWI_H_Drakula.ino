#include <stdlib.h>
#include <string.h>

// А ВОТ и номера пинов от Меги.... для Архата нет ничего, кроме Меги... правда для остального мира ардуино - она САМАЯ невостребованная... 
#define I2C_SDA    20
#define I2C_SCL   21

/**
 * INLINE: 16-bit counter: up to 65535*4 F_CPU for 16Mhz:[0.25 .. 16383.75] mcsec.
 * Короткие задержки по 4 цикла ЦПУ (кратно 250 нсек)
 */
#define delayMicro16(__count) \
  __asm__ __volatile__ (      \
    "1: sbiw %0,1 \n\t"       \
       "brne 1b\n\t"          \
       :: "w" (__count)       \
        )
// ============================================= arhat_twi.h ================================================== //
/**
 * Работа с TWI (I2C, 2-Wire) интерфейсом через аппаратные прерывания.
 *
 * ! Аппаратно не бывает одновременно режима Master-RX и Slave-RX - поэтому тут используется ОДИН буфер.
 * ! Нет никаких "проверок", настройка глобалов - обязательна до каждого запуска автомата:
 * Master-Transmitter: twiMT_Ptr, twiMT_Count                  -- откуда и сколько байт свистеть;
 * Master-Receiver:    twiRX_Ptr, twiRX_Count, twiMasterReader -- куда и сколько принять и (опц.)что потом сделать;
 * Slave-Receiver:     twiRX_Ptr, twiRX_Count, twiSlaveReader  -- куда и сколько принять и (обяз.)что сделать;
 * Slave-Transmitter:  twiST_Ptr, twiST_Count, twiSlaveWriter  -- откуда и сколько отдать и (обяз.)что потом сделать;
 *
 * Особенности и отличия от типовых разработок (собрано многое вместе):
 * 1. Возможность одновременной работы как в режиме Master так и в режиме Slave;
 * 2. Внешняя буферизация данных при необходимости. Размер памяти определяется вашей программой, а не тут;
 * 3. Возможность ведения статистики - управляется константами компиляции;
 * 4. Произвольная настройка скорости работы интерфейса от 490гц до 1Мгц с авто вычислением прескалера и регистра скорости
 * 5. Возможность уменьшенной комплиции, если не требуются все режимы сразу.
 *
 * Константы компиляции #define (вставить в скетч перед инклудом этого файла нужное):
 * #define TWI_ON 1  // Master-Transmitter only: компилировать как режим Мастера-передатчика    ,ISR(TWI)=190 байт
 * #define TWI_ON 2  // Master-Receiver only:    компилировать как режим Мастер-приемник        ,ISR(TWI)=224 байт
 * #define TWI_ON 4  // Slave-Receiver only:     компилировать как режим Ожидающий получатель   ,ISR(TWI)=202 байт
 * #define TWI_ON 8  // Slave-Transmitter only:  компилировать как режим Отправитель по запросу ,ISR(TWI)=188 байт
 *
 * !!! Допускается компиляция нескольких режимов одновременно:
 * #define TWI_ON (1+2+4+8) // Включить в компиляцию ВСЕ режимы. ,ISR(TWI)=424 байт.
 *
 * @author Arhat109-20160402. <a href="mailto:arhat109@mail.ru">arhat109@mail.ru</a>
 * @license:
 *   1. This is a free software for any using and distributing without any warranties.
 *   2. You should keep author tag with any changes. May be with adding.
 *   Это свободное ПО для любого использования без каких-либо гарантий и претензий.
 *   Требуется сохранять тег @author при любых изменениях. Можете дописать свой.
 */
#ifndef _ARHAT_TWI_H_
#define _ARHAT_TWI_H_ 1

#define TWI_MASTER_TX    1
#define TWI_MASTER_RX    2
#define TWI_IS_SLAVE_RX  4
#define TWI_IS_SLAVE_TX  8

// If not defined - use as Master Transmitter only!
// Если нет ничего, то только управляющий мастер!
#ifndef TWI_ON
#  define TWI_ON TWI_MASTER_TX
#endif // TWI_ON

// ------------ All states TWI status register AND twiState: ------------- //
// Misc
#define TWI_ERROR                  0x00 // Misc: illegal start or stop condition
#define TWI_NO_INFO                0xF8 // Misc: no state information available

// I am Master
#define TWI_START                  0x08 // start condition transmitted
#define TWI_REP_START              0x10 // repeated start condition transmitted
#define TWI_MTR_ARB_LOST           0x38 // arbitration lost in SLA+W or data

// Master Transmitter
#define TWI_MT_SLA_ACK             0x18 // address: SLA+W transmitted, ACK received
#define TWI_MT_SLA_NACK            0x20 // address: SLA+W transmitted, NACK received
#define TWI_MT_DATA_ACK            0x28 // data: transmitted, ACK received
#define TWI_MT_DATA_NACK           0x30 // data: transmitted, NACK received

// Master Receiver
#define TWI_MR_SLA_ACK             0x40 // address: SLA+R transmitted, ACK received
#define TWI_MR_SLA_NACK            0x48 // address: SLA+R transmitted, NACK received
#define TWI_MR_DATA_ACK            0x50 // data: received, ACK returned
#define TWI_MR_DATA_NACK           0x58 // data: received, NACK returned

// I am Slave
// Slave Receiver
#define TWI_SR_SLA_ACK             0x60 // address: SLA+W received, ACK returned
#define TWI_SR_ARB_LOST_SLA_ACK    0x68 // arbitration lost in SLA+RW, SLA+W received, ACK returned
#define TWI_SR_GCALL_ACK           0x70 // general call received, ACK returned
#define TWI_SR_ARB_LOST_GCALL_ACK  0x78 // arbitration lost in SLA+RW, general call received, ACK returned
#define TWI_SR_DATA_ACK            0x80 // data: received, ACK returned
#define TWI_SR_DATA_NACK           0x88 // data: received, NACK returned
#define TWI_SR_GCALL_DATA_ACK      0x90 // general call data received, ACK returned
#define TWI_SR_GCALL_DATA_NACK     0x98 // general call data received, NACK returned
#define TWI_SR_STOP                0xA0 // stop or repeated start condition received while selected

// Slave Transmitter
#define TWI_ST_SLA_ACK             0xA8 // address: SLA+R received, ACK returned
#define TWI_ST_ARB_LOST_SLA_ACK    0xB0 // arbitration lost in SLA+RW, SLA+R received, ACK returned
#define TWI_ST_DATA_ACK            0xB8 // data: transmitted, ACK received
#define TWI_ST_DATA_NACK           0xC0 // data: transmitted, NACK received
#define TWI_ST_LAST_DATA           0xC8 // last data byte transmitted, ACK received

// ------------ Macros for TWI ------------- //

#define TWI_STATUS_MASK (_BV(TWS7)|_BV(TWS6)|_BV(TWS5)|_BV(TWS4)|_BV(TWS3)) // Two LSB are prescaler bits
#define TWI_STATUS      (TWSR & TWI_STATUS_MASK)                            // Get status from TWSR

#define TWI_READ    1                   // for SLA+R address
#define TWI_WRITE   0                   // SLA+W address
#define TWI_ACK     1
#define TWI_NACK    0

#define twiOn()       (PRR0 &= ~_BV(7)) // =0: TWI power is On (default on power!)
#define twiOff()      (PRR0 |= _BV(7))  // =1: TWI power is Off

/**
 * Set twi bit rate and prescaler: _twbr:[0..255], _twsr:[0..3]
 * ------------------------------------------------------------
 * _twsr = 3: scl freq. = [   490 .. 111_111] hz
 * _twsr = 2: scl freq. = [ 1_960 .. 333_333] hz
 * _twsr = 1: scl freq. = [ 7_782 .. 666_667] hz
 * _twsr = 0: scl freq. = [30_418 .. 888_889] hz
 * IF _twbr = 0: frequency equal 1 Mhz with any _twsr!
 *
 * @example twiSetRate(72,0) : use 100_000hz standart mode
 * @example twiSetRate(12,0) : use 400_000hz standart mode
 * @example twiSetRate(0,0)  : use 1 Mhz mode
 */
#define twiSetRate(_twbr, _twsr)      \
{                                     \
  _SFR_BYTE(TWSR) = (uint8_t)(_twsr); \
  TWBR = (uint8_t)(_twbr);            \
}
/**
 * Макросы управления автоматом TWI: последняя команда везде - запись в TWCR
 *
 * @param bool ack -- есть ли режимы Slave, надо ли слушать шину?
 *
 * twiStart()      -- включаем, разрешаем, сброс прерывание(запуск КА) и выставляем старт на шину.
 * twiReply()      -- оно же, только без старта
 * twiReleaseBus() -- включаем, сброс прерывание(запуск КА), а вот прерывание разрешаем только если есть Slave
 * twiStop()       -- оно же, только ещё и отправляем "стоп" в шину и ждем исполнения.
 */
#define twiStart(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|_BV(TWSTA)|((ack)?_BV(TWEA):0))
#define twiReply(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|((ack)? _BV(TWEA):0))
#define twiReleaseBus(ack)              (_BV(TWEN)|_BV(TWINT)|((ack)? _BV(TWEA)|_BV(TWIE):0))
#define twiSetAddress(address, isGcall) (TWAR  = (uint8_t)(((address) << 1)|((isGcall)&0x01)))
#define twiSetMaskAddress(mask)         (TWAMR = (uint8_t)(mask))
#define twiStop(ack)                    \
{                                       \
  TWCR = _BV(TWSTO)|twiReleaseBus(ack); \
  while(TWCR & _BV(TWSTO));             \
  twiMode |= TWI_READY;                 \
}

#ifdef __cplusplus
    extern "C" {
#endif
// ------------ TWI internal variables ------------- //

enum TwiModes {
     TWI_IS_SLAVE  = 1                                  // have I slave mode too?
    ,TWI_SEND_STOP = 2                                  // is need send stop when Master is ending?
    ,TWI_READY     = 4                                  // previous work is ended
};

volatile uint8_t    twiMode;
volatile uint8_t    twiState;                           // state TWI automat
volatile uint8_t    twiSLARW;                           // address for send to (SLARW)

volatile uint8_t   twiMT_Count;                         // остаток байт для передачи мастеров
volatile uint8_t  * twiMT_Ptr;                          // указатель текущего байта внешнего буфера передачи мастером

volatile uint8_t   twiRX_Count;                         // остаток байт для приема мастером/слейвом
volatile uint8_t  * twiRX_Ptr;                          // указатель текущего байта внешнего буфера приема мастером/слейвом

volatile uint8_t   twiST_Count;                         // остаток байт для передачи слейвом
volatile uint8_t  * twiST_Ptr;                          // указатель текущего байта внешнего буфера передачи слейвом

volatile void    (* twiHookRestart)(void) = 0;          // указатель на функцию перезапуска мастера без освобождения шины (TWI_SEND_STOP)
volatile void    (* twiMasterReader)(void) = 0;         // указатель на функцию "Master принял данные, куда их?"
volatile void    (* twiSlaveReader)(void) = 0;          // указатель на функцию "Slave принял данные, куда их?"
volatile void    (* twiSlaveWriter)(void) = 0;          // указатель на функцию "Slave всё отправил, что дальше?"

/*
#if defined(TWI_ON) && (TWI_ON & TWI_LOG_ON)

typedef struct {
    uint16_t   starts,restarts,stops,losts,noslarw,mtx,mrx,srx,grx,stx;
} TwiStat;
#define ptrTwiStat(ptr)  ((TWI_Stat *)(ptr))
static volatile TwiStat    twiStatistic;

#endif // TWI_ON::TWI_LOG_ON
*/
// ------------ TWI functions ------------- //

/**
 * Autocalculate and set twi prescaler and bit rate
 * 1Mhz      .. 30.418khz : TWSR=0!
 * 30.42khz  ..  7.782khz : TWSR=1
 *  7.782khz ..  1.960khz : TWSR=2
 *  1/960khz ..  0.490khz : TWSR=3
 */
void twiSpeed(uint32_t freq)
{
    uint16_t bitRate = (F_CPU / freq) - 16;
    uint8_t  bitMul  = 0;

    while( (bitRate > 511) && (bitMul < 3) ){
        bitRate /= 4; bitRate += 1; bitMul++;
    }
    bitRate /= 2;
    if( bitRate > 255 ) return;
    twiSetRate(bitRate, bitMul);
}

/**
 * for Arduino setup() as Master or Slave or Both modes
 * freq:[490 .. 1 000 000], mode:[0,TWI_IS_SLAVE]
 */
void twiSetup(uint32_t freq, uint8_t mode)
{
    digitalWrite(I2C_SDA, HIGH);                                  // internal pullup is ON.
    digitalWrite(I2C_SCL, HIGH);
    twiSpeed(freq);                                               // set bitrate and prescaler for frequency
    twiMode = mode;
    TWCR = _BV(TWEN)|_BV(TWIE)|((mode&TWI_IS_SLAVE)?_BV(TWEA):0); // module, acks, and interrupt is ON
}

/**
 * for ISR(TWI): control restart conditions in all modes:
 * ! if only 1 mode -- this is a MACRO with next RETURN into ISR, else - function !
 *
 * 1. Освобождать шину, или надо ещё (напр. прием после передачи)?
 * да: Сеанс завершен. Ждем прямо тут прохождения стопа! Выходим из обработчика тут!
 * нет, рестарт:
 * .. есть Хук? процедура подготовки след. посылки: указатели, размеры, адрес, режим..
 * .. а нет Хука! Типовой режим "чтение после записи"
 * в любом случае отправляем restart
 *
 */
#if ((TWI_ON & 0x0F)!=1) && ((TWI_ON & 0x0F)!=2) && ((TWI_ON & 0x0F)!=4) && ((TWI_ON & 0x0F)!=8)
void twiSendStop(uint8_t _md)
{
    if (_md & TWI_SEND_STOP)
    {
        TWCR = _BV(TWSTO)|twiReleaseBus(_md & TWI_IS_SLAVE);
        while(TWCR & _BV(TWSTO));
        twiMode |= TWI_READY;
    }else{
        if( twiHookRestart ){
            twiHookRestart();
        } else {
            twiSLARW |= TWI_READ;
        }
        TWCR = twiStart(_md & TWI_IS_SLAVE);
    }
}
#else
#define twiSendStop(_md)                                   \
{                                                          \
    TWCR = _BV(TWSTO)|twiReleaseBus((_md) & TWI_IS_SLAVE); \
    while(TWCR & _BV(TWSTO));                              \
    twiMode |= TWI_READY;                                  \
}
#endif

/**
 * ISR for TWI interface: realised master and slave modes
 * ------------------------------------------------------
 */
ISR(TWI_vect)
{
    uint8_t _cr = twiReply(0);
    uint8_t _md = twiMode;
    uint8_t _st = twiState=TWI_STATUS;

#if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
    if( _st >= TWI_SR_SLA_ACK )
    {
#if (TWI_ON & TWI_IS_SLAVE_TX)
        if( (_st == TWI_ST_DATA_NACK) || (_st == TWI_ST_LAST_DATA) )
        {
            // ST: Был последний байт, мастер наелся ..
            // ST: Был наш последний байт: предупреждали мастера twiReply(NACK)
            twiSlaveWriter();                                   // Хук - обязателен! Дальше нечего передавать..
            _md=twiMode;                                        // возможно изменение режимов в хуке!
            twiSendStop(_md); return;
        }else{
            if( (_st == TWI_ST_ARB_LOST_SLA_ACK) || (_st == TWI_ST_SLA_ACK || _st == TWI_ST_DATA_ACK) )
            {
                // ST: Моего мастера заткнули и просят данные ..
                // ST: Мой адрес, начинаем ..
                // ST: Отправлено успешно, продолжаем ..
                TWDR = *twiST_Ptr++;
                _cr = twiReply(--twiST_Count);
            }else{
#endif // TWI_ON::TWI_IS_SLAVE_TX
#if (TWI_ON & TWI_IS_SLAVE_RX)
                if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) || (_st == TWI_SR_STOP) )
                {
                    if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) )
                    {
                        // SR: УПС. GCall - туда же.
                        // SR: УПС. Получен байт, мастеру уже был отправлен NACK
                        *twiRX_Ptr = TWDR;
                    }
                    // SR: Обнаружен stop или restart в процессе приема .. это всё?
                    twiSlaveReader();                           // Хук обязателен! это последний, дальше некуда складывать!
                    _md=twiMode;                                // возможно изменение режимов в хуке!
                    twiSendStop(_md); return;
                }else{
                    if( (_st == TWI_SR_GCALL_DATA_ACK) || (_st == TWI_SR_DATA_ACK) )
                    {
                        // SR: пришел байт всем - аналогично
                        // SR: пришел байт, можно ещё принять
                        *(twiRX_Ptr++) = TWDR;
                    }
                    // TWI_SR_ARB_LOST_SLA_ACK   SR: Мастер потерял шину: нет данных ..
                    // TWI_SR_ARB_LOST_GCALL_ACK SR: Вызов всем потерял шину (как это?) --""--
                    // TWI_SR_SLA_ACK            SR: Адрес принят, ещё только ждем данные
                    // TWI_SR_GCALL_ACK          SR: Вызов всем принят оно же
                    _cr = twiReply(--twiRX_Count);              // .. приняли байт и отправляем NACK если осталось 1 место.
                }
#endif // TWI_ON::TWI_IS_SLAVE_RX
#if (TWI_ON & TWI_IS_SLAVE_TX)
            }
        }
#endif // TWI_ON::TWI_IS_SLAVE_TX
    }else{

#endif // TWI_ON::TWI_SLAVE..
#if defined(TWI_ON) && (TWI_ON & TWI_MASTER_TX)
        // Master Transmiter or Reciever modes
        if( (_st == TWI_START) || (_st == TWI_REP_START) )
        {
            // MT,MR:: Прошла отправка стартовой посылки
            // MT,MR:: Прошла отправка повторного старта
            TWDR = twiSLARW;
            _cr = twiReply(_md & TWI_IS_SLAVE);
        }else{
            if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
            {
                // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
                // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликается зараза.
                twiSendStop(_md); return;
            }
            if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
            {
                // MT: Адрес получателя отправлен успешно, начинаем
                // MT: Байт данных отправлен, продолжаем
                if( twiMT_Count-- ){
                    TWDR = *twiMT_Ptr++;
                    _cr = twiReply(_md & TWI_IS_SLAVE);
                }else{
                    twiSendStop(_md); return;
                }
            }else{
#endif // TWI_ON::TWI_MASTER_TX
#if defined(TWI_ON) && (TWI_ON & TWI_MASTER_RX)
                if( _st == TWI_MTR_ARB_LOST )
                {
                    // MT,MR: Упс. Мастер потерял шину: освобождаем и ждем/слушаем.
                    _md |= TWI_READY;
                    _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
                }else{
                    if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
                    {
                        if( _st == TWI_MR_DATA_ACK ){
                            // MR: байт принят, ACK отправлен
                            *(twiRX_Ptr++) = TWDR;
                        }
                        // MR: Отправитель найден, начинаем прием
                        _cr = twiReply( --twiRX_Count );        // .. Можно ещё принять? Или Отправителю - NACK
                    }else{
                        if( _st == TWI_ERROR ) return;
                        if( _st == TWI_MR_DATA_NACK )
                        {
                            // MR: Упс. Получен последний байт дальше принимать некуда.
                            *twiRX_Ptr = TWDR;
                            if( twiMasterReader ) twiMasterReader();
//                            goto TWI_RET_HOOK;
                            _md=twiMode;                        // возможно изменение режимов в хуке!
                        }
                        // All other Master states: stop/restart if need
                        // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не откликается зараза.
                        twiSendStop(_md); return;
                    }
                }
#endif // TWI_ON::TWI_MASTER_RX
#if defined(TWI_ON) && (TWI_ON&TWI_MASTER_TX)
            }
        }
#endif // TWI_ON::TWI_MASTER_TX
#if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
    }
#endif // TWI_SLAVE_ON
    twiMode = _md;
    TWCR = _cr;
} //end ISR()

// -------------------------              (PROTECTED)             ------------------------- //
// Внутренние методы интерфейса, могут пригодится для создания внешних уровней работы с I2C //
// ---------------------------------------------------------------------------------------- //

/**
 * INTERNAL:: Простая передача. Запись адреса собеседника и запуск автомата TWI
 *
 * @see twiWrite(), twiRead()
 */
void _twiStartTo(uint8_t address)
{
    twiSLARW = address;                                 // Режим поставляется вместе с адресом!
    twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быть иные режимы..
    TWCR = twiStart(twiMode & TWI_IS_SLAVE);
}

/**
 * INTERNAL:: Передача с рестартом. Запись адреса собеседника и запуск автомата TWI
 *
 * @see twiWrite(), twiRead()
 */
void _twiStartRe(uint8_t address)
{
    twiSLARW = address;                                 // Режим поставляется вместе с адресом!
    twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быть иные режимы..
    TWCR = twiStart(twiMode & TWI_IS_SLAVE);
}

#define _twiWaitReady()             {while(!(TWI_READY & twiMode)); twiMode &= ~TWI_READY;}
#define _twiMT_Buffer(data, length) (twiMT_Ptr=(volatile uint8_t *)(data), twiMT_Count=(volatile uint8_t)(length))
#define _twiRX_Buffer(data, length) (twiRX_Ptr=(volatile uint8_t *)(data), twiRX_Count=(volatile uint8_t)(length))
#define _twiST_Buffer(data, length) (twiST_Ptr=(volatile uint8_t *)(data), twiST_Count=(volatile uint8_t)(length))

// -------------------------                PUBLIC                ------------------------- //
// ---------------------------------------------------------------------------------------- //

/**
 * Master-TX:: Передача length байт по адресу получателя. Только запуск!
 */
void twiWrite(uint8_t address, const uint8_t * data, uint8_t length)
{
    _twiWaitReady();                                    // Ждем завершения предыдущей работы
    _twiMT_Buffer(data, length);
    _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
}

/**
 * MASTER-RX:: Прием length байт из адреса отправителя. Только запуск!
 */
void twiRead(uint8_t address, uint8_t * data, uint8_t length)
{
    _twiWaitReady();                                    // Ждем завершения предыдущей работы
    _twiRX_Buffer(data, length);
    _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
}

/**
 * Master Read-after-Write:: Чтение данных после отправки команды. Только запуск.
 * !!! Не совместимо с Slave Receive Mode - буфер приема общий !!!
 */
void twiRAW(uint8_t address                             // адрес устройства
, uint8_t* command, uint8_t clength                     // команда и её длина
, uint8_t* data, uint8_t dlength                        // буфер приема данных и его длина
){
    _twiWaitReady();                                    // Ждем завершения предыдущей работы
    _twiMT_Buffer(command, clength);
    _twiRX_Buffer(data, dlength);

    twiHookRestart = 0;                                 // типовой переход на чтение этого же Slave
    twiMode |= TWI_SEND_STOP;                           // рестарт после отправки команды
    twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передачи!
    TWCR = twiStart(twiMode & TWI_IS_SLAVE);
}

/**
 * @example: Пример реализации обработчика "SLAVE отправил всё, что дальше?"
 * для случая, когда текущий буфер можно отправлять повторно по следующему запросу
 *
 * !!! Использует доп. глобалы (должны быть определены в вашем скетче):
 *  uint8_t * stBuffer;
 *  uint8_t   stBufferSize;
 *//*
 void twiSlaveRewriter(void)
 {
     _twiST_Buffer(stBuffer, stBufferSize);             // просто перенастраиваем буфер на повторную передачу.
 }
*/
#ifdef __cplusplus
    }
#endif

#endif // _ARHAT_TWI_H_

// =========================================== LCD1602.h ================================================ //
/**
 * Набор примитивов для работы с дисплеем LCD1602 или иными на базе 1,2 контроллеров HD44780
 * 1 контроллер держит дисплеи 8х2 или 16х1; 2 контроллера держат дисплеи 16х2. Программируются вроде как одинаково.
 *
 * !!! Пока только базовые примимтивы .. в развитии.
 *
 * Тайминги циклов шины связи с МК HD44780:
 * 1. Предустановка RS,R/W:          >60нсек от фронта E (>80нсек х2)
 * 2. Длительность строба записи E:  >500нсек (x2 устр.: LCD1602!) с периодом >1мксек
 * 3. Предустановка данных D7..D0:   >300нсек от спада E
 * 4. Удержание D7..D0, RS, R/W:     >20нсек после спада E (1), >300нсек (x2 контроллера!)
 * 5. Время исполнения команд в среднем <=37мксек -- в даташите НЕВЕРНО! Реально около 4.1 миллисекунды !!!
 *
 * Длительность 1 передачи по I2C на 100кГц = 90мксек! В реальности тянет до 800кгц..
 * Нельзя ничего читать с дисплея (R/W===0)! А ведь есть BF - "бит готовности" ..
 *
 * Отсюда передача возможна только побайтная:
 * сразу готовим посылку каждой тетрады в виде 3-х байт: установка, строб, сброс строба,
 * и сразу же отправляем одной пачкой обе тетрады. Итого буфер на передачу 1 байта = 6.
 *
 * @author Arhat109-20160402. <a href="mailto:arhat109@mail.ru">arhat109@mail.ru</a>
 * @license:
 *   1. This is a free software for any using and distributing without any warranties.
 *   2. You should keep author tag with any changes. May be with adding.
 *   Это свободное ПО для любого использования без каких-либо гарантий и претензий.
 *   Требуется сохранять тег @author при любых изменениях. Можете дописать свой.
 */
#ifndef _LCD1602_H_

#ifndef _ARHAT_TWI_H_
  #define TWI_ON           TWI_MASTER_TX         // only Master-Transmit mode! Not use other mode in this!
  #include "arhat_twi.h"
#endif // _ARHAT_TWI_H_

#ifndef LCD_I2C_SPEED
  #define LCD_I2C_SPEED    800000
#endif

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
#define lcdSend(len)                               \
{                                                  \
  twiWrite(lcdAddress, lcdBuffer, (uint8_t)(len)); \
  delayMicroseconds(49);                               \
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
    (lcdCommand(LCD_SHOW_RAM | ((((_row)? 0x40 : 0x00) + (uint8_t)(_col)) & 0x7f)))

/**
 * Установить позицию записи в память шрифтов
 */
#define lcdGoChar5x8(_ch) (lcdCommand(LCD_FONT_RAM | ((((uint8_t)(_ch))<<3)&0x3f)))

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

        twiMode |= TWI_SEND_STOP;
        while(_l--)
            lcdWrite1(*_b++);
    }
    void lcdWriteW(const void *buf, uint8_t len)
    {
        uint8_t *_b = (uint8_t *)buf;
        uint8_t  _l = len;

        twiMode |= TWI_SEND_STOP;
        while(_l--)
          {
        uint8_t d = *_b++;
        uint8_t nibble = (d & 0xf0) | lcdBackLight;

        nibble |= LCD_RS;
        lcdBuffer[0] = nibble | LCD_E;
        lcdBuffer[1] = nibble;

        nibble = ((d &0x0f)<<4) | lcdBackLight;

        nibble |= LCD_RS;
        lcdBuffer[2] = nibble | LCD_E;
        lcdBuffer[3] = nibble;
        lcdSend(4);
          }
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
        twiSetup(LCD_I2C_SPEED, TWI_READY|TWI_SEND_STOP); // только если не запущен ранее!
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

#endif // _LCD1602_H_

// ========================================= test_lcd1602.ino =============================== //
/**
 * Пример скетча вывода на LCD1602 или аналогичные дисплеи, подключаемые по шине I2C.
 *
 * В стадии развития и тестирования ..
 *
 * Лицензия:
 * 1. Полностью свободное и бесплатное программное обеспечение. В том числе и от претензий.
 * 2. Вы вправе использовать его на свои нужды произвольным образом и на свой риск.
 * 3. Вы не вправе удалять из него строку с тегом @author или изменять её.
 * 4. Изменяя этот файл, Вы вправе дописать свои авторские данные и/или пояснения.
 *
 * Если Вам это оказалось полезным, то Вы можете по-достоинству оценить мой труд
 * "на свое усмотрение" (напр. кинуть денег на телефон "сколько не жалко")
 * @author Arhat109 <a href="mailto:arhat109@mail.ru">arhat109@mail.ru</a>, +7-(951)-388-2793
 */
//#include "arhat.h"

//#define TWI_ON    15    // Debug: Включить все режимы обработчика I2C
//#include "arhat_twi.h"  // Debug: Подключить явно тут с заданным комплектом режимов

//#define LCD_I2C_SPEED 800000 // Установить типовую скорость (внутри задано 800кгц!)
//#include "lcd1602.h"

// ************* Example *********** //

void setup() {
  /*
    lcdSetup(0x27, 16, 2, 1);
    lcdWrite("Hello, Arhat!", 13);
    lcdSetCursor(0,1);
    lcdWrite("Bye, Bye..", 10);
*/
    lcdSetup(0x27, 16, 2, 1);
    
    
}
void loop()  {
  static int i=0;
  char bb[16];
    lcdSetCursor(0,0);
    //lcdWriteW("                ", 16);
    unsigned long uSec = micros();
    lcdWriteW("ArhatSuperProger", 16);
    unsigned long intrval = micros() - uSec;
    ltoa(intrval,bb,10);
    lcdSetCursor(0,1);
    lcdWriteW(bb,strnlen(bb,8));
    ltoa(i++,bb,10);
    lcdSetCursor(8,1);
    lcdWriteW(bb,strnlen(bb,8));
    delay(500);
    }
