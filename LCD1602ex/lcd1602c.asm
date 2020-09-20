GAS LISTING /tmp/ccqx8j8N.s 			page 1


   1               		.file	"LCD1602ex.cpp"
   2               	__SP_H__ = 0x3e
   3               	__SP_L__ = 0x3d
   4               	__SREG__ = 0x3f
   5               	__RAMPZ__ = 0x3b
   6               	__tmp_reg__ = 0
   7               	__zero_reg__ = 1
   8               		.text
   9               	.Ltext0:
  10               		.cfi_sections	.debug_frame
  11               		.section	.text.twiSpeed,"ax",@progbits
  12               	.global	twiSpeed
  13               		.type	twiSpeed, @function
  14               	twiSpeed:
  15               	.LFB102:
  16               		.file 1 "/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h"
   1:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
   2:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Работа с TWI (I2C, 2-Wire) интерфейсом через аппаратные пре�
   3:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
   4:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ! Аппаратно не бывает одновременно режима Master-RX и Slave-
   5:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ! Нет никаких "проверок", настройка глобалов - обязате
   6:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-Transmitter: twiMT_Ptr, twiMT_Count                  -- откуда и сколько б
   7:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-Receiver:    twiRX_Ptr, twiRX_Count, twiMasterReader -- куда и сколько при
   8:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Slave-Receiver:     twiRX_Ptr, twiRX_Count, twiSlaveReader  -- куда и сколько при
   9:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Slave-Transmitter:  twiST_Ptr, twiST_Count, twiSlaveWriter  -- откуда и сколько о
  10:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  11:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Особенности и отличия от типовых разработок (собран�
  12:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1. Возможность одновременной работы как в режиме Master 
  13:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 2. Внешняя буферизация данных при необходимости. Раз�
  14:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 3. Возможность ведения статистики - управляется конс�
  15:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 4. Произвольная настройка скорости работы интерфейс�
  16:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 5. Возможность уменьшенной комплиции только режима Ma
  17:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  18:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Константы компиляции #define и default_value:
  19:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * #define TWI_LOG_ON   1 // если не определено, то не компилироват
  20:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * #define TWI_SLAVE_ON 1 // если не определено, то не компилироват
  21:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
  22:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @author Arhat109-20160402. arhat109@mail.ru
  23:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @license:
  24:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   1. This is a free software for any using and distributing without any warranties.
  25:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   2. You should keep author tag with any changes. May be with adding.
  26:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   Это свободное ПО для любого использования без каки�
  27:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *   Требуется сохранять тег @author при любых изменениях. �
  28:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
  29:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifndef ARHAT_TWI_H
  30:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define ARHAT_TWI_H 1
  31:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  32:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //#include "arhat.h"
  33:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Compiler mode ONLY! Use as digits into #define TWI_ON before include this file ONLY!
  34:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // @TODO: to move into arhat.h
  35:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MASTER_TX    1
  36:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MASTER_RX    2
  37:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_IS_SLAVE_RX  4
  38:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_IS_SLAVE_TX  8
  39:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_LOG_ON      16
  40:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  41:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ All states TWI status register AND twiState: ------------- //
GAS LISTING /tmp/ccqx8j8N.s 			page 2


  42:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Misc
  43:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ERROR                  0x00 // Misc: illegal start or stop condition
  44:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_NO_INFO                0xF8 // Misc: no state information available
  45:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  46:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // I am Master
  47:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_START                  0x08 // start condition transmitted
  48:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_REP_START              0x10 // repeated start condition transmitted
  49:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MTR_ARB_LOST           0x38 // arbitration lost in SLA+W or data
  50:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  51:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Master Transmitter
  52:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_SLA_ACK             0x18 // address: SLA+W transmitted, ACK received
  53:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_SLA_NACK            0x20 // address: SLA+W transmitted, NACK received
  54:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_DATA_ACK            0x28 // data: transmitted, ACK received
  55:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MT_DATA_NACK           0x30 // data: transmitted, NACK received
  56:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  57:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Master Receiver
  58:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_SLA_ACK             0x40 // address: SLA+R transmitted, ACK received
  59:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_SLA_NACK            0x48 // address: SLA+R transmitted, NACK received
  60:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_DATA_ACK            0x50 // data: received, ACK returned
  61:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_MR_DATA_NACK           0x58 // data: received, NACK returned
  62:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  63:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // I am Slave
  64:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Slave Receiver
  65:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_SLA_ACK             0x60 // address: SLA+W received, ACK returned
  66:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_ARB_LOST_SLA_ACK    0x68 // arbitration lost in SLA+RW, SLA+W received, ACK returned
  67:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_ACK           0x70 // general call received, ACK returned
  68:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_ARB_LOST_GCALL_ACK  0x78 // arbitration lost in SLA+RW, general call received, ACK r
  69:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_DATA_ACK            0x80 // data: received, ACK returned
  70:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_DATA_NACK           0x88 // data: received, NACK returned
  71:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_DATA_ACK      0x90 // general call data received, ACK returned
  72:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_GCALL_DATA_NACK     0x98 // general call data received, NACK returned
  73:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_SR_STOP                0xA0 // stop or repeated start condition received while selected
  74:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  75:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Slave Transmitter
  76:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_SLA_ACK             0xA8 // address: SLA+R received, ACK returned
  77:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_ARB_LOST_SLA_ACK    0xB0 // arbitration lost in SLA+RW, SLA+R received, ACK returned
  78:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_DATA_ACK            0xB8 // data: transmitted, ACK received
  79:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_DATA_NACK           0xC0 // data: transmitted, NACK received
  80:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ST_LAST_DATA           0xC8 // last data byte transmitted, ACK received
  81:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  82:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ Macros for TWI ------------- //
  83:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  84:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_STATUS_MASK (_BV(TWS7)|_BV(TWS6)|_BV(TWS5)|_BV(TWS4)|_BV(TWS3)) // Two LSB are prescale
  85:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_STATUS      (TWSR & TWI_STATUS_MASK)                            // Get status from TWSR
  86:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  87:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_READ    1                   // for SLA+R address
  88:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_WRITE   0                   // SLA+W address
  89:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_ACK     1
  90:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define TWI_NACK    0
  91:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  92:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiOn()       (PRR0 &= ~_BV(7)) // =0: TWI power is On (default on power!)
  93:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiOff()      (PRR0 |= _BV(7))  // =1: TWI power is Off
  94:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
  95:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
  96:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Set twi bit rate and prescaler: _twbr:[0..255], _twsr:[0..3]
  97:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ------------------------------------------------------------
  98:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 3: scl freq. = [   490 .. 111_111] hz
GAS LISTING /tmp/ccqx8j8N.s 			page 3


  99:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 2: scl freq. = [ 1_960 .. 333_333] hz
 100:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 1: scl freq. = [ 7_782 .. 666_667] hz
 101:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * _twsr = 0: scl freq. = [30_418 .. 888_889] hz
 102:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * IF _twbr = 0: frequency equal 1 Mhz with any _twsr!
 103:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 104:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(72,0) : use 100_000hz standart mode
 105:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(12,0) : use 400_000hz standart mode
 106:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @example twiSetRate(0,0)  : use 1 Mhz mode
 107:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 108:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetRate(_twbr, _twsr)      \
 109:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                     \
 110:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   _SFR_BYTE(TWSR) = (uint8_t)(_twsr); \
 111:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   TWBR = (uint8_t)(_twbr);            \
 112:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 113:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 114:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Макросы управления автоматом TWI: последняя команда в
 115:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 116:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @param bool ack -- есть ли режимы Slave, надо ли слушать шину?
 117:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 118:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiStart()      -- включаем, разрешаем, сброс прерывание(зап�
 119:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiReply()      -- оно же, только без старта
 120:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiReleaseBus() -- включаем, сброс прерывание(запуск КА), а во
 121:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * twiStop()       -- оно же, только ещё и отправляем "стоп" в шин
 122:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 123:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiStart(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|_BV(TWSTA)|((ack)?_BV(TWEA)
 124:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiReply(ack)                   (_BV(TWEN)|_BV(TWINT)|_BV(TWIE)|((ack)? _BV(TWEA):0))
 125:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiReleaseBus(ack)              (_BV(TWEN)|_BV(TWINT)|((ack)? _BV(TWEA)|_BV(TWIE):0))
 126:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetAddress(address, isGcall) (TWAR  = (uint8_t)(((address) << 1)|((isGcall)&0x01)))
 127:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSetMaskAddress(mask)         (TWAMR = (uint8_t)(mask))
 128:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiStop(ack)                    \
 129:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                       \
 130:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   TWCR = _BV(TWSTO)|twiReleaseBus(ack); \
 131:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   while(TWCR & _BV(TWSTO));             \
 132:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****   twiMode |= TWI_READY;                 \
 133:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 134:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 135:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifdef __cplusplus
 136:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     extern "C" {
 137:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif
 138:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ TWI internal variables ------------- //
 139:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 140:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** enum TWI_Modes {
 141:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****      TWI_IS_SLAVE  = 1                                  // have I slave mode too?
 142:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     ,TWI_SEND_STOP = 2                                  // is need send stop when Master is ending?
 143:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     ,TWI_READY     = 4                                  // previous work is ended
 144:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** };
 145:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 146:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiMode;
 147:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiState;                           // state TWI automat
 148:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t    twiSLARW;                           // address for send to (SLARW)
 149:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 150:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint16_t   twiMT_Count;                        // остаток байт для пере�
 151:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiMT_Ptr;                          // указатель текущего ба
 152:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 153:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint16_t   twiRX_Count;                        // остаток байт для прие�
 154:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiRX_Ptr;                          // указатель текущего ба
 155:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccqx8j8N.s 			page 4


 156:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint16_t   twiST_Count;                        // остаток байт для пере�
 157:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiST_Ptr;                          // указатель текущего ба
 158:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 159:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiHookRestart)(void) = 0;          // указатель на функцию �
 160:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiMasterReader)(void) = 0;         // указатель на функцию "
 161:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiSlaveReader)(void) = 0;          // указатель на функцию "
 162:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile void    (* twiSlaveWriter)(void) = 0;          // указатель на функцию "
 163:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 164:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #ifdef TWI_LOG_ON
 165:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 166:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** typedef struct {
 167:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint16_t   starts,restarts,stops,losts,noslarw,mtx,mrx,srx,grx,stx;
 168:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } TWI_Stat;
 169:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define ptrTWI_Stat(ptr)  ((TWI_Stat *)(ptr))
 170:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** static volatile TWI_Stat    twiStatistic;
 171:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 172:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_LOG_ON
 173:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 174:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ------------ TWI functions ------------- //
 175:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 176:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 177:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Autocalculate and set twi prescaler and bit rate
 178:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1Mhz      .. 30.418khz : TWSR=0!
 179:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 30.42khz  ..  7.782khz : TWSR=1
 180:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *  7.782khz ..  1.960khz : TWSR=2
 181:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *  1/960khz ..  0.490khz : TWSR=3
 182:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 183:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSpeed(uint32_t freq)
 184:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
  17               		.loc 1 184 0
  18               		.cfi_startproc
  19               	.LVL0:
  20               	/* prologue: function */
  21               	/* frame size = 0 */
  22               	/* stack size = 0 */
  23               	.L__stack_usage = 0
  24 0000 9B01      		movw r18,r22
  25 0002 AC01      		movw r20,r24
  26               	.LBB2:
 185:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint16_t bitRate = (F_CPU / freq) - 16;
  27               		.loc 1 185 0
  28 0004 60E0      		ldi r22,0
  29 0006 74E2      		ldi r23,lo8(36)
  30 0008 84EF      		ldi r24,lo8(-12)
  31 000a 90E0      		ldi r25,0
  32               	.LVL1:
  33 000c 0E94 0000 		call __udivmodsi4
  34               	.LVL2:
  35 0010 2051      		subi r18,16
  36 0012 3109      		sbc r19,__zero_reg__
  37               	.LVL3:
 186:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t  bitMul  = 0;
  38               		.loc 1 186 0
  39 0014 80E0      		ldi r24,0
  40               	.LVL4:
  41               	.L2:
 187:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccqx8j8N.s 			page 5


 188:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     while( (bitRate > 511) && (bitMul < 3) ){
  42               		.loc 1 188 0 discriminator 1
  43 0016 2115      		cp r18,__zero_reg__
  44 0018 92E0      		ldi r25,2
  45 001a 3907      		cpc r19,r25
  46 001c 00F0      		brlo .L3
  47               		.loc 1 188 0 is_stmt 0 discriminator 2
  48 001e 8330      		cpi r24,lo8(3)
  49 0020 01F0      		breq .L3
 189:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         bitRate /= 4; bitRate += 1; bitMul++;
  50               		.loc 1 189 0 is_stmt 1
  51 0022 3695      		lsr r19
  52 0024 2795      		ror r18
  53 0026 3695      		lsr r19
  54 0028 2795      		ror r18
  55               	.LVL5:
  56 002a 2F5F      		subi r18,-1
  57 002c 3F4F      		sbci r19,-1
  58               	.LVL6:
  59 002e 8F5F      		subi r24,lo8(-(1))
  60               	.LVL7:
  61 0030 00C0      		rjmp .L2
  62               	.L3:
 190:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 191:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     bitRate /= 2;
  63               		.loc 1 191 0
  64 0032 3695      		lsr r19
  65 0034 2795      		ror r18
  66               	.LVL8:
 192:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( bitRate > 255 ) return;
  67               		.loc 1 192 0
  68 0036 2F3F      		cpi r18,-1
  69 0038 3105      		cpc r19,__zero_reg__
  70 003a 01F0      		breq .+2
  71 003c 00F4      		brsh .L1
 193:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSetRate(bitRate, bitMul);
  72               		.loc 1 193 0
  73 003e 8093 B900 		sts 185,r24
  74 0042 2093 B800 		sts 184,r18
  75               	.L1:
  76 0046 0895      		ret
  77               	.LBE2:
  78               		.cfi_endproc
  79               	.LFE102:
  80               		.size	twiSpeed, .-twiSpeed
  81               		.section	.text.twiSetup,"ax",@progbits
  82               	.global	twiSetup
  83               		.type	twiSetup, @function
  84               	twiSetup:
  85               	.LFB103:
 194:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 195:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 196:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 197:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * for Arduino setup() as Master or Slave or Both modes
 198:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * freq:[490 .. 1 000 000], mode:[0,TWI_IS_SLAVE]
 199:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 200:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSetup(uint32_t freq, uint8_t mode)
GAS LISTING /tmp/ccqx8j8N.s 			page 6


 201:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
  86               		.loc 1 201 0
  87               		.cfi_startproc
  88               	.LVL9:
  89 0000 CF93      		push r28
  90               	.LCFI0:
  91               		.cfi_def_cfa_offset 4
  92               		.cfi_offset 28, -3
  93 0002 DF93      		push r29
  94               	.LCFI1:
  95               		.cfi_def_cfa_offset 5
  96               		.cfi_offset 29, -4
  97 0004 1F92      		push __zero_reg__
  98               	.LCFI2:
  99               		.cfi_def_cfa_offset 6
 100 0006 CDB7      		in r28,__SP_L__
 101 0008 DEB7      		in r29,__SP_H__
 102               	.LCFI3:
 103               		.cfi_def_cfa_register 28
 104               	/* prologue: function */
 105               	/* frame size = 1 */
 106               	/* stack size = 3 */
 107               	.L__stack_usage = 3
 202:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     digitalWrite(I2C_SDA, HIGH);                                  // internal pullup is ON.
 108               		.loc 1 202 0
 109 000a 599A      		sbi 0xb,1
 203:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     digitalWrite(I2C_SCL, HIGH);
 110               		.loc 1 203 0
 111 000c 589A      		sbi 0xb,0
 204:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSpeed(freq);                                               // set bitrate and prescaler for 
 112               		.loc 1 204 0
 113 000e 4983      		std Y+1,r20
 114 0010 0E94 0000 		call twiSpeed
 115               	.LVL10:
 205:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = mode;
 116               		.loc 1 205 0
 117 0014 4981      		ldd r20,Y+1
 118 0016 4093 0000 		sts twiMode,r20
 206:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _BV(TWEN)|_BV(TWIE)|((mode&TWI_IS_SLAVE)?_BV(TWEA):0); // module, acks, and interrupt is
 119               		.loc 1 206 0
 120 001a 40FF      		sbrs r20,0
 121 001c 00C0      		rjmp .L9
 122 001e 85E4      		ldi r24,lo8(69)
 123 0020 00C0      		rjmp .L8
 124               	.L9:
 125 0022 85E0      		ldi r24,lo8(5)
 126               	.L8:
 127               		.loc 1 206 0 is_stmt 0 discriminator 3
 128 0024 8093 BC00 		sts 188,r24
 129               	/* epilogue start */
 207:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 130               		.loc 1 207 0 is_stmt 1 discriminator 3
 131 0028 0F90      		pop __tmp_reg__
 132 002a DF91      		pop r29
 133 002c CF91      		pop r28
 134 002e 0895      		ret
 135               		.cfi_endproc
GAS LISTING /tmp/ccqx8j8N.s 			page 7


 136               	.LFE103:
 137               		.size	twiSetup, .-twiSetup
 138               		.section	.text.twiSendStop,"ax",@progbits
 139               	.global	twiSendStop
 140               		.type	twiSendStop, @function
 141               	twiSendStop:
 142               	.LFB104:
 208:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 209:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 210:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * for ISR(TWI): control restart conditions in all modes:
 211:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 212:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * 1. Освобождать шину, или надо ещё (напр. прием после пе
 213:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * да: Сеанс завершен. Ждем прямо тут прохождения стопа!
 214:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * нет, рестарт:
 215:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * .. есть Хук? процедура подготовки след. посылки: указа
 216:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * .. а нет Хука! Типовой режим "чтение после записи"
 217:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * в любом случае отправляем restart
 218:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 219:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @return command for TWCR
 220:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *//*
 221:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define twiSendStop(_md, _cr)                                \
 222:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {                                                            \
 223:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if (_md & TWI_SEND_STOP)                                 \
 224:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {                                                        \
 225:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = _BV(TWSTO)|twiReleaseBus(_md & TWI_IS_SLAVE); \
 226:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         while(TWCR & _BV(TWSTO));                            \
 227:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         twiMode |= TWI_READY;                                \
 228:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         return;                                              \
 229:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{                                                   \
 230:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( twiHookRestart ){                                \
 231:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiHookRestart();                                \
 232:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         } else {                                             \
 233:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSLARW |= TWI_READ;                            \
 234:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }                                                    \
 235:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         _cr = twiStart(_md & TWI_IS_SLAVE);                  \
 236:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }                                                        \
 237:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 238:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** */
 239:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiSendStop(uint8_t _md)
 240:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 143               		.loc 1 240 0
 144               		.cfi_startproc
 145               	.LVL11:
 146 0000 CF93      		push r28
 147               	.LCFI4:
 148               		.cfi_def_cfa_offset 4
 149               		.cfi_offset 28, -3
 150               	/* prologue: function */
 151               	/* frame size = 0 */
 152               	/* stack size = 1 */
 153               	.L__stack_usage = 1
 154 0002 C82F      		mov r28,r24
 155 0004 C170      		andi r28,lo8(1)
 241:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if (_md & TWI_SEND_STOP)
 156               		.loc 1 241 0
 157 0006 81FF      		sbrs r24,1
 158 0008 00C0      		rjmp .L11
GAS LISTING /tmp/ccqx8j8N.s 			page 8


 242:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 243:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = _BV(TWSTO)|twiReleaseBus(_md & TWI_IS_SLAVE);
 159               		.loc 1 243 0
 160 000a CC23      		tst r28
 161 000c 01F0      		breq .L19
 162 000e 85ED      		ldi r24,lo8(-43)
 163               	.LVL12:
 164 0010 00C0      		rjmp .L12
 165               	.LVL13:
 166               	.L19:
 167 0012 84E9      		ldi r24,lo8(-108)
 168               	.LVL14:
 169               	.L12:
 170               		.loc 1 243 0 is_stmt 0 discriminator 3
 171 0014 8093 BC00 		sts 188,r24
 172               	.L14:
 244:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         while(TWCR & _BV(TWSTO));
 173               		.loc 1 244 0 is_stmt 1 discriminator 1
 174 0018 8091 BC00 		lds r24,188
 175 001c 84FD      		sbrc r24,4
 176 001e 00C0      		rjmp .L14
 245:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         twiMode |= TWI_READY;
 177               		.loc 1 245 0
 178 0020 8091 0000 		lds r24,twiMode
 179 0024 8460      		ori r24,lo8(4)
 180 0026 8093 0000 		sts twiMode,r24
 181 002a 00C0      		rjmp .L10
 182               	.LVL15:
 183               	.L11:
 246:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 247:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( twiHookRestart ){
 184               		.loc 1 247 0
 185 002c E091 0000 		lds r30,twiHookRestart
 186 0030 F091 0000 		lds r31,twiHookRestart+1
 187 0034 3097      		sbiw r30,0
 188 0036 01F0      		breq .L16
 248:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiHookRestart();
 189               		.loc 1 248 0
 190 0038 1995      		eicall
 191               	.LVL16:
 192 003a 00C0      		rjmp .L17
 193               	.LVL17:
 194               	.L16:
 249:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         } else {
 250:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSLARW |= TWI_READ;
 195               		.loc 1 250 0
 196 003c 8091 0000 		lds r24,twiSLARW
 197               	.LVL18:
 198 0040 8160      		ori r24,lo8(1)
 199 0042 8093 0000 		sts twiSLARW,r24
 200               	.L17:
 251:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 252:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = twiStart(_md & TWI_IS_SLAVE);
 201               		.loc 1 252 0
 202 0046 CC23      		tst r28
 203 0048 01F0      		breq .L20
 204 004a 85EE      		ldi r24,lo8(-27)
GAS LISTING /tmp/ccqx8j8N.s 			page 9


 205 004c 00C0      		rjmp .L18
 206               	.L20:
 207 004e 85EA      		ldi r24,lo8(-91)
 208               	.L18:
 209               		.loc 1 252 0 is_stmt 0 discriminator 3
 210 0050 8093 BC00 		sts 188,r24
 211               	.L10:
 212               	/* epilogue start */
 253:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 254:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 213               		.loc 1 254 0 is_stmt 1
 214 0054 CF91      		pop r28
 215 0056 0895      		ret
 216               		.cfi_endproc
 217               	.LFE104:
 218               		.size	twiSendStop, .-twiSendStop
 219               		.section	.text.__vector_39,"ax",@progbits
 220               	.global	__vector_39
 221               		.type	__vector_39, @function
 222               	__vector_39:
 223               	.LFB105:
 255:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 256:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 257:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ISR for TWI interface: realised master and slave modes
 258:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ------------------------------------------------------
 259:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 260:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ISR(TWI_vect)
 261:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 224               		.loc 1 261 0
 225               		.cfi_startproc
 226 0000 1F92      		push r1
 227               	.LCFI5:
 228               		.cfi_def_cfa_offset 4
 229               		.cfi_offset 1, -3
 230 0002 0F92      		push r0
 231               	.LCFI6:
 232               		.cfi_def_cfa_offset 5
 233               		.cfi_offset 0, -4
 234 0004 0FB6      		in r0,__SREG__
 235 0006 0F92      		push r0
 236 0008 1124      		clr __zero_reg__
 237 000a 8F93      		push r24
 238               	.LCFI7:
 239               		.cfi_def_cfa_offset 6
 240               		.cfi_offset 24, -5
 241 000c 9F93      		push r25
 242               	.LCFI8:
 243               		.cfi_def_cfa_offset 7
 244               		.cfi_offset 25, -6
 245               	/* prologue: Signal */
 246               	/* frame size = 0 */
 247               	/* stack size = 5 */
 248               	.L__stack_usage = 5
 249               	.LBB3:
 262:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _cr;
 263:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _md = twiMode;
 250               		.loc 1 263 0
GAS LISTING /tmp/ccqx8j8N.s 			page 10


 251 000e 9091 0000 		lds r25,twiMode
 252               	.LVL19:
 264:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _st = twiState=TWI_STATUS;
 253               		.loc 1 264 0
 254 0012 8091 B900 		lds r24,185
 255 0016 887F      		andi r24,lo8(-8)
 256 0018 8093 0000 		sts twiState,r24
 257               	.LVL20:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 267:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( _st >= TWI_SR_SLA_ACK )
 268:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 269:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 270:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_ST_DATA_NACK) || (_st == TWI_ST_LAST_DATA) )
 271:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 272:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был последний байт, мастер наелся ..
 273:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был наш последний байт: предупреждали масте
 274:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSlaveWriter();                                   // Хук - обязателен!
 275:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _md=twiMode;                                        // возможно изменен�
 276:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSendStop(_md); return;
 277:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 278:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_ST_ARB_LOST_SLA_ACK) || (_st == TWI_ST_SLA_ACK || _st == TWI_ST_DATA_AC
 279:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 280:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Моего мастера заткнули и просят данные ..
 281:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Мой адрес, начинаем ..
 282:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Отправлено успешно, продолжаем ..
 283:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 TWDR = *twiST_Ptr++;
 284:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 _cr = twiReply(--twiST_Count);
 285:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 286:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 287:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_RX)
 288:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) || (_st == TWI_SR_
 289:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 290:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) )
 291:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 292:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. GCall - туда же.
 293:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. Получен байт, мастеру уже был отп
 294:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *twiRX_Ptr = TWDR;
 295:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 296:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // SR: Обнаружен stop или restart в процессе приема 
 297:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSlaveReader();                           // Хук обязателен! э�
 298:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md=twiMode;                                // возможно изменен�
 299:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 300:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 301:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_ACK) || (_st == TWI_SR_DATA_ACK) )
 302:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 303:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт всем - аналогично
 304:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт, можно ещё принять
 305:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *(twiRX_Ptr++) = TWDR;
 306:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 307:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_SLA_ACK   SR: Мастер потерял шину: нет �
 308:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_GCALL_ACK SR: Вызов всем потерял шину (�
 309:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_SLA_ACK            SR: Адрес принят, ещё только �
 310:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_GCALL_ACK          SR: Вызов всем принят оно же
 311:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(--twiRX_Count);              // .. приняли байт и о
 312:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 313:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_RX
GAS LISTING /tmp/ccqx8j8N.s 			page 11


 314:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 315:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 316:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 317:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 318:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 319:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 320:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_SLAVE..
 321:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_TX)
 322:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         // Master Transmiter or Reciever modes
 323:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_START) || (_st == TWI_REP_START) )
 324:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 325:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка стартовой посылки
 326:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка повторного старта
 327:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             TWDR = twiSLARW;
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
 329:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 330:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
 331:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 332:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
 333:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликае
 334:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 twiSendStop(_md); return;
 335:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 336:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
 337:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 338:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Адрес получателя отправлен успешно, начи�
 339:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Байт данных отправлен, продолжаем
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( (twiMT_Count--) ){
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *(twiMT_Ptr++);
 342:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(_md & TWI_IS_SLAVE);
 343:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 344:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 345:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 346:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 347:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 348:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_RX)
 349:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( _st == TWI_MTR_ARB_LOST )
 350:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 351:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // MT,MR: Упс. Мастер потерял шину: освобождаем 
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md |= TWI_READY;
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 354:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 355:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
 356:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 357:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_ACK ){
 358:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: байт принят, ACK отправлен
 359:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *(twiRX_Ptr++) = TWDR;
 360:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 361:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // MR: Отправитель найден, начинаем прием
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         _cr = twiReply( --twiRX_Count );        // .. Можно ещё приня�
 363:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 364:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_ERROR ) return;
 365:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_NACK )
 366:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         {
 367:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: Упс. Получен последний байт дальше 
 368:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *twiRX_Ptr = TWDR;
 369:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             if( twiMasterReader ) twiMasterReader();
 370:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //                            goto TWI_RET_HOOK;
GAS LISTING /tmp/ccqx8j8N.s 			page 12


 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 376:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 377:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 378:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_RX
 379:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON&TWI_MASTER_TX)
 380:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 381:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 382:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 383:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 384:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 385:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_SLAVE_ON
 386:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = _md;
 258               		.loc 1 386 0
 259 001c 9093 0000 		sts twiMode,r25
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 260               		.loc 1 387 0
 261 0020 1092 BC00 		sts 188,__zero_reg__
 262               	/* epilogue start */
 263               	.LBE3:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 264               		.loc 1 388 0
 265 0024 9F91      		pop r25
 266               	.LVL21:
 267 0026 8F91      		pop r24
 268               	.LVL22:
 269 0028 0F90      		pop r0
 270 002a 0FBE      		out __SREG__,r0
 271 002c 0F90      		pop r0
 272 002e 1F90      		pop r1
 273 0030 1895      		reti
 274               		.cfi_endproc
 275               	.LFE105:
 276               		.size	__vector_39, .-__vector_39
 277               		.section	.text._twiStartTo,"ax",@progbits
 278               	.global	_twiStartTo
 279               		.type	_twiStartTo, @function
 280               	_twiStartTo:
 281               	.LFB106:
 389:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 390:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // -------------------------              (PROTECTED)             ------------------------- //
 391:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // Внутренние методы интерфейса, могут пригодится для �
 392:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ---------------------------------------------------------------------------------------- //
 393:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 394:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 395:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Простая передача. Запись адреса собеседника и 
 396:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 397:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 398:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 399:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartTo(uint8_t address)
 400:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 282               		.loc 1 400 0
 283               		.cfi_startproc
 284               	.LVL23:
GAS LISTING /tmp/ccqx8j8N.s 			page 13


 285               	/* prologue: function */
 286               	/* frame size = 0 */
 287               	/* stack size = 0 */
 288               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 289               		.loc 1 401 0
 290 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 291               		.loc 1 402 0
 292 0004 8091 0000 		lds r24,twiMode
 293               	.LVL24:
 294 0008 8260      		ori r24,lo8(2)
 295 000a 8093 0000 		sts twiMode,r24
 296               	.LVL25:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 297               		.loc 1 403 0
 298 000e 8091 0000 		lds r24,twiMode
 299 0012 80FF      		sbrs r24,0
 300 0014 00C0      		rjmp .L24
 301 0016 85EE      		ldi r24,lo8(-27)
 302 0018 00C0      		rjmp .L23
 303               	.L24:
 304 001a 85EA      		ldi r24,lo8(-91)
 305               	.L23:
 306               		.loc 1 403 0 is_stmt 0 discriminator 3
 307 001c 8093 BC00 		sts 188,r24
 308 0020 0895      		ret
 309               		.cfi_endproc
 310               	.LFE106:
 311               		.size	_twiStartTo, .-_twiStartTo
 312               		.section	.text._twiStartRe,"ax",@progbits
 313               	.global	_twiStartRe
 314               		.type	_twiStartRe, @function
 315               	_twiStartRe:
 316               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 317               		.loc 1 412 0 is_stmt 1
 318               		.cfi_startproc
 319               	.LVL26:
 320               	/* prologue: function */
 321               	/* frame size = 0 */
 322               	/* stack size = 0 */
 323               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 324               		.loc 1 413 0
 325 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 326               		.loc 1 414 0
 327 0004 8091 0000 		lds r24,twiMode
GAS LISTING /tmp/ccqx8j8N.s 			page 14


 328               	.LVL27:
 329 0008 8D7F      		andi r24,lo8(-3)
 330 000a 8093 0000 		sts twiMode,r24
 331               	.LVL28:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 332               		.loc 1 415 0
 333 000e 8091 0000 		lds r24,twiMode
 334 0012 80FF      		sbrs r24,0
 335 0014 00C0      		rjmp .L27
 336 0016 85EE      		ldi r24,lo8(-27)
 337 0018 00C0      		rjmp .L26
 338               	.L27:
 339 001a 85EA      		ldi r24,lo8(-91)
 340               	.L26:
 341               		.loc 1 415 0 is_stmt 0 discriminator 3
 342 001c 8093 BC00 		sts 188,r24
 343 0020 0895      		ret
 344               		.cfi_endproc
 345               	.LFE107:
 346               		.size	_twiStartRe, .-_twiStartRe
 347               		.section	.text.twiWrite,"ax",@progbits
 348               	.global	twiWrite
 349               		.type	twiWrite, @function
 350               	twiWrite:
 351               	.LFB108:
 416:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 417:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 418:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiWaitReady()             {while(!(TWI_READY & twiMode)); twiMode &= ~TWI_READY;}
 419:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiMT_Buffer(data, length) (twiMT_Ptr=(volatile uint8_t *)(data), twiMT_Count=(volatile ui
 420:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiRX_Buffer(data, length) (twiRX_Ptr=(volatile uint8_t *)(data), twiRX_Count=(volatile ui
 421:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #define _twiST_Buffer(data, length) (twiST_Ptr=(volatile uint8_t *)(data), twiST_Count=(volatile ui
 422:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 423:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // -------------------------                PUBLIC                ------------------------- //
 424:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** // ---------------------------------------------------------------------------------------- //
 425:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 426:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 427:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master-TX:: Передача length байт по адресу получателя. Тольк�
 428:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 429:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiWrite(uint8_t address, const uint8_t * data, uint8_t length)
 430:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 352               		.loc 1 430 0 is_stmt 1
 353               		.cfi_startproc
 354               	/* prologue: function */
 355               	/* frame size = 0 */
 356               	/* stack size = 0 */
 357               	.L__stack_usage = 0
 358               	.LVL29:
 359               	.L30:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 360               		.loc 1 431 0 discriminator 1
 361 0000 9091 0000 		lds r25,twiMode
 362 0004 92FF      		sbrs r25,2
 363 0006 00C0      		rjmp .L30
 364               		.loc 1 431 0 is_stmt 0 discriminator 2
 365 0008 9091 0000 		lds r25,twiMode
 366 000c 9B7F      		andi r25,lo8(-5)
 367 000e 9093 0000 		sts twiMode,r25
GAS LISTING /tmp/ccqx8j8N.s 			page 15


 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 368               		.loc 1 432 0 is_stmt 1 discriminator 2
 369 0012 7093 0000 		sts twiMT_Ptr+1,r23
 370 0016 6093 0000 		sts twiMT_Ptr,r22
 371 001a 50E0      		ldi r21,0
 372 001c 5093 0000 		sts twiMT_Count+1,r21
 373 0020 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 374               		.loc 1 433 0 discriminator 2
 375 0024 880F      		lsl r24
 376               	.LVL30:
 377 0026 0C94 0000 		jmp _twiStartTo
 378               	.LVL31:
 379               		.cfi_endproc
 380               	.LFE108:
 381               		.size	twiWrite, .-twiWrite
 382               		.section	.text.twiRead,"ax",@progbits
 383               	.global	twiRead
 384               		.type	twiRead, @function
 385               	twiRead:
 386               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 387               		.loc 1 440 0
 388               		.cfi_startproc
 389               	/* prologue: function */
 390               	/* frame size = 0 */
 391               	/* stack size = 0 */
 392               	.L__stack_usage = 0
 393               	.LVL32:
 394               	.L33:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 395               		.loc 1 441 0 discriminator 1
 396 0000 9091 0000 		lds r25,twiMode
 397 0004 92FF      		sbrs r25,2
 398 0006 00C0      		rjmp .L33
 399               		.loc 1 441 0 is_stmt 0 discriminator 2
 400 0008 9091 0000 		lds r25,twiMode
 401 000c 9B7F      		andi r25,lo8(-5)
 402 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 403               		.loc 1 442 0 is_stmt 1 discriminator 2
 404 0012 7093 0000 		sts twiRX_Ptr+1,r23
 405 0016 6093 0000 		sts twiRX_Ptr,r22
 406 001a 50E0      		ldi r21,0
 407 001c 5093 0000 		sts twiRX_Count+1,r21
 408 0020 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 409               		.loc 1 443 0 discriminator 2
 410 0024 880F      		lsl r24
 411               	.LVL33:
 412 0026 8160      		ori r24,lo8(1)
GAS LISTING /tmp/ccqx8j8N.s 			page 16


 413 0028 0C94 0000 		jmp _twiStartTo
 414               	.LVL34:
 415               		.cfi_endproc
 416               	.LFE109:
 417               		.size	twiRead, .-twiRead
 418               		.section	.text.twiRAW,"ax",@progbits
 419               	.global	twiRAW
 420               		.type	twiRAW, @function
 421               	twiRAW:
 422               	.LFB110:
 444:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 445:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 446:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 447:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master Read-after-Write:: Чтение данных после отправки команды. 
 448:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * !!! Не совместимо с Slave Receive Mode - буфер приема общий !!!
 449:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 450:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRAW(uint8_t address                             // адрес устройства
 451:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* command, uint8_t clength                     // команда и её длина
 452:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* data, uint8_t dlength                        // буфер приема данных и 
 453:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ){
 423               		.loc 1 453 0
 424               		.cfi_startproc
 425               	.LVL35:
 426 0000 0F93      		push r16
 427               	.LCFI9:
 428               		.cfi_def_cfa_offset 4
 429               		.cfi_offset 16, -3
 430 0002 1F93      		push r17
 431               	.LCFI10:
 432               		.cfi_def_cfa_offset 5
 433               		.cfi_offset 17, -4
 434               	/* prologue: function */
 435               	/* frame size = 0 */
 436               	/* stack size = 2 */
 437               	.L__stack_usage = 2
 438               	.L36:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 439               		.loc 1 454 0 discriminator 1
 440 0004 9091 0000 		lds r25,twiMode
 441 0008 92FF      		sbrs r25,2
 442 000a 00C0      		rjmp .L36
 443               		.loc 1 454 0 is_stmt 0 discriminator 2
 444 000c 9091 0000 		lds r25,twiMode
 445 0010 9B7F      		andi r25,lo8(-5)
 446 0012 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 447               		.loc 1 455 0 is_stmt 1 discriminator 2
 448 0016 7093 0000 		sts twiMT_Ptr+1,r23
 449 001a 6093 0000 		sts twiMT_Ptr,r22
 450 001e 50E0      		ldi r21,0
 451 0020 5093 0000 		sts twiMT_Count+1,r21
 452 0024 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 453               		.loc 1 456 0 discriminator 2
 454 0028 3093 0000 		sts twiRX_Ptr+1,r19
 455 002c 2093 0000 		sts twiRX_Ptr,r18
 456 0030 10E0      		ldi r17,0
GAS LISTING /tmp/ccqx8j8N.s 			page 17


 457 0032 1093 0000 		sts twiRX_Count+1,r17
 458 0036 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 459               		.loc 1 458 0 discriminator 2
 460 003a 1092 0000 		sts twiHookRestart+1,__zero_reg__
 461 003e 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 462               		.loc 1 459 0 discriminator 2
 463 0042 9091 0000 		lds r25,twiMode
 464 0046 9D7F      		andi r25,lo8(-3)
 465 0048 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 466               		.loc 1 460 0 discriminator 2
 467 004c 880F      		lsl r24
 468               	.LVL36:
 469 004e 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 470               		.loc 1 461 0 discriminator 2
 471 0052 8091 0000 		lds r24,twiMode
 472 0056 80FF      		sbrs r24,0
 473 0058 00C0      		rjmp .L38
 474               		.loc 1 461 0 is_stmt 0
 475 005a 85EE      		ldi r24,lo8(-27)
 476 005c 00C0      		rjmp .L37
 477               	.L38:
 478 005e 85EA      		ldi r24,lo8(-91)
 479               	.L37:
 480               		.loc 1 461 0 discriminator 3
 481 0060 8093 BC00 		sts 188,r24
 482               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 483               		.loc 1 462 0 is_stmt 1 discriminator 3
 484 0064 1F91      		pop r17
 485 0066 0F91      		pop r16
 486               	.LVL37:
 487 0068 0895      		ret
 488               		.cfi_endproc
 489               	.LFE110:
 490               		.size	twiRAW, .-twiRAW
 491               		.section	.text.lcdPrepare,"ax",@progbits
 492               	.global	lcdPrepare
 493               		.type	lcdPrepare, @function
 494               	lcdPrepare:
 495               	.LFB111:
 496               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 497               		.loc 2 490 0
 498               		.cfi_startproc
 499               	.LVL38:
 500               	/* prologue: function */
 501               	/* frame size = 0 */
 502               	/* stack size = 0 */
 503               	.L__stack_usage = 0
 504               	.LBB4:
 505               		.loc 2 491 0
 506 0000 2091 0000 		lds r18,lcdBackLight
GAS LISTING /tmp/ccqx8j8N.s 			page 18


 507 0004 982F      		mov r25,r24
 508 0006 907F      		andi r25,lo8(-16)
 509 0008 922B      		or r25,r18
 510               	.LVL39:
 511               		.loc 2 493 0
 512 000a 6111      		cpse r22,__zero_reg__
 513               		.loc 2 493 0 is_stmt 0 discriminator 1
 514 000c 9160      		ori r25,lo8(1)
 515               	.LVL40:
 516               	.L40:
 517               		.loc 2 494 0 is_stmt 1
 518 000e 9093 0000 		sts lcdBuffer,r25
 519 0012 9093 0000 		sts lcdBuffer+2,r25
 520               	.LVL41:
 521               		.loc 2 495 0
 522 0016 9460      		ori r25,lo8(4)
 523               	.LVL42:
 524               		.loc 2 496 0
 525 0018 9093 0000 		sts lcdBuffer+1,r25
 526               		.loc 2 498 0
 527 001c 30E1      		ldi r19,lo8(16)
 528 001e 839F      		mul r24,r19
 529 0020 C001      		movw r24,r0
 530 0022 1124      		clr __zero_reg__
 531               	.LVL43:
 532 0024 822B      		or r24,r18
 533               	.LVL44:
 534               		.loc 2 500 0
 535 0026 6111      		cpse r22,__zero_reg__
 536               		.loc 2 500 0 is_stmt 0 discriminator 1
 537 0028 8160      		ori r24,lo8(1)
 538               	.LVL45:
 539               	.L41:
 540               		.loc 2 501 0 is_stmt 1
 541 002a 8093 0000 		sts lcdBuffer+3,r24
 542 002e 8093 0000 		sts lcdBuffer+5,r24
 543               	.LVL46:
 544               		.loc 2 502 0
 545 0032 8460      		ori r24,lo8(4)
 546               	.LVL47:
 547               		.loc 2 503 0
 548 0034 8093 0000 		sts lcdBuffer+4,r24
 549 0038 0895      		ret
 550               	.LBE4:
 551               		.cfi_endproc
 552               	.LFE111:
 553               		.size	lcdPrepare, .-lcdPrepare
 554               		.section	.text.lcdWrite,"ax",@progbits
 555               	.global	lcdWrite
 556               		.type	lcdWrite, @function
 557               	lcdWrite:
 558               	.LFB112:
 559               		.loc 2 511 0
 560               		.cfi_startproc
 561               	.LVL48:
 562 0000 1F93      		push r17
 563               	.LCFI11:
GAS LISTING /tmp/ccqx8j8N.s 			page 19


 564               		.cfi_def_cfa_offset 4
 565               		.cfi_offset 17, -3
 566 0002 CF93      		push r28
 567               	.LCFI12:
 568               		.cfi_def_cfa_offset 5
 569               		.cfi_offset 28, -4
 570 0004 DF93      		push r29
 571               	.LCFI13:
 572               		.cfi_def_cfa_offset 6
 573               		.cfi_offset 29, -5
 574               	/* prologue: function */
 575               	/* frame size = 0 */
 576               	/* stack size = 3 */
 577               	.L__stack_usage = 3
 578 0006 162F      		mov r17,r22
 579               	.LVL49:
 580               	.LBB5:
 581               		.loc 2 515 0
 582 0008 2091 0000 		lds r18,twiMode
 583 000c 2260      		ori r18,lo8(2)
 584 000e 2093 0000 		sts twiMode,r18
 585               		.loc 2 516 0
 586 0012 C82F      		mov r28,r24
 587 0014 D92F      		mov r29,r25
 588 0016 180F      		add r17,r24
 589               	.LVL50:
 590               	.L49:
 591               		.loc 2 516 0 is_stmt 0 discriminator 1
 592 0018 1C17      		cp r17,r28
 593 001a 01F0      		breq .L51
 594               	.LVL51:
 595               		.loc 2 517 0 is_stmt 1
 596 001c 61E0      		ldi r22,lo8(1)
 597 001e 8991      		ld r24,Y+
 598               	.LVL52:
 599 0020 0E94 0000 		call lcdPrepare
 600               	.LVL53:
 601 0024 46E0      		ldi r20,lo8(6)
 602 0026 60E0      		ldi r22,lo8(lcdBuffer)
 603 0028 70E0      		ldi r23,hi8(lcdBuffer)
 604 002a 8091 0000 		lds r24,lcdAddress
 605 002e 0E94 0000 		call twiWrite
 606               	.LVL54:
 607 0032 85E0      		ldi r24,lo8(5)
 608 0034 90E0      		ldi r25,0
 609 0036 0E94 0000 		call time_delay16
 610               	.LVL55:
 611 003a 00C0      		rjmp .L49
 612               	.LVL56:
 613               	.L51:
 614               	/* epilogue start */
 615               	.LBE5:
 616               		.loc 2 518 0
 617 003c DF91      		pop r29
 618 003e CF91      		pop r28
 619               	.LVL57:
 620 0040 1F91      		pop r17
GAS LISTING /tmp/ccqx8j8N.s 			page 20


 621 0042 0895      		ret
 622               		.cfi_endproc
 623               	.LFE112:
 624               		.size	lcdWrite, .-lcdWrite
 625               		.section	.text.lcdInit,"ax",@progbits
 626               	.global	lcdInit
 627               		.type	lcdInit, @function
 628               	lcdInit:
 629               	.LFB113:
 630               		.loc 2 524 0
 631               		.cfi_startproc
 632               	/* prologue: function */
 633               	/* frame size = 0 */
 634               	/* stack size = 0 */
 635               	.L__stack_usage = 0
 636               		.loc 2 525 0
 637 0000 60E0      		ldi r22,0
 638 0002 8091 0000 		lds r24,lcdModes
 639 0006 0E94 0000 		call lcdPrepare
 640               	.LVL58:
 641 000a 46E0      		ldi r20,lo8(6)
 642 000c 60E0      		ldi r22,lo8(lcdBuffer)
 643 000e 70E0      		ldi r23,hi8(lcdBuffer)
 644 0010 8091 0000 		lds r24,lcdAddress
 645 0014 0E94 0000 		call twiWrite
 646               	.LVL59:
 647 0018 85E0      		ldi r24,lo8(5)
 648 001a 90E0      		ldi r25,0
 649 001c 0E94 0000 		call time_delay16
 650               	.LVL60:
 651               		.loc 2 526 0
 652 0020 60E0      		ldi r22,0
 653 0022 8091 0000 		lds r24,lcdShows
 654 0026 0E94 0000 		call lcdPrepare
 655               	.LVL61:
 656 002a 46E0      		ldi r20,lo8(6)
 657 002c 60E0      		ldi r22,lo8(lcdBuffer)
 658 002e 70E0      		ldi r23,hi8(lcdBuffer)
 659 0030 8091 0000 		lds r24,lcdAddress
 660 0034 0E94 0000 		call twiWrite
 661               	.LVL62:
 662 0038 85E0      		ldi r24,lo8(5)
 663 003a 90E0      		ldi r25,0
 664 003c 0E94 0000 		call time_delay16
 665               	.LVL63:
 666               		.loc 2 527 0
 667 0040 60E0      		ldi r22,0
 668 0042 8091 0000 		lds r24,lcdShifts
 669 0046 0E94 0000 		call lcdPrepare
 670               	.LVL64:
 671 004a 46E0      		ldi r20,lo8(6)
 672 004c 60E0      		ldi r22,lo8(lcdBuffer)
 673 004e 70E0      		ldi r23,hi8(lcdBuffer)
 674 0050 8091 0000 		lds r24,lcdAddress
 675 0054 0E94 0000 		call twiWrite
 676               	.LVL65:
 677 0058 85E0      		ldi r24,lo8(5)
GAS LISTING /tmp/ccqx8j8N.s 			page 21


 678 005a 90E0      		ldi r25,0
 679 005c 0E94 0000 		call time_delay16
 680               	.LVL66:
 681               		.loc 2 528 0
 682 0060 60E0      		ldi r22,0
 683 0062 81E0      		ldi r24,lo8(1)
 684 0064 0E94 0000 		call lcdPrepare
 685               	.LVL67:
 686 0068 46E0      		ldi r20,lo8(6)
 687 006a 60E0      		ldi r22,lo8(lcdBuffer)
 688 006c 70E0      		ldi r23,hi8(lcdBuffer)
 689 006e 8091 0000 		lds r24,lcdAddress
 690 0072 0E94 0000 		call twiWrite
 691               	.LVL68:
 692 0076 85E0      		ldi r24,lo8(5)
 693 0078 90E0      		ldi r25,0
 694 007a 0E94 0000 		call time_delay16
 695               	.LVL69:
 696 007e 80E1      		ldi r24,lo8(16)
 697 0080 90E0      		ldi r25,0
 698 0082 0E94 0000 		call time_delay16
 699               	.LVL70:
 700               		.loc 2 529 0
 701 0086 60E0      		ldi r22,0
 702 0088 82E0      		ldi r24,lo8(2)
 703 008a 0E94 0000 		call lcdPrepare
 704               	.LVL71:
 705 008e 46E0      		ldi r20,lo8(6)
 706 0090 60E0      		ldi r22,lo8(lcdBuffer)
 707 0092 70E0      		ldi r23,hi8(lcdBuffer)
 708 0094 8091 0000 		lds r24,lcdAddress
 709 0098 0E94 0000 		call twiWrite
 710               	.LVL72:
 711 009c 85E0      		ldi r24,lo8(5)
 712 009e 90E0      		ldi r25,0
 713 00a0 0C94 0000 		jmp time_delay16
 714               	.LVL73:
 715               		.cfi_endproc
 716               	.LFE113:
 717               		.size	lcdInit, .-lcdInit
 718               		.section	.text.lcdSetup,"ax",@progbits
 719               	.global	lcdSetup
 720               		.type	lcdSetup, @function
 721               	lcdSetup:
 722               	.LFB114:
 723               		.loc 2 536 0
 724               		.cfi_startproc
 725               	.LVL74:
 726 0000 CF93      		push r28
 727               	.LCFI14:
 728               		.cfi_def_cfa_offset 4
 729               		.cfi_offset 28, -3
 730               	/* prologue: function */
 731               	/* frame size = 0 */
 732               	/* stack size = 1 */
 733               	.L__stack_usage = 1
 734 0002 C42F      		mov r28,r20
GAS LISTING /tmp/ccqx8j8N.s 			page 22


 735               		.loc 2 537 0
 736 0004 8093 0000 		sts lcdAddress,r24
 737               		.loc 2 538 0
 738 0008 6093 0000 		sts lcdCols,r22
 739               		.loc 2 539 0
 740 000c 4093 0000 		sts lcdRows,r20
 741               		.loc 2 540 0
 742 0010 2223      		tst r18
 743 0012 01F0      		breq .L56
 744 0014 88E0      		ldi r24,lo8(8)
 745               	.LVL75:
 746 0016 00C0      		rjmp .L54
 747               	.LVL76:
 748               	.L56:
 749 0018 80E0      		ldi r24,0
 750               	.LVL77:
 751               	.L54:
 752               		.loc 2 540 0 is_stmt 0 discriminator 3
 753 001a 8093 0000 		sts lcdBackLight,r24
 754               		.loc 2 541 0 is_stmt 1 discriminator 3
 755 001e 80E2      		ldi r24,lo8(32)
 756 0020 8093 0000 		sts lcdModes,r24
 757               		.loc 2 542 0 discriminator 3
 758 0024 86E0      		ldi r24,lo8(6)
 759 0026 8093 0000 		sts lcdShifts,r24
 760               		.loc 2 543 0 discriminator 3
 761 002a 8CE0      		ldi r24,lo8(12)
 762 002c 8093 0000 		sts lcdShows,r24
 763               		.loc 2 547 0 discriminator 3
 764 0030 46E0      		ldi r20,lo8(6)
 765               	.LVL78:
 766 0032 60EA      		ldi r22,lo8(-96)
 767 0034 76E8      		ldi r23,lo8(-122)
 768 0036 81E0      		ldi r24,lo8(1)
 769 0038 90E0      		ldi r25,0
 770               	.LVL79:
 771 003a 0E94 0000 		call twiSetup
 772               	.LVL80:
 773               		.loc 2 551 0 discriminator 3
 774 003e C230      		cpi r28,lo8(2)
 775 0040 00F0      		brlo .L55
 776               		.loc 2 551 0 is_stmt 0 discriminator 1
 777 0042 8091 0000 		lds r24,lcdModes
 778 0046 8860      		ori r24,lo8(8)
 779 0048 8093 0000 		sts lcdModes,r24
 780               	.L55:
 781               		.loc 2 555 0 is_stmt 1
 782 004c 60E0      		ldi r22,0
 783 004e 80E3      		ldi r24,lo8(48)
 784 0050 0E94 0000 		call lcdPrepare
 785               	.LVL81:
 786               		.loc 2 557 0
 787 0054 8FE0      		ldi r24,lo8(15)
 788 0056 90E0      		ldi r25,0
 789 0058 0E94 0000 		call time_delay16
 790               	.LVL82:
 791               		.loc 2 558 0
GAS LISTING /tmp/ccqx8j8N.s 			page 23


 792 005c 43E0      		ldi r20,lo8(3)
 793 005e 60E0      		ldi r22,lo8(lcdBuffer)
 794 0060 70E0      		ldi r23,hi8(lcdBuffer)
 795 0062 8091 0000 		lds r24,lcdAddress
 796 0066 0E94 0000 		call twiWrite
 797               	.LVL83:
 798 006a 85E0      		ldi r24,lo8(5)
 799 006c 90E0      		ldi r25,0
 800 006e 0E94 0000 		call time_delay16
 801               	.LVL84:
 802               		.loc 2 559 0
 803 0072 85E0      		ldi r24,lo8(5)
 804 0074 90E0      		ldi r25,0
 805 0076 0E94 0000 		call time_delay16
 806               	.LVL85:
 807               		.loc 2 560 0
 808 007a 43E0      		ldi r20,lo8(3)
 809 007c 60E0      		ldi r22,lo8(lcdBuffer)
 810 007e 70E0      		ldi r23,hi8(lcdBuffer)
 811 0080 8091 0000 		lds r24,lcdAddress
 812 0084 0E94 0000 		call twiWrite
 813               	.LVL86:
 814 0088 85E0      		ldi r24,lo8(5)
 815 008a 90E0      		ldi r25,0
 816 008c 0E94 0000 		call time_delay16
 817               	.LVL87:
 818               		.loc 2 561 0
 819 0090 80E9      		ldi r24,lo8(-112)
 820 0092 91E0      		ldi r25,lo8(1)
 821               	/* #APP */
 822               	 ;  561 "LCD1602ex.ino" 1
 823 0094 0197      		1: sbiw r24,1 
 824 0096 01F4      		brne 1b
 825               		
 826               	 ;  0 "" 2
 827               		.loc 2 562 0
 828               	/* #NOAPP */
 829 0098 43E0      		ldi r20,lo8(3)
 830 009a 60E0      		ldi r22,lo8(lcdBuffer)
 831 009c 70E0      		ldi r23,hi8(lcdBuffer)
 832 009e 8091 0000 		lds r24,lcdAddress
 833 00a2 0E94 0000 		call twiWrite
 834               	.LVL88:
 835 00a6 85E0      		ldi r24,lo8(5)
 836 00a8 90E0      		ldi r25,0
 837 00aa 0E94 0000 		call time_delay16
 838               	.LVL89:
 839               		.loc 2 564 0
 840 00ae 60E0      		ldi r22,0
 841 00b0 80E2      		ldi r24,lo8(32)
 842 00b2 0E94 0000 		call lcdPrepare
 843               	.LVL90:
 844               		.loc 2 565 0
 845 00b6 43E0      		ldi r20,lo8(3)
 846 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 847 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 848 00bc 8091 0000 		lds r24,lcdAddress
GAS LISTING /tmp/ccqx8j8N.s 			page 24


 849 00c0 0E94 0000 		call twiWrite
 850               	.LVL91:
 851 00c4 85E0      		ldi r24,lo8(5)
 852 00c6 90E0      		ldi r25,0
 853 00c8 0E94 0000 		call time_delay16
 854               	.LVL92:
 855               		.loc 2 567 0
 856 00cc 0E94 0000 		call lcdInit
 857               	.LVL93:
 858               		.loc 2 568 0
 859 00d0 84EF      		ldi r24,lo8(-12)
 860 00d2 91E0      		ldi r25,lo8(1)
 861               	/* epilogue start */
 862               		.loc 2 569 0
 863 00d4 CF91      		pop r28
 864               	.LVL94:
 865               		.loc 2 568 0
 866 00d6 0C94 0000 		jmp time_delay16
 867               	.LVL95:
 868               		.cfi_endproc
 869               	.LFE114:
 870               		.size	lcdSetup, .-lcdSetup
 871               		.section	.rodata.str1.1,"aMS",@progbits,1
 872               	.LC0:
 873 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 873      6F2C 2041 
 873      4141 4141 
 873      4100 
 874               		.section	.text.setup,"ax",@progbits
 875               	.global	setup
 876               		.type	setup, @function
 877               	setup:
 878               	.LFB115:
 879               		.loc 2 577 0
 880               		.cfi_startproc
 881               	/* prologue: function */
 882               	/* frame size = 0 */
 883               	/* stack size = 0 */
 884               	.L__stack_usage = 0
 885               	.LBB6:
 886               		.loc 2 581 0
 887 0000 21E0      		ldi r18,lo8(1)
 888 0002 42E0      		ldi r20,lo8(2)
 889 0004 60E1      		ldi r22,lo8(16)
 890 0006 87E2      		ldi r24,lo8(39)
 891 0008 0E94 0000 		call lcdSetup
 892               	.LVL96:
 893               		.loc 2 582 0
 894 000c 6DE0      		ldi r22,lo8(13)
 895 000e 80E0      		ldi r24,lo8(.LC0)
 896 0010 90E0      		ldi r25,hi8(.LC0)
 897 0012 0C94 0000 		jmp lcdWrite
 898               	.LVL97:
 899               	.LBE6:
 900               		.cfi_endproc
 901               	.LFE115:
 902               		.size	setup, .-setup
GAS LISTING /tmp/ccqx8j8N.s 			page 25


 903               		.section	.text.loop,"ax",@progbits
 904               	.global	loop
 905               		.type	loop, @function
 906               	loop:
 907               	.LFB116:
 908               		.loc 2 588 0
 909               		.cfi_startproc
 910               	/* prologue: function */
 911               	/* frame size = 0 */
 912               	/* stack size = 0 */
 913               	.L__stack_usage = 0
 914 0000 0895      		ret
 915               		.cfi_endproc
 916               	.LFE116:
 917               		.size	loop, .-loop
 918               	.global	lcdBuffer
 919               		.section	.bss.lcdBuffer,"aw",@nobits
 920               		.type	lcdBuffer, @object
 921               		.size	lcdBuffer, 6
 922               	lcdBuffer:
 923 0000 0000 0000 		.zero	6
 923      0000 
 924               	.global	lcdRows
 925               		.section	.data.lcdRows,"aw",@progbits
 926               		.type	lcdRows, @object
 927               		.size	lcdRows, 1
 928               	lcdRows:
 929 0000 02        		.byte	2
 930               	.global	lcdCols
 931               		.section	.data.lcdCols,"aw",@progbits
 932               		.type	lcdCols, @object
 933               		.size	lcdCols, 1
 934               	lcdCols:
 935 0000 10        		.byte	16
 936               	.global	lcdAddress
 937               		.section	.data.lcdAddress,"aw",@progbits
 938               		.type	lcdAddress, @object
 939               		.size	lcdAddress, 1
 940               	lcdAddress:
 941 0000 27        		.byte	39
 942               	.global	lcdBackLight
 943               		.section	.data.lcdBackLight,"aw",@progbits
 944               		.type	lcdBackLight, @object
 945               		.size	lcdBackLight, 1
 946               	lcdBackLight:
 947 0000 08        		.byte	8
 948               	.global	lcdShows
 949               		.section	.data.lcdShows,"aw",@progbits
 950               		.type	lcdShows, @object
 951               		.size	lcdShows, 1
 952               	lcdShows:
 953 0000 08        		.byte	8
 954               	.global	lcdShifts
 955               		.section	.data.lcdShifts,"aw",@progbits
 956               		.type	lcdShifts, @object
 957               		.size	lcdShifts, 1
 958               	lcdShifts:
GAS LISTING /tmp/ccqx8j8N.s 			page 26


 959 0000 06        		.byte	6
 960               	.global	lcdModes
 961               		.section	.data.lcdModes,"aw",@progbits
 962               		.type	lcdModes, @object
 963               		.size	lcdModes, 1
 964               	lcdModes:
 965 0000 30        		.byte	48
 966               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 967               		.type	_ZL12twiStatistic, @object
 968               		.size	_ZL12twiStatistic, 20
 969               	_ZL12twiStatistic:
 970 0000 0000 0000 		.zero	20
 970      0000 0000 
 970      0000 0000 
 970      0000 0000 
 970      0000 0000 
 971               	.global	twiSlaveWriter
 972               		.section	.bss.twiSlaveWriter,"aw",@nobits
 973               		.type	twiSlaveWriter, @object
 974               		.size	twiSlaveWriter, 2
 975               	twiSlaveWriter:
 976 0000 0000      		.zero	2
 977               	.global	twiSlaveReader
 978               		.section	.bss.twiSlaveReader,"aw",@nobits
 979               		.type	twiSlaveReader, @object
 980               		.size	twiSlaveReader, 2
 981               	twiSlaveReader:
 982 0000 0000      		.zero	2
 983               	.global	twiMasterReader
 984               		.section	.bss.twiMasterReader,"aw",@nobits
 985               		.type	twiMasterReader, @object
 986               		.size	twiMasterReader, 2
 987               	twiMasterReader:
 988 0000 0000      		.zero	2
 989               	.global	twiHookRestart
 990               		.section	.bss.twiHookRestart,"aw",@nobits
 991               		.type	twiHookRestart, @object
 992               		.size	twiHookRestart, 2
 993               	twiHookRestart:
 994 0000 0000      		.zero	2
 995               	.global	twiST_Ptr
 996               		.section	.bss.twiST_Ptr,"aw",@nobits
 997               		.type	twiST_Ptr, @object
 998               		.size	twiST_Ptr, 2
 999               	twiST_Ptr:
 1000 0000 0000      		.zero	2
 1001               	.global	twiST_Count
 1002               		.section	.bss.twiST_Count,"aw",@nobits
 1003               		.type	twiST_Count, @object
 1004               		.size	twiST_Count, 2
 1005               	twiST_Count:
 1006 0000 0000      		.zero	2
 1007               	.global	twiRX_Ptr
 1008               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1009               		.type	twiRX_Ptr, @object
 1010               		.size	twiRX_Ptr, 2
 1011               	twiRX_Ptr:
GAS LISTING /tmp/ccqx8j8N.s 			page 27


 1012 0000 0000      		.zero	2
 1013               	.global	twiRX_Count
 1014               		.section	.bss.twiRX_Count,"aw",@nobits
 1015               		.type	twiRX_Count, @object
 1016               		.size	twiRX_Count, 2
 1017               	twiRX_Count:
 1018 0000 0000      		.zero	2
 1019               	.global	twiMT_Ptr
 1020               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1021               		.type	twiMT_Ptr, @object
 1022               		.size	twiMT_Ptr, 2
 1023               	twiMT_Ptr:
 1024 0000 0000      		.zero	2
 1025               	.global	twiMT_Count
 1026               		.section	.bss.twiMT_Count,"aw",@nobits
 1027               		.type	twiMT_Count, @object
 1028               		.size	twiMT_Count, 2
 1029               	twiMT_Count:
 1030 0000 0000      		.zero	2
 1031               	.global	twiSLARW
 1032               		.section	.bss.twiSLARW,"aw",@nobits
 1033               		.type	twiSLARW, @object
 1034               		.size	twiSLARW, 1
 1035               	twiSLARW:
 1036 0000 00        		.zero	1
 1037               	.global	twiState
 1038               		.section	.bss.twiState,"aw",@nobits
 1039               		.type	twiState, @object
 1040               		.size	twiState, 1
 1041               	twiState:
 1042 0000 00        		.zero	1
 1043               	.global	twiMode
 1044               		.section	.bss.twiMode,"aw",@nobits
 1045               		.type	twiMode, @object
 1046               		.size	twiMode, 1
 1047               	twiMode:
 1048 0000 00        		.zero	1
 1049               		.text
 1050               	.Letext0:
 1051               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1052               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1053               		.section	.debug_info,"",@progbits
 1054               	.Ldebug_info0:
 1055 0000 1E0B 0000 		.long	0xb1e
 1056 0004 0200      		.word	0x2
 1057 0006 0000 0000 		.long	.Ldebug_abbrev0
 1058 000a 04        		.byte	0x4
 1059 000b 01        		.uleb128 0x1
 1060 000c 0000 0000 		.long	.LASF78
 1061 0010 04        		.byte	0x4
 1062 0011 0000 0000 		.long	.LASF79
 1063 0015 0000 0000 		.long	.LASF80
 1064 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1065 001d 0000 0000 		.long	0
 1066 0021 0000 0000 		.long	0
 1067 0025 0000 0000 		.long	.Ldebug_line0
 1068 0029 02        		.uleb128 0x2
GAS LISTING /tmp/ccqx8j8N.s 			page 28


 1069 002a 01        		.byte	0x1
 1070 002b 06        		.byte	0x6
 1071 002c 0000 0000 		.long	.LASF0
 1072 0030 03        		.uleb128 0x3
 1073 0031 0000 0000 		.long	.LASF2
 1074 0035 03        		.byte	0x3
 1075 0036 7A        		.byte	0x7a
 1076 0037 3B00 0000 		.long	0x3b
 1077 003b 02        		.uleb128 0x2
 1078 003c 01        		.byte	0x1
 1079 003d 08        		.byte	0x8
 1080 003e 0000 0000 		.long	.LASF1
 1081 0042 04        		.uleb128 0x4
 1082 0043 02        		.byte	0x2
 1083 0044 05        		.byte	0x5
 1084 0045 696E 7400 		.string	"int"
 1085 0049 03        		.uleb128 0x3
 1086 004a 0000 0000 		.long	.LASF3
 1087 004e 03        		.byte	0x3
 1088 004f 7C        		.byte	0x7c
 1089 0050 5400 0000 		.long	0x54
 1090 0054 02        		.uleb128 0x2
 1091 0055 02        		.byte	0x2
 1092 0056 07        		.byte	0x7
 1093 0057 0000 0000 		.long	.LASF4
 1094 005b 02        		.uleb128 0x2
 1095 005c 04        		.byte	0x4
 1096 005d 05        		.byte	0x5
 1097 005e 0000 0000 		.long	.LASF5
 1098 0062 03        		.uleb128 0x3
 1099 0063 0000 0000 		.long	.LASF6
 1100 0067 03        		.byte	0x3
 1101 0068 7E        		.byte	0x7e
 1102 0069 6D00 0000 		.long	0x6d
 1103 006d 02        		.uleb128 0x2
 1104 006e 04        		.byte	0x4
 1105 006f 07        		.byte	0x7
 1106 0070 0000 0000 		.long	.LASF7
 1107 0074 02        		.uleb128 0x2
 1108 0075 08        		.byte	0x8
 1109 0076 05        		.byte	0x5
 1110 0077 0000 0000 		.long	.LASF8
 1111 007b 02        		.uleb128 0x2
 1112 007c 08        		.byte	0x8
 1113 007d 07        		.byte	0x7
 1114 007e 0000 0000 		.long	.LASF9
 1115 0082 02        		.uleb128 0x2
 1116 0083 01        		.byte	0x1
 1117 0084 02        		.byte	0x2
 1118 0085 0000 0000 		.long	.LASF10
 1119 0089 05        		.uleb128 0x5
 1120 008a 02        		.byte	0x2
 1121 008b 8F00 0000 		.long	0x8f
 1122 008f 06        		.uleb128 0x6
 1123 0090 02        		.uleb128 0x2
 1124 0091 01        		.byte	0x1
 1125 0092 06        		.byte	0x6
GAS LISTING /tmp/ccqx8j8N.s 			page 29


 1126 0093 0000 0000 		.long	.LASF11
 1127 0097 02        		.uleb128 0x2
 1128 0098 04        		.byte	0x4
 1129 0099 04        		.byte	0x4
 1130 009a 0000 0000 		.long	.LASF12
 1131 009e 02        		.uleb128 0x2
 1132 009f 04        		.byte	0x4
 1133 00a0 04        		.byte	0x4
 1134 00a1 0000 0000 		.long	.LASF13
 1135 00a5 02        		.uleb128 0x2
 1136 00a6 02        		.byte	0x2
 1137 00a7 07        		.byte	0x7
 1138 00a8 0000 0000 		.long	.LASF14
 1139 00ac 07        		.uleb128 0x7
 1140 00ad 0000 0000 		.long	.LASF81
 1141 00b1 02        		.byte	0x2
 1142 00b2 01        		.byte	0x1
 1143 00b3 8C        		.byte	0x8c
 1144 00b4 CB00 0000 		.long	0xcb
 1145 00b8 08        		.uleb128 0x8
 1146 00b9 0000 0000 		.long	.LASF15
 1147 00bd 01        		.sleb128 1
 1148 00be 08        		.uleb128 0x8
 1149 00bf 0000 0000 		.long	.LASF16
 1150 00c3 02        		.sleb128 2
 1151 00c4 08        		.uleb128 0x8
 1152 00c5 0000 0000 		.long	.LASF17
 1153 00c9 04        		.sleb128 4
 1154 00ca 00        		.byte	0
 1155 00cb 09        		.uleb128 0x9
 1156 00cc 14        		.byte	0x14
 1157 00cd 01        		.byte	0x1
 1158 00ce A6        		.byte	0xa6
 1159 00cf 0000 0000 		.long	.LASF82
 1160 00d3 6401 0000 		.long	0x164
 1161 00d7 0A        		.uleb128 0xa
 1162 00d8 0000 0000 		.long	.LASF18
 1163 00dc 01        		.byte	0x1
 1164 00dd A7        		.byte	0xa7
 1165 00de 4900 0000 		.long	0x49
 1166 00e2 02        		.byte	0x2
 1167 00e3 23        		.byte	0x23
 1168 00e4 00        		.uleb128 0
 1169 00e5 0A        		.uleb128 0xa
 1170 00e6 0000 0000 		.long	.LASF19
 1171 00ea 01        		.byte	0x1
 1172 00eb A7        		.byte	0xa7
 1173 00ec 4900 0000 		.long	0x49
 1174 00f0 02        		.byte	0x2
 1175 00f1 23        		.byte	0x23
 1176 00f2 02        		.uleb128 0x2
 1177 00f3 0A        		.uleb128 0xa
 1178 00f4 0000 0000 		.long	.LASF20
 1179 00f8 01        		.byte	0x1
 1180 00f9 A7        		.byte	0xa7
 1181 00fa 4900 0000 		.long	0x49
 1182 00fe 02        		.byte	0x2
GAS LISTING /tmp/ccqx8j8N.s 			page 30


 1183 00ff 23        		.byte	0x23
 1184 0100 04        		.uleb128 0x4
 1185 0101 0A        		.uleb128 0xa
 1186 0102 0000 0000 		.long	.LASF21
 1187 0106 01        		.byte	0x1
 1188 0107 A7        		.byte	0xa7
 1189 0108 4900 0000 		.long	0x49
 1190 010c 02        		.byte	0x2
 1191 010d 23        		.byte	0x23
 1192 010e 06        		.uleb128 0x6
 1193 010f 0A        		.uleb128 0xa
 1194 0110 0000 0000 		.long	.LASF22
 1195 0114 01        		.byte	0x1
 1196 0115 A7        		.byte	0xa7
 1197 0116 4900 0000 		.long	0x49
 1198 011a 02        		.byte	0x2
 1199 011b 23        		.byte	0x23
 1200 011c 08        		.uleb128 0x8
 1201 011d 0B        		.uleb128 0xb
 1202 011e 6D74 7800 		.string	"mtx"
 1203 0122 01        		.byte	0x1
 1204 0123 A7        		.byte	0xa7
 1205 0124 4900 0000 		.long	0x49
 1206 0128 02        		.byte	0x2
 1207 0129 23        		.byte	0x23
 1208 012a 0A        		.uleb128 0xa
 1209 012b 0B        		.uleb128 0xb
 1210 012c 6D72 7800 		.string	"mrx"
 1211 0130 01        		.byte	0x1
 1212 0131 A7        		.byte	0xa7
 1213 0132 4900 0000 		.long	0x49
 1214 0136 02        		.byte	0x2
 1215 0137 23        		.byte	0x23
 1216 0138 0C        		.uleb128 0xc
 1217 0139 0B        		.uleb128 0xb
 1218 013a 7372 7800 		.string	"srx"
 1219 013e 01        		.byte	0x1
 1220 013f A7        		.byte	0xa7
 1221 0140 4900 0000 		.long	0x49
 1222 0144 02        		.byte	0x2
 1223 0145 23        		.byte	0x23
 1224 0146 0E        		.uleb128 0xe
 1225 0147 0B        		.uleb128 0xb
 1226 0148 6772 7800 		.string	"grx"
 1227 014c 01        		.byte	0x1
 1228 014d A7        		.byte	0xa7
 1229 014e 4900 0000 		.long	0x49
 1230 0152 02        		.byte	0x2
 1231 0153 23        		.byte	0x23
 1232 0154 10        		.uleb128 0x10
 1233 0155 0B        		.uleb128 0xb
 1234 0156 7374 7800 		.string	"stx"
 1235 015a 01        		.byte	0x1
 1236 015b A7        		.byte	0xa7
 1237 015c 4900 0000 		.long	0x49
 1238 0160 02        		.byte	0x2
 1239 0161 23        		.byte	0x23
GAS LISTING /tmp/ccqx8j8N.s 			page 31


 1240 0162 12        		.uleb128 0x12
 1241 0163 00        		.byte	0
 1242 0164 03        		.uleb128 0x3
 1243 0165 0000 0000 		.long	.LASF23
 1244 0169 01        		.byte	0x1
 1245 016a A8        		.byte	0xa8
 1246 016b CB00 0000 		.long	0xcb
 1247 016f 05        		.uleb128 0x5
 1248 0170 02        		.byte	0x2
 1249 0171 3000 0000 		.long	0x30
 1250 0175 0C        		.uleb128 0xc
 1251 0176 01        		.byte	0x1
 1252 0177 0000 0000 		.long	.LASF26
 1253 017b 01        		.byte	0x1
 1254 017c B7        		.byte	0xb7
 1255 017d 0000 0000 		.long	.LFB102
 1256 0181 0000 0000 		.long	.LFE102
 1257 0185 03        		.byte	0x3
 1258 0186 92        		.byte	0x92
 1259 0187 20        		.uleb128 0x20
 1260 0188 03        		.sleb128 3
 1261 0189 01        		.byte	0x1
 1262 018a C901 0000 		.long	0x1c9
 1263 018e 0D        		.uleb128 0xd
 1264 018f 0000 0000 		.long	.LASF28
 1265 0193 01        		.byte	0x1
 1266 0194 B7        		.byte	0xb7
 1267 0195 6200 0000 		.long	0x62
 1268 0199 0000 0000 		.long	.LLST0
 1269 019d 0E        		.uleb128 0xe
 1270 019e 0000 0000 		.long	.LBB2
 1271 01a2 0000 0000 		.long	.LBE2
 1272 01a6 0F        		.uleb128 0xf
 1273 01a7 0000 0000 		.long	.LASF24
 1274 01ab 01        		.byte	0x1
 1275 01ac B9        		.byte	0xb9
 1276 01ad 4900 0000 		.long	0x49
 1277 01b1 06        		.byte	0x6
 1278 01b2 62        		.byte	0x62
 1279 01b3 93        		.byte	0x93
 1280 01b4 01        		.uleb128 0x1
 1281 01b5 63        		.byte	0x63
 1282 01b6 93        		.byte	0x93
 1283 01b7 01        		.uleb128 0x1
 1284 01b8 10        		.uleb128 0x10
 1285 01b9 0000 0000 		.long	.LASF25
 1286 01bd 01        		.byte	0x1
 1287 01be BA        		.byte	0xba
 1288 01bf 3000 0000 		.long	0x30
 1289 01c3 0000 0000 		.long	.LLST1
 1290 01c7 00        		.byte	0
 1291 01c8 00        		.byte	0
 1292 01c9 11        		.uleb128 0x11
 1293 01ca 01        		.byte	0x1
 1294 01cb 0000 0000 		.long	.LASF27
 1295 01cf 01        		.byte	0x1
 1296 01d0 C8        		.byte	0xc8
GAS LISTING /tmp/ccqx8j8N.s 			page 32


 1297 01d1 0000 0000 		.long	.LFB103
 1298 01d5 0000 0000 		.long	.LFE103
 1299 01d9 0000 0000 		.long	.LLST2
 1300 01dd 01        		.byte	0x1
 1301 01de 1D02 0000 		.long	0x21d
 1302 01e2 0D        		.uleb128 0xd
 1303 01e3 0000 0000 		.long	.LASF28
 1304 01e7 01        		.byte	0x1
 1305 01e8 C8        		.byte	0xc8
 1306 01e9 6200 0000 		.long	0x62
 1307 01ed 0000 0000 		.long	.LLST3
 1308 01f1 0D        		.uleb128 0xd
 1309 01f2 0000 0000 		.long	.LASF29
 1310 01f6 01        		.byte	0x1
 1311 01f7 C8        		.byte	0xc8
 1312 01f8 3000 0000 		.long	0x30
 1313 01fc 0000 0000 		.long	.LLST4
 1314 0200 12        		.uleb128 0x12
 1315 0201 0000 0000 		.long	.LVL10
 1316 0205 7501 0000 		.long	0x175
 1317 0209 13        		.uleb128 0x13
 1318 020a 0C        		.byte	0xc
 1319 020b 66        		.byte	0x66
 1320 020c 93        		.byte	0x93
 1321 020d 01        		.uleb128 0x1
 1322 020e 67        		.byte	0x67
 1323 020f 93        		.byte	0x93
 1324 0210 01        		.uleb128 0x1
 1325 0211 68        		.byte	0x68
 1326 0212 93        		.byte	0x93
 1327 0213 01        		.uleb128 0x1
 1328 0214 69        		.byte	0x69
 1329 0215 93        		.byte	0x93
 1330 0216 01        		.uleb128 0x1
 1331 0217 03        		.byte	0x3
 1332 0218 F3        		.byte	0xf3
 1333 0219 01        		.uleb128 0x1
 1334 021a 66        		.byte	0x66
 1335 021b 00        		.byte	0
 1336 021c 00        		.byte	0
 1337 021d 14        		.uleb128 0x14
 1338 021e 01        		.byte	0x1
 1339 021f 0000 0000 		.long	.LASF30
 1340 0223 01        		.byte	0x1
 1341 0224 EF        		.byte	0xef
 1342 0225 0000 0000 		.long	.LFB104
 1343 0229 0000 0000 		.long	.LFE104
 1344 022d 0000 0000 		.long	.LLST5
 1345 0231 01        		.byte	0x1
 1346 0232 4602 0000 		.long	0x246
 1347 0236 15        		.uleb128 0x15
 1348 0237 5F6D 6400 		.string	"_md"
 1349 023b 01        		.byte	0x1
 1350 023c EF        		.byte	0xef
 1351 023d 3000 0000 		.long	0x30
 1352 0241 0000 0000 		.long	.LLST6
 1353 0245 00        		.byte	0
GAS LISTING /tmp/ccqx8j8N.s 			page 33


 1354 0246 16        		.uleb128 0x16
 1355 0247 01        		.byte	0x1
 1356 0248 0000 0000 		.long	.LASF31
 1357 024c 01        		.byte	0x1
 1358 024d 0401      		.word	0x104
 1359 024f 0000 0000 		.long	.LFB105
 1360 0253 0000 0000 		.long	.LFE105
 1361 0257 0000 0000 		.long	.LLST7
 1362 025b 01        		.byte	0x1
 1363 025c 9702 0000 		.long	0x297
 1364 0260 0E        		.uleb128 0xe
 1365 0261 0000 0000 		.long	.LBB3
 1366 0265 0000 0000 		.long	.LBE3
 1367 0269 17        		.uleb128 0x17
 1368 026a 5F63 7200 		.string	"_cr"
 1369 026e 01        		.byte	0x1
 1370 026f 0601      		.word	0x106
 1371 0271 3000 0000 		.long	0x30
 1372 0275 18        		.uleb128 0x18
 1373 0276 5F6D 6400 		.string	"_md"
 1374 027a 01        		.byte	0x1
 1375 027b 0701      		.word	0x107
 1376 027d 3000 0000 		.long	0x30
 1377 0281 0000 0000 		.long	.LLST8
 1378 0285 18        		.uleb128 0x18
 1379 0286 5F73 7400 		.string	"_st"
 1380 028a 01        		.byte	0x1
 1381 028b 0801      		.word	0x108
 1382 028d 3000 0000 		.long	0x30
 1383 0291 0000 0000 		.long	.LLST9
 1384 0295 00        		.byte	0
 1385 0296 00        		.byte	0
 1386 0297 19        		.uleb128 0x19
 1387 0298 01        		.byte	0x1
 1388 0299 0000 0000 		.long	.LASF32
 1389 029d 01        		.byte	0x1
 1390 029e 8F01      		.word	0x18f
 1391 02a0 0000 0000 		.long	.LFB106
 1392 02a4 0000 0000 		.long	.LFE106
 1393 02a8 03        		.byte	0x3
 1394 02a9 92        		.byte	0x92
 1395 02aa 20        		.uleb128 0x20
 1396 02ab 03        		.sleb128 3
 1397 02ac 01        		.byte	0x1
 1398 02ad C202 0000 		.long	0x2c2
 1399 02b1 1A        		.uleb128 0x1a
 1400 02b2 0000 0000 		.long	.LASF33
 1401 02b6 01        		.byte	0x1
 1402 02b7 8F01      		.word	0x18f
 1403 02b9 3000 0000 		.long	0x30
 1404 02bd 0000 0000 		.long	.LLST10
 1405 02c1 00        		.byte	0
 1406 02c2 19        		.uleb128 0x19
 1407 02c3 01        		.byte	0x1
 1408 02c4 0000 0000 		.long	.LASF34
 1409 02c8 01        		.byte	0x1
 1410 02c9 9B01      		.word	0x19b
GAS LISTING /tmp/ccqx8j8N.s 			page 34


 1411 02cb 0000 0000 		.long	.LFB107
 1412 02cf 0000 0000 		.long	.LFE107
 1413 02d3 03        		.byte	0x3
 1414 02d4 92        		.byte	0x92
 1415 02d5 20        		.uleb128 0x20
 1416 02d6 03        		.sleb128 3
 1417 02d7 01        		.byte	0x1
 1418 02d8 ED02 0000 		.long	0x2ed
 1419 02dc 1A        		.uleb128 0x1a
 1420 02dd 0000 0000 		.long	.LASF33
 1421 02e1 01        		.byte	0x1
 1422 02e2 9B01      		.word	0x19b
 1423 02e4 3000 0000 		.long	0x30
 1424 02e8 0000 0000 		.long	.LLST11
 1425 02ec 00        		.byte	0
 1426 02ed 19        		.uleb128 0x19
 1427 02ee 01        		.byte	0x1
 1428 02ef 0000 0000 		.long	.LASF35
 1429 02f3 01        		.byte	0x1
 1430 02f4 AD01      		.word	0x1ad
 1431 02f6 0000 0000 		.long	.LFB108
 1432 02fa 0000 0000 		.long	.LFE108
 1433 02fe 03        		.byte	0x3
 1434 02ff 92        		.byte	0x92
 1435 0300 20        		.uleb128 0x20
 1436 0301 03        		.sleb128 3
 1437 0302 01        		.byte	0x1
 1438 0303 4C03 0000 		.long	0x34c
 1439 0307 1A        		.uleb128 0x1a
 1440 0308 0000 0000 		.long	.LASF33
 1441 030c 01        		.byte	0x1
 1442 030d AD01      		.word	0x1ad
 1443 030f 3000 0000 		.long	0x30
 1444 0313 0000 0000 		.long	.LLST12
 1445 0317 1A        		.uleb128 0x1a
 1446 0318 0000 0000 		.long	.LASF36
 1447 031c 01        		.byte	0x1
 1448 031d AD01      		.word	0x1ad
 1449 031f 4C03 0000 		.long	0x34c
 1450 0323 0000 0000 		.long	.LLST13
 1451 0327 1A        		.uleb128 0x1a
 1452 0328 0000 0000 		.long	.LASF37
 1453 032c 01        		.byte	0x1
 1454 032d AD01      		.word	0x1ad
 1455 032f 3000 0000 		.long	0x30
 1456 0333 0000 0000 		.long	.LLST14
 1457 0337 1B        		.uleb128 0x1b
 1458 0338 0000 0000 		.long	.LVL31
 1459 033c 01        		.byte	0x1
 1460 033d 9702 0000 		.long	0x297
 1461 0341 13        		.uleb128 0x13
 1462 0342 01        		.byte	0x1
 1463 0343 68        		.byte	0x68
 1464 0344 05        		.byte	0x5
 1465 0345 F3        		.byte	0xf3
 1466 0346 01        		.uleb128 0x1
 1467 0347 68        		.byte	0x68
GAS LISTING /tmp/ccqx8j8N.s 			page 35


 1468 0348 31        		.byte	0x31
 1469 0349 24        		.byte	0x24
 1470 034a 00        		.byte	0
 1471 034b 00        		.byte	0
 1472 034c 05        		.uleb128 0x5
 1473 034d 02        		.byte	0x2
 1474 034e 5203 0000 		.long	0x352
 1475 0352 1C        		.uleb128 0x1c
 1476 0353 3000 0000 		.long	0x30
 1477 0357 19        		.uleb128 0x19
 1478 0358 01        		.byte	0x1
 1479 0359 0000 0000 		.long	.LASF38
 1480 035d 01        		.byte	0x1
 1481 035e B701      		.word	0x1b7
 1482 0360 0000 0000 		.long	.LFB109
 1483 0364 0000 0000 		.long	.LFE109
 1484 0368 03        		.byte	0x3
 1485 0369 92        		.byte	0x92
 1486 036a 20        		.uleb128 0x20
 1487 036b 03        		.sleb128 3
 1488 036c 01        		.byte	0x1
 1489 036d B803 0000 		.long	0x3b8
 1490 0371 1A        		.uleb128 0x1a
 1491 0372 0000 0000 		.long	.LASF33
 1492 0376 01        		.byte	0x1
 1493 0377 B701      		.word	0x1b7
 1494 0379 3000 0000 		.long	0x30
 1495 037d 0000 0000 		.long	.LLST15
 1496 0381 1A        		.uleb128 0x1a
 1497 0382 0000 0000 		.long	.LASF36
 1498 0386 01        		.byte	0x1
 1499 0387 B701      		.word	0x1b7
 1500 0389 6F01 0000 		.long	0x16f
 1501 038d 0000 0000 		.long	.LLST16
 1502 0391 1A        		.uleb128 0x1a
 1503 0392 0000 0000 		.long	.LASF37
 1504 0396 01        		.byte	0x1
 1505 0397 B701      		.word	0x1b7
 1506 0399 3000 0000 		.long	0x30
 1507 039d 0000 0000 		.long	.LLST17
 1508 03a1 1B        		.uleb128 0x1b
 1509 03a2 0000 0000 		.long	.LVL34
 1510 03a6 01        		.byte	0x1
 1511 03a7 9702 0000 		.long	0x297
 1512 03ab 13        		.uleb128 0x13
 1513 03ac 01        		.byte	0x1
 1514 03ad 68        		.byte	0x68
 1515 03ae 07        		.byte	0x7
 1516 03af F3        		.byte	0xf3
 1517 03b0 01        		.uleb128 0x1
 1518 03b1 68        		.byte	0x68
 1519 03b2 31        		.byte	0x31
 1520 03b3 24        		.byte	0x24
 1521 03b4 31        		.byte	0x31
 1522 03b5 21        		.byte	0x21
 1523 03b6 00        		.byte	0
 1524 03b7 00        		.byte	0
GAS LISTING /tmp/ccqx8j8N.s 			page 36


 1525 03b8 16        		.uleb128 0x16
 1526 03b9 01        		.byte	0x1
 1527 03ba 0000 0000 		.long	.LASF39
 1528 03be 01        		.byte	0x1
 1529 03bf C201      		.word	0x1c2
 1530 03c1 0000 0000 		.long	.LFB110
 1531 03c5 0000 0000 		.long	.LFE110
 1532 03c9 0000 0000 		.long	.LLST18
 1533 03cd 01        		.byte	0x1
 1534 03ce 2704 0000 		.long	0x427
 1535 03d2 1A        		.uleb128 0x1a
 1536 03d3 0000 0000 		.long	.LASF33
 1537 03d7 01        		.byte	0x1
 1538 03d8 C201      		.word	0x1c2
 1539 03da 3000 0000 		.long	0x30
 1540 03de 0000 0000 		.long	.LLST19
 1541 03e2 1D        		.uleb128 0x1d
 1542 03e3 0000 0000 		.long	.LASF40
 1543 03e7 01        		.byte	0x1
 1544 03e8 C301      		.word	0x1c3
 1545 03ea 6F01 0000 		.long	0x16f
 1546 03ee 06        		.byte	0x6
 1547 03ef 66        		.byte	0x66
 1548 03f0 93        		.byte	0x93
 1549 03f1 01        		.uleb128 0x1
 1550 03f2 67        		.byte	0x67
 1551 03f3 93        		.byte	0x93
 1552 03f4 01        		.uleb128 0x1
 1553 03f5 1D        		.uleb128 0x1d
 1554 03f6 0000 0000 		.long	.LASF41
 1555 03fa 01        		.byte	0x1
 1556 03fb C301      		.word	0x1c3
 1557 03fd 3000 0000 		.long	0x30
 1558 0401 01        		.byte	0x1
 1559 0402 64        		.byte	0x64
 1560 0403 1D        		.uleb128 0x1d
 1561 0404 0000 0000 		.long	.LASF36
 1562 0408 01        		.byte	0x1
 1563 0409 C401      		.word	0x1c4
 1564 040b 6F01 0000 		.long	0x16f
 1565 040f 06        		.byte	0x6
 1566 0410 62        		.byte	0x62
 1567 0411 93        		.byte	0x93
 1568 0412 01        		.uleb128 0x1
 1569 0413 63        		.byte	0x63
 1570 0414 93        		.byte	0x93
 1571 0415 01        		.uleb128 0x1
 1572 0416 1A        		.uleb128 0x1a
 1573 0417 0000 0000 		.long	.LASF42
 1574 041b 01        		.byte	0x1
 1575 041c C401      		.word	0x1c4
 1576 041e 3000 0000 		.long	0x30
 1577 0422 0000 0000 		.long	.LLST20
 1578 0426 00        		.byte	0
 1579 0427 19        		.uleb128 0x19
 1580 0428 01        		.byte	0x1
 1581 0429 0000 0000 		.long	.LASF43
GAS LISTING /tmp/ccqx8j8N.s 			page 37


 1582 042d 02        		.byte	0x2
 1583 042e E901      		.word	0x1e9
 1584 0430 0000 0000 		.long	.LFB111
 1585 0434 0000 0000 		.long	.LFE111
 1586 0438 03        		.byte	0x3
 1587 0439 92        		.byte	0x92
 1588 043a 20        		.uleb128 0x20
 1589 043b 03        		.sleb128 3
 1590 043c 01        		.byte	0x1
 1591 043d 7A04 0000 		.long	0x47a
 1592 0441 1A        		.uleb128 0x1a
 1593 0442 0000 0000 		.long	.LASF44
 1594 0446 02        		.byte	0x2
 1595 0447 E901      		.word	0x1e9
 1596 0449 3000 0000 		.long	0x30
 1597 044d 0000 0000 		.long	.LLST21
 1598 0451 1E        		.uleb128 0x1e
 1599 0452 5F72 7300 		.string	"_rs"
 1600 0456 02        		.byte	0x2
 1601 0457 E901      		.word	0x1e9
 1602 0459 3000 0000 		.long	0x30
 1603 045d 01        		.byte	0x1
 1604 045e 66        		.byte	0x66
 1605 045f 0E        		.uleb128 0xe
 1606 0460 0000 0000 		.long	.LBB4
 1607 0464 0000 0000 		.long	.LBE4
 1608 0468 1F        		.uleb128 0x1f
 1609 0469 0000 0000 		.long	.LASF45
 1610 046d 02        		.byte	0x2
 1611 046e EB01      		.word	0x1eb
 1612 0470 3000 0000 		.long	0x30
 1613 0474 0000 0000 		.long	.LLST22
 1614 0478 00        		.byte	0
 1615 0479 00        		.byte	0
 1616 047a 16        		.uleb128 0x16
 1617 047b 01        		.byte	0x1
 1618 047c 0000 0000 		.long	.LASF46
 1619 0480 02        		.byte	0x2
 1620 0481 FE01      		.word	0x1fe
 1621 0483 0000 0000 		.long	.LFB112
 1622 0487 0000 0000 		.long	.LFE112
 1623 048b 0000 0000 		.long	.LLST23
 1624 048f 01        		.byte	0x1
 1625 0490 2505 0000 		.long	0x525
 1626 0494 20        		.uleb128 0x20
 1627 0495 6275 6600 		.string	"buf"
 1628 0499 02        		.byte	0x2
 1629 049a FE01      		.word	0x1fe
 1630 049c 8900 0000 		.long	0x89
 1631 04a0 0000 0000 		.long	.LLST24
 1632 04a4 20        		.uleb128 0x20
 1633 04a5 6C65 6E00 		.string	"len"
 1634 04a9 02        		.byte	0x2
 1635 04aa FE01      		.word	0x1fe
 1636 04ac 3000 0000 		.long	0x30
 1637 04b0 0000 0000 		.long	.LLST25
 1638 04b4 0E        		.uleb128 0xe
GAS LISTING /tmp/ccqx8j8N.s 			page 38


 1639 04b5 0000 0000 		.long	.LBB5
 1640 04b9 0000 0000 		.long	.LBE5
 1641 04bd 18        		.uleb128 0x18
 1642 04be 5F62 00   		.string	"_b"
 1643 04c1 02        		.byte	0x2
 1644 04c2 0002      		.word	0x200
 1645 04c4 6F01 0000 		.long	0x16f
 1646 04c8 0000 0000 		.long	.LLST26
 1647 04cc 18        		.uleb128 0x18
 1648 04cd 5F6C 00   		.string	"_l"
 1649 04d0 02        		.byte	0x2
 1650 04d1 0102      		.word	0x201
 1651 04d3 3000 0000 		.long	0x30
 1652 04d7 0000 0000 		.long	.LLST27
 1653 04db 21        		.uleb128 0x21
 1654 04dc 0000 0000 		.long	.LVL53
 1655 04e0 2704 0000 		.long	0x427
 1656 04e4 EE04 0000 		.long	0x4ee
 1657 04e8 13        		.uleb128 0x13
 1658 04e9 01        		.byte	0x1
 1659 04ea 66        		.byte	0x66
 1660 04eb 01        		.byte	0x1
 1661 04ec 31        		.byte	0x31
 1662 04ed 00        		.byte	0
 1663 04ee 21        		.uleb128 0x21
 1664 04ef 0000 0000 		.long	.LVL54
 1665 04f3 ED02 0000 		.long	0x2ed
 1666 04f7 0F05 0000 		.long	0x50f
 1667 04fb 13        		.uleb128 0x13
 1668 04fc 06        		.byte	0x6
 1669 04fd 66        		.byte	0x66
 1670 04fe 93        		.byte	0x93
 1671 04ff 01        		.uleb128 0x1
 1672 0500 67        		.byte	0x67
 1673 0501 93        		.byte	0x93
 1674 0502 01        		.uleb128 0x1
 1675 0503 05        		.byte	0x5
 1676 0504 03        		.byte	0x3
 1677 0505 0000 0000 		.long	lcdBuffer
 1678 0509 13        		.uleb128 0x13
 1679 050a 01        		.byte	0x1
 1680 050b 64        		.byte	0x64
 1681 050c 01        		.byte	0x1
 1682 050d 36        		.byte	0x36
 1683 050e 00        		.byte	0
 1684 050f 12        		.uleb128 0x12
 1685 0510 0000 0000 		.long	.LVL55
 1686 0514 110B 0000 		.long	0xb11
 1687 0518 13        		.uleb128 0x13
 1688 0519 06        		.byte	0x6
 1689 051a 68        		.byte	0x68
 1690 051b 93        		.byte	0x93
 1691 051c 01        		.uleb128 0x1
 1692 051d 69        		.byte	0x69
 1693 051e 93        		.byte	0x93
 1694 051f 01        		.uleb128 0x1
 1695 0520 01        		.byte	0x1
GAS LISTING /tmp/ccqx8j8N.s 			page 39


 1696 0521 35        		.byte	0x35
 1697 0522 00        		.byte	0
 1698 0523 00        		.byte	0
 1699 0524 00        		.byte	0
 1700 0525 19        		.uleb128 0x19
 1701 0526 01        		.byte	0x1
 1702 0527 0000 0000 		.long	.LASF47
 1703 052b 02        		.byte	0x2
 1704 052c 0B02      		.word	0x20b
 1705 052e 0000 0000 		.long	.LFB113
 1706 0532 0000 0000 		.long	.LFE113
 1707 0536 03        		.byte	0x3
 1708 0537 92        		.byte	0x92
 1709 0538 20        		.uleb128 0x20
 1710 0539 03        		.sleb128 3
 1711 053a 01        		.byte	0x1
 1712 053b DB06 0000 		.long	0x6db
 1713 053f 21        		.uleb128 0x21
 1714 0540 0000 0000 		.long	.LVL58
 1715 0544 2704 0000 		.long	0x427
 1716 0548 5205 0000 		.long	0x552
 1717 054c 13        		.uleb128 0x13
 1718 054d 01        		.byte	0x1
 1719 054e 66        		.byte	0x66
 1720 054f 01        		.byte	0x1
 1721 0550 30        		.byte	0x30
 1722 0551 00        		.byte	0
 1723 0552 21        		.uleb128 0x21
 1724 0553 0000 0000 		.long	.LVL59
 1725 0557 ED02 0000 		.long	0x2ed
 1726 055b 7305 0000 		.long	0x573
 1727 055f 13        		.uleb128 0x13
 1728 0560 06        		.byte	0x6
 1729 0561 66        		.byte	0x66
 1730 0562 93        		.byte	0x93
 1731 0563 01        		.uleb128 0x1
 1732 0564 67        		.byte	0x67
 1733 0565 93        		.byte	0x93
 1734 0566 01        		.uleb128 0x1
 1735 0567 05        		.byte	0x5
 1736 0568 03        		.byte	0x3
 1737 0569 0000 0000 		.long	lcdBuffer
 1738 056d 13        		.uleb128 0x13
 1739 056e 01        		.byte	0x1
 1740 056f 64        		.byte	0x64
 1741 0570 01        		.byte	0x1
 1742 0571 36        		.byte	0x36
 1743 0572 00        		.byte	0
 1744 0573 21        		.uleb128 0x21
 1745 0574 0000 0000 		.long	.LVL60
 1746 0578 110B 0000 		.long	0xb11
 1747 057c 8B05 0000 		.long	0x58b
 1748 0580 13        		.uleb128 0x13
 1749 0581 06        		.byte	0x6
 1750 0582 68        		.byte	0x68
 1751 0583 93        		.byte	0x93
 1752 0584 01        		.uleb128 0x1
GAS LISTING /tmp/ccqx8j8N.s 			page 40


 1753 0585 69        		.byte	0x69
 1754 0586 93        		.byte	0x93
 1755 0587 01        		.uleb128 0x1
 1756 0588 01        		.byte	0x1
 1757 0589 35        		.byte	0x35
 1758 058a 00        		.byte	0
 1759 058b 21        		.uleb128 0x21
 1760 058c 0000 0000 		.long	.LVL61
 1761 0590 2704 0000 		.long	0x427
 1762 0594 9E05 0000 		.long	0x59e
 1763 0598 13        		.uleb128 0x13
 1764 0599 01        		.byte	0x1
 1765 059a 66        		.byte	0x66
 1766 059b 01        		.byte	0x1
 1767 059c 30        		.byte	0x30
 1768 059d 00        		.byte	0
 1769 059e 21        		.uleb128 0x21
 1770 059f 0000 0000 		.long	.LVL62
 1771 05a3 ED02 0000 		.long	0x2ed
 1772 05a7 BF05 0000 		.long	0x5bf
 1773 05ab 13        		.uleb128 0x13
 1774 05ac 06        		.byte	0x6
 1775 05ad 66        		.byte	0x66
 1776 05ae 93        		.byte	0x93
 1777 05af 01        		.uleb128 0x1
 1778 05b0 67        		.byte	0x67
 1779 05b1 93        		.byte	0x93
 1780 05b2 01        		.uleb128 0x1
 1781 05b3 05        		.byte	0x5
 1782 05b4 03        		.byte	0x3
 1783 05b5 0000 0000 		.long	lcdBuffer
 1784 05b9 13        		.uleb128 0x13
 1785 05ba 01        		.byte	0x1
 1786 05bb 64        		.byte	0x64
 1787 05bc 01        		.byte	0x1
 1788 05bd 36        		.byte	0x36
 1789 05be 00        		.byte	0
 1790 05bf 21        		.uleb128 0x21
 1791 05c0 0000 0000 		.long	.LVL63
 1792 05c4 110B 0000 		.long	0xb11
 1793 05c8 D705 0000 		.long	0x5d7
 1794 05cc 13        		.uleb128 0x13
 1795 05cd 06        		.byte	0x6
 1796 05ce 68        		.byte	0x68
 1797 05cf 93        		.byte	0x93
 1798 05d0 01        		.uleb128 0x1
 1799 05d1 69        		.byte	0x69
 1800 05d2 93        		.byte	0x93
 1801 05d3 01        		.uleb128 0x1
 1802 05d4 01        		.byte	0x1
 1803 05d5 35        		.byte	0x35
 1804 05d6 00        		.byte	0
 1805 05d7 21        		.uleb128 0x21
 1806 05d8 0000 0000 		.long	.LVL64
 1807 05dc 2704 0000 		.long	0x427
 1808 05e0 EA05 0000 		.long	0x5ea
 1809 05e4 13        		.uleb128 0x13
GAS LISTING /tmp/ccqx8j8N.s 			page 41


 1810 05e5 01        		.byte	0x1
 1811 05e6 66        		.byte	0x66
 1812 05e7 01        		.byte	0x1
 1813 05e8 30        		.byte	0x30
 1814 05e9 00        		.byte	0
 1815 05ea 21        		.uleb128 0x21
 1816 05eb 0000 0000 		.long	.LVL65
 1817 05ef ED02 0000 		.long	0x2ed
 1818 05f3 0B06 0000 		.long	0x60b
 1819 05f7 13        		.uleb128 0x13
 1820 05f8 06        		.byte	0x6
 1821 05f9 66        		.byte	0x66
 1822 05fa 93        		.byte	0x93
 1823 05fb 01        		.uleb128 0x1
 1824 05fc 67        		.byte	0x67
 1825 05fd 93        		.byte	0x93
 1826 05fe 01        		.uleb128 0x1
 1827 05ff 05        		.byte	0x5
 1828 0600 03        		.byte	0x3
 1829 0601 0000 0000 		.long	lcdBuffer
 1830 0605 13        		.uleb128 0x13
 1831 0606 01        		.byte	0x1
 1832 0607 64        		.byte	0x64
 1833 0608 01        		.byte	0x1
 1834 0609 36        		.byte	0x36
 1835 060a 00        		.byte	0
 1836 060b 21        		.uleb128 0x21
 1837 060c 0000 0000 		.long	.LVL66
 1838 0610 110B 0000 		.long	0xb11
 1839 0614 2306 0000 		.long	0x623
 1840 0618 13        		.uleb128 0x13
 1841 0619 06        		.byte	0x6
 1842 061a 68        		.byte	0x68
 1843 061b 93        		.byte	0x93
 1844 061c 01        		.uleb128 0x1
 1845 061d 69        		.byte	0x69
 1846 061e 93        		.byte	0x93
 1847 061f 01        		.uleb128 0x1
 1848 0620 01        		.byte	0x1
 1849 0621 35        		.byte	0x35
 1850 0622 00        		.byte	0
 1851 0623 21        		.uleb128 0x21
 1852 0624 0000 0000 		.long	.LVL67
 1853 0628 2704 0000 		.long	0x427
 1854 062c 3B06 0000 		.long	0x63b
 1855 0630 13        		.uleb128 0x13
 1856 0631 01        		.byte	0x1
 1857 0632 68        		.byte	0x68
 1858 0633 01        		.byte	0x1
 1859 0634 31        		.byte	0x31
 1860 0635 13        		.uleb128 0x13
 1861 0636 01        		.byte	0x1
 1862 0637 66        		.byte	0x66
 1863 0638 01        		.byte	0x1
 1864 0639 30        		.byte	0x30
 1865 063a 00        		.byte	0
 1866 063b 21        		.uleb128 0x21
GAS LISTING /tmp/ccqx8j8N.s 			page 42


 1867 063c 0000 0000 		.long	.LVL68
 1868 0640 ED02 0000 		.long	0x2ed
 1869 0644 5C06 0000 		.long	0x65c
 1870 0648 13        		.uleb128 0x13
 1871 0649 06        		.byte	0x6
 1872 064a 66        		.byte	0x66
 1873 064b 93        		.byte	0x93
 1874 064c 01        		.uleb128 0x1
 1875 064d 67        		.byte	0x67
 1876 064e 93        		.byte	0x93
 1877 064f 01        		.uleb128 0x1
 1878 0650 05        		.byte	0x5
 1879 0651 03        		.byte	0x3
 1880 0652 0000 0000 		.long	lcdBuffer
 1881 0656 13        		.uleb128 0x13
 1882 0657 01        		.byte	0x1
 1883 0658 64        		.byte	0x64
 1884 0659 01        		.byte	0x1
 1885 065a 36        		.byte	0x36
 1886 065b 00        		.byte	0
 1887 065c 21        		.uleb128 0x21
 1888 065d 0000 0000 		.long	.LVL69
 1889 0661 110B 0000 		.long	0xb11
 1890 0665 7406 0000 		.long	0x674
 1891 0669 13        		.uleb128 0x13
 1892 066a 06        		.byte	0x6
 1893 066b 68        		.byte	0x68
 1894 066c 93        		.byte	0x93
 1895 066d 01        		.uleb128 0x1
 1896 066e 69        		.byte	0x69
 1897 066f 93        		.byte	0x93
 1898 0670 01        		.uleb128 0x1
 1899 0671 01        		.byte	0x1
 1900 0672 35        		.byte	0x35
 1901 0673 00        		.byte	0
 1902 0674 21        		.uleb128 0x21
 1903 0675 0000 0000 		.long	.LVL70
 1904 0679 110B 0000 		.long	0xb11
 1905 067d 8C06 0000 		.long	0x68c
 1906 0681 13        		.uleb128 0x13
 1907 0682 06        		.byte	0x6
 1908 0683 68        		.byte	0x68
 1909 0684 93        		.byte	0x93
 1910 0685 01        		.uleb128 0x1
 1911 0686 69        		.byte	0x69
 1912 0687 93        		.byte	0x93
 1913 0688 01        		.uleb128 0x1
 1914 0689 01        		.byte	0x1
 1915 068a 40        		.byte	0x40
 1916 068b 00        		.byte	0
 1917 068c 21        		.uleb128 0x21
 1918 068d 0000 0000 		.long	.LVL71
 1919 0691 2704 0000 		.long	0x427
 1920 0695 A406 0000 		.long	0x6a4
 1921 0699 13        		.uleb128 0x13
 1922 069a 01        		.byte	0x1
 1923 069b 68        		.byte	0x68
GAS LISTING /tmp/ccqx8j8N.s 			page 43


 1924 069c 01        		.byte	0x1
 1925 069d 32        		.byte	0x32
 1926 069e 13        		.uleb128 0x13
 1927 069f 01        		.byte	0x1
 1928 06a0 66        		.byte	0x66
 1929 06a1 01        		.byte	0x1
 1930 06a2 30        		.byte	0x30
 1931 06a3 00        		.byte	0
 1932 06a4 21        		.uleb128 0x21
 1933 06a5 0000 0000 		.long	.LVL72
 1934 06a9 ED02 0000 		.long	0x2ed
 1935 06ad C506 0000 		.long	0x6c5
 1936 06b1 13        		.uleb128 0x13
 1937 06b2 06        		.byte	0x6
 1938 06b3 66        		.byte	0x66
 1939 06b4 93        		.byte	0x93
 1940 06b5 01        		.uleb128 0x1
 1941 06b6 67        		.byte	0x67
 1942 06b7 93        		.byte	0x93
 1943 06b8 01        		.uleb128 0x1
 1944 06b9 05        		.byte	0x5
 1945 06ba 03        		.byte	0x3
 1946 06bb 0000 0000 		.long	lcdBuffer
 1947 06bf 13        		.uleb128 0x13
 1948 06c0 01        		.byte	0x1
 1949 06c1 64        		.byte	0x64
 1950 06c2 01        		.byte	0x1
 1951 06c3 36        		.byte	0x36
 1952 06c4 00        		.byte	0
 1953 06c5 1B        		.uleb128 0x1b
 1954 06c6 0000 0000 		.long	.LVL73
 1955 06ca 01        		.byte	0x1
 1956 06cb 110B 0000 		.long	0xb11
 1957 06cf 13        		.uleb128 0x13
 1958 06d0 06        		.byte	0x6
 1959 06d1 68        		.byte	0x68
 1960 06d2 93        		.byte	0x93
 1961 06d3 01        		.uleb128 0x1
 1962 06d4 69        		.byte	0x69
 1963 06d5 93        		.byte	0x93
 1964 06d6 01        		.uleb128 0x1
 1965 06d7 01        		.byte	0x1
 1966 06d8 35        		.byte	0x35
 1967 06d9 00        		.byte	0
 1968 06da 00        		.byte	0
 1969 06db 16        		.uleb128 0x16
 1970 06dc 01        		.byte	0x1
 1971 06dd 0000 0000 		.long	.LASF48
 1972 06e1 02        		.byte	0x2
 1973 06e2 1702      		.word	0x217
 1974 06e4 0000 0000 		.long	.LFB114
 1975 06e8 0000 0000 		.long	.LFE114
 1976 06ec 0000 0000 		.long	.LLST28
 1977 06f0 01        		.byte	0x1
 1978 06f1 C308 0000 		.long	0x8c3
 1979 06f5 1A        		.uleb128 0x1a
 1980 06f6 0000 0000 		.long	.LASF49
GAS LISTING /tmp/ccqx8j8N.s 			page 44


 1981 06fa 02        		.byte	0x2
 1982 06fb 1702      		.word	0x217
 1983 06fd 3000 0000 		.long	0x30
 1984 0701 0000 0000 		.long	.LLST29
 1985 0705 1A        		.uleb128 0x1a
 1986 0706 0000 0000 		.long	.LASF50
 1987 070a 02        		.byte	0x2
 1988 070b 1702      		.word	0x217
 1989 070d 3000 0000 		.long	0x30
 1990 0711 0000 0000 		.long	.LLST30
 1991 0715 1A        		.uleb128 0x1a
 1992 0716 0000 0000 		.long	.LASF51
 1993 071a 02        		.byte	0x2
 1994 071b 1702      		.word	0x217
 1995 071d 3000 0000 		.long	0x30
 1996 0721 0000 0000 		.long	.LLST31
 1997 0725 1A        		.uleb128 0x1a
 1998 0726 0000 0000 		.long	.LASF52
 1999 072a 02        		.byte	0x2
 2000 072b 1702      		.word	0x217
 2001 072d 3000 0000 		.long	0x30
 2002 0731 0000 0000 		.long	.LLST32
 2003 0735 21        		.uleb128 0x21
 2004 0736 0000 0000 		.long	.LVL80
 2005 073a C901 0000 		.long	0x1c9
 2006 073e 5C07 0000 		.long	0x75c
 2007 0742 13        		.uleb128 0x13
 2008 0743 0C        		.byte	0xc
 2009 0744 66        		.byte	0x66
 2010 0745 93        		.byte	0x93
 2011 0746 01        		.uleb128 0x1
 2012 0747 67        		.byte	0x67
 2013 0748 93        		.byte	0x93
 2014 0749 01        		.uleb128 0x1
 2015 074a 68        		.byte	0x68
 2016 074b 93        		.byte	0x93
 2017 074c 01        		.uleb128 0x1
 2018 074d 69        		.byte	0x69
 2019 074e 93        		.byte	0x93
 2020 074f 01        		.uleb128 0x1
 2021 0750 05        		.byte	0x5
 2022 0751 0C        		.byte	0xc
 2023 0752 A086 0100 		.long	0x186a0
 2024 0756 13        		.uleb128 0x13
 2025 0757 01        		.byte	0x1
 2026 0758 64        		.byte	0x64
 2027 0759 01        		.byte	0x1
 2028 075a 36        		.byte	0x36
 2029 075b 00        		.byte	0
 2030 075c 21        		.uleb128 0x21
 2031 075d 0000 0000 		.long	.LVL81
 2032 0761 2704 0000 		.long	0x427
 2033 0765 7507 0000 		.long	0x775
 2034 0769 13        		.uleb128 0x13
 2035 076a 01        		.byte	0x1
 2036 076b 68        		.byte	0x68
 2037 076c 02        		.byte	0x2
GAS LISTING /tmp/ccqx8j8N.s 			page 45


 2038 076d 08        		.byte	0x8
 2039 076e 30        		.byte	0x30
 2040 076f 13        		.uleb128 0x13
 2041 0770 01        		.byte	0x1
 2042 0771 66        		.byte	0x66
 2043 0772 01        		.byte	0x1
 2044 0773 30        		.byte	0x30
 2045 0774 00        		.byte	0
 2046 0775 21        		.uleb128 0x21
 2047 0776 0000 0000 		.long	.LVL82
 2048 077a 110B 0000 		.long	0xb11
 2049 077e 8D07 0000 		.long	0x78d
 2050 0782 13        		.uleb128 0x13
 2051 0783 06        		.byte	0x6
 2052 0784 68        		.byte	0x68
 2053 0785 93        		.byte	0x93
 2054 0786 01        		.uleb128 0x1
 2055 0787 69        		.byte	0x69
 2056 0788 93        		.byte	0x93
 2057 0789 01        		.uleb128 0x1
 2058 078a 01        		.byte	0x1
 2059 078b 3F        		.byte	0x3f
 2060 078c 00        		.byte	0
 2061 078d 21        		.uleb128 0x21
 2062 078e 0000 0000 		.long	.LVL83
 2063 0792 ED02 0000 		.long	0x2ed
 2064 0796 AE07 0000 		.long	0x7ae
 2065 079a 13        		.uleb128 0x13
 2066 079b 06        		.byte	0x6
 2067 079c 66        		.byte	0x66
 2068 079d 93        		.byte	0x93
 2069 079e 01        		.uleb128 0x1
 2070 079f 67        		.byte	0x67
 2071 07a0 93        		.byte	0x93
 2072 07a1 01        		.uleb128 0x1
 2073 07a2 05        		.byte	0x5
 2074 07a3 03        		.byte	0x3
 2075 07a4 0000 0000 		.long	lcdBuffer
 2076 07a8 13        		.uleb128 0x13
 2077 07a9 01        		.byte	0x1
 2078 07aa 64        		.byte	0x64
 2079 07ab 01        		.byte	0x1
 2080 07ac 33        		.byte	0x33
 2081 07ad 00        		.byte	0
 2082 07ae 21        		.uleb128 0x21
 2083 07af 0000 0000 		.long	.LVL84
 2084 07b3 110B 0000 		.long	0xb11
 2085 07b7 C607 0000 		.long	0x7c6
 2086 07bb 13        		.uleb128 0x13
 2087 07bc 06        		.byte	0x6
 2088 07bd 68        		.byte	0x68
 2089 07be 93        		.byte	0x93
 2090 07bf 01        		.uleb128 0x1
 2091 07c0 69        		.byte	0x69
 2092 07c1 93        		.byte	0x93
 2093 07c2 01        		.uleb128 0x1
 2094 07c3 01        		.byte	0x1
GAS LISTING /tmp/ccqx8j8N.s 			page 46


 2095 07c4 35        		.byte	0x35
 2096 07c5 00        		.byte	0
 2097 07c6 21        		.uleb128 0x21
 2098 07c7 0000 0000 		.long	.LVL85
 2099 07cb 110B 0000 		.long	0xb11
 2100 07cf DE07 0000 		.long	0x7de
 2101 07d3 13        		.uleb128 0x13
 2102 07d4 06        		.byte	0x6
 2103 07d5 68        		.byte	0x68
 2104 07d6 93        		.byte	0x93
 2105 07d7 01        		.uleb128 0x1
 2106 07d8 69        		.byte	0x69
 2107 07d9 93        		.byte	0x93
 2108 07da 01        		.uleb128 0x1
 2109 07db 01        		.byte	0x1
 2110 07dc 35        		.byte	0x35
 2111 07dd 00        		.byte	0
 2112 07de 21        		.uleb128 0x21
 2113 07df 0000 0000 		.long	.LVL86
 2114 07e3 ED02 0000 		.long	0x2ed
 2115 07e7 FF07 0000 		.long	0x7ff
 2116 07eb 13        		.uleb128 0x13
 2117 07ec 06        		.byte	0x6
 2118 07ed 66        		.byte	0x66
 2119 07ee 93        		.byte	0x93
 2120 07ef 01        		.uleb128 0x1
 2121 07f0 67        		.byte	0x67
 2122 07f1 93        		.byte	0x93
 2123 07f2 01        		.uleb128 0x1
 2124 07f3 05        		.byte	0x5
 2125 07f4 03        		.byte	0x3
 2126 07f5 0000 0000 		.long	lcdBuffer
 2127 07f9 13        		.uleb128 0x13
 2128 07fa 01        		.byte	0x1
 2129 07fb 64        		.byte	0x64
 2130 07fc 01        		.byte	0x1
 2131 07fd 33        		.byte	0x33
 2132 07fe 00        		.byte	0
 2133 07ff 21        		.uleb128 0x21
 2134 0800 0000 0000 		.long	.LVL87
 2135 0804 110B 0000 		.long	0xb11
 2136 0808 1708 0000 		.long	0x817
 2137 080c 13        		.uleb128 0x13
 2138 080d 06        		.byte	0x6
 2139 080e 68        		.byte	0x68
 2140 080f 93        		.byte	0x93
 2141 0810 01        		.uleb128 0x1
 2142 0811 69        		.byte	0x69
 2143 0812 93        		.byte	0x93
 2144 0813 01        		.uleb128 0x1
 2145 0814 01        		.byte	0x1
 2146 0815 35        		.byte	0x35
 2147 0816 00        		.byte	0
 2148 0817 21        		.uleb128 0x21
 2149 0818 0000 0000 		.long	.LVL88
 2150 081c ED02 0000 		.long	0x2ed
 2151 0820 3808 0000 		.long	0x838
GAS LISTING /tmp/ccqx8j8N.s 			page 47


 2152 0824 13        		.uleb128 0x13
 2153 0825 06        		.byte	0x6
 2154 0826 66        		.byte	0x66
 2155 0827 93        		.byte	0x93
 2156 0828 01        		.uleb128 0x1
 2157 0829 67        		.byte	0x67
 2158 082a 93        		.byte	0x93
 2159 082b 01        		.uleb128 0x1
 2160 082c 05        		.byte	0x5
 2161 082d 03        		.byte	0x3
 2162 082e 0000 0000 		.long	lcdBuffer
 2163 0832 13        		.uleb128 0x13
 2164 0833 01        		.byte	0x1
 2165 0834 64        		.byte	0x64
 2166 0835 01        		.byte	0x1
 2167 0836 33        		.byte	0x33
 2168 0837 00        		.byte	0
 2169 0838 21        		.uleb128 0x21
 2170 0839 0000 0000 		.long	.LVL89
 2171 083d 110B 0000 		.long	0xb11
 2172 0841 5008 0000 		.long	0x850
 2173 0845 13        		.uleb128 0x13
 2174 0846 06        		.byte	0x6
 2175 0847 68        		.byte	0x68
 2176 0848 93        		.byte	0x93
 2177 0849 01        		.uleb128 0x1
 2178 084a 69        		.byte	0x69
 2179 084b 93        		.byte	0x93
 2180 084c 01        		.uleb128 0x1
 2181 084d 01        		.byte	0x1
 2182 084e 35        		.byte	0x35
 2183 084f 00        		.byte	0
 2184 0850 21        		.uleb128 0x21
 2185 0851 0000 0000 		.long	.LVL90
 2186 0855 2704 0000 		.long	0x427
 2187 0859 6908 0000 		.long	0x869
 2188 085d 13        		.uleb128 0x13
 2189 085e 01        		.byte	0x1
 2190 085f 68        		.byte	0x68
 2191 0860 02        		.byte	0x2
 2192 0861 08        		.byte	0x8
 2193 0862 20        		.byte	0x20
 2194 0863 13        		.uleb128 0x13
 2195 0864 01        		.byte	0x1
 2196 0865 66        		.byte	0x66
 2197 0866 01        		.byte	0x1
 2198 0867 30        		.byte	0x30
 2199 0868 00        		.byte	0
 2200 0869 21        		.uleb128 0x21
 2201 086a 0000 0000 		.long	.LVL91
 2202 086e ED02 0000 		.long	0x2ed
 2203 0872 8A08 0000 		.long	0x88a
 2204 0876 13        		.uleb128 0x13
 2205 0877 06        		.byte	0x6
 2206 0878 66        		.byte	0x66
 2207 0879 93        		.byte	0x93
 2208 087a 01        		.uleb128 0x1
GAS LISTING /tmp/ccqx8j8N.s 			page 48


 2209 087b 67        		.byte	0x67
 2210 087c 93        		.byte	0x93
 2211 087d 01        		.uleb128 0x1
 2212 087e 05        		.byte	0x5
 2213 087f 03        		.byte	0x3
 2214 0880 0000 0000 		.long	lcdBuffer
 2215 0884 13        		.uleb128 0x13
 2216 0885 01        		.byte	0x1
 2217 0886 64        		.byte	0x64
 2218 0887 01        		.byte	0x1
 2219 0888 33        		.byte	0x33
 2220 0889 00        		.byte	0
 2221 088a 21        		.uleb128 0x21
 2222 088b 0000 0000 		.long	.LVL92
 2223 088f 110B 0000 		.long	0xb11
 2224 0893 A208 0000 		.long	0x8a2
 2225 0897 13        		.uleb128 0x13
 2226 0898 06        		.byte	0x6
 2227 0899 68        		.byte	0x68
 2228 089a 93        		.byte	0x93
 2229 089b 01        		.uleb128 0x1
 2230 089c 69        		.byte	0x69
 2231 089d 93        		.byte	0x93
 2232 089e 01        		.uleb128 0x1
 2233 089f 01        		.byte	0x1
 2234 08a0 35        		.byte	0x35
 2235 08a1 00        		.byte	0
 2236 08a2 22        		.uleb128 0x22
 2237 08a3 0000 0000 		.long	.LVL93
 2238 08a7 2505 0000 		.long	0x525
 2239 08ab 1B        		.uleb128 0x1b
 2240 08ac 0000 0000 		.long	.LVL95
 2241 08b0 01        		.byte	0x1
 2242 08b1 110B 0000 		.long	0xb11
 2243 08b5 13        		.uleb128 0x13
 2244 08b6 06        		.byte	0x6
 2245 08b7 68        		.byte	0x68
 2246 08b8 93        		.byte	0x93
 2247 08b9 01        		.uleb128 0x1
 2248 08ba 69        		.byte	0x69
 2249 08bb 93        		.byte	0x93
 2250 08bc 01        		.uleb128 0x1
 2251 08bd 03        		.byte	0x3
 2252 08be 0A        		.byte	0xa
 2253 08bf F401      		.word	0x1f4
 2254 08c1 00        		.byte	0
 2255 08c2 00        		.byte	0
 2256 08c3 19        		.uleb128 0x19
 2257 08c4 01        		.byte	0x1
 2258 08c5 0000 0000 		.long	.LASF53
 2259 08c9 02        		.byte	0x2
 2260 08ca 4102      		.word	0x241
 2261 08cc 0000 0000 		.long	.LFB115
 2262 08d0 0000 0000 		.long	.LFE115
 2263 08d4 03        		.byte	0x3
 2264 08d5 92        		.byte	0x92
 2265 08d6 20        		.uleb128 0x20
GAS LISTING /tmp/ccqx8j8N.s 			page 49


 2266 08d7 03        		.sleb128 3
 2267 08d8 01        		.byte	0x1
 2268 08d9 3509 0000 		.long	0x935
 2269 08dd 0E        		.uleb128 0xe
 2270 08de 0000 0000 		.long	.LBB6
 2271 08e2 0000 0000 		.long	.LBE6
 2272 08e6 23        		.uleb128 0x23
 2273 08e7 0000 0000 		.long	.LASF54
 2274 08eb 02        		.byte	0x2
 2275 08ec 4202      		.word	0x242
 2276 08ee 4900 0000 		.long	0x49
 2277 08f2 21        		.uleb128 0x21
 2278 08f3 0000 0000 		.long	.LVL96
 2279 08f7 DB06 0000 		.long	0x6db
 2280 08fb 1509 0000 		.long	0x915
 2281 08ff 13        		.uleb128 0x13
 2282 0900 01        		.byte	0x1
 2283 0901 68        		.byte	0x68
 2284 0902 02        		.byte	0x2
 2285 0903 08        		.byte	0x8
 2286 0904 27        		.byte	0x27
 2287 0905 13        		.uleb128 0x13
 2288 0906 01        		.byte	0x1
 2289 0907 66        		.byte	0x66
 2290 0908 01        		.byte	0x1
 2291 0909 40        		.byte	0x40
 2292 090a 13        		.uleb128 0x13
 2293 090b 01        		.byte	0x1
 2294 090c 64        		.byte	0x64
 2295 090d 01        		.byte	0x1
 2296 090e 32        		.byte	0x32
 2297 090f 13        		.uleb128 0x13
 2298 0910 01        		.byte	0x1
 2299 0911 62        		.byte	0x62
 2300 0912 01        		.byte	0x1
 2301 0913 31        		.byte	0x31
 2302 0914 00        		.byte	0
 2303 0915 1B        		.uleb128 0x1b
 2304 0916 0000 0000 		.long	.LVL97
 2305 091a 01        		.byte	0x1
 2306 091b 7A04 0000 		.long	0x47a
 2307 091f 13        		.uleb128 0x13
 2308 0920 06        		.byte	0x6
 2309 0921 68        		.byte	0x68
 2310 0922 93        		.byte	0x93
 2311 0923 01        		.uleb128 0x1
 2312 0924 69        		.byte	0x69
 2313 0925 93        		.byte	0x93
 2314 0926 01        		.uleb128 0x1
 2315 0927 05        		.byte	0x5
 2316 0928 03        		.byte	0x3
 2317 0929 0000 0000 		.long	.LC0
 2318 092d 13        		.uleb128 0x13
 2319 092e 01        		.byte	0x1
 2320 092f 66        		.byte	0x66
 2321 0930 01        		.byte	0x1
 2322 0931 3D        		.byte	0x3d
GAS LISTING /tmp/ccqx8j8N.s 			page 50


 2323 0932 00        		.byte	0
 2324 0933 00        		.byte	0
 2325 0934 00        		.byte	0
 2326 0935 24        		.uleb128 0x24
 2327 0936 01        		.byte	0x1
 2328 0937 0000 0000 		.long	.LASF83
 2329 093b 02        		.byte	0x2
 2330 093c 4C02      		.word	0x24c
 2331 093e 0000 0000 		.long	.LFB116
 2332 0942 0000 0000 		.long	.LFE116
 2333 0946 03        		.byte	0x3
 2334 0947 92        		.byte	0x92
 2335 0948 20        		.uleb128 0x20
 2336 0949 03        		.sleb128 3
 2337 094a 01        		.byte	0x1
 2338 094b 25        		.uleb128 0x25
 2339 094c 0000 0000 		.long	.LASF55
 2340 0950 01        		.byte	0x1
 2341 0951 92        		.byte	0x92
 2342 0952 5D09 0000 		.long	0x95d
 2343 0956 01        		.byte	0x1
 2344 0957 05        		.byte	0x5
 2345 0958 03        		.byte	0x3
 2346 0959 0000 0000 		.long	twiMode
 2347 095d 26        		.uleb128 0x26
 2348 095e 3000 0000 		.long	0x30
 2349 0962 25        		.uleb128 0x25
 2350 0963 0000 0000 		.long	.LASF56
 2351 0967 01        		.byte	0x1
 2352 0968 93        		.byte	0x93
 2353 0969 5D09 0000 		.long	0x95d
 2354 096d 01        		.byte	0x1
 2355 096e 05        		.byte	0x5
 2356 096f 03        		.byte	0x3
 2357 0970 0000 0000 		.long	twiState
 2358 0974 25        		.uleb128 0x25
 2359 0975 0000 0000 		.long	.LASF57
 2360 0979 01        		.byte	0x1
 2361 097a 94        		.byte	0x94
 2362 097b 5D09 0000 		.long	0x95d
 2363 097f 01        		.byte	0x1
 2364 0980 05        		.byte	0x5
 2365 0981 03        		.byte	0x3
 2366 0982 0000 0000 		.long	twiSLARW
 2367 0986 25        		.uleb128 0x25
 2368 0987 0000 0000 		.long	.LASF58
 2369 098b 01        		.byte	0x1
 2370 098c 96        		.byte	0x96
 2371 098d 9809 0000 		.long	0x998
 2372 0991 01        		.byte	0x1
 2373 0992 05        		.byte	0x5
 2374 0993 03        		.byte	0x3
 2375 0994 0000 0000 		.long	twiMT_Count
 2376 0998 26        		.uleb128 0x26
 2377 0999 4900 0000 		.long	0x49
 2378 099d 25        		.uleb128 0x25
 2379 099e 0000 0000 		.long	.LASF59
GAS LISTING /tmp/ccqx8j8N.s 			page 51


 2380 09a2 01        		.byte	0x1
 2381 09a3 97        		.byte	0x97
 2382 09a4 AF09 0000 		.long	0x9af
 2383 09a8 01        		.byte	0x1
 2384 09a9 05        		.byte	0x5
 2385 09aa 03        		.byte	0x3
 2386 09ab 0000 0000 		.long	twiMT_Ptr
 2387 09af 05        		.uleb128 0x5
 2388 09b0 02        		.byte	0x2
 2389 09b1 5D09 0000 		.long	0x95d
 2390 09b5 25        		.uleb128 0x25
 2391 09b6 0000 0000 		.long	.LASF60
 2392 09ba 01        		.byte	0x1
 2393 09bb 99        		.byte	0x99
 2394 09bc 9809 0000 		.long	0x998
 2395 09c0 01        		.byte	0x1
 2396 09c1 05        		.byte	0x5
 2397 09c2 03        		.byte	0x3
 2398 09c3 0000 0000 		.long	twiRX_Count
 2399 09c7 25        		.uleb128 0x25
 2400 09c8 0000 0000 		.long	.LASF61
 2401 09cc 01        		.byte	0x1
 2402 09cd 9A        		.byte	0x9a
 2403 09ce AF09 0000 		.long	0x9af
 2404 09d2 01        		.byte	0x1
 2405 09d3 05        		.byte	0x5
 2406 09d4 03        		.byte	0x3
 2407 09d5 0000 0000 		.long	twiRX_Ptr
 2408 09d9 25        		.uleb128 0x25
 2409 09da 0000 0000 		.long	.LASF62
 2410 09de 01        		.byte	0x1
 2411 09df 9C        		.byte	0x9c
 2412 09e0 9809 0000 		.long	0x998
 2413 09e4 01        		.byte	0x1
 2414 09e5 05        		.byte	0x5
 2415 09e6 03        		.byte	0x3
 2416 09e7 0000 0000 		.long	twiST_Count
 2417 09eb 25        		.uleb128 0x25
 2418 09ec 0000 0000 		.long	.LASF63
 2419 09f0 01        		.byte	0x1
 2420 09f1 9D        		.byte	0x9d
 2421 09f2 AF09 0000 		.long	0x9af
 2422 09f6 01        		.byte	0x1
 2423 09f7 05        		.byte	0x5
 2424 09f8 03        		.byte	0x3
 2425 09f9 0000 0000 		.long	twiST_Ptr
 2426 09fd 27        		.uleb128 0x27
 2427 09fe 25        		.uleb128 0x25
 2428 09ff 0000 0000 		.long	.LASF64
 2429 0a03 01        		.byte	0x1
 2430 0a04 9F        		.byte	0x9f
 2431 0a05 100A 0000 		.long	0xa10
 2432 0a09 01        		.byte	0x1
 2433 0a0a 05        		.byte	0x5
 2434 0a0b 03        		.byte	0x3
 2435 0a0c 0000 0000 		.long	twiHookRestart
 2436 0a10 05        		.uleb128 0x5
GAS LISTING /tmp/ccqx8j8N.s 			page 52


 2437 0a11 02        		.byte	0x2
 2438 0a12 FD09 0000 		.long	0x9fd
 2439 0a16 25        		.uleb128 0x25
 2440 0a17 0000 0000 		.long	.LASF65
 2441 0a1b 01        		.byte	0x1
 2442 0a1c A0        		.byte	0xa0
 2443 0a1d 100A 0000 		.long	0xa10
 2444 0a21 01        		.byte	0x1
 2445 0a22 05        		.byte	0x5
 2446 0a23 03        		.byte	0x3
 2447 0a24 0000 0000 		.long	twiMasterReader
 2448 0a28 25        		.uleb128 0x25
 2449 0a29 0000 0000 		.long	.LASF66
 2450 0a2d 01        		.byte	0x1
 2451 0a2e A1        		.byte	0xa1
 2452 0a2f 100A 0000 		.long	0xa10
 2453 0a33 01        		.byte	0x1
 2454 0a34 05        		.byte	0x5
 2455 0a35 03        		.byte	0x3
 2456 0a36 0000 0000 		.long	twiSlaveReader
 2457 0a3a 25        		.uleb128 0x25
 2458 0a3b 0000 0000 		.long	.LASF67
 2459 0a3f 01        		.byte	0x1
 2460 0a40 A2        		.byte	0xa2
 2461 0a41 100A 0000 		.long	0xa10
 2462 0a45 01        		.byte	0x1
 2463 0a46 05        		.byte	0x5
 2464 0a47 03        		.byte	0x3
 2465 0a48 0000 0000 		.long	twiSlaveWriter
 2466 0a4c 0F        		.uleb128 0xf
 2467 0a4d 0000 0000 		.long	.LASF68
 2468 0a51 01        		.byte	0x1
 2469 0a52 AA        		.byte	0xaa
 2470 0a53 5D0A 0000 		.long	0xa5d
 2471 0a57 05        		.byte	0x5
 2472 0a58 03        		.byte	0x3
 2473 0a59 0000 0000 		.long	_ZL12twiStatistic
 2474 0a5d 26        		.uleb128 0x26
 2475 0a5e 6401 0000 		.long	0x164
 2476 0a62 28        		.uleb128 0x28
 2477 0a63 0000 0000 		.long	.LASF69
 2478 0a67 02        		.byte	0x2
 2479 0a68 DB01      		.word	0x1db
 2480 0a6a 3000 0000 		.long	0x30
 2481 0a6e 01        		.byte	0x1
 2482 0a6f 05        		.byte	0x5
 2483 0a70 03        		.byte	0x3
 2484 0a71 0000 0000 		.long	lcdModes
 2485 0a75 28        		.uleb128 0x28
 2486 0a76 0000 0000 		.long	.LASF70
 2487 0a7a 02        		.byte	0x2
 2488 0a7b DC01      		.word	0x1dc
 2489 0a7d 3000 0000 		.long	0x30
 2490 0a81 01        		.byte	0x1
 2491 0a82 05        		.byte	0x5
 2492 0a83 03        		.byte	0x3
 2493 0a84 0000 0000 		.long	lcdShifts
GAS LISTING /tmp/ccqx8j8N.s 			page 53


 2494 0a88 28        		.uleb128 0x28
 2495 0a89 0000 0000 		.long	.LASF71
 2496 0a8d 02        		.byte	0x2
 2497 0a8e DD01      		.word	0x1dd
 2498 0a90 3000 0000 		.long	0x30
 2499 0a94 01        		.byte	0x1
 2500 0a95 05        		.byte	0x5
 2501 0a96 03        		.byte	0x3
 2502 0a97 0000 0000 		.long	lcdShows
 2503 0a9b 28        		.uleb128 0x28
 2504 0a9c 0000 0000 		.long	.LASF72
 2505 0aa0 02        		.byte	0x2
 2506 0aa1 DE01      		.word	0x1de
 2507 0aa3 3000 0000 		.long	0x30
 2508 0aa7 01        		.byte	0x1
 2509 0aa8 05        		.byte	0x5
 2510 0aa9 03        		.byte	0x3
 2511 0aaa 0000 0000 		.long	lcdBackLight
 2512 0aae 28        		.uleb128 0x28
 2513 0aaf 0000 0000 		.long	.LASF73
 2514 0ab3 02        		.byte	0x2
 2515 0ab4 E001      		.word	0x1e0
 2516 0ab6 3000 0000 		.long	0x30
 2517 0aba 01        		.byte	0x1
 2518 0abb 05        		.byte	0x5
 2519 0abc 03        		.byte	0x3
 2520 0abd 0000 0000 		.long	lcdAddress
 2521 0ac1 28        		.uleb128 0x28
 2522 0ac2 0000 0000 		.long	.LASF74
 2523 0ac6 02        		.byte	0x2
 2524 0ac7 E101      		.word	0x1e1
 2525 0ac9 3000 0000 		.long	0x30
 2526 0acd 01        		.byte	0x1
 2527 0ace 05        		.byte	0x5
 2528 0acf 03        		.byte	0x3
 2529 0ad0 0000 0000 		.long	lcdCols
 2530 0ad4 28        		.uleb128 0x28
 2531 0ad5 0000 0000 		.long	.LASF75
 2532 0ad9 02        		.byte	0x2
 2533 0ada E201      		.word	0x1e2
 2534 0adc 3000 0000 		.long	0x30
 2535 0ae0 01        		.byte	0x1
 2536 0ae1 05        		.byte	0x5
 2537 0ae2 03        		.byte	0x3
 2538 0ae3 0000 0000 		.long	lcdRows
 2539 0ae7 29        		.uleb128 0x29
 2540 0ae8 3B00 0000 		.long	0x3b
 2541 0aec F70A 0000 		.long	0xaf7
 2542 0af0 2A        		.uleb128 0x2a
 2543 0af1 F70A 0000 		.long	0xaf7
 2544 0af5 05        		.byte	0x5
 2545 0af6 00        		.byte	0
 2546 0af7 02        		.uleb128 0x2
 2547 0af8 02        		.byte	0x2
 2548 0af9 07        		.byte	0x7
 2549 0afa 0000 0000 		.long	.LASF76
 2550 0afe 28        		.uleb128 0x28
GAS LISTING /tmp/ccqx8j8N.s 			page 54


 2551 0aff 0000 0000 		.long	.LASF77
 2552 0b03 02        		.byte	0x2
 2553 0b04 E301      		.word	0x1e3
 2554 0b06 E70A 0000 		.long	0xae7
 2555 0b0a 01        		.byte	0x1
 2556 0b0b 05        		.byte	0x5
 2557 0b0c 03        		.byte	0x3
 2558 0b0d 0000 0000 		.long	lcdBuffer
 2559 0b11 2B        		.uleb128 0x2b
 2560 0b12 01        		.byte	0x1
 2561 0b13 0000 0000 		.long	.LASF84
 2562 0b17 04        		.byte	0x4
 2563 0b18 E101      		.word	0x1e1
 2564 0b1a 01        		.byte	0x1
 2565 0b1b 2C        		.uleb128 0x2c
 2566 0b1c 4900 0000 		.long	0x49
 2567 0b20 00        		.byte	0
 2568 0b21 00        		.byte	0
 2569               		.section	.debug_abbrev,"",@progbits
 2570               	.Ldebug_abbrev0:
 2571 0000 01        		.uleb128 0x1
 2572 0001 11        		.uleb128 0x11
 2573 0002 01        		.byte	0x1
 2574 0003 25        		.uleb128 0x25
 2575 0004 0E        		.uleb128 0xe
 2576 0005 13        		.uleb128 0x13
 2577 0006 0B        		.uleb128 0xb
 2578 0007 03        		.uleb128 0x3
 2579 0008 0E        		.uleb128 0xe
 2580 0009 1B        		.uleb128 0x1b
 2581 000a 0E        		.uleb128 0xe
 2582 000b 55        		.uleb128 0x55
 2583 000c 06        		.uleb128 0x6
 2584 000d 11        		.uleb128 0x11
 2585 000e 01        		.uleb128 0x1
 2586 000f 52        		.uleb128 0x52
 2587 0010 01        		.uleb128 0x1
 2588 0011 10        		.uleb128 0x10
 2589 0012 06        		.uleb128 0x6
 2590 0013 00        		.byte	0
 2591 0014 00        		.byte	0
 2592 0015 02        		.uleb128 0x2
 2593 0016 24        		.uleb128 0x24
 2594 0017 00        		.byte	0
 2595 0018 0B        		.uleb128 0xb
 2596 0019 0B        		.uleb128 0xb
 2597 001a 3E        		.uleb128 0x3e
 2598 001b 0B        		.uleb128 0xb
 2599 001c 03        		.uleb128 0x3
 2600 001d 0E        		.uleb128 0xe
 2601 001e 00        		.byte	0
 2602 001f 00        		.byte	0
 2603 0020 03        		.uleb128 0x3
 2604 0021 16        		.uleb128 0x16
 2605 0022 00        		.byte	0
 2606 0023 03        		.uleb128 0x3
 2607 0024 0E        		.uleb128 0xe
GAS LISTING /tmp/ccqx8j8N.s 			page 55


 2608 0025 3A        		.uleb128 0x3a
 2609 0026 0B        		.uleb128 0xb
 2610 0027 3B        		.uleb128 0x3b
 2611 0028 0B        		.uleb128 0xb
 2612 0029 49        		.uleb128 0x49
 2613 002a 13        		.uleb128 0x13
 2614 002b 00        		.byte	0
 2615 002c 00        		.byte	0
 2616 002d 04        		.uleb128 0x4
 2617 002e 24        		.uleb128 0x24
 2618 002f 00        		.byte	0
 2619 0030 0B        		.uleb128 0xb
 2620 0031 0B        		.uleb128 0xb
 2621 0032 3E        		.uleb128 0x3e
 2622 0033 0B        		.uleb128 0xb
 2623 0034 03        		.uleb128 0x3
 2624 0035 08        		.uleb128 0x8
 2625 0036 00        		.byte	0
 2626 0037 00        		.byte	0
 2627 0038 05        		.uleb128 0x5
 2628 0039 0F        		.uleb128 0xf
 2629 003a 00        		.byte	0
 2630 003b 0B        		.uleb128 0xb
 2631 003c 0B        		.uleb128 0xb
 2632 003d 49        		.uleb128 0x49
 2633 003e 13        		.uleb128 0x13
 2634 003f 00        		.byte	0
 2635 0040 00        		.byte	0
 2636 0041 06        		.uleb128 0x6
 2637 0042 26        		.uleb128 0x26
 2638 0043 00        		.byte	0
 2639 0044 00        		.byte	0
 2640 0045 00        		.byte	0
 2641 0046 07        		.uleb128 0x7
 2642 0047 04        		.uleb128 0x4
 2643 0048 01        		.byte	0x1
 2644 0049 03        		.uleb128 0x3
 2645 004a 0E        		.uleb128 0xe
 2646 004b 0B        		.uleb128 0xb
 2647 004c 0B        		.uleb128 0xb
 2648 004d 3A        		.uleb128 0x3a
 2649 004e 0B        		.uleb128 0xb
 2650 004f 3B        		.uleb128 0x3b
 2651 0050 0B        		.uleb128 0xb
 2652 0051 01        		.uleb128 0x1
 2653 0052 13        		.uleb128 0x13
 2654 0053 00        		.byte	0
 2655 0054 00        		.byte	0
 2656 0055 08        		.uleb128 0x8
 2657 0056 28        		.uleb128 0x28
 2658 0057 00        		.byte	0
 2659 0058 03        		.uleb128 0x3
 2660 0059 0E        		.uleb128 0xe
 2661 005a 1C        		.uleb128 0x1c
 2662 005b 0D        		.uleb128 0xd
 2663 005c 00        		.byte	0
 2664 005d 00        		.byte	0
GAS LISTING /tmp/ccqx8j8N.s 			page 56


 2665 005e 09        		.uleb128 0x9
 2666 005f 13        		.uleb128 0x13
 2667 0060 01        		.byte	0x1
 2668 0061 0B        		.uleb128 0xb
 2669 0062 0B        		.uleb128 0xb
 2670 0063 3A        		.uleb128 0x3a
 2671 0064 0B        		.uleb128 0xb
 2672 0065 3B        		.uleb128 0x3b
 2673 0066 0B        		.uleb128 0xb
 2674 0067 8740      		.uleb128 0x2007
 2675 0069 0E        		.uleb128 0xe
 2676 006a 01        		.uleb128 0x1
 2677 006b 13        		.uleb128 0x13
 2678 006c 00        		.byte	0
 2679 006d 00        		.byte	0
 2680 006e 0A        		.uleb128 0xa
 2681 006f 0D        		.uleb128 0xd
 2682 0070 00        		.byte	0
 2683 0071 03        		.uleb128 0x3
 2684 0072 0E        		.uleb128 0xe
 2685 0073 3A        		.uleb128 0x3a
 2686 0074 0B        		.uleb128 0xb
 2687 0075 3B        		.uleb128 0x3b
 2688 0076 0B        		.uleb128 0xb
 2689 0077 49        		.uleb128 0x49
 2690 0078 13        		.uleb128 0x13
 2691 0079 38        		.uleb128 0x38
 2692 007a 0A        		.uleb128 0xa
 2693 007b 00        		.byte	0
 2694 007c 00        		.byte	0
 2695 007d 0B        		.uleb128 0xb
 2696 007e 0D        		.uleb128 0xd
 2697 007f 00        		.byte	0
 2698 0080 03        		.uleb128 0x3
 2699 0081 08        		.uleb128 0x8
 2700 0082 3A        		.uleb128 0x3a
 2701 0083 0B        		.uleb128 0xb
 2702 0084 3B        		.uleb128 0x3b
 2703 0085 0B        		.uleb128 0xb
 2704 0086 49        		.uleb128 0x49
 2705 0087 13        		.uleb128 0x13
 2706 0088 38        		.uleb128 0x38
 2707 0089 0A        		.uleb128 0xa
 2708 008a 00        		.byte	0
 2709 008b 00        		.byte	0
 2710 008c 0C        		.uleb128 0xc
 2711 008d 2E        		.uleb128 0x2e
 2712 008e 01        		.byte	0x1
 2713 008f 3F        		.uleb128 0x3f
 2714 0090 0C        		.uleb128 0xc
 2715 0091 03        		.uleb128 0x3
 2716 0092 0E        		.uleb128 0xe
 2717 0093 3A        		.uleb128 0x3a
 2718 0094 0B        		.uleb128 0xb
 2719 0095 3B        		.uleb128 0x3b
 2720 0096 0B        		.uleb128 0xb
 2721 0097 11        		.uleb128 0x11
GAS LISTING /tmp/ccqx8j8N.s 			page 57


 2722 0098 01        		.uleb128 0x1
 2723 0099 12        		.uleb128 0x12
 2724 009a 01        		.uleb128 0x1
 2725 009b 40        		.uleb128 0x40
 2726 009c 0A        		.uleb128 0xa
 2727 009d 9742      		.uleb128 0x2117
 2728 009f 0C        		.uleb128 0xc
 2729 00a0 01        		.uleb128 0x1
 2730 00a1 13        		.uleb128 0x13
 2731 00a2 00        		.byte	0
 2732 00a3 00        		.byte	0
 2733 00a4 0D        		.uleb128 0xd
 2734 00a5 05        		.uleb128 0x5
 2735 00a6 00        		.byte	0
 2736 00a7 03        		.uleb128 0x3
 2737 00a8 0E        		.uleb128 0xe
 2738 00a9 3A        		.uleb128 0x3a
 2739 00aa 0B        		.uleb128 0xb
 2740 00ab 3B        		.uleb128 0x3b
 2741 00ac 0B        		.uleb128 0xb
 2742 00ad 49        		.uleb128 0x49
 2743 00ae 13        		.uleb128 0x13
 2744 00af 02        		.uleb128 0x2
 2745 00b0 06        		.uleb128 0x6
 2746 00b1 00        		.byte	0
 2747 00b2 00        		.byte	0
 2748 00b3 0E        		.uleb128 0xe
 2749 00b4 0B        		.uleb128 0xb
 2750 00b5 01        		.byte	0x1
 2751 00b6 11        		.uleb128 0x11
 2752 00b7 01        		.uleb128 0x1
 2753 00b8 12        		.uleb128 0x12
 2754 00b9 01        		.uleb128 0x1
 2755 00ba 00        		.byte	0
 2756 00bb 00        		.byte	0
 2757 00bc 0F        		.uleb128 0xf
 2758 00bd 34        		.uleb128 0x34
 2759 00be 00        		.byte	0
 2760 00bf 03        		.uleb128 0x3
 2761 00c0 0E        		.uleb128 0xe
 2762 00c1 3A        		.uleb128 0x3a
 2763 00c2 0B        		.uleb128 0xb
 2764 00c3 3B        		.uleb128 0x3b
 2765 00c4 0B        		.uleb128 0xb
 2766 00c5 49        		.uleb128 0x49
 2767 00c6 13        		.uleb128 0x13
 2768 00c7 02        		.uleb128 0x2
 2769 00c8 0A        		.uleb128 0xa
 2770 00c9 00        		.byte	0
 2771 00ca 00        		.byte	0
 2772 00cb 10        		.uleb128 0x10
 2773 00cc 34        		.uleb128 0x34
 2774 00cd 00        		.byte	0
 2775 00ce 03        		.uleb128 0x3
 2776 00cf 0E        		.uleb128 0xe
 2777 00d0 3A        		.uleb128 0x3a
 2778 00d1 0B        		.uleb128 0xb
GAS LISTING /tmp/ccqx8j8N.s 			page 58


 2779 00d2 3B        		.uleb128 0x3b
 2780 00d3 0B        		.uleb128 0xb
 2781 00d4 49        		.uleb128 0x49
 2782 00d5 13        		.uleb128 0x13
 2783 00d6 02        		.uleb128 0x2
 2784 00d7 06        		.uleb128 0x6
 2785 00d8 00        		.byte	0
 2786 00d9 00        		.byte	0
 2787 00da 11        		.uleb128 0x11
 2788 00db 2E        		.uleb128 0x2e
 2789 00dc 01        		.byte	0x1
 2790 00dd 3F        		.uleb128 0x3f
 2791 00de 0C        		.uleb128 0xc
 2792 00df 03        		.uleb128 0x3
 2793 00e0 0E        		.uleb128 0xe
 2794 00e1 3A        		.uleb128 0x3a
 2795 00e2 0B        		.uleb128 0xb
 2796 00e3 3B        		.uleb128 0x3b
 2797 00e4 0B        		.uleb128 0xb
 2798 00e5 11        		.uleb128 0x11
 2799 00e6 01        		.uleb128 0x1
 2800 00e7 12        		.uleb128 0x12
 2801 00e8 01        		.uleb128 0x1
 2802 00e9 40        		.uleb128 0x40
 2803 00ea 06        		.uleb128 0x6
 2804 00eb 9742      		.uleb128 0x2117
 2805 00ed 0C        		.uleb128 0xc
 2806 00ee 01        		.uleb128 0x1
 2807 00ef 13        		.uleb128 0x13
 2808 00f0 00        		.byte	0
 2809 00f1 00        		.byte	0
 2810 00f2 12        		.uleb128 0x12
 2811 00f3 8982 01   		.uleb128 0x4109
 2812 00f6 01        		.byte	0x1
 2813 00f7 11        		.uleb128 0x11
 2814 00f8 01        		.uleb128 0x1
 2815 00f9 31        		.uleb128 0x31
 2816 00fa 13        		.uleb128 0x13
 2817 00fb 00        		.byte	0
 2818 00fc 00        		.byte	0
 2819 00fd 13        		.uleb128 0x13
 2820 00fe 8A82 01   		.uleb128 0x410a
 2821 0101 00        		.byte	0
 2822 0102 02        		.uleb128 0x2
 2823 0103 0A        		.uleb128 0xa
 2824 0104 9142      		.uleb128 0x2111
 2825 0106 0A        		.uleb128 0xa
 2826 0107 00        		.byte	0
 2827 0108 00        		.byte	0
 2828 0109 14        		.uleb128 0x14
 2829 010a 2E        		.uleb128 0x2e
 2830 010b 01        		.byte	0x1
 2831 010c 3F        		.uleb128 0x3f
 2832 010d 0C        		.uleb128 0xc
 2833 010e 03        		.uleb128 0x3
 2834 010f 0E        		.uleb128 0xe
 2835 0110 3A        		.uleb128 0x3a
GAS LISTING /tmp/ccqx8j8N.s 			page 59


 2836 0111 0B        		.uleb128 0xb
 2837 0112 3B        		.uleb128 0x3b
 2838 0113 0B        		.uleb128 0xb
 2839 0114 11        		.uleb128 0x11
 2840 0115 01        		.uleb128 0x1
 2841 0116 12        		.uleb128 0x12
 2842 0117 01        		.uleb128 0x1
 2843 0118 40        		.uleb128 0x40
 2844 0119 06        		.uleb128 0x6
 2845 011a 9642      		.uleb128 0x2116
 2846 011c 0C        		.uleb128 0xc
 2847 011d 01        		.uleb128 0x1
 2848 011e 13        		.uleb128 0x13
 2849 011f 00        		.byte	0
 2850 0120 00        		.byte	0
 2851 0121 15        		.uleb128 0x15
 2852 0122 05        		.uleb128 0x5
 2853 0123 00        		.byte	0
 2854 0124 03        		.uleb128 0x3
 2855 0125 08        		.uleb128 0x8
 2856 0126 3A        		.uleb128 0x3a
 2857 0127 0B        		.uleb128 0xb
 2858 0128 3B        		.uleb128 0x3b
 2859 0129 0B        		.uleb128 0xb
 2860 012a 49        		.uleb128 0x49
 2861 012b 13        		.uleb128 0x13
 2862 012c 02        		.uleb128 0x2
 2863 012d 06        		.uleb128 0x6
 2864 012e 00        		.byte	0
 2865 012f 00        		.byte	0
 2866 0130 16        		.uleb128 0x16
 2867 0131 2E        		.uleb128 0x2e
 2868 0132 01        		.byte	0x1
 2869 0133 3F        		.uleb128 0x3f
 2870 0134 0C        		.uleb128 0xc
 2871 0135 03        		.uleb128 0x3
 2872 0136 0E        		.uleb128 0xe
 2873 0137 3A        		.uleb128 0x3a
 2874 0138 0B        		.uleb128 0xb
 2875 0139 3B        		.uleb128 0x3b
 2876 013a 05        		.uleb128 0x5
 2877 013b 11        		.uleb128 0x11
 2878 013c 01        		.uleb128 0x1
 2879 013d 12        		.uleb128 0x12
 2880 013e 01        		.uleb128 0x1
 2881 013f 40        		.uleb128 0x40
 2882 0140 06        		.uleb128 0x6
 2883 0141 9742      		.uleb128 0x2117
 2884 0143 0C        		.uleb128 0xc
 2885 0144 01        		.uleb128 0x1
 2886 0145 13        		.uleb128 0x13
 2887 0146 00        		.byte	0
 2888 0147 00        		.byte	0
 2889 0148 17        		.uleb128 0x17
 2890 0149 34        		.uleb128 0x34
 2891 014a 00        		.byte	0
 2892 014b 03        		.uleb128 0x3
GAS LISTING /tmp/ccqx8j8N.s 			page 60


 2893 014c 08        		.uleb128 0x8
 2894 014d 3A        		.uleb128 0x3a
 2895 014e 0B        		.uleb128 0xb
 2896 014f 3B        		.uleb128 0x3b
 2897 0150 05        		.uleb128 0x5
 2898 0151 49        		.uleb128 0x49
 2899 0152 13        		.uleb128 0x13
 2900 0153 00        		.byte	0
 2901 0154 00        		.byte	0
 2902 0155 18        		.uleb128 0x18
 2903 0156 34        		.uleb128 0x34
 2904 0157 00        		.byte	0
 2905 0158 03        		.uleb128 0x3
 2906 0159 08        		.uleb128 0x8
 2907 015a 3A        		.uleb128 0x3a
 2908 015b 0B        		.uleb128 0xb
 2909 015c 3B        		.uleb128 0x3b
 2910 015d 05        		.uleb128 0x5
 2911 015e 49        		.uleb128 0x49
 2912 015f 13        		.uleb128 0x13
 2913 0160 02        		.uleb128 0x2
 2914 0161 06        		.uleb128 0x6
 2915 0162 00        		.byte	0
 2916 0163 00        		.byte	0
 2917 0164 19        		.uleb128 0x19
 2918 0165 2E        		.uleb128 0x2e
 2919 0166 01        		.byte	0x1
 2920 0167 3F        		.uleb128 0x3f
 2921 0168 0C        		.uleb128 0xc
 2922 0169 03        		.uleb128 0x3
 2923 016a 0E        		.uleb128 0xe
 2924 016b 3A        		.uleb128 0x3a
 2925 016c 0B        		.uleb128 0xb
 2926 016d 3B        		.uleb128 0x3b
 2927 016e 05        		.uleb128 0x5
 2928 016f 11        		.uleb128 0x11
 2929 0170 01        		.uleb128 0x1
 2930 0171 12        		.uleb128 0x12
 2931 0172 01        		.uleb128 0x1
 2932 0173 40        		.uleb128 0x40
 2933 0174 0A        		.uleb128 0xa
 2934 0175 9742      		.uleb128 0x2117
 2935 0177 0C        		.uleb128 0xc
 2936 0178 01        		.uleb128 0x1
 2937 0179 13        		.uleb128 0x13
 2938 017a 00        		.byte	0
 2939 017b 00        		.byte	0
 2940 017c 1A        		.uleb128 0x1a
 2941 017d 05        		.uleb128 0x5
 2942 017e 00        		.byte	0
 2943 017f 03        		.uleb128 0x3
 2944 0180 0E        		.uleb128 0xe
 2945 0181 3A        		.uleb128 0x3a
 2946 0182 0B        		.uleb128 0xb
 2947 0183 3B        		.uleb128 0x3b
 2948 0184 05        		.uleb128 0x5
 2949 0185 49        		.uleb128 0x49
GAS LISTING /tmp/ccqx8j8N.s 			page 61


 2950 0186 13        		.uleb128 0x13
 2951 0187 02        		.uleb128 0x2
 2952 0188 06        		.uleb128 0x6
 2953 0189 00        		.byte	0
 2954 018a 00        		.byte	0
 2955 018b 1B        		.uleb128 0x1b
 2956 018c 8982 01   		.uleb128 0x4109
 2957 018f 01        		.byte	0x1
 2958 0190 11        		.uleb128 0x11
 2959 0191 01        		.uleb128 0x1
 2960 0192 9542      		.uleb128 0x2115
 2961 0194 0C        		.uleb128 0xc
 2962 0195 31        		.uleb128 0x31
 2963 0196 13        		.uleb128 0x13
 2964 0197 00        		.byte	0
 2965 0198 00        		.byte	0
 2966 0199 1C        		.uleb128 0x1c
 2967 019a 26        		.uleb128 0x26
 2968 019b 00        		.byte	0
 2969 019c 49        		.uleb128 0x49
 2970 019d 13        		.uleb128 0x13
 2971 019e 00        		.byte	0
 2972 019f 00        		.byte	0
 2973 01a0 1D        		.uleb128 0x1d
 2974 01a1 05        		.uleb128 0x5
 2975 01a2 00        		.byte	0
 2976 01a3 03        		.uleb128 0x3
 2977 01a4 0E        		.uleb128 0xe
 2978 01a5 3A        		.uleb128 0x3a
 2979 01a6 0B        		.uleb128 0xb
 2980 01a7 3B        		.uleb128 0x3b
 2981 01a8 05        		.uleb128 0x5
 2982 01a9 49        		.uleb128 0x49
 2983 01aa 13        		.uleb128 0x13
 2984 01ab 02        		.uleb128 0x2
 2985 01ac 0A        		.uleb128 0xa
 2986 01ad 00        		.byte	0
 2987 01ae 00        		.byte	0
 2988 01af 1E        		.uleb128 0x1e
 2989 01b0 05        		.uleb128 0x5
 2990 01b1 00        		.byte	0
 2991 01b2 03        		.uleb128 0x3
 2992 01b3 08        		.uleb128 0x8
 2993 01b4 3A        		.uleb128 0x3a
 2994 01b5 0B        		.uleb128 0xb
 2995 01b6 3B        		.uleb128 0x3b
 2996 01b7 05        		.uleb128 0x5
 2997 01b8 49        		.uleb128 0x49
 2998 01b9 13        		.uleb128 0x13
 2999 01ba 02        		.uleb128 0x2
 3000 01bb 0A        		.uleb128 0xa
 3001 01bc 00        		.byte	0
 3002 01bd 00        		.byte	0
 3003 01be 1F        		.uleb128 0x1f
 3004 01bf 34        		.uleb128 0x34
 3005 01c0 00        		.byte	0
 3006 01c1 03        		.uleb128 0x3
GAS LISTING /tmp/ccqx8j8N.s 			page 62


 3007 01c2 0E        		.uleb128 0xe
 3008 01c3 3A        		.uleb128 0x3a
 3009 01c4 0B        		.uleb128 0xb
 3010 01c5 3B        		.uleb128 0x3b
 3011 01c6 05        		.uleb128 0x5
 3012 01c7 49        		.uleb128 0x49
 3013 01c8 13        		.uleb128 0x13
 3014 01c9 02        		.uleb128 0x2
 3015 01ca 06        		.uleb128 0x6
 3016 01cb 00        		.byte	0
 3017 01cc 00        		.byte	0
 3018 01cd 20        		.uleb128 0x20
 3019 01ce 05        		.uleb128 0x5
 3020 01cf 00        		.byte	0
 3021 01d0 03        		.uleb128 0x3
 3022 01d1 08        		.uleb128 0x8
 3023 01d2 3A        		.uleb128 0x3a
 3024 01d3 0B        		.uleb128 0xb
 3025 01d4 3B        		.uleb128 0x3b
 3026 01d5 05        		.uleb128 0x5
 3027 01d6 49        		.uleb128 0x49
 3028 01d7 13        		.uleb128 0x13
 3029 01d8 02        		.uleb128 0x2
 3030 01d9 06        		.uleb128 0x6
 3031 01da 00        		.byte	0
 3032 01db 00        		.byte	0
 3033 01dc 21        		.uleb128 0x21
 3034 01dd 8982 01   		.uleb128 0x4109
 3035 01e0 01        		.byte	0x1
 3036 01e1 11        		.uleb128 0x11
 3037 01e2 01        		.uleb128 0x1
 3038 01e3 31        		.uleb128 0x31
 3039 01e4 13        		.uleb128 0x13
 3040 01e5 01        		.uleb128 0x1
 3041 01e6 13        		.uleb128 0x13
 3042 01e7 00        		.byte	0
 3043 01e8 00        		.byte	0
 3044 01e9 22        		.uleb128 0x22
 3045 01ea 8982 01   		.uleb128 0x4109
 3046 01ed 00        		.byte	0
 3047 01ee 11        		.uleb128 0x11
 3048 01ef 01        		.uleb128 0x1
 3049 01f0 31        		.uleb128 0x31
 3050 01f1 13        		.uleb128 0x13
 3051 01f2 00        		.byte	0
 3052 01f3 00        		.byte	0
 3053 01f4 23        		.uleb128 0x23
 3054 01f5 34        		.uleb128 0x34
 3055 01f6 00        		.byte	0
 3056 01f7 03        		.uleb128 0x3
 3057 01f8 0E        		.uleb128 0xe
 3058 01f9 3A        		.uleb128 0x3a
 3059 01fa 0B        		.uleb128 0xb
 3060 01fb 3B        		.uleb128 0x3b
 3061 01fc 05        		.uleb128 0x5
 3062 01fd 49        		.uleb128 0x49
 3063 01fe 13        		.uleb128 0x13
GAS LISTING /tmp/ccqx8j8N.s 			page 63


 3064 01ff 00        		.byte	0
 3065 0200 00        		.byte	0
 3066 0201 24        		.uleb128 0x24
 3067 0202 2E        		.uleb128 0x2e
 3068 0203 00        		.byte	0
 3069 0204 3F        		.uleb128 0x3f
 3070 0205 0C        		.uleb128 0xc
 3071 0206 03        		.uleb128 0x3
 3072 0207 0E        		.uleb128 0xe
 3073 0208 3A        		.uleb128 0x3a
 3074 0209 0B        		.uleb128 0xb
 3075 020a 3B        		.uleb128 0x3b
 3076 020b 05        		.uleb128 0x5
 3077 020c 11        		.uleb128 0x11
 3078 020d 01        		.uleb128 0x1
 3079 020e 12        		.uleb128 0x12
 3080 020f 01        		.uleb128 0x1
 3081 0210 40        		.uleb128 0x40
 3082 0211 0A        		.uleb128 0xa
 3083 0212 9742      		.uleb128 0x2117
 3084 0214 0C        		.uleb128 0xc
 3085 0215 00        		.byte	0
 3086 0216 00        		.byte	0
 3087 0217 25        		.uleb128 0x25
 3088 0218 34        		.uleb128 0x34
 3089 0219 00        		.byte	0
 3090 021a 03        		.uleb128 0x3
 3091 021b 0E        		.uleb128 0xe
 3092 021c 3A        		.uleb128 0x3a
 3093 021d 0B        		.uleb128 0xb
 3094 021e 3B        		.uleb128 0x3b
 3095 021f 0B        		.uleb128 0xb
 3096 0220 49        		.uleb128 0x49
 3097 0221 13        		.uleb128 0x13
 3098 0222 3F        		.uleb128 0x3f
 3099 0223 0C        		.uleb128 0xc
 3100 0224 02        		.uleb128 0x2
 3101 0225 0A        		.uleb128 0xa
 3102 0226 00        		.byte	0
 3103 0227 00        		.byte	0
 3104 0228 26        		.uleb128 0x26
 3105 0229 35        		.uleb128 0x35
 3106 022a 00        		.byte	0
 3107 022b 49        		.uleb128 0x49
 3108 022c 13        		.uleb128 0x13
 3109 022d 00        		.byte	0
 3110 022e 00        		.byte	0
 3111 022f 27        		.uleb128 0x27
 3112 0230 15        		.uleb128 0x15
 3113 0231 00        		.byte	0
 3114 0232 00        		.byte	0
 3115 0233 00        		.byte	0
 3116 0234 28        		.uleb128 0x28
 3117 0235 34        		.uleb128 0x34
 3118 0236 00        		.byte	0
 3119 0237 03        		.uleb128 0x3
 3120 0238 0E        		.uleb128 0xe
GAS LISTING /tmp/ccqx8j8N.s 			page 64


 3121 0239 3A        		.uleb128 0x3a
 3122 023a 0B        		.uleb128 0xb
 3123 023b 3B        		.uleb128 0x3b
 3124 023c 05        		.uleb128 0x5
 3125 023d 49        		.uleb128 0x49
 3126 023e 13        		.uleb128 0x13
 3127 023f 3F        		.uleb128 0x3f
 3128 0240 0C        		.uleb128 0xc
 3129 0241 02        		.uleb128 0x2
 3130 0242 0A        		.uleb128 0xa
 3131 0243 00        		.byte	0
 3132 0244 00        		.byte	0
 3133 0245 29        		.uleb128 0x29
 3134 0246 01        		.uleb128 0x1
 3135 0247 01        		.byte	0x1
 3136 0248 49        		.uleb128 0x49
 3137 0249 13        		.uleb128 0x13
 3138 024a 01        		.uleb128 0x1
 3139 024b 13        		.uleb128 0x13
 3140 024c 00        		.byte	0
 3141 024d 00        		.byte	0
 3142 024e 2A        		.uleb128 0x2a
 3143 024f 21        		.uleb128 0x21
 3144 0250 00        		.byte	0
 3145 0251 49        		.uleb128 0x49
 3146 0252 13        		.uleb128 0x13
 3147 0253 2F        		.uleb128 0x2f
 3148 0254 0B        		.uleb128 0xb
 3149 0255 00        		.byte	0
 3150 0256 00        		.byte	0
 3151 0257 2B        		.uleb128 0x2b
 3152 0258 2E        		.uleb128 0x2e
 3153 0259 01        		.byte	0x1
 3154 025a 3F        		.uleb128 0x3f
 3155 025b 0C        		.uleb128 0xc
 3156 025c 03        		.uleb128 0x3
 3157 025d 0E        		.uleb128 0xe
 3158 025e 3A        		.uleb128 0x3a
 3159 025f 0B        		.uleb128 0xb
 3160 0260 3B        		.uleb128 0x3b
 3161 0261 05        		.uleb128 0x5
 3162 0262 3C        		.uleb128 0x3c
 3163 0263 0C        		.uleb128 0xc
 3164 0264 00        		.byte	0
 3165 0265 00        		.byte	0
 3166 0266 2C        		.uleb128 0x2c
 3167 0267 05        		.uleb128 0x5
 3168 0268 00        		.byte	0
 3169 0269 49        		.uleb128 0x49
 3170 026a 13        		.uleb128 0x13
 3171 026b 00        		.byte	0
 3172 026c 00        		.byte	0
 3173 026d 00        		.byte	0
 3174               		.section	.debug_loc,"",@progbits
 3175               	.Ldebug_loc0:
 3176               	.LLST0:
 3177 0000 0000 0000 		.long	.LVL0
GAS LISTING /tmp/ccqx8j8N.s 			page 65


 3178 0004 0000 0000 		.long	.LVL1
 3179 0008 0C00      		.word	0xc
 3180 000a 66        		.byte	0x66
 3181 000b 93        		.byte	0x93
 3182 000c 01        		.uleb128 0x1
 3183 000d 67        		.byte	0x67
 3184 000e 93        		.byte	0x93
 3185 000f 01        		.uleb128 0x1
 3186 0010 68        		.byte	0x68
 3187 0011 93        		.byte	0x93
 3188 0012 01        		.uleb128 0x1
 3189 0013 69        		.byte	0x69
 3190 0014 93        		.byte	0x93
 3191 0015 01        		.uleb128 0x1
 3192 0016 0000 0000 		.long	.LVL1
 3193 001a 0000 0000 		.long	.LVL2
 3194 001e 0C00      		.word	0xc
 3195 0020 62        		.byte	0x62
 3196 0021 93        		.byte	0x93
 3197 0022 01        		.uleb128 0x1
 3198 0023 63        		.byte	0x63
 3199 0024 93        		.byte	0x93
 3200 0025 01        		.uleb128 0x1
 3201 0026 64        		.byte	0x64
 3202 0027 93        		.byte	0x93
 3203 0028 01        		.uleb128 0x1
 3204 0029 65        		.byte	0x65
 3205 002a 93        		.byte	0x93
 3206 002b 01        		.uleb128 0x1
 3207 002c 0000 0000 		.long	.LVL2
 3208 0030 0000 0000 		.long	.LFE102
 3209 0034 0400      		.word	0x4
 3210 0036 F3        		.byte	0xf3
 3211 0037 01        		.uleb128 0x1
 3212 0038 66        		.byte	0x66
 3213 0039 9F        		.byte	0x9f
 3214 003a 0000 0000 		.long	0
 3215 003e 0000 0000 		.long	0
 3216               	.LLST1:
 3217 0042 0000 0000 		.long	.LVL3
 3218 0046 0000 0000 		.long	.LVL4
 3219 004a 0200      		.word	0x2
 3220 004c 30        		.byte	0x30
 3221 004d 9F        		.byte	0x9f
 3222 004e 0000 0000 		.long	.LVL4
 3223 0052 0000 0000 		.long	.LFE102
 3224 0056 0100      		.word	0x1
 3225 0058 68        		.byte	0x68
 3226 0059 0000 0000 		.long	0
 3227 005d 0000 0000 		.long	0
 3228               	.LLST2:
 3229 0061 0000 0000 		.long	.LFB103
 3230 0065 0000 0000 		.long	.LCFI0
 3231 0069 0300      		.word	0x3
 3232 006b 92        		.byte	0x92
 3233 006c 20        		.uleb128 0x20
 3234 006d 03        		.sleb128 3
GAS LISTING /tmp/ccqx8j8N.s 			page 66


 3235 006e 0000 0000 		.long	.LCFI0
 3236 0072 0000 0000 		.long	.LCFI1
 3237 0076 0300      		.word	0x3
 3238 0078 92        		.byte	0x92
 3239 0079 20        		.uleb128 0x20
 3240 007a 04        		.sleb128 4
 3241 007b 0000 0000 		.long	.LCFI1
 3242 007f 0000 0000 		.long	.LCFI2
 3243 0083 0300      		.word	0x3
 3244 0085 92        		.byte	0x92
 3245 0086 20        		.uleb128 0x20
 3246 0087 05        		.sleb128 5
 3247 0088 0000 0000 		.long	.LCFI2
 3248 008c 0000 0000 		.long	.LCFI3
 3249 0090 0300      		.word	0x3
 3250 0092 92        		.byte	0x92
 3251 0093 20        		.uleb128 0x20
 3252 0094 06        		.sleb128 6
 3253 0095 0000 0000 		.long	.LCFI3
 3254 0099 0000 0000 		.long	.LFE103
 3255 009d 0200      		.word	0x2
 3256 009f 8C        		.byte	0x8c
 3257 00a0 06        		.sleb128 6
 3258 00a1 0000 0000 		.long	0
 3259 00a5 0000 0000 		.long	0
 3260               	.LLST3:
 3261 00a9 0000 0000 		.long	.LVL9
 3262 00ad 0000 0000 		.long	.LVL10-1
 3263 00b1 0C00      		.word	0xc
 3264 00b3 66        		.byte	0x66
 3265 00b4 93        		.byte	0x93
 3266 00b5 01        		.uleb128 0x1
 3267 00b6 67        		.byte	0x67
 3268 00b7 93        		.byte	0x93
 3269 00b8 01        		.uleb128 0x1
 3270 00b9 68        		.byte	0x68
 3271 00ba 93        		.byte	0x93
 3272 00bb 01        		.uleb128 0x1
 3273 00bc 69        		.byte	0x69
 3274 00bd 93        		.byte	0x93
 3275 00be 01        		.uleb128 0x1
 3276 00bf 0000 0000 		.long	.LVL10-1
 3277 00c3 0000 0000 		.long	.LFE103
 3278 00c7 0400      		.word	0x4
 3279 00c9 F3        		.byte	0xf3
 3280 00ca 01        		.uleb128 0x1
 3281 00cb 66        		.byte	0x66
 3282 00cc 9F        		.byte	0x9f
 3283 00cd 0000 0000 		.long	0
 3284 00d1 0000 0000 		.long	0
 3285               	.LLST4:
 3286 00d5 0000 0000 		.long	.LVL9
 3287 00d9 0000 0000 		.long	.LVL10-1
 3288 00dd 0100      		.word	0x1
 3289 00df 64        		.byte	0x64
 3290 00e0 0000 0000 		.long	.LVL10-1
 3291 00e4 0000 0000 		.long	.LFE103
GAS LISTING /tmp/ccqx8j8N.s 			page 67


 3292 00e8 0400      		.word	0x4
 3293 00ea F3        		.byte	0xf3
 3294 00eb 01        		.uleb128 0x1
 3295 00ec 64        		.byte	0x64
 3296 00ed 9F        		.byte	0x9f
 3297 00ee 0000 0000 		.long	0
 3298 00f2 0000 0000 		.long	0
 3299               	.LLST5:
 3300 00f6 0000 0000 		.long	.LFB104
 3301 00fa 0000 0000 		.long	.LCFI4
 3302 00fe 0300      		.word	0x3
 3303 0100 92        		.byte	0x92
 3304 0101 20        		.uleb128 0x20
 3305 0102 03        		.sleb128 3
 3306 0103 0000 0000 		.long	.LCFI4
 3307 0107 0000 0000 		.long	.LFE104
 3308 010b 0300      		.word	0x3
 3309 010d 92        		.byte	0x92
 3310 010e 20        		.uleb128 0x20
 3311 010f 04        		.sleb128 4
 3312 0110 0000 0000 		.long	0
 3313 0114 0000 0000 		.long	0
 3314               	.LLST6:
 3315 0118 0000 0000 		.long	.LVL11
 3316 011c 0000 0000 		.long	.LVL12
 3317 0120 0100      		.word	0x1
 3318 0122 68        		.byte	0x68
 3319 0123 0000 0000 		.long	.LVL12
 3320 0127 0000 0000 		.long	.LVL13
 3321 012b 0400      		.word	0x4
 3322 012d F3        		.byte	0xf3
 3323 012e 01        		.uleb128 0x1
 3324 012f 68        		.byte	0x68
 3325 0130 9F        		.byte	0x9f
 3326 0131 0000 0000 		.long	.LVL13
 3327 0135 0000 0000 		.long	.LVL14
 3328 0139 0100      		.word	0x1
 3329 013b 68        		.byte	0x68
 3330 013c 0000 0000 		.long	.LVL14
 3331 0140 0000 0000 		.long	.LVL15
 3332 0144 0400      		.word	0x4
 3333 0146 F3        		.byte	0xf3
 3334 0147 01        		.uleb128 0x1
 3335 0148 68        		.byte	0x68
 3336 0149 9F        		.byte	0x9f
 3337 014a 0000 0000 		.long	.LVL15
 3338 014e 0000 0000 		.long	.LVL16-1
 3339 0152 0100      		.word	0x1
 3340 0154 68        		.byte	0x68
 3341 0155 0000 0000 		.long	.LVL16-1
 3342 0159 0000 0000 		.long	.LVL17
 3343 015d 0400      		.word	0x4
 3344 015f F3        		.byte	0xf3
 3345 0160 01        		.uleb128 0x1
 3346 0161 68        		.byte	0x68
 3347 0162 9F        		.byte	0x9f
 3348 0163 0000 0000 		.long	.LVL17
GAS LISTING /tmp/ccqx8j8N.s 			page 68


 3349 0167 0000 0000 		.long	.LVL18
 3350 016b 0100      		.word	0x1
 3351 016d 68        		.byte	0x68
 3352 016e 0000 0000 		.long	.LVL18
 3353 0172 0000 0000 		.long	.LFE104
 3354 0176 0400      		.word	0x4
 3355 0178 F3        		.byte	0xf3
 3356 0179 01        		.uleb128 0x1
 3357 017a 68        		.byte	0x68
 3358 017b 9F        		.byte	0x9f
 3359 017c 0000 0000 		.long	0
 3360 0180 0000 0000 		.long	0
 3361               	.LLST7:
 3362 0184 0000 0000 		.long	.LFB105
 3363 0188 0000 0000 		.long	.LCFI5
 3364 018c 0300      		.word	0x3
 3365 018e 92        		.byte	0x92
 3366 018f 20        		.uleb128 0x20
 3367 0190 03        		.sleb128 3
 3368 0191 0000 0000 		.long	.LCFI5
 3369 0195 0000 0000 		.long	.LCFI6
 3370 0199 0300      		.word	0x3
 3371 019b 92        		.byte	0x92
 3372 019c 20        		.uleb128 0x20
 3373 019d 04        		.sleb128 4
 3374 019e 0000 0000 		.long	.LCFI6
 3375 01a2 0000 0000 		.long	.LCFI7
 3376 01a6 0300      		.word	0x3
 3377 01a8 92        		.byte	0x92
 3378 01a9 20        		.uleb128 0x20
 3379 01aa 05        		.sleb128 5
 3380 01ab 0000 0000 		.long	.LCFI7
 3381 01af 0000 0000 		.long	.LCFI8
 3382 01b3 0300      		.word	0x3
 3383 01b5 92        		.byte	0x92
 3384 01b6 20        		.uleb128 0x20
 3385 01b7 06        		.sleb128 6
 3386 01b8 0000 0000 		.long	.LCFI8
 3387 01bc 0000 0000 		.long	.LFE105
 3388 01c0 0300      		.word	0x3
 3389 01c2 92        		.byte	0x92
 3390 01c3 20        		.uleb128 0x20
 3391 01c4 07        		.sleb128 7
 3392 01c5 0000 0000 		.long	0
 3393 01c9 0000 0000 		.long	0
 3394               	.LLST8:
 3395 01cd 0000 0000 		.long	.LVL19
 3396 01d1 0000 0000 		.long	.LVL21
 3397 01d5 0100      		.word	0x1
 3398 01d7 69        		.byte	0x69
 3399 01d8 0000 0000 		.long	0
 3400 01dc 0000 0000 		.long	0
 3401               	.LLST9:
 3402 01e0 0000 0000 		.long	.LVL20
 3403 01e4 0000 0000 		.long	.LVL22
 3404 01e8 0100      		.word	0x1
 3405 01ea 68        		.byte	0x68
GAS LISTING /tmp/ccqx8j8N.s 			page 69


 3406 01eb 0000 0000 		.long	0
 3407 01ef 0000 0000 		.long	0
 3408               	.LLST10:
 3409 01f3 0000 0000 		.long	.LVL23
 3410 01f7 0000 0000 		.long	.LVL24
 3411 01fb 0100      		.word	0x1
 3412 01fd 68        		.byte	0x68
 3413 01fe 0000 0000 		.long	.LVL24
 3414 0202 0000 0000 		.long	.LVL25
 3415 0206 0500      		.word	0x5
 3416 0208 03        		.byte	0x3
 3417 0209 0000 0000 		.long	twiSLARW
 3418 020d 0000 0000 		.long	.LVL25
 3419 0211 0000 0000 		.long	.LFE106
 3420 0215 0400      		.word	0x4
 3421 0217 F3        		.byte	0xf3
 3422 0218 01        		.uleb128 0x1
 3423 0219 68        		.byte	0x68
 3424 021a 9F        		.byte	0x9f
 3425 021b 0000 0000 		.long	0
 3426 021f 0000 0000 		.long	0
 3427               	.LLST11:
 3428 0223 0000 0000 		.long	.LVL26
 3429 0227 0000 0000 		.long	.LVL27
 3430 022b 0100      		.word	0x1
 3431 022d 68        		.byte	0x68
 3432 022e 0000 0000 		.long	.LVL27
 3433 0232 0000 0000 		.long	.LVL28
 3434 0236 0500      		.word	0x5
 3435 0238 03        		.byte	0x3
 3436 0239 0000 0000 		.long	twiSLARW
 3437 023d 0000 0000 		.long	.LVL28
 3438 0241 0000 0000 		.long	.LFE107
 3439 0245 0400      		.word	0x4
 3440 0247 F3        		.byte	0xf3
 3441 0248 01        		.uleb128 0x1
 3442 0249 68        		.byte	0x68
 3443 024a 9F        		.byte	0x9f
 3444 024b 0000 0000 		.long	0
 3445 024f 0000 0000 		.long	0
 3446               	.LLST12:
 3447 0253 0000 0000 		.long	.LVL29
 3448 0257 0000 0000 		.long	.LVL30
 3449 025b 0100      		.word	0x1
 3450 025d 68        		.byte	0x68
 3451 025e 0000 0000 		.long	.LVL30
 3452 0262 0000 0000 		.long	.LFE108
 3453 0266 0400      		.word	0x4
 3454 0268 F3        		.byte	0xf3
 3455 0269 01        		.uleb128 0x1
 3456 026a 68        		.byte	0x68
 3457 026b 9F        		.byte	0x9f
 3458 026c 0000 0000 		.long	0
 3459 0270 0000 0000 		.long	0
 3460               	.LLST13:
 3461 0274 0000 0000 		.long	.LVL29
 3462 0278 0000 0000 		.long	.LVL31-1
GAS LISTING /tmp/ccqx8j8N.s 			page 70


 3463 027c 0600      		.word	0x6
 3464 027e 66        		.byte	0x66
 3465 027f 93        		.byte	0x93
 3466 0280 01        		.uleb128 0x1
 3467 0281 67        		.byte	0x67
 3468 0282 93        		.byte	0x93
 3469 0283 01        		.uleb128 0x1
 3470 0284 0000 0000 		.long	.LVL31-1
 3471 0288 0000 0000 		.long	.LFE108
 3472 028c 0400      		.word	0x4
 3473 028e F3        		.byte	0xf3
 3474 028f 01        		.uleb128 0x1
 3475 0290 66        		.byte	0x66
 3476 0291 9F        		.byte	0x9f
 3477 0292 0000 0000 		.long	0
 3478 0296 0000 0000 		.long	0
 3479               	.LLST14:
 3480 029a 0000 0000 		.long	.LVL29
 3481 029e 0000 0000 		.long	.LVL31-1
 3482 02a2 0100      		.word	0x1
 3483 02a4 64        		.byte	0x64
 3484 02a5 0000 0000 		.long	.LVL31-1
 3485 02a9 0000 0000 		.long	.LFE108
 3486 02ad 0400      		.word	0x4
 3487 02af F3        		.byte	0xf3
 3488 02b0 01        		.uleb128 0x1
 3489 02b1 64        		.byte	0x64
 3490 02b2 9F        		.byte	0x9f
 3491 02b3 0000 0000 		.long	0
 3492 02b7 0000 0000 		.long	0
 3493               	.LLST15:
 3494 02bb 0000 0000 		.long	.LVL32
 3495 02bf 0000 0000 		.long	.LVL33
 3496 02c3 0100      		.word	0x1
 3497 02c5 68        		.byte	0x68
 3498 02c6 0000 0000 		.long	.LVL33
 3499 02ca 0000 0000 		.long	.LFE109
 3500 02ce 0400      		.word	0x4
 3501 02d0 F3        		.byte	0xf3
 3502 02d1 01        		.uleb128 0x1
 3503 02d2 68        		.byte	0x68
 3504 02d3 9F        		.byte	0x9f
 3505 02d4 0000 0000 		.long	0
 3506 02d8 0000 0000 		.long	0
 3507               	.LLST16:
 3508 02dc 0000 0000 		.long	.LVL32
 3509 02e0 0000 0000 		.long	.LVL34-1
 3510 02e4 0600      		.word	0x6
 3511 02e6 66        		.byte	0x66
 3512 02e7 93        		.byte	0x93
 3513 02e8 01        		.uleb128 0x1
 3514 02e9 67        		.byte	0x67
 3515 02ea 93        		.byte	0x93
 3516 02eb 01        		.uleb128 0x1
 3517 02ec 0000 0000 		.long	.LVL34-1
 3518 02f0 0000 0000 		.long	.LFE109
 3519 02f4 0400      		.word	0x4
GAS LISTING /tmp/ccqx8j8N.s 			page 71


 3520 02f6 F3        		.byte	0xf3
 3521 02f7 01        		.uleb128 0x1
 3522 02f8 66        		.byte	0x66
 3523 02f9 9F        		.byte	0x9f
 3524 02fa 0000 0000 		.long	0
 3525 02fe 0000 0000 		.long	0
 3526               	.LLST17:
 3527 0302 0000 0000 		.long	.LVL32
 3528 0306 0000 0000 		.long	.LVL34-1
 3529 030a 0100      		.word	0x1
 3530 030c 64        		.byte	0x64
 3531 030d 0000 0000 		.long	.LVL34-1
 3532 0311 0000 0000 		.long	.LFE109
 3533 0315 0400      		.word	0x4
 3534 0317 F3        		.byte	0xf3
 3535 0318 01        		.uleb128 0x1
 3536 0319 64        		.byte	0x64
 3537 031a 9F        		.byte	0x9f
 3538 031b 0000 0000 		.long	0
 3539 031f 0000 0000 		.long	0
 3540               	.LLST18:
 3541 0323 0000 0000 		.long	.LFB110
 3542 0327 0000 0000 		.long	.LCFI9
 3543 032b 0300      		.word	0x3
 3544 032d 92        		.byte	0x92
 3545 032e 20        		.uleb128 0x20
 3546 032f 03        		.sleb128 3
 3547 0330 0000 0000 		.long	.LCFI9
 3548 0334 0000 0000 		.long	.LCFI10
 3549 0338 0300      		.word	0x3
 3550 033a 92        		.byte	0x92
 3551 033b 20        		.uleb128 0x20
 3552 033c 04        		.sleb128 4
 3553 033d 0000 0000 		.long	.LCFI10
 3554 0341 0000 0000 		.long	.LFE110
 3555 0345 0300      		.word	0x3
 3556 0347 92        		.byte	0x92
 3557 0348 20        		.uleb128 0x20
 3558 0349 05        		.sleb128 5
 3559 034a 0000 0000 		.long	0
 3560 034e 0000 0000 		.long	0
 3561               	.LLST19:
 3562 0352 0000 0000 		.long	.LVL35
 3563 0356 0000 0000 		.long	.LVL36
 3564 035a 0100      		.word	0x1
 3565 035c 68        		.byte	0x68
 3566 035d 0000 0000 		.long	.LVL36
 3567 0361 0000 0000 		.long	.LFE110
 3568 0365 0400      		.word	0x4
 3569 0367 F3        		.byte	0xf3
 3570 0368 01        		.uleb128 0x1
 3571 0369 68        		.byte	0x68
 3572 036a 9F        		.byte	0x9f
 3573 036b 0000 0000 		.long	0
 3574 036f 0000 0000 		.long	0
 3575               	.LLST20:
 3576 0373 0000 0000 		.long	.LVL35
GAS LISTING /tmp/ccqx8j8N.s 			page 72


 3577 0377 0000 0000 		.long	.LVL37
 3578 037b 0100      		.word	0x1
 3579 037d 60        		.byte	0x60
 3580 037e 0000 0000 		.long	.LVL37
 3581 0382 0000 0000 		.long	.LFE110
 3582 0386 0400      		.word	0x4
 3583 0388 F3        		.byte	0xf3
 3584 0389 01        		.uleb128 0x1
 3585 038a 60        		.byte	0x60
 3586 038b 9F        		.byte	0x9f
 3587 038c 0000 0000 		.long	0
 3588 0390 0000 0000 		.long	0
 3589               	.LLST21:
 3590 0394 0000 0000 		.long	.LVL38
 3591 0398 0000 0000 		.long	.LVL43
 3592 039c 0100      		.word	0x1
 3593 039e 68        		.byte	0x68
 3594 039f 0000 0000 		.long	.LVL43
 3595 03a3 0000 0000 		.long	.LFE111
 3596 03a7 0400      		.word	0x4
 3597 03a9 F3        		.byte	0xf3
 3598 03aa 01        		.uleb128 0x1
 3599 03ab 68        		.byte	0x68
 3600 03ac 9F        		.byte	0x9f
 3601 03ad 0000 0000 		.long	0
 3602 03b1 0000 0000 		.long	0
 3603               	.LLST22:
 3604 03b5 0000 0000 		.long	.LVL39
 3605 03b9 0000 0000 		.long	.LVL41
 3606 03bd 0100      		.word	0x1
 3607 03bf 69        		.byte	0x69
 3608 03c0 0000 0000 		.long	.LVL41
 3609 03c4 0000 0000 		.long	.LVL42
 3610 03c8 0500      		.word	0x5
 3611 03ca 89        		.byte	0x89
 3612 03cb 00        		.sleb128 0
 3613 03cc 34        		.byte	0x34
 3614 03cd 21        		.byte	0x21
 3615 03ce 9F        		.byte	0x9f
 3616 03cf 0000 0000 		.long	.LVL42
 3617 03d3 0000 0000 		.long	.LVL44
 3618 03d7 0100      		.word	0x1
 3619 03d9 69        		.byte	0x69
 3620 03da 0000 0000 		.long	.LVL44
 3621 03de 0000 0000 		.long	.LVL46
 3622 03e2 0100      		.word	0x1
 3623 03e4 68        		.byte	0x68
 3624 03e5 0000 0000 		.long	.LVL46
 3625 03e9 0000 0000 		.long	.LVL47
 3626 03ed 0500      		.word	0x5
 3627 03ef 88        		.byte	0x88
 3628 03f0 00        		.sleb128 0
 3629 03f1 34        		.byte	0x34
 3630 03f2 21        		.byte	0x21
 3631 03f3 9F        		.byte	0x9f
 3632 03f4 0000 0000 		.long	.LVL47
 3633 03f8 0000 0000 		.long	.LFE111
GAS LISTING /tmp/ccqx8j8N.s 			page 73


 3634 03fc 0100      		.word	0x1
 3635 03fe 68        		.byte	0x68
 3636 03ff 0000 0000 		.long	0
 3637 0403 0000 0000 		.long	0
 3638               	.LLST23:
 3639 0407 0000 0000 		.long	.LFB112
 3640 040b 0000 0000 		.long	.LCFI11
 3641 040f 0300      		.word	0x3
 3642 0411 92        		.byte	0x92
 3643 0412 20        		.uleb128 0x20
 3644 0413 03        		.sleb128 3
 3645 0414 0000 0000 		.long	.LCFI11
 3646 0418 0000 0000 		.long	.LCFI12
 3647 041c 0300      		.word	0x3
 3648 041e 92        		.byte	0x92
 3649 041f 20        		.uleb128 0x20
 3650 0420 04        		.sleb128 4
 3651 0421 0000 0000 		.long	.LCFI12
 3652 0425 0000 0000 		.long	.LCFI13
 3653 0429 0300      		.word	0x3
 3654 042b 92        		.byte	0x92
 3655 042c 20        		.uleb128 0x20
 3656 042d 05        		.sleb128 5
 3657 042e 0000 0000 		.long	.LCFI13
 3658 0432 0000 0000 		.long	.LFE112
 3659 0436 0300      		.word	0x3
 3660 0438 92        		.byte	0x92
 3661 0439 20        		.uleb128 0x20
 3662 043a 06        		.sleb128 6
 3663 043b 0000 0000 		.long	0
 3664 043f 0000 0000 		.long	0
 3665               	.LLST24:
 3666 0443 0000 0000 		.long	.LVL48
 3667 0447 0000 0000 		.long	.LVL50
 3668 044b 0600      		.word	0x6
 3669 044d 68        		.byte	0x68
 3670 044e 93        		.byte	0x93
 3671 044f 01        		.uleb128 0x1
 3672 0450 69        		.byte	0x69
 3673 0451 93        		.byte	0x93
 3674 0452 01        		.uleb128 0x1
 3675 0453 0000 0000 		.long	.LVL50
 3676 0457 0000 0000 		.long	.LFE112
 3677 045b 0400      		.word	0x4
 3678 045d F3        		.byte	0xf3
 3679 045e 01        		.uleb128 0x1
 3680 045f 68        		.byte	0x68
 3681 0460 9F        		.byte	0x9f
 3682 0461 0000 0000 		.long	0
 3683 0465 0000 0000 		.long	0
 3684               	.LLST25:
 3685 0469 0000 0000 		.long	.LVL48
 3686 046d 0000 0000 		.long	.LVL50
 3687 0471 0100      		.word	0x1
 3688 0473 66        		.byte	0x66
 3689 0474 0000 0000 		.long	.LVL50
 3690 0478 0000 0000 		.long	.LFE112
GAS LISTING /tmp/ccqx8j8N.s 			page 74


 3691 047c 0400      		.word	0x4
 3692 047e F3        		.byte	0xf3
 3693 047f 01        		.uleb128 0x1
 3694 0480 66        		.byte	0x66
 3695 0481 9F        		.byte	0x9f
 3696 0482 0000 0000 		.long	0
 3697 0486 0000 0000 		.long	0
 3698               	.LLST26:
 3699 048a 0000 0000 		.long	.LVL49
 3700 048e 0000 0000 		.long	.LVL50
 3701 0492 0600      		.word	0x6
 3702 0494 68        		.byte	0x68
 3703 0495 93        		.byte	0x93
 3704 0496 01        		.uleb128 0x1
 3705 0497 69        		.byte	0x69
 3706 0498 93        		.byte	0x93
 3707 0499 01        		.uleb128 0x1
 3708 049a 0000 0000 		.long	.LVL50
 3709 049e 0000 0000 		.long	.LVL51
 3710 04a2 0600      		.word	0x6
 3711 04a4 6C        		.byte	0x6c
 3712 04a5 93        		.byte	0x93
 3713 04a6 01        		.uleb128 0x1
 3714 04a7 6D        		.byte	0x6d
 3715 04a8 93        		.byte	0x93
 3716 04a9 01        		.uleb128 0x1
 3717 04aa 0000 0000 		.long	.LVL51
 3718 04ae 0000 0000 		.long	.LVL52
 3719 04b2 0300      		.word	0x3
 3720 04b4 8C        		.byte	0x8c
 3721 04b5 01        		.sleb128 1
 3722 04b6 9F        		.byte	0x9f
 3723 04b7 0000 0000 		.long	.LVL52
 3724 04bb 0000 0000 		.long	.LVL57
 3725 04bf 0600      		.word	0x6
 3726 04c1 6C        		.byte	0x6c
 3727 04c2 93        		.byte	0x93
 3728 04c3 01        		.uleb128 0x1
 3729 04c4 6D        		.byte	0x6d
 3730 04c5 93        		.byte	0x93
 3731 04c6 01        		.uleb128 0x1
 3732 04c7 0000 0000 		.long	0
 3733 04cb 0000 0000 		.long	0
 3734               	.LLST27:
 3735 04cf 0000 0000 		.long	.LVL49
 3736 04d3 0000 0000 		.long	.LVL50
 3737 04d7 0100      		.word	0x1
 3738 04d9 66        		.byte	0x66
 3739 04da 0000 0000 		.long	.LVL50
 3740 04de 0000 0000 		.long	.LVL52
 3741 04e2 0C00      		.word	0xc
 3742 04e4 8C        		.byte	0x8c
 3743 04e5 00        		.sleb128 0
 3744 04e6 20        		.byte	0x20
 3745 04e7 F3        		.byte	0xf3
 3746 04e8 01        		.uleb128 0x1
 3747 04e9 66        		.byte	0x66
GAS LISTING /tmp/ccqx8j8N.s 			page 75


 3748 04ea 22        		.byte	0x22
 3749 04eb F3        		.byte	0xf3
 3750 04ec 01        		.uleb128 0x1
 3751 04ed 68        		.byte	0x68
 3752 04ee 22        		.byte	0x22
 3753 04ef 9F        		.byte	0x9f
 3754 04f0 0000 0000 		.long	.LVL52
 3755 04f4 0000 0000 		.long	.LVL56
 3756 04f8 0B00      		.word	0xb
 3757 04fa F3        		.byte	0xf3
 3758 04fb 01        		.uleb128 0x1
 3759 04fc 66        		.byte	0x66
 3760 04fd 8C        		.byte	0x8c
 3761 04fe 00        		.sleb128 0
 3762 04ff 1C        		.byte	0x1c
 3763 0500 F3        		.byte	0xf3
 3764 0501 01        		.uleb128 0x1
 3765 0502 68        		.byte	0x68
 3766 0503 22        		.byte	0x22
 3767 0504 9F        		.byte	0x9f
 3768 0505 0000 0000 		.long	.LVL56
 3769 0509 0000 0000 		.long	.LVL57
 3770 050d 0C00      		.word	0xc
 3771 050f 8C        		.byte	0x8c
 3772 0510 00        		.sleb128 0
 3773 0511 20        		.byte	0x20
 3774 0512 F3        		.byte	0xf3
 3775 0513 01        		.uleb128 0x1
 3776 0514 66        		.byte	0x66
 3777 0515 22        		.byte	0x22
 3778 0516 F3        		.byte	0xf3
 3779 0517 01        		.uleb128 0x1
 3780 0518 68        		.byte	0x68
 3781 0519 22        		.byte	0x22
 3782 051a 9F        		.byte	0x9f
 3783 051b 0000 0000 		.long	0
 3784 051f 0000 0000 		.long	0
 3785               	.LLST28:
 3786 0523 0000 0000 		.long	.LFB114
 3787 0527 0000 0000 		.long	.LCFI14
 3788 052b 0300      		.word	0x3
 3789 052d 92        		.byte	0x92
 3790 052e 20        		.uleb128 0x20
 3791 052f 03        		.sleb128 3
 3792 0530 0000 0000 		.long	.LCFI14
 3793 0534 0000 0000 		.long	.LFE114
 3794 0538 0300      		.word	0x3
 3795 053a 92        		.byte	0x92
 3796 053b 20        		.uleb128 0x20
 3797 053c 04        		.sleb128 4
 3798 053d 0000 0000 		.long	0
 3799 0541 0000 0000 		.long	0
 3800               	.LLST29:
 3801 0545 0000 0000 		.long	.LVL74
 3802 0549 0000 0000 		.long	.LVL75
 3803 054d 0100      		.word	0x1
 3804 054f 68        		.byte	0x68
GAS LISTING /tmp/ccqx8j8N.s 			page 76


 3805 0550 0000 0000 		.long	.LVL75
 3806 0554 0000 0000 		.long	.LVL76
 3807 0558 0500      		.word	0x5
 3808 055a 03        		.byte	0x3
 3809 055b 0000 0000 		.long	lcdAddress
 3810 055f 0000 0000 		.long	.LVL76
 3811 0563 0000 0000 		.long	.LVL77
 3812 0567 0100      		.word	0x1
 3813 0569 68        		.byte	0x68
 3814 056a 0000 0000 		.long	.LVL77
 3815 056e 0000 0000 		.long	.LVL80-1
 3816 0572 0500      		.word	0x5
 3817 0574 03        		.byte	0x3
 3818 0575 0000 0000 		.long	lcdAddress
 3819 0579 0000 0000 		.long	.LVL80-1
 3820 057d 0000 0000 		.long	.LFE114
 3821 0581 0400      		.word	0x4
 3822 0583 F3        		.byte	0xf3
 3823 0584 01        		.uleb128 0x1
 3824 0585 68        		.byte	0x68
 3825 0586 9F        		.byte	0x9f
 3826 0587 0000 0000 		.long	0
 3827 058b 0000 0000 		.long	0
 3828               	.LLST30:
 3829 058f 0000 0000 		.long	.LVL74
 3830 0593 0000 0000 		.long	.LVL79
 3831 0597 0100      		.word	0x1
 3832 0599 66        		.byte	0x66
 3833 059a 0000 0000 		.long	.LVL79
 3834 059e 0000 0000 		.long	.LVL80-1
 3835 05a2 0500      		.word	0x5
 3836 05a4 03        		.byte	0x3
 3837 05a5 0000 0000 		.long	lcdCols
 3838 05a9 0000 0000 		.long	.LVL80-1
 3839 05ad 0000 0000 		.long	.LFE114
 3840 05b1 0400      		.word	0x4
 3841 05b3 F3        		.byte	0xf3
 3842 05b4 01        		.uleb128 0x1
 3843 05b5 66        		.byte	0x66
 3844 05b6 9F        		.byte	0x9f
 3845 05b7 0000 0000 		.long	0
 3846 05bb 0000 0000 		.long	0
 3847               	.LLST31:
 3848 05bf 0000 0000 		.long	.LVL74
 3849 05c3 0000 0000 		.long	.LVL78
 3850 05c7 0100      		.word	0x1
 3851 05c9 64        		.byte	0x64
 3852 05ca 0000 0000 		.long	.LVL78
 3853 05ce 0000 0000 		.long	.LVL94
 3854 05d2 0100      		.word	0x1
 3855 05d4 6C        		.byte	0x6c
 3856 05d5 0000 0000 		.long	.LVL94
 3857 05d9 0000 0000 		.long	.LFE114
 3858 05dd 0400      		.word	0x4
 3859 05df F3        		.byte	0xf3
 3860 05e0 01        		.uleb128 0x1
 3861 05e1 64        		.byte	0x64
GAS LISTING /tmp/ccqx8j8N.s 			page 77


 3862 05e2 9F        		.byte	0x9f
 3863 05e3 0000 0000 		.long	0
 3864 05e7 0000 0000 		.long	0
 3865               	.LLST32:
 3866 05eb 0000 0000 		.long	.LVL74
 3867 05ef 0000 0000 		.long	.LVL80-1
 3868 05f3 0100      		.word	0x1
 3869 05f5 62        		.byte	0x62
 3870 05f6 0000 0000 		.long	.LVL80-1
 3871 05fa 0000 0000 		.long	.LFE114
 3872 05fe 0400      		.word	0x4
 3873 0600 F3        		.byte	0xf3
 3874 0601 01        		.uleb128 0x1
 3875 0602 62        		.byte	0x62
 3876 0603 9F        		.byte	0x9f
 3877 0604 0000 0000 		.long	0
 3878 0608 0000 0000 		.long	0
 3879               		.section	.debug_aranges,"",@progbits
 3880 0000 8C00 0000 		.long	0x8c
 3881 0004 0200      		.word	0x2
 3882 0006 0000 0000 		.long	.Ldebug_info0
 3883 000a 04        		.byte	0x4
 3884 000b 00        		.byte	0
 3885 000c 0000      		.word	0
 3886 000e 0000      		.word	0
 3887 0010 0000 0000 		.long	.LFB102
 3888 0014 4800 0000 		.long	.LFE102-.LFB102
 3889 0018 0000 0000 		.long	.LFB103
 3890 001c 3000 0000 		.long	.LFE103-.LFB103
 3891 0020 0000 0000 		.long	.LFB104
 3892 0024 5800 0000 		.long	.LFE104-.LFB104
 3893 0028 0000 0000 		.long	.LFB105
 3894 002c 3200 0000 		.long	.LFE105-.LFB105
 3895 0030 0000 0000 		.long	.LFB106
 3896 0034 2200 0000 		.long	.LFE106-.LFB106
 3897 0038 0000 0000 		.long	.LFB107
 3898 003c 2200 0000 		.long	.LFE107-.LFB107
 3899 0040 0000 0000 		.long	.LFB108
 3900 0044 2A00 0000 		.long	.LFE108-.LFB108
 3901 0048 0000 0000 		.long	.LFB109
 3902 004c 2C00 0000 		.long	.LFE109-.LFB109
 3903 0050 0000 0000 		.long	.LFB110
 3904 0054 6A00 0000 		.long	.LFE110-.LFB110
 3905 0058 0000 0000 		.long	.LFB111
 3906 005c 3A00 0000 		.long	.LFE111-.LFB111
 3907 0060 0000 0000 		.long	.LFB112
 3908 0064 4400 0000 		.long	.LFE112-.LFB112
 3909 0068 0000 0000 		.long	.LFB113
 3910 006c A400 0000 		.long	.LFE113-.LFB113
 3911 0070 0000 0000 		.long	.LFB114
 3912 0074 DA00 0000 		.long	.LFE114-.LFB114
 3913 0078 0000 0000 		.long	.LFB115
 3914 007c 1600 0000 		.long	.LFE115-.LFB115
 3915 0080 0000 0000 		.long	.LFB116
 3916 0084 0200 0000 		.long	.LFE116-.LFB116
 3917 0088 0000 0000 		.long	0
 3918 008c 0000 0000 		.long	0
GAS LISTING /tmp/ccqx8j8N.s 			page 78


 3919               		.section	.debug_ranges,"",@progbits
 3920               	.Ldebug_ranges0:
 3921 0000 0000 0000 		.long	.LFB102
 3922 0004 0000 0000 		.long	.LFE102
 3923 0008 0000 0000 		.long	.LFB103
 3924 000c 0000 0000 		.long	.LFE103
 3925 0010 0000 0000 		.long	.LFB104
 3926 0014 0000 0000 		.long	.LFE104
 3927 0018 0000 0000 		.long	.LFB105
 3928 001c 0000 0000 		.long	.LFE105
 3929 0020 0000 0000 		.long	.LFB106
 3930 0024 0000 0000 		.long	.LFE106
 3931 0028 0000 0000 		.long	.LFB107
 3932 002c 0000 0000 		.long	.LFE107
 3933 0030 0000 0000 		.long	.LFB108
 3934 0034 0000 0000 		.long	.LFE108
 3935 0038 0000 0000 		.long	.LFB109
 3936 003c 0000 0000 		.long	.LFE109
 3937 0040 0000 0000 		.long	.LFB110
 3938 0044 0000 0000 		.long	.LFE110
 3939 0048 0000 0000 		.long	.LFB111
 3940 004c 0000 0000 		.long	.LFE111
 3941 0050 0000 0000 		.long	.LFB112
 3942 0054 0000 0000 		.long	.LFE112
 3943 0058 0000 0000 		.long	.LFB113
 3944 005c 0000 0000 		.long	.LFE113
 3945 0060 0000 0000 		.long	.LFB114
 3946 0064 0000 0000 		.long	.LFE114
 3947 0068 0000 0000 		.long	.LFB115
 3948 006c 0000 0000 		.long	.LFE115
 3949 0070 0000 0000 		.long	.LFB116
 3950 0074 0000 0000 		.long	.LFE116
 3951 0078 0000 0000 		.long	0
 3952 007c 0000 0000 		.long	0
 3953               		.section	.debug_line,"",@progbits
 3954               	.Ldebug_line0:
 3955 0000 D402 0000 		.section	.debug_str,"MS",@progbits,1
 3955      0200 B400 
 3955      0000 0201 
 3955      FB0E 0D00 
 3955      0101 0101 
 3956               	.LASF27:
 3957 0000 7477 6953 		.string	"twiSetup"
 3957      6574 7570 
 3957      00
 3958               	.LASF44:
 3959 0009 5F64 6174 		.string	"_data"
 3959      6100 
 3960               	.LASF9:
 3961 000f 6C6F 6E67 		.string	"long long unsigned int"
 3961      206C 6F6E 
 3961      6720 756E 
 3961      7369 676E 
 3961      6564 2069 
 3962               	.LASF18:
 3963 0026 7374 6172 		.string	"starts"
 3963      7473 00
GAS LISTING /tmp/ccqx8j8N.s 			page 79


 3964               	.LASF70:
 3965 002d 6C63 6453 		.string	"lcdShifts"
 3965      6869 6674 
 3965      7300 
 3966               	.LASF60:
 3967 0037 7477 6952 		.string	"twiRX_Count"
 3967      585F 436F 
 3967      756E 7400 
 3968               	.LASF8:
 3969 0043 6C6F 6E67 		.string	"long long int"
 3969      206C 6F6E 
 3969      6720 696E 
 3969      7400 
 3970               	.LASF0:
 3971 0051 7369 676E 		.string	"signed char"
 3971      6564 2063 
 3971      6861 7200 
 3972               	.LASF28:
 3973 005d 6672 6571 		.string	"freq"
 3973      00
 3974               	.LASF20:
 3975 0062 7374 6F70 		.string	"stops"
 3975      7300 
 3976               	.LASF17:
 3977 0068 5457 495F 		.string	"TWI_READY"
 3977      5245 4144 
 3977      5900 
 3978               	.LASF71:
 3979 0072 6C63 6453 		.string	"lcdShows"
 3979      686F 7773 
 3979      00
 3980               	.LASF5:
 3981 007b 6C6F 6E67 		.string	"long int"
 3981      2069 6E74 
 3981      00
 3982               	.LASF31:
 3983 0084 5F5F 7665 		.string	"__vector_39"
 3983      6374 6F72 
 3983      5F33 3900 
 3984               	.LASF68:
 3985 0090 7477 6953 		.string	"twiStatistic"
 3985      7461 7469 
 3985      7374 6963 
 3985      00
 3986               	.LASF3:
 3987 009d 7569 6E74 		.string	"uint16_t"
 3987      3136 5F74 
 3987      00
 3988               	.LASF13:
 3989 00a6 646F 7562 		.string	"double"
 3989      6C65 00
 3990               	.LASF41:
 3991 00ad 636C 656E 		.string	"clength"
 3991      6774 6800 
 3992               	.LASF67:
 3993 00b5 7477 6953 		.string	"twiSlaveWriter"
 3993      6C61 7665 
GAS LISTING /tmp/ccqx8j8N.s 			page 80


 3993      5772 6974 
 3993      6572 00
 3994               	.LASF39:
 3995 00c4 7477 6952 		.string	"twiRAW"
 3995      4157 00
 3996               	.LASF46:
 3997 00cb 6C63 6457 		.string	"lcdWrite"
 3997      7269 7465 
 3997      00
 3998               	.LASF38:
 3999 00d4 7477 6952 		.string	"twiRead"
 3999      6561 6400 
 4000               	.LASF25:
 4001 00dc 6269 744D 		.string	"bitMul"
 4001      756C 00
 4002               	.LASF4:
 4003 00e3 756E 7369 		.string	"unsigned int"
 4003      676E 6564 
 4003      2069 6E74 
 4003      00
 4004               	.LASF73:
 4005 00f0 6C63 6441 		.string	"lcdAddress"
 4005      6464 7265 
 4005      7373 00
 4006               	.LASF61:
 4007 00fb 7477 6952 		.string	"twiRX_Ptr"
 4007      585F 5074 
 4007      7200 
 4008               	.LASF40:
 4009 0105 636F 6D6D 		.string	"command"
 4009      616E 6400 
 4010               	.LASF83:
 4011 010d 6C6F 6F70 		.string	"loop"
 4011      00
 4012               	.LASF48:
 4013 0112 6C63 6453 		.string	"lcdSetup"
 4013      6574 7570 
 4013      00
 4014               	.LASF7:
 4015 011b 6C6F 6E67 		.string	"long unsigned int"
 4015      2075 6E73 
 4015      6967 6E65 
 4015      6420 696E 
 4015      7400 
 4016               	.LASF57:
 4017 012d 7477 6953 		.string	"twiSLARW"
 4017      4C41 5257 
 4017      00
 4018               	.LASF49:
 4019 0136 5F61 6464 		.string	"_address"
 4019      7265 7373 
 4019      00
 4020               	.LASF36:
 4021 013f 6461 7461 		.string	"data"
 4021      00
 4022               	.LASF14:
 4023 0144 7368 6F72 		.string	"short unsigned int"
GAS LISTING /tmp/ccqx8j8N.s 			page 81


 4023      7420 756E 
 4023      7369 676E 
 4023      6564 2069 
 4023      6E74 00
 4024               	.LASF23:
 4025 0157 5457 495F 		.string	"TWI_Stat"
 4025      5374 6174 
 4025      00
 4026               	.LASF51:
 4027 0160 5F72 6F77 		.string	"_rows"
 4027      7300 
 4028               	.LASF10:
 4029 0166 626F 6F6C 		.string	"bool"
 4029      00
 4030               	.LASF55:
 4031 016b 7477 694D 		.string	"twiMode"
 4031      6F64 6500 
 4032               	.LASF65:
 4033 0173 7477 694D 		.string	"twiMasterReader"
 4033      6173 7465 
 4033      7252 6561 
 4033      6465 7200 
 4034               	.LASF81:
 4035 0183 5457 495F 		.string	"TWI_Modes"
 4035      4D6F 6465 
 4035      7300 
 4036               	.LASF58:
 4037 018d 7477 694D 		.string	"twiMT_Count"
 4037      545F 436F 
 4037      756E 7400 
 4038               	.LASF30:
 4039 0199 7477 6953 		.string	"twiSendStop"
 4039      656E 6453 
 4039      746F 7000 
 4040               	.LASF33:
 4041 01a5 6164 6472 		.string	"address"
 4041      6573 7300 
 4042               	.LASF32:
 4043 01ad 5F74 7769 		.string	"_twiStartTo"
 4043      5374 6172 
 4043      7454 6F00 
 4044               	.LASF53:
 4045 01b9 7365 7475 		.string	"setup"
 4045      7000 
 4046               	.LASF12:
 4047 01bf 666C 6F61 		.string	"float"
 4047      7400 
 4048               	.LASF75:
 4049 01c5 6C63 6452 		.string	"lcdRows"
 4049      6F77 7300 
 4050               	.LASF84:
 4051 01cd 7469 6D65 		.string	"time_delay16"
 4051      5F64 656C 
 4051      6179 3136 
 4051      00
 4052               	.LASF59:
 4053 01da 7477 694D 		.string	"twiMT_Ptr"
GAS LISTING /tmp/ccqx8j8N.s 			page 82


 4053      545F 5074 
 4053      7200 
 4054               	.LASF43:
 4055 01e4 6C63 6450 		.string	"lcdPrepare"
 4055      7265 7061 
 4055      7265 00
 4056               	.LASF19:
 4057 01ef 7265 7374 		.string	"restarts"
 4057      6172 7473 
 4057      00
 4058               	.LASF52:
 4059 01f8 5F62 6163 		.string	"_backLight"
 4059      6B4C 6967 
 4059      6874 00
 4060               	.LASF78:
 4061 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4061      432B 2B20 
 4061      342E 382E 
 4061      3120 2D6D 
 4061      6D63 753D 
 4062               	.LASF1:
 4063 0295 756E 7369 		.string	"unsigned char"
 4063      676E 6564 
 4063      2063 6861 
 4063      7200 
 4064               	.LASF50:
 4065 02a3 5F63 6F6C 		.string	"_cols"
 4065      7300 
 4066               	.LASF80:
 4067 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4067      2F62 7569 
 4067      6C64 3132 
 4067      3336 3837 
 4067      3935 3737 
 4068               	.LASF24:
 4069 02cb 6269 7452 		.string	"bitRate"
 4069      6174 6500 
 4070               	.LASF56:
 4071 02d3 7477 6953 		.string	"twiState"
 4071      7461 7465 
 4071      00
 4072               	.LASF79:
 4073 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4073      2F62 7569 
 4073      6C64 3132 
 4073      3336 3837 
 4073      3935 3737 
 4074               	.LASF6:
 4075 030c 7569 6E74 		.string	"uint32_t"
 4075      3332 5F74 
 4075      00
 4076               	.LASF77:
 4077 0315 6C63 6442 		.string	"lcdBuffer"
 4077      7566 6665 
 4077      7200 
 4078               	.LASF22:
 4079 031f 6E6F 736C 		.string	"noslarw"
GAS LISTING /tmp/ccqx8j8N.s 			page 83


 4079      6172 7700 
 4080               	.LASF37:
 4081 0327 6C65 6E67 		.string	"length"
 4081      7468 00
 4082               	.LASF11:
 4083 032e 6368 6172 		.string	"char"
 4083      00
 4084               	.LASF42:
 4085 0333 646C 656E 		.string	"dlength"
 4085      6774 6800 
 4086               	.LASF29:
 4087 033b 6D6F 6465 		.string	"mode"
 4087      00
 4088               	.LASF74:
 4089 0340 6C63 6443 		.string	"lcdCols"
 4089      6F6C 7300 
 4090               	.LASF21:
 4091 0348 6C6F 7374 		.string	"losts"
 4091      7300 
 4092               	.LASF54:
 4093 034e 7469 6D65 		.string	"time"
 4093      00
 4094               	.LASF26:
 4095 0353 7477 6953 		.string	"twiSpeed"
 4095      7065 6564 
 4095      00
 4096               	.LASF16:
 4097 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4097      5345 4E44 
 4097      5F53 544F 
 4097      5000 
 4098               	.LASF72:
 4099 036a 6C63 6442 		.string	"lcdBackLight"
 4099      6163 6B4C 
 4099      6967 6874 
 4099      00
 4100               	.LASF2:
 4101 0377 7569 6E74 		.string	"uint8_t"
 4101      385F 7400 
 4102               	.LASF82:
 4103 037f 3854 5749 		.string	"8TWI_Stat"
 4103      5F53 7461 
 4103      7400 
 4104               	.LASF76:
 4105 0389 7369 7A65 		.string	"sizetype"
 4105      7479 7065 
 4105      00
 4106               	.LASF47:
 4107 0392 6C63 6449 		.string	"lcdInit"
 4107      6E69 7400 
 4108               	.LASF66:
 4109 039a 7477 6953 		.string	"twiSlaveReader"
 4109      6C61 7665 
 4109      5265 6164 
 4109      6572 00
 4110               	.LASF64:
 4111 03a9 7477 6948 		.string	"twiHookRestart"
GAS LISTING /tmp/ccqx8j8N.s 			page 84


 4111      6F6F 6B52 
 4111      6573 7461 
 4111      7274 00
 4112               	.LASF63:
 4113 03b8 7477 6953 		.string	"twiST_Ptr"
 4113      545F 5074 
 4113      7200 
 4114               	.LASF34:
 4115 03c2 5F74 7769 		.string	"_twiStartRe"
 4115      5374 6172 
 4115      7452 6500 
 4116               	.LASF35:
 4117 03ce 7477 6957 		.string	"twiWrite"
 4117      7269 7465 
 4117      00
 4118               	.LASF69:
 4119 03d7 6C63 644D 		.string	"lcdModes"
 4119      6F64 6573 
 4119      00
 4120               	.LASF45:
 4121 03e0 6E69 6262 		.string	"nibble"
 4121      6C65 00
 4122               	.LASF62:
 4123 03e7 7477 6953 		.string	"twiST_Count"
 4123      545F 436F 
 4123      756E 7400 
 4124               	.LASF15:
 4125 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4125      4953 5F53 
 4125      4C41 5645 
 4125      00
 4126               		.ident	"GCC: (GNU) 4.8.1"
 4127               	.global __do_copy_data
 4128               	.global __do_clear_bss
GAS LISTING /tmp/ccqx8j8N.s 			page 85


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccqx8j8N.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccqx8j8N.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccqx8j8N.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccqx8j8N.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccqx8j8N.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccqx8j8N.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccqx8j8N.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccqx8j8N.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccqx8j8N.s:1047   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccqx8j8N.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccqx8j8N.s:993    .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccqx8j8N.s:1035   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccqx8j8N.s:222    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccqx8j8N.s:1041   .bss.twiState:0000000000000000 twiState
     /tmp/ccqx8j8N.s:280    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccqx8j8N.s:315    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccqx8j8N.s:350    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccqx8j8N.s:1023   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccqx8j8N.s:1029   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccqx8j8N.s:385    .text.twiRead:0000000000000000 twiRead
     /tmp/ccqx8j8N.s:1011   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccqx8j8N.s:1017   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccqx8j8N.s:421    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccqx8j8N.s:494    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccqx8j8N.s:946    .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccqx8j8N.s:922    .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccqx8j8N.s:557    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccqx8j8N.s:940    .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccqx8j8N.s:628    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccqx8j8N.s:964    .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccqx8j8N.s:952    .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccqx8j8N.s:958    .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccqx8j8N.s:721    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccqx8j8N.s:934    .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccqx8j8N.s:928    .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccqx8j8N.s:877    .text.setup:0000000000000000 setup
     /tmp/ccqx8j8N.s:906    .text.loop:0000000000000000 loop
     /tmp/ccqx8j8N.s:969    .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccqx8j8N.s:975    .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccqx8j8N.s:981    .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccqx8j8N.s:987    .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccqx8j8N.s:999    .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccqx8j8N.s:1005   .bss.twiST_Count:0000000000000000 twiST_Count

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
