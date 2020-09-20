GAS LISTING /tmp/ccChP33i.s 			page 1


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
GAS LISTING /tmp/ccChP33i.s 			page 2


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
GAS LISTING /tmp/ccChP33i.s 			page 3


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
 150:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiMT_Count;                         // остаток байт для пере�
 151:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiMT_Ptr;                          // указатель текущего ба
 152:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 153:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiRX_Count;                         // остаток байт для прие�
 154:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t  * twiRX_Ptr;                          // указатель текущего ба
 155:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccChP33i.s 			page 4


 156:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** volatile uint8_t   twiST_Count;                         // остаток байт для пере�
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
GAS LISTING /tmp/ccChP33i.s 			page 5


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
GAS LISTING /tmp/ccChP33i.s 			page 6


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
GAS LISTING /tmp/ccChP33i.s 			page 7


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
GAS LISTING /tmp/ccChP33i.s 			page 8


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
 184               	.LBB5:
 185               	.LBB6:
 246:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 247:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( twiHookRestart ){
 186               		.loc 1 247 0
 187 002c E091 0000 		lds r30,twiHookRestart
 188 0030 F091 0000 		lds r31,twiHookRestart+1
 189 0034 3097      		sbiw r30,0
 190 0036 01F0      		breq .L16
 248:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiHookRestart();
 191               		.loc 1 248 0
 192 0038 1995      		eicall
 193               	.LVL16:
 194 003a 00C0      		rjmp .L17
 195               	.LVL17:
 196               	.L16:
 249:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         } else {
 250:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSLARW |= TWI_READ;
 197               		.loc 1 250 0
 198 003c 8091 0000 		lds r24,twiSLARW
 199               	.LVL18:
 200 0040 8160      		ori r24,lo8(1)
 201 0042 8093 0000 		sts twiSLARW,r24
 202               	.L17:
 251:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 252:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         TWCR = twiStart(_md & TWI_IS_SLAVE);
 203               		.loc 1 252 0
 204 0046 CC23      		tst r28
GAS LISTING /tmp/ccChP33i.s 			page 9


 205 0048 01F0      		breq .L20
 206 004a 85EE      		ldi r24,lo8(-27)
 207 004c 00C0      		rjmp .L18
 208               	.L20:
 209 004e 85EA      		ldi r24,lo8(-91)
 210               	.L18:
 211 0050 8093 BC00 		sts 188,r24
 212               	.LVL19:
 213               	.L10:
 214               	/* epilogue start */
 215               	.LBE6:
 216               	.LBE5:
 253:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 254:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 217               		.loc 1 254 0
 218 0054 CF91      		pop r28
 219 0056 0895      		ret
 220               		.cfi_endproc
 221               	.LFE104:
 222               		.size	twiSendStop, .-twiSendStop
 223               		.section	.text.__vector_39,"ax",@progbits
 224               	.global	__vector_39
 225               		.type	__vector_39, @function
 226               	__vector_39:
 227               	.LFB105:
 255:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 256:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 257:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ISR for TWI interface: realised master and slave modes
 258:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * ------------------------------------------------------
 259:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 260:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ISR(TWI_vect)
 261:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 228               		.loc 1 261 0
 229               		.cfi_startproc
 230 0000 1F92      		push r1
 231               	.LCFI5:
 232               		.cfi_def_cfa_offset 4
 233               		.cfi_offset 1, -3
 234 0002 0F92      		push r0
 235               	.LCFI6:
 236               		.cfi_def_cfa_offset 5
 237               		.cfi_offset 0, -4
 238 0004 0FB6      		in r0,__SREG__
 239 0006 0F92      		push r0
 240 0008 1124      		clr __zero_reg__
 241 000a 0BB6      		in r0,__RAMPZ__
 242 000c 0F92      		push r0
 243 000e 2F93      		push r18
 244               	.LCFI7:
 245               		.cfi_def_cfa_offset 6
 246               		.cfi_offset 18, -5
 247 0010 3F93      		push r19
 248               	.LCFI8:
 249               		.cfi_def_cfa_offset 7
 250               		.cfi_offset 19, -6
 251 0012 4F93      		push r20
 252               	.LCFI9:
GAS LISTING /tmp/ccChP33i.s 			page 10


 253               		.cfi_def_cfa_offset 8
 254               		.cfi_offset 20, -7
 255 0014 5F93      		push r21
 256               	.LCFI10:
 257               		.cfi_def_cfa_offset 9
 258               		.cfi_offset 21, -8
 259 0016 6F93      		push r22
 260               	.LCFI11:
 261               		.cfi_def_cfa_offset 10
 262               		.cfi_offset 22, -9
 263 0018 7F93      		push r23
 264               	.LCFI12:
 265               		.cfi_def_cfa_offset 11
 266               		.cfi_offset 23, -10
 267 001a 8F93      		push r24
 268               	.LCFI13:
 269               		.cfi_def_cfa_offset 12
 270               		.cfi_offset 24, -11
 271 001c 9F93      		push r25
 272               	.LCFI14:
 273               		.cfi_def_cfa_offset 13
 274               		.cfi_offset 25, -12
 275 001e AF93      		push r26
 276               	.LCFI15:
 277               		.cfi_def_cfa_offset 14
 278               		.cfi_offset 26, -13
 279 0020 BF93      		push r27
 280               	.LCFI16:
 281               		.cfi_def_cfa_offset 15
 282               		.cfi_offset 27, -14
 283 0022 EF93      		push r30
 284               	.LCFI17:
 285               		.cfi_def_cfa_offset 16
 286               		.cfi_offset 30, -15
 287 0024 FF93      		push r31
 288               	.LCFI18:
 289               		.cfi_def_cfa_offset 17
 290               		.cfi_offset 31, -16
 291               	/* prologue: Signal */
 292               	/* frame size = 0 */
 293               	/* stack size = 16 */
 294               	.L__stack_usage = 16
 295               	.LBB7:
 262:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _cr;
 263:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _md = twiMode;
 296               		.loc 1 263 0
 297 0026 8091 0000 		lds r24,twiMode
 298               	.LVL20:
 264:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _st = twiState=TWI_STATUS;
 299               		.loc 1 264 0
 300 002a 2091 B900 		lds r18,185
 301 002e 922F      		mov r25,r18
 302 0030 987F      		andi r25,lo8(-8)
 303 0032 9093 0000 		sts twiState,r25
 304               	.LVL21:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
GAS LISTING /tmp/ccChP33i.s 			page 11


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
GAS LISTING /tmp/ccChP33i.s 			page 12


 305               		.loc 1 323 0
 306 0036 9830      		cpi r25,lo8(8)
 307 0038 01F0      		breq .L22
 308               		.loc 1 323 0 is_stmt 0 discriminator 1
 309 003a 9031      		cpi r25,lo8(16)
 310 003c 01F4      		brne .L23
 311               	.L22:
 324:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 325:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка стартовой посылки
 326:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка повторного старта
 327:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             TWDR = twiSLARW;
 312               		.loc 1 327 0 is_stmt 1
 313 003e 9091 0000 		lds r25,twiSLARW
 314               	.LVL22:
 315 0042 00C0      		rjmp .L56
 316               	.LVL23:
 317               	.L23:
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
 329:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 330:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
 318               		.loc 1 330 0
 319 0044 287E      		andi r18,lo8(-24)
 320 0046 2032      		cpi r18,lo8(32)
 321 0048 01F4      		brne .+2
 322 004a 00C0      		rjmp .L35
 331:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 332:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
 333:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликае
 334:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 twiSendStop(_md); return;
 335:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 336:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
 323               		.loc 1 336 0
 324 004c 9831      		cpi r25,lo8(24)
 325 004e 01F0      		breq .L28
 326               		.loc 1 336 0 is_stmt 0 discriminator 1
 327 0050 9832      		cpi r25,lo8(40)
 328 0052 01F4      		brne .L29
 329               	.L28:
 337:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 338:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Адрес получателя отправлен успешно, начи�
 339:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Байт данных отправлен, продолжаем
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( twiMT_Count-- ){
 330               		.loc 1 340 0 is_stmt 1
 331 0054 9091 0000 		lds r25,twiMT_Count
 332               	.LVL24:
 333 0058 2FEF      		ldi r18,lo8(-1)
 334 005a 290F      		add r18,r25
 335 005c 2093 0000 		sts twiMT_Count,r18
 336               	.LVL25:
 337 0060 9923      		tst r25
 338 0062 01F4      		brne .+2
 339 0064 00C0      		rjmp .L35
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *twiMT_Ptr++;
 340               		.loc 1 341 0
 341 0066 E091 0000 		lds r30,twiMT_Ptr
 342 006a F091 0000 		lds r31,twiMT_Ptr+1
 343 006e 9F01      		movw r18,r30
GAS LISTING /tmp/ccChP33i.s 			page 13


 344 0070 2F5F      		subi r18,-1
 345 0072 3F4F      		sbci r19,-1
 346 0074 3093 0000 		sts twiMT_Ptr+1,r19
 347 0078 2093 0000 		sts twiMT_Ptr,r18
 348 007c 9081      		ld r25,Z
 349               	.L56:
 350 007e 9093 BB00 		sts 187,r25
 342:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(_md & TWI_IS_SLAVE);
 351               		.loc 1 342 0
 352 0082 80FF      		sbrs r24,0
 353 0084 00C0      		rjmp .L39
 354 0086 00C0      		rjmp .L24
 355               	.LVL26:
 356               	.L29:
 343:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 344:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 345:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 346:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 347:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 348:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_RX)
 349:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( _st == TWI_MTR_ARB_LOST )
 357               		.loc 1 349 0
 358 0088 9833      		cpi r25,lo8(56)
 359 008a 01F4      		brne .L31
 350:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 351:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // MT,MR: Упс. Мастер потерял шину: освобождаем 
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md |= TWI_READY;
 360               		.loc 1 352 0
 361 008c 982F      		mov r25,r24
 362               	.LVL27:
 363 008e 9460      		ori r25,lo8(4)
 364               	.LVL28:
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 365               		.loc 1 353 0
 366 0090 80FF      		sbrs r24,0
 367 0092 00C0      		rjmp .L38
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 368               		.loc 1 352 0
 369 0094 892F      		mov r24,r25
 370 0096 00C0      		rjmp .L24
 371               	.LVL29:
 372               	.L31:
 354:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 355:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
 373               		.loc 1 355 0
 374 0098 9035      		cpi r25,lo8(80)
 375 009a 01F0      		breq .L32
 376               		.loc 1 355 0 is_stmt 0 discriminator 1
 377 009c 9034      		cpi r25,lo8(64)
 378 009e 01F4      		brne .L55
 379 00a0 00C0      		rjmp .L33
 380               	.L32:
 356:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 357:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_ACK ){
 358:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: байт принят, ACK отправлен
 359:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *(twiRX_Ptr++) = TWDR;
 381               		.loc 1 359 0 is_stmt 1
GAS LISTING /tmp/ccChP33i.s 			page 14


 382 00a2 E091 0000 		lds r30,twiRX_Ptr
 383 00a6 F091 0000 		lds r31,twiRX_Ptr+1
 384 00aa 9F01      		movw r18,r30
 385 00ac 2F5F      		subi r18,-1
 386 00ae 3F4F      		sbci r19,-1
 387 00b0 3093 0000 		sts twiRX_Ptr+1,r19
 388 00b4 2093 0000 		sts twiRX_Ptr,r18
 389 00b8 9091 BB00 		lds r25,187
 390               	.LVL30:
 391 00bc 9083      		st Z,r25
 392               	.LVL31:
 393               	.L33:
 360:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 361:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // MR: Отправитель найден, начинаем прием
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         _cr = twiReply( --twiRX_Count );        // .. Можно ещё приня�
 394               		.loc 1 362 0
 395 00be 9091 0000 		lds r25,twiRX_Count
 396 00c2 9150      		subi r25,lo8(-(-1))
 397 00c4 9093 0000 		sts twiRX_Count,r25
 398 00c8 9923      		tst r25
 399 00ca 01F0      		breq .L39
 400 00cc 00C0      		rjmp .L24
 401               	.LVL32:
 402               	.L55:
 363:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 364:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_ERROR ) return;
 403               		.loc 1 364 0
 404 00ce 9923      		tst r25
 405 00d0 01F0      		breq .L21
 365:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_NACK )
 406               		.loc 1 365 0
 407 00d2 9835      		cpi r25,lo8(88)
 408 00d4 01F4      		brne .L35
 366:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         {
 367:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: Упс. Получен последний байт дальше 
 368:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *twiRX_Ptr = TWDR;
 409               		.loc 1 368 0
 410 00d6 E091 0000 		lds r30,twiRX_Ptr
 411 00da F091 0000 		lds r31,twiRX_Ptr+1
 412 00de 8091 BB00 		lds r24,187
 413               	.LVL33:
 414 00e2 8083      		st Z,r24
 369:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             if( twiMasterReader ) twiMasterReader();
 415               		.loc 1 369 0
 416 00e4 E091 0000 		lds r30,twiMasterReader
 417 00e8 F091 0000 		lds r31,twiMasterReader+1
 418 00ec 3097      		sbiw r30,0
 419 00ee 01F0      		breq .L36
 420               		.loc 1 369 0 is_stmt 0 discriminator 1
 421 00f0 1995      		eicall
 422               	.LVL34:
 423               	.L36:
 370:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //                            goto TWI_RET_HOOK;
 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
 424               		.loc 1 371 0 is_stmt 1 discriminator 3
 425 00f2 8091 0000 		lds r24,twiMode
 426               	.LVL35:
GAS LISTING /tmp/ccChP33i.s 			page 15


 427               	.L35:
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 428               		.loc 1 375 0
 429 00f6 0E94 0000 		call twiSendStop
 430               	.LVL36:
 431 00fa 00C0      		rjmp .L21
 432               	.LVL37:
 433               	.L24:
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 434               		.loc 1 328 0
 435 00fc 95EC      		ldi r25,lo8(-59)
 436 00fe 00C0      		rjmp .L25
 437               	.LVL38:
 438               	.L38:
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 439               		.loc 1 352 0
 440 0100 892F      		mov r24,r25
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 441               		.loc 1 353 0
 442 0102 94E8      		ldi r25,lo8(-124)
 443               	.LVL39:
 444 0104 00C0      		rjmp .L25
 445               	.LVL40:
 446               	.L39:
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 447               		.loc 1 362 0
 448 0106 95E8      		ldi r25,lo8(-123)
 449               	.L25:
 450               	.LVL41:
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
 451               		.loc 1 386 0
 452 0108 8093 0000 		sts twiMode,r24
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 453               		.loc 1 387 0
 454 010c 9093 BC00 		sts 188,r25
 455               	.LVL42:
 456               	.L21:
 457               	/* epilogue start */
 458               	.LBE7:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 459               		.loc 1 388 0
 460 0110 FF91      		pop r31
 461 0112 EF91      		pop r30
 462 0114 BF91      		pop r27
GAS LISTING /tmp/ccChP33i.s 			page 16


 463 0116 AF91      		pop r26
 464 0118 9F91      		pop r25
 465 011a 8F91      		pop r24
 466 011c 7F91      		pop r23
 467 011e 6F91      		pop r22
 468 0120 5F91      		pop r21
 469 0122 4F91      		pop r20
 470 0124 3F91      		pop r19
 471 0126 2F91      		pop r18
 472 0128 0F90      		pop r0
 473 012a 0BBE      		out __RAMPZ__,r0
 474 012c 0F90      		pop r0
 475 012e 0FBE      		out __SREG__,r0
 476 0130 0F90      		pop r0
 477 0132 1F90      		pop r1
 478 0134 1895      		reti
 479               		.cfi_endproc
 480               	.LFE105:
 481               		.size	__vector_39, .-__vector_39
 482               		.section	.text._twiStartTo,"ax",@progbits
 483               	.global	_twiStartTo
 484               		.type	_twiStartTo, @function
 485               	_twiStartTo:
 486               	.LFB106:
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
 487               		.loc 1 400 0
 488               		.cfi_startproc
 489               	.LVL43:
 490               	/* prologue: function */
 491               	/* frame size = 0 */
 492               	/* stack size = 0 */
 493               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 494               		.loc 1 401 0
 495 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 496               		.loc 1 402 0
 497 0004 8091 0000 		lds r24,twiMode
 498               	.LVL44:
 499 0008 8260      		ori r24,lo8(2)
 500 000a 8093 0000 		sts twiMode,r24
 501               	.LVL45:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 502               		.loc 1 403 0
 503 000e 8091 0000 		lds r24,twiMode
 504 0012 80FF      		sbrs r24,0
GAS LISTING /tmp/ccChP33i.s 			page 17


 505 0014 00C0      		rjmp .L59
 506 0016 85EE      		ldi r24,lo8(-27)
 507 0018 00C0      		rjmp .L58
 508               	.L59:
 509 001a 85EA      		ldi r24,lo8(-91)
 510               	.L58:
 511               		.loc 1 403 0 is_stmt 0 discriminator 3
 512 001c 8093 BC00 		sts 188,r24
 513 0020 0895      		ret
 514               		.cfi_endproc
 515               	.LFE106:
 516               		.size	_twiStartTo, .-_twiStartTo
 517               		.section	.text._twiStartRe,"ax",@progbits
 518               	.global	_twiStartRe
 519               		.type	_twiStartRe, @function
 520               	_twiStartRe:
 521               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 522               		.loc 1 412 0 is_stmt 1
 523               		.cfi_startproc
 524               	.LVL46:
 525               	/* prologue: function */
 526               	/* frame size = 0 */
 527               	/* stack size = 0 */
 528               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 529               		.loc 1 413 0
 530 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 531               		.loc 1 414 0
 532 0004 8091 0000 		lds r24,twiMode
 533               	.LVL47:
 534 0008 8D7F      		andi r24,lo8(-3)
 535 000a 8093 0000 		sts twiMode,r24
 536               	.LVL48:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 537               		.loc 1 415 0
 538 000e 8091 0000 		lds r24,twiMode
 539 0012 80FF      		sbrs r24,0
 540 0014 00C0      		rjmp .L62
 541 0016 85EE      		ldi r24,lo8(-27)
 542 0018 00C0      		rjmp .L61
 543               	.L62:
 544 001a 85EA      		ldi r24,lo8(-91)
 545               	.L61:
 546               		.loc 1 415 0 is_stmt 0 discriminator 3
 547 001c 8093 BC00 		sts 188,r24
 548 0020 0895      		ret
 549               		.cfi_endproc
GAS LISTING /tmp/ccChP33i.s 			page 18


 550               	.LFE107:
 551               		.size	_twiStartRe, .-_twiStartRe
 552               		.section	.text.twiWrite,"ax",@progbits
 553               	.global	twiWrite
 554               		.type	twiWrite, @function
 555               	twiWrite:
 556               	.LFB108:
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
 557               		.loc 1 430 0 is_stmt 1
 558               		.cfi_startproc
 559               	/* prologue: function */
 560               	/* frame size = 0 */
 561               	/* stack size = 0 */
 562               	.L__stack_usage = 0
 563               	.LVL49:
 564               	.L65:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 565               		.loc 1 431 0 discriminator 1
 566 0000 9091 0000 		lds r25,twiMode
 567 0004 92FF      		sbrs r25,2
 568 0006 00C0      		rjmp .L65
 569               		.loc 1 431 0 is_stmt 0 discriminator 2
 570 0008 9091 0000 		lds r25,twiMode
 571 000c 9B7F      		andi r25,lo8(-5)
 572 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 573               		.loc 1 432 0 is_stmt 1 discriminator 2
 574 0012 7093 0000 		sts twiMT_Ptr+1,r23
 575 0016 6093 0000 		sts twiMT_Ptr,r22
 576 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 577               		.loc 1 433 0 discriminator 2
 578 001e 880F      		lsl r24
 579               	.LVL50:
 580 0020 0C94 0000 		jmp _twiStartTo
 581               	.LVL51:
 582               		.cfi_endproc
 583               	.LFE108:
 584               		.size	twiWrite, .-twiWrite
 585               		.section	.text.twiRead,"ax",@progbits
 586               	.global	twiRead
 587               		.type	twiRead, @function
 588               	twiRead:
GAS LISTING /tmp/ccChP33i.s 			page 19


 589               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 590               		.loc 1 440 0
 591               		.cfi_startproc
 592               	/* prologue: function */
 593               	/* frame size = 0 */
 594               	/* stack size = 0 */
 595               	.L__stack_usage = 0
 596               	.LVL52:
 597               	.L68:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 598               		.loc 1 441 0 discriminator 1
 599 0000 9091 0000 		lds r25,twiMode
 600 0004 92FF      		sbrs r25,2
 601 0006 00C0      		rjmp .L68
 602               		.loc 1 441 0 is_stmt 0 discriminator 2
 603 0008 9091 0000 		lds r25,twiMode
 604 000c 9B7F      		andi r25,lo8(-5)
 605 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 606               		.loc 1 442 0 is_stmt 1 discriminator 2
 607 0012 7093 0000 		sts twiRX_Ptr+1,r23
 608 0016 6093 0000 		sts twiRX_Ptr,r22
 609 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 610               		.loc 1 443 0 discriminator 2
 611 001e 880F      		lsl r24
 612               	.LVL53:
 613 0020 8160      		ori r24,lo8(1)
 614 0022 0C94 0000 		jmp _twiStartTo
 615               	.LVL54:
 616               		.cfi_endproc
 617               	.LFE109:
 618               		.size	twiRead, .-twiRead
 619               		.section	.text.twiRAW,"ax",@progbits
 620               	.global	twiRAW
 621               		.type	twiRAW, @function
 622               	twiRAW:
 623               	.LFB110:
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
 624               		.loc 1 453 0
 625               		.cfi_startproc
GAS LISTING /tmp/ccChP33i.s 			page 20


 626               	.LVL55:
 627 0000 0F93      		push r16
 628               	.LCFI19:
 629               		.cfi_def_cfa_offset 4
 630               		.cfi_offset 16, -3
 631               	/* prologue: function */
 632               	/* frame size = 0 */
 633               	/* stack size = 1 */
 634               	.L__stack_usage = 1
 635               	.L71:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 636               		.loc 1 454 0 discriminator 1
 637 0002 9091 0000 		lds r25,twiMode
 638 0006 92FF      		sbrs r25,2
 639 0008 00C0      		rjmp .L71
 640               		.loc 1 454 0 is_stmt 0 discriminator 2
 641 000a 9091 0000 		lds r25,twiMode
 642 000e 9B7F      		andi r25,lo8(-5)
 643 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 644               		.loc 1 455 0 is_stmt 1 discriminator 2
 645 0014 7093 0000 		sts twiMT_Ptr+1,r23
 646 0018 6093 0000 		sts twiMT_Ptr,r22
 647 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 648               		.loc 1 456 0 discriminator 2
 649 0020 3093 0000 		sts twiRX_Ptr+1,r19
 650 0024 2093 0000 		sts twiRX_Ptr,r18
 651 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 652               		.loc 1 458 0 discriminator 2
 653 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 654 0030 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 655               		.loc 1 459 0 discriminator 2
 656 0034 9091 0000 		lds r25,twiMode
 657 0038 9D7F      		andi r25,lo8(-3)
 658 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 659               		.loc 1 460 0 discriminator 2
 660 003e 880F      		lsl r24
 661               	.LVL56:
 662 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 663               		.loc 1 461 0 discriminator 2
 664 0044 8091 0000 		lds r24,twiMode
 665 0048 80FF      		sbrs r24,0
 666 004a 00C0      		rjmp .L73
 667               		.loc 1 461 0 is_stmt 0
 668 004c 85EE      		ldi r24,lo8(-27)
 669 004e 00C0      		rjmp .L72
 670               	.L73:
 671 0050 85EA      		ldi r24,lo8(-91)
 672               	.L72:
 673               		.loc 1 461 0 discriminator 3
 674 0052 8093 BC00 		sts 188,r24
GAS LISTING /tmp/ccChP33i.s 			page 21


 675               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 676               		.loc 1 462 0 is_stmt 1 discriminator 3
 677 0056 0F91      		pop r16
 678               	.LVL57:
 679 0058 0895      		ret
 680               		.cfi_endproc
 681               	.LFE110:
 682               		.size	twiRAW, .-twiRAW
 683               		.section	.text.lcdPrepare,"ax",@progbits
 684               	.global	lcdPrepare
 685               		.type	lcdPrepare, @function
 686               	lcdPrepare:
 687               	.LFB111:
 688               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 689               		.loc 2 490 0
 690               		.cfi_startproc
 691               	.LVL58:
 692               	/* prologue: function */
 693               	/* frame size = 0 */
 694               	/* stack size = 0 */
 695               	.L__stack_usage = 0
 696               	.LBB8:
 697               		.loc 2 491 0
 698 0000 2091 0000 		lds r18,lcdBackLight
 699 0004 982F      		mov r25,r24
 700 0006 907F      		andi r25,lo8(-16)
 701 0008 922B      		or r25,r18
 702               	.LVL59:
 703               		.loc 2 493 0
 704 000a 6111      		cpse r22,__zero_reg__
 705               		.loc 2 493 0 is_stmt 0 discriminator 1
 706 000c 9160      		ori r25,lo8(1)
 707               	.LVL60:
 708               	.L75:
 709               		.loc 2 494 0 is_stmt 1
 710 000e 9093 0000 		sts lcdBuffer,r25
 711 0012 9093 0000 		sts lcdBuffer+2,r25
 712               	.LVL61:
 713               		.loc 2 495 0
 714 0016 9460      		ori r25,lo8(4)
 715               	.LVL62:
 716               		.loc 2 496 0
 717 0018 9093 0000 		sts lcdBuffer+1,r25
 718               		.loc 2 498 0
 719 001c 30E1      		ldi r19,lo8(16)
 720 001e 839F      		mul r24,r19
 721 0020 C001      		movw r24,r0
 722 0022 1124      		clr __zero_reg__
 723               	.LVL63:
 724 0024 822B      		or r24,r18
 725               	.LVL64:
 726               		.loc 2 500 0
 727 0026 6111      		cpse r22,__zero_reg__
 728               		.loc 2 500 0 is_stmt 0 discriminator 1
 729 0028 8160      		ori r24,lo8(1)
GAS LISTING /tmp/ccChP33i.s 			page 22


 730               	.LVL65:
 731               	.L76:
 732               		.loc 2 501 0 is_stmt 1
 733 002a 8093 0000 		sts lcdBuffer+3,r24
 734 002e 8093 0000 		sts lcdBuffer+5,r24
 735               	.LVL66:
 736               		.loc 2 502 0
 737 0032 8460      		ori r24,lo8(4)
 738               	.LVL67:
 739               		.loc 2 503 0
 740 0034 8093 0000 		sts lcdBuffer+4,r24
 741 0038 0895      		ret
 742               	.LBE8:
 743               		.cfi_endproc
 744               	.LFE111:
 745               		.size	lcdPrepare, .-lcdPrepare
 746               		.section	.text.lcdWrite,"ax",@progbits
 747               	.global	lcdWrite
 748               		.type	lcdWrite, @function
 749               	lcdWrite:
 750               	.LFB112:
 751               		.loc 2 511 0
 752               		.cfi_startproc
 753               	.LVL68:
 754 0000 1F93      		push r17
 755               	.LCFI20:
 756               		.cfi_def_cfa_offset 4
 757               		.cfi_offset 17, -3
 758 0002 CF93      		push r28
 759               	.LCFI21:
 760               		.cfi_def_cfa_offset 5
 761               		.cfi_offset 28, -4
 762 0004 DF93      		push r29
 763               	.LCFI22:
 764               		.cfi_def_cfa_offset 6
 765               		.cfi_offset 29, -5
 766               	/* prologue: function */
 767               	/* frame size = 0 */
 768               	/* stack size = 3 */
 769               	.L__stack_usage = 3
 770 0006 162F      		mov r17,r22
 771               	.LVL69:
 772               	.LBB9:
 773               		.loc 2 515 0
 774 0008 2091 0000 		lds r18,twiMode
 775 000c 2260      		ori r18,lo8(2)
 776 000e 2093 0000 		sts twiMode,r18
 777               		.loc 2 516 0
 778 0012 C82F      		mov r28,r24
 779 0014 D92F      		mov r29,r25
 780 0016 180F      		add r17,r24
 781               	.LVL70:
 782               	.L84:
 783               		.loc 2 516 0 is_stmt 0 discriminator 1
 784 0018 1C17      		cp r17,r28
 785 001a 01F0      		breq .L86
 786               	.LVL71:
GAS LISTING /tmp/ccChP33i.s 			page 23


 787               		.loc 2 517 0 is_stmt 1
 788 001c 61E0      		ldi r22,lo8(1)
 789 001e 8991      		ld r24,Y+
 790               	.LVL72:
 791 0020 0E94 0000 		call lcdPrepare
 792               	.LVL73:
 793 0024 46E0      		ldi r20,lo8(6)
 794 0026 60E0      		ldi r22,lo8(lcdBuffer)
 795 0028 70E0      		ldi r23,hi8(lcdBuffer)
 796 002a 8091 0000 		lds r24,lcdAddress
 797 002e 0E94 0000 		call twiWrite
 798               	.LVL74:
 799 0032 85E0      		ldi r24,lo8(5)
 800 0034 90E0      		ldi r25,0
 801 0036 0E94 0000 		call time_delay16
 802               	.LVL75:
 803 003a 00C0      		rjmp .L84
 804               	.LVL76:
 805               	.L86:
 806               	/* epilogue start */
 807               	.LBE9:
 808               		.loc 2 518 0
 809 003c DF91      		pop r29
 810 003e CF91      		pop r28
 811               	.LVL77:
 812 0040 1F91      		pop r17
 813 0042 0895      		ret
 814               		.cfi_endproc
 815               	.LFE112:
 816               		.size	lcdWrite, .-lcdWrite
 817               		.section	.text.lcdInit,"ax",@progbits
 818               	.global	lcdInit
 819               		.type	lcdInit, @function
 820               	lcdInit:
 821               	.LFB113:
 822               		.loc 2 524 0
 823               		.cfi_startproc
 824               	/* prologue: function */
 825               	/* frame size = 0 */
 826               	/* stack size = 0 */
 827               	.L__stack_usage = 0
 828               		.loc 2 525 0
 829 0000 60E0      		ldi r22,0
 830 0002 8091 0000 		lds r24,lcdModes
 831 0006 0E94 0000 		call lcdPrepare
 832               	.LVL78:
 833 000a 46E0      		ldi r20,lo8(6)
 834 000c 60E0      		ldi r22,lo8(lcdBuffer)
 835 000e 70E0      		ldi r23,hi8(lcdBuffer)
 836 0010 8091 0000 		lds r24,lcdAddress
 837 0014 0E94 0000 		call twiWrite
 838               	.LVL79:
 839 0018 85E0      		ldi r24,lo8(5)
 840 001a 90E0      		ldi r25,0
 841 001c 0E94 0000 		call time_delay16
 842               	.LVL80:
 843               		.loc 2 526 0
GAS LISTING /tmp/ccChP33i.s 			page 24


 844 0020 60E0      		ldi r22,0
 845 0022 8091 0000 		lds r24,lcdShows
 846 0026 0E94 0000 		call lcdPrepare
 847               	.LVL81:
 848 002a 46E0      		ldi r20,lo8(6)
 849 002c 60E0      		ldi r22,lo8(lcdBuffer)
 850 002e 70E0      		ldi r23,hi8(lcdBuffer)
 851 0030 8091 0000 		lds r24,lcdAddress
 852 0034 0E94 0000 		call twiWrite
 853               	.LVL82:
 854 0038 85E0      		ldi r24,lo8(5)
 855 003a 90E0      		ldi r25,0
 856 003c 0E94 0000 		call time_delay16
 857               	.LVL83:
 858               		.loc 2 527 0
 859 0040 60E0      		ldi r22,0
 860 0042 8091 0000 		lds r24,lcdShifts
 861 0046 0E94 0000 		call lcdPrepare
 862               	.LVL84:
 863 004a 46E0      		ldi r20,lo8(6)
 864 004c 60E0      		ldi r22,lo8(lcdBuffer)
 865 004e 70E0      		ldi r23,hi8(lcdBuffer)
 866 0050 8091 0000 		lds r24,lcdAddress
 867 0054 0E94 0000 		call twiWrite
 868               	.LVL85:
 869 0058 85E0      		ldi r24,lo8(5)
 870 005a 90E0      		ldi r25,0
 871 005c 0E94 0000 		call time_delay16
 872               	.LVL86:
 873               		.loc 2 528 0
 874 0060 60E0      		ldi r22,0
 875 0062 81E0      		ldi r24,lo8(1)
 876 0064 0E94 0000 		call lcdPrepare
 877               	.LVL87:
 878 0068 46E0      		ldi r20,lo8(6)
 879 006a 60E0      		ldi r22,lo8(lcdBuffer)
 880 006c 70E0      		ldi r23,hi8(lcdBuffer)
 881 006e 8091 0000 		lds r24,lcdAddress
 882 0072 0E94 0000 		call twiWrite
 883               	.LVL88:
 884 0076 85E0      		ldi r24,lo8(5)
 885 0078 90E0      		ldi r25,0
 886 007a 0E94 0000 		call time_delay16
 887               	.LVL89:
 888 007e 80E1      		ldi r24,lo8(16)
 889 0080 90E0      		ldi r25,0
 890 0082 0E94 0000 		call time_delay16
 891               	.LVL90:
 892               		.loc 2 529 0
 893 0086 60E0      		ldi r22,0
 894 0088 82E0      		ldi r24,lo8(2)
 895 008a 0E94 0000 		call lcdPrepare
 896               	.LVL91:
 897 008e 46E0      		ldi r20,lo8(6)
 898 0090 60E0      		ldi r22,lo8(lcdBuffer)
 899 0092 70E0      		ldi r23,hi8(lcdBuffer)
 900 0094 8091 0000 		lds r24,lcdAddress
GAS LISTING /tmp/ccChP33i.s 			page 25


 901 0098 0E94 0000 		call twiWrite
 902               	.LVL92:
 903 009c 85E0      		ldi r24,lo8(5)
 904 009e 90E0      		ldi r25,0
 905 00a0 0C94 0000 		jmp time_delay16
 906               	.LVL93:
 907               		.cfi_endproc
 908               	.LFE113:
 909               		.size	lcdInit, .-lcdInit
 910               		.section	.text.lcdSetup,"ax",@progbits
 911               	.global	lcdSetup
 912               		.type	lcdSetup, @function
 913               	lcdSetup:
 914               	.LFB114:
 915               		.loc 2 536 0
 916               		.cfi_startproc
 917               	.LVL94:
 918 0000 CF93      		push r28
 919               	.LCFI23:
 920               		.cfi_def_cfa_offset 4
 921               		.cfi_offset 28, -3
 922               	/* prologue: function */
 923               	/* frame size = 0 */
 924               	/* stack size = 1 */
 925               	.L__stack_usage = 1
 926 0002 C42F      		mov r28,r20
 927               		.loc 2 537 0
 928 0004 8093 0000 		sts lcdAddress,r24
 929               		.loc 2 538 0
 930 0008 6093 0000 		sts lcdCols,r22
 931               		.loc 2 539 0
 932 000c 4093 0000 		sts lcdRows,r20
 933               		.loc 2 540 0
 934 0010 2223      		tst r18
 935 0012 01F0      		breq .L91
 936 0014 88E0      		ldi r24,lo8(8)
 937               	.LVL95:
 938 0016 00C0      		rjmp .L89
 939               	.LVL96:
 940               	.L91:
 941 0018 80E0      		ldi r24,0
 942               	.LVL97:
 943               	.L89:
 944               		.loc 2 540 0 is_stmt 0 discriminator 3
 945 001a 8093 0000 		sts lcdBackLight,r24
 946               		.loc 2 541 0 is_stmt 1 discriminator 3
 947 001e 80E2      		ldi r24,lo8(32)
 948 0020 8093 0000 		sts lcdModes,r24
 949               		.loc 2 542 0 discriminator 3
 950 0024 86E0      		ldi r24,lo8(6)
 951 0026 8093 0000 		sts lcdShifts,r24
 952               		.loc 2 543 0 discriminator 3
 953 002a 8CE0      		ldi r24,lo8(12)
 954 002c 8093 0000 		sts lcdShows,r24
 955               		.loc 2 547 0 discriminator 3
 956 0030 46E0      		ldi r20,lo8(6)
 957               	.LVL98:
GAS LISTING /tmp/ccChP33i.s 			page 26


 958 0032 60EA      		ldi r22,lo8(-96)
 959 0034 76E8      		ldi r23,lo8(-122)
 960 0036 81E0      		ldi r24,lo8(1)
 961 0038 90E0      		ldi r25,0
 962               	.LVL99:
 963 003a 0E94 0000 		call twiSetup
 964               	.LVL100:
 965               		.loc 2 551 0 discriminator 3
 966 003e C230      		cpi r28,lo8(2)
 967 0040 00F0      		brlo .L90
 968               		.loc 2 551 0 is_stmt 0 discriminator 1
 969 0042 8091 0000 		lds r24,lcdModes
 970 0046 8860      		ori r24,lo8(8)
 971 0048 8093 0000 		sts lcdModes,r24
 972               	.L90:
 973               		.loc 2 555 0 is_stmt 1
 974 004c 60E0      		ldi r22,0
 975 004e 80E3      		ldi r24,lo8(48)
 976 0050 0E94 0000 		call lcdPrepare
 977               	.LVL101:
 978               		.loc 2 557 0
 979 0054 8FE0      		ldi r24,lo8(15)
 980 0056 90E0      		ldi r25,0
 981 0058 0E94 0000 		call time_delay16
 982               	.LVL102:
 983               		.loc 2 558 0
 984 005c 43E0      		ldi r20,lo8(3)
 985 005e 60E0      		ldi r22,lo8(lcdBuffer)
 986 0060 70E0      		ldi r23,hi8(lcdBuffer)
 987 0062 8091 0000 		lds r24,lcdAddress
 988 0066 0E94 0000 		call twiWrite
 989               	.LVL103:
 990 006a 85E0      		ldi r24,lo8(5)
 991 006c 90E0      		ldi r25,0
 992 006e 0E94 0000 		call time_delay16
 993               	.LVL104:
 994               		.loc 2 559 0
 995 0072 85E0      		ldi r24,lo8(5)
 996 0074 90E0      		ldi r25,0
 997 0076 0E94 0000 		call time_delay16
 998               	.LVL105:
 999               		.loc 2 560 0
 1000 007a 43E0      		ldi r20,lo8(3)
 1001 007c 60E0      		ldi r22,lo8(lcdBuffer)
 1002 007e 70E0      		ldi r23,hi8(lcdBuffer)
 1003 0080 8091 0000 		lds r24,lcdAddress
 1004 0084 0E94 0000 		call twiWrite
 1005               	.LVL106:
 1006 0088 85E0      		ldi r24,lo8(5)
 1007 008a 90E0      		ldi r25,0
 1008 008c 0E94 0000 		call time_delay16
 1009               	.LVL107:
 1010               		.loc 2 561 0
 1011 0090 80E9      		ldi r24,lo8(-112)
 1012 0092 91E0      		ldi r25,lo8(1)
 1013               	/* #APP */
 1014               	 ;  561 "LCD1602ex.ino" 1
GAS LISTING /tmp/ccChP33i.s 			page 27


 1015 0094 0197      		1: sbiw r24,1 
 1016 0096 01F4      		brne 1b
 1017               		
 1018               	 ;  0 "" 2
 1019               		.loc 2 562 0
 1020               	/* #NOAPP */
 1021 0098 43E0      		ldi r20,lo8(3)
 1022 009a 60E0      		ldi r22,lo8(lcdBuffer)
 1023 009c 70E0      		ldi r23,hi8(lcdBuffer)
 1024 009e 8091 0000 		lds r24,lcdAddress
 1025 00a2 0E94 0000 		call twiWrite
 1026               	.LVL108:
 1027 00a6 85E0      		ldi r24,lo8(5)
 1028 00a8 90E0      		ldi r25,0
 1029 00aa 0E94 0000 		call time_delay16
 1030               	.LVL109:
 1031               		.loc 2 564 0
 1032 00ae 60E0      		ldi r22,0
 1033 00b0 80E2      		ldi r24,lo8(32)
 1034 00b2 0E94 0000 		call lcdPrepare
 1035               	.LVL110:
 1036               		.loc 2 565 0
 1037 00b6 43E0      		ldi r20,lo8(3)
 1038 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 1039 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 1040 00bc 8091 0000 		lds r24,lcdAddress
 1041 00c0 0E94 0000 		call twiWrite
 1042               	.LVL111:
 1043 00c4 85E0      		ldi r24,lo8(5)
 1044 00c6 90E0      		ldi r25,0
 1045 00c8 0E94 0000 		call time_delay16
 1046               	.LVL112:
 1047               		.loc 2 567 0
 1048 00cc 0E94 0000 		call lcdInit
 1049               	.LVL113:
 1050               		.loc 2 568 0
 1051 00d0 84EF      		ldi r24,lo8(-12)
 1052 00d2 91E0      		ldi r25,lo8(1)
 1053               	/* epilogue start */
 1054               		.loc 2 569 0
 1055 00d4 CF91      		pop r28
 1056               	.LVL114:
 1057               		.loc 2 568 0
 1058 00d6 0C94 0000 		jmp time_delay16
 1059               	.LVL115:
 1060               		.cfi_endproc
 1061               	.LFE114:
 1062               		.size	lcdSetup, .-lcdSetup
 1063               		.section	.rodata.str1.1,"aMS",@progbits,1
 1064               	.LC0:
 1065 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 1065      6F2C 2041 
 1065      4141 4141 
 1065      4100 
 1066               		.section	.text.setup,"ax",@progbits
 1067               	.global	setup
 1068               		.type	setup, @function
GAS LISTING /tmp/ccChP33i.s 			page 28


 1069               	setup:
 1070               	.LFB115:
 1071               		.loc 2 577 0
 1072               		.cfi_startproc
 1073               	/* prologue: function */
 1074               	/* frame size = 0 */
 1075               	/* stack size = 0 */
 1076               	.L__stack_usage = 0
 1077               	.LBB10:
 1078               		.loc 2 581 0
 1079 0000 21E0      		ldi r18,lo8(1)
 1080 0002 42E0      		ldi r20,lo8(2)
 1081 0004 60E1      		ldi r22,lo8(16)
 1082 0006 87E2      		ldi r24,lo8(39)
 1083 0008 0E94 0000 		call lcdSetup
 1084               	.LVL116:
 1085               		.loc 2 582 0
 1086 000c 6DE0      		ldi r22,lo8(13)
 1087 000e 80E0      		ldi r24,lo8(.LC0)
 1088 0010 90E0      		ldi r25,hi8(.LC0)
 1089 0012 0C94 0000 		jmp lcdWrite
 1090               	.LVL117:
 1091               	.LBE10:
 1092               		.cfi_endproc
 1093               	.LFE115:
 1094               		.size	setup, .-setup
 1095               		.section	.text.loop,"ax",@progbits
 1096               	.global	loop
 1097               		.type	loop, @function
 1098               	loop:
 1099               	.LFB116:
 1100               		.loc 2 588 0
 1101               		.cfi_startproc
 1102               	/* prologue: function */
 1103               	/* frame size = 0 */
 1104               	/* stack size = 0 */
 1105               	.L__stack_usage = 0
 1106 0000 0895      		ret
 1107               		.cfi_endproc
 1108               	.LFE116:
 1109               		.size	loop, .-loop
 1110               	.global	lcdBuffer
 1111               		.section	.bss.lcdBuffer,"aw",@nobits
 1112               		.type	lcdBuffer, @object
 1113               		.size	lcdBuffer, 6
 1114               	lcdBuffer:
 1115 0000 0000 0000 		.zero	6
 1115      0000 
 1116               	.global	lcdRows
 1117               		.section	.data.lcdRows,"aw",@progbits
 1118               		.type	lcdRows, @object
 1119               		.size	lcdRows, 1
 1120               	lcdRows:
 1121 0000 02        		.byte	2
 1122               	.global	lcdCols
 1123               		.section	.data.lcdCols,"aw",@progbits
 1124               		.type	lcdCols, @object
GAS LISTING /tmp/ccChP33i.s 			page 29


 1125               		.size	lcdCols, 1
 1126               	lcdCols:
 1127 0000 10        		.byte	16
 1128               	.global	lcdAddress
 1129               		.section	.data.lcdAddress,"aw",@progbits
 1130               		.type	lcdAddress, @object
 1131               		.size	lcdAddress, 1
 1132               	lcdAddress:
 1133 0000 27        		.byte	39
 1134               	.global	lcdBackLight
 1135               		.section	.data.lcdBackLight,"aw",@progbits
 1136               		.type	lcdBackLight, @object
 1137               		.size	lcdBackLight, 1
 1138               	lcdBackLight:
 1139 0000 08        		.byte	8
 1140               	.global	lcdShows
 1141               		.section	.data.lcdShows,"aw",@progbits
 1142               		.type	lcdShows, @object
 1143               		.size	lcdShows, 1
 1144               	lcdShows:
 1145 0000 08        		.byte	8
 1146               	.global	lcdShifts
 1147               		.section	.data.lcdShifts,"aw",@progbits
 1148               		.type	lcdShifts, @object
 1149               		.size	lcdShifts, 1
 1150               	lcdShifts:
 1151 0000 06        		.byte	6
 1152               	.global	lcdModes
 1153               		.section	.data.lcdModes,"aw",@progbits
 1154               		.type	lcdModes, @object
 1155               		.size	lcdModes, 1
 1156               	lcdModes:
 1157 0000 30        		.byte	48
 1158               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 1159               		.type	_ZL12twiStatistic, @object
 1160               		.size	_ZL12twiStatistic, 20
 1161               	_ZL12twiStatistic:
 1162 0000 0000 0000 		.zero	20
 1162      0000 0000 
 1162      0000 0000 
 1162      0000 0000 
 1162      0000 0000 
 1163               	.global	twiSlaveWriter
 1164               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1165               		.type	twiSlaveWriter, @object
 1166               		.size	twiSlaveWriter, 2
 1167               	twiSlaveWriter:
 1168 0000 0000      		.zero	2
 1169               	.global	twiSlaveReader
 1170               		.section	.bss.twiSlaveReader,"aw",@nobits
 1171               		.type	twiSlaveReader, @object
 1172               		.size	twiSlaveReader, 2
 1173               	twiSlaveReader:
 1174 0000 0000      		.zero	2
 1175               	.global	twiMasterReader
 1176               		.section	.bss.twiMasterReader,"aw",@nobits
 1177               		.type	twiMasterReader, @object
GAS LISTING /tmp/ccChP33i.s 			page 30


 1178               		.size	twiMasterReader, 2
 1179               	twiMasterReader:
 1180 0000 0000      		.zero	2
 1181               	.global	twiHookRestart
 1182               		.section	.bss.twiHookRestart,"aw",@nobits
 1183               		.type	twiHookRestart, @object
 1184               		.size	twiHookRestart, 2
 1185               	twiHookRestart:
 1186 0000 0000      		.zero	2
 1187               	.global	twiST_Ptr
 1188               		.section	.bss.twiST_Ptr,"aw",@nobits
 1189               		.type	twiST_Ptr, @object
 1190               		.size	twiST_Ptr, 2
 1191               	twiST_Ptr:
 1192 0000 0000      		.zero	2
 1193               	.global	twiST_Count
 1194               		.section	.bss.twiST_Count,"aw",@nobits
 1195               		.type	twiST_Count, @object
 1196               		.size	twiST_Count, 1
 1197               	twiST_Count:
 1198 0000 00        		.zero	1
 1199               	.global	twiRX_Ptr
 1200               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1201               		.type	twiRX_Ptr, @object
 1202               		.size	twiRX_Ptr, 2
 1203               	twiRX_Ptr:
 1204 0000 0000      		.zero	2
 1205               	.global	twiRX_Count
 1206               		.section	.bss.twiRX_Count,"aw",@nobits
 1207               		.type	twiRX_Count, @object
 1208               		.size	twiRX_Count, 1
 1209               	twiRX_Count:
 1210 0000 00        		.zero	1
 1211               	.global	twiMT_Ptr
 1212               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1213               		.type	twiMT_Ptr, @object
 1214               		.size	twiMT_Ptr, 2
 1215               	twiMT_Ptr:
 1216 0000 0000      		.zero	2
 1217               	.global	twiMT_Count
 1218               		.section	.bss.twiMT_Count,"aw",@nobits
 1219               		.type	twiMT_Count, @object
 1220               		.size	twiMT_Count, 1
 1221               	twiMT_Count:
 1222 0000 00        		.zero	1
 1223               	.global	twiSLARW
 1224               		.section	.bss.twiSLARW,"aw",@nobits
 1225               		.type	twiSLARW, @object
 1226               		.size	twiSLARW, 1
 1227               	twiSLARW:
 1228 0000 00        		.zero	1
 1229               	.global	twiState
 1230               		.section	.bss.twiState,"aw",@nobits
 1231               		.type	twiState, @object
 1232               		.size	twiState, 1
 1233               	twiState:
 1234 0000 00        		.zero	1
GAS LISTING /tmp/ccChP33i.s 			page 31


 1235               	.global	twiMode
 1236               		.section	.bss.twiMode,"aw",@nobits
 1237               		.type	twiMode, @object
 1238               		.size	twiMode, 1
 1239               	twiMode:
 1240 0000 00        		.zero	1
 1241               		.text
 1242               	.Letext0:
 1243               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1244               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1245               		.section	.debug_info,"",@progbits
 1246               	.Ldebug_info0:
 1247 0000 490B 0000 		.long	0xb49
 1248 0004 0200      		.word	0x2
 1249 0006 0000 0000 		.long	.Ldebug_abbrev0
 1250 000a 04        		.byte	0x4
 1251 000b 01        		.uleb128 0x1
 1252 000c 0000 0000 		.long	.LASF76
 1253 0010 04        		.byte	0x4
 1254 0011 0000 0000 		.long	.LASF77
 1255 0015 0000 0000 		.long	.LASF78
 1256 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1257 001d 0000 0000 		.long	0
 1258 0021 0000 0000 		.long	0
 1259 0025 0000 0000 		.long	.Ldebug_line0
 1260 0029 02        		.uleb128 0x2
 1261 002a 01        		.byte	0x1
 1262 002b 06        		.byte	0x6
 1263 002c 0000 0000 		.long	.LASF0
 1264 0030 03        		.uleb128 0x3
 1265 0031 0000 0000 		.long	.LASF2
 1266 0035 03        		.byte	0x3
 1267 0036 7A        		.byte	0x7a
 1268 0037 3B00 0000 		.long	0x3b
 1269 003b 02        		.uleb128 0x2
 1270 003c 01        		.byte	0x1
 1271 003d 08        		.byte	0x8
 1272 003e 0000 0000 		.long	.LASF1
 1273 0042 04        		.uleb128 0x4
 1274 0043 02        		.byte	0x2
 1275 0044 05        		.byte	0x5
 1276 0045 696E 7400 		.string	"int"
 1277 0049 03        		.uleb128 0x3
 1278 004a 0000 0000 		.long	.LASF3
 1279 004e 03        		.byte	0x3
 1280 004f 7C        		.byte	0x7c
 1281 0050 5400 0000 		.long	0x54
 1282 0054 02        		.uleb128 0x2
 1283 0055 02        		.byte	0x2
 1284 0056 07        		.byte	0x7
 1285 0057 0000 0000 		.long	.LASF4
 1286 005b 02        		.uleb128 0x2
 1287 005c 04        		.byte	0x4
 1288 005d 05        		.byte	0x5
 1289 005e 0000 0000 		.long	.LASF5
 1290 0062 03        		.uleb128 0x3
 1291 0063 0000 0000 		.long	.LASF6
GAS LISTING /tmp/ccChP33i.s 			page 32


 1292 0067 03        		.byte	0x3
 1293 0068 7E        		.byte	0x7e
 1294 0069 6D00 0000 		.long	0x6d
 1295 006d 02        		.uleb128 0x2
 1296 006e 04        		.byte	0x4
 1297 006f 07        		.byte	0x7
 1298 0070 0000 0000 		.long	.LASF7
 1299 0074 02        		.uleb128 0x2
 1300 0075 08        		.byte	0x8
 1301 0076 05        		.byte	0x5
 1302 0077 0000 0000 		.long	.LASF8
 1303 007b 02        		.uleb128 0x2
 1304 007c 08        		.byte	0x8
 1305 007d 07        		.byte	0x7
 1306 007e 0000 0000 		.long	.LASF9
 1307 0082 02        		.uleb128 0x2
 1308 0083 01        		.byte	0x1
 1309 0084 02        		.byte	0x2
 1310 0085 0000 0000 		.long	.LASF10
 1311 0089 05        		.uleb128 0x5
 1312 008a 02        		.byte	0x2
 1313 008b 8F00 0000 		.long	0x8f
 1314 008f 06        		.uleb128 0x6
 1315 0090 02        		.uleb128 0x2
 1316 0091 01        		.byte	0x1
 1317 0092 06        		.byte	0x6
 1318 0093 0000 0000 		.long	.LASF11
 1319 0097 02        		.uleb128 0x2
 1320 0098 04        		.byte	0x4
 1321 0099 04        		.byte	0x4
 1322 009a 0000 0000 		.long	.LASF12
 1323 009e 02        		.uleb128 0x2
 1324 009f 04        		.byte	0x4
 1325 00a0 04        		.byte	0x4
 1326 00a1 0000 0000 		.long	.LASF13
 1327 00a5 02        		.uleb128 0x2
 1328 00a6 02        		.byte	0x2
 1329 00a7 07        		.byte	0x7
 1330 00a8 0000 0000 		.long	.LASF14
 1331 00ac 07        		.uleb128 0x7
 1332 00ad 0000 0000 		.long	.LASF79
 1333 00b1 02        		.byte	0x2
 1334 00b2 01        		.byte	0x1
 1335 00b3 8C        		.byte	0x8c
 1336 00b4 CB00 0000 		.long	0xcb
 1337 00b8 08        		.uleb128 0x8
 1338 00b9 0000 0000 		.long	.LASF15
 1339 00bd 01        		.sleb128 1
 1340 00be 08        		.uleb128 0x8
 1341 00bf 0000 0000 		.long	.LASF16
 1342 00c3 02        		.sleb128 2
 1343 00c4 08        		.uleb128 0x8
 1344 00c5 0000 0000 		.long	.LASF17
 1345 00c9 04        		.sleb128 4
 1346 00ca 00        		.byte	0
 1347 00cb 09        		.uleb128 0x9
 1348 00cc 14        		.byte	0x14
GAS LISTING /tmp/ccChP33i.s 			page 33


 1349 00cd 01        		.byte	0x1
 1350 00ce A6        		.byte	0xa6
 1351 00cf 0000 0000 		.long	.LASF80
 1352 00d3 6401 0000 		.long	0x164
 1353 00d7 0A        		.uleb128 0xa
 1354 00d8 0000 0000 		.long	.LASF18
 1355 00dc 01        		.byte	0x1
 1356 00dd A7        		.byte	0xa7
 1357 00de 4900 0000 		.long	0x49
 1358 00e2 02        		.byte	0x2
 1359 00e3 23        		.byte	0x23
 1360 00e4 00        		.uleb128 0
 1361 00e5 0A        		.uleb128 0xa
 1362 00e6 0000 0000 		.long	.LASF19
 1363 00ea 01        		.byte	0x1
 1364 00eb A7        		.byte	0xa7
 1365 00ec 4900 0000 		.long	0x49
 1366 00f0 02        		.byte	0x2
 1367 00f1 23        		.byte	0x23
 1368 00f2 02        		.uleb128 0x2
 1369 00f3 0A        		.uleb128 0xa
 1370 00f4 0000 0000 		.long	.LASF20
 1371 00f8 01        		.byte	0x1
 1372 00f9 A7        		.byte	0xa7
 1373 00fa 4900 0000 		.long	0x49
 1374 00fe 02        		.byte	0x2
 1375 00ff 23        		.byte	0x23
 1376 0100 04        		.uleb128 0x4
 1377 0101 0A        		.uleb128 0xa
 1378 0102 0000 0000 		.long	.LASF21
 1379 0106 01        		.byte	0x1
 1380 0107 A7        		.byte	0xa7
 1381 0108 4900 0000 		.long	0x49
 1382 010c 02        		.byte	0x2
 1383 010d 23        		.byte	0x23
 1384 010e 06        		.uleb128 0x6
 1385 010f 0A        		.uleb128 0xa
 1386 0110 0000 0000 		.long	.LASF22
 1387 0114 01        		.byte	0x1
 1388 0115 A7        		.byte	0xa7
 1389 0116 4900 0000 		.long	0x49
 1390 011a 02        		.byte	0x2
 1391 011b 23        		.byte	0x23
 1392 011c 08        		.uleb128 0x8
 1393 011d 0B        		.uleb128 0xb
 1394 011e 6D74 7800 		.string	"mtx"
 1395 0122 01        		.byte	0x1
 1396 0123 A7        		.byte	0xa7
 1397 0124 4900 0000 		.long	0x49
 1398 0128 02        		.byte	0x2
 1399 0129 23        		.byte	0x23
 1400 012a 0A        		.uleb128 0xa
 1401 012b 0B        		.uleb128 0xb
 1402 012c 6D72 7800 		.string	"mrx"
 1403 0130 01        		.byte	0x1
 1404 0131 A7        		.byte	0xa7
 1405 0132 4900 0000 		.long	0x49
GAS LISTING /tmp/ccChP33i.s 			page 34


 1406 0136 02        		.byte	0x2
 1407 0137 23        		.byte	0x23
 1408 0138 0C        		.uleb128 0xc
 1409 0139 0B        		.uleb128 0xb
 1410 013a 7372 7800 		.string	"srx"
 1411 013e 01        		.byte	0x1
 1412 013f A7        		.byte	0xa7
 1413 0140 4900 0000 		.long	0x49
 1414 0144 02        		.byte	0x2
 1415 0145 23        		.byte	0x23
 1416 0146 0E        		.uleb128 0xe
 1417 0147 0B        		.uleb128 0xb
 1418 0148 6772 7800 		.string	"grx"
 1419 014c 01        		.byte	0x1
 1420 014d A7        		.byte	0xa7
 1421 014e 4900 0000 		.long	0x49
 1422 0152 02        		.byte	0x2
 1423 0153 23        		.byte	0x23
 1424 0154 10        		.uleb128 0x10
 1425 0155 0B        		.uleb128 0xb
 1426 0156 7374 7800 		.string	"stx"
 1427 015a 01        		.byte	0x1
 1428 015b A7        		.byte	0xa7
 1429 015c 4900 0000 		.long	0x49
 1430 0160 02        		.byte	0x2
 1431 0161 23        		.byte	0x23
 1432 0162 12        		.uleb128 0x12
 1433 0163 00        		.byte	0
 1434 0164 03        		.uleb128 0x3
 1435 0165 0000 0000 		.long	.LASF23
 1436 0169 01        		.byte	0x1
 1437 016a A8        		.byte	0xa8
 1438 016b CB00 0000 		.long	0xcb
 1439 016f 05        		.uleb128 0x5
 1440 0170 02        		.byte	0x2
 1441 0171 3000 0000 		.long	0x30
 1442 0175 0C        		.uleb128 0xc
 1443 0176 01        		.byte	0x1
 1444 0177 0000 0000 		.long	.LASF81
 1445 017b 01        		.byte	0x1
 1446 017c EF        		.byte	0xef
 1447 017d 01        		.byte	0x1
 1448 017e 8E01 0000 		.long	0x18e
 1449 0182 0D        		.uleb128 0xd
 1450 0183 5F6D 6400 		.string	"_md"
 1451 0187 01        		.byte	0x1
 1452 0188 EF        		.byte	0xef
 1453 0189 3000 0000 		.long	0x30
 1454 018d 00        		.byte	0
 1455 018e 0E        		.uleb128 0xe
 1456 018f 01        		.byte	0x1
 1457 0190 0000 0000 		.long	.LASF26
 1458 0194 01        		.byte	0x1
 1459 0195 B7        		.byte	0xb7
 1460 0196 0000 0000 		.long	.LFB102
 1461 019a 0000 0000 		.long	.LFE102
 1462 019e 03        		.byte	0x3
GAS LISTING /tmp/ccChP33i.s 			page 35


 1463 019f 92        		.byte	0x92
 1464 01a0 20        		.uleb128 0x20
 1465 01a1 03        		.sleb128 3
 1466 01a2 01        		.byte	0x1
 1467 01a3 E201 0000 		.long	0x1e2
 1468 01a7 0F        		.uleb128 0xf
 1469 01a8 0000 0000 		.long	.LASF28
 1470 01ac 01        		.byte	0x1
 1471 01ad B7        		.byte	0xb7
 1472 01ae 6200 0000 		.long	0x62
 1473 01b2 0000 0000 		.long	.LLST0
 1474 01b6 10        		.uleb128 0x10
 1475 01b7 0000 0000 		.long	.LBB2
 1476 01bb 0000 0000 		.long	.LBE2
 1477 01bf 11        		.uleb128 0x11
 1478 01c0 0000 0000 		.long	.LASF24
 1479 01c4 01        		.byte	0x1
 1480 01c5 B9        		.byte	0xb9
 1481 01c6 4900 0000 		.long	0x49
 1482 01ca 06        		.byte	0x6
 1483 01cb 62        		.byte	0x62
 1484 01cc 93        		.byte	0x93
 1485 01cd 01        		.uleb128 0x1
 1486 01ce 63        		.byte	0x63
 1487 01cf 93        		.byte	0x93
 1488 01d0 01        		.uleb128 0x1
 1489 01d1 12        		.uleb128 0x12
 1490 01d2 0000 0000 		.long	.LASF25
 1491 01d6 01        		.byte	0x1
 1492 01d7 BA        		.byte	0xba
 1493 01d8 3000 0000 		.long	0x30
 1494 01dc 0000 0000 		.long	.LLST1
 1495 01e0 00        		.byte	0
 1496 01e1 00        		.byte	0
 1497 01e2 13        		.uleb128 0x13
 1498 01e3 01        		.byte	0x1
 1499 01e4 0000 0000 		.long	.LASF27
 1500 01e8 01        		.byte	0x1
 1501 01e9 C8        		.byte	0xc8
 1502 01ea 0000 0000 		.long	.LFB103
 1503 01ee 0000 0000 		.long	.LFE103
 1504 01f2 0000 0000 		.long	.LLST2
 1505 01f6 01        		.byte	0x1
 1506 01f7 3602 0000 		.long	0x236
 1507 01fb 0F        		.uleb128 0xf
 1508 01fc 0000 0000 		.long	.LASF28
 1509 0200 01        		.byte	0x1
 1510 0201 C8        		.byte	0xc8
 1511 0202 6200 0000 		.long	0x62
 1512 0206 0000 0000 		.long	.LLST3
 1513 020a 0F        		.uleb128 0xf
 1514 020b 0000 0000 		.long	.LASF29
 1515 020f 01        		.byte	0x1
 1516 0210 C8        		.byte	0xc8
 1517 0211 3000 0000 		.long	0x30
 1518 0215 0000 0000 		.long	.LLST4
 1519 0219 14        		.uleb128 0x14
GAS LISTING /tmp/ccChP33i.s 			page 36


 1520 021a 0000 0000 		.long	.LVL10
 1521 021e 8E01 0000 		.long	0x18e
 1522 0222 15        		.uleb128 0x15
 1523 0223 0C        		.byte	0xc
 1524 0224 66        		.byte	0x66
 1525 0225 93        		.byte	0x93
 1526 0226 01        		.uleb128 0x1
 1527 0227 67        		.byte	0x67
 1528 0228 93        		.byte	0x93
 1529 0229 01        		.uleb128 0x1
 1530 022a 68        		.byte	0x68
 1531 022b 93        		.byte	0x93
 1532 022c 01        		.uleb128 0x1
 1533 022d 69        		.byte	0x69
 1534 022e 93        		.byte	0x93
 1535 022f 01        		.uleb128 0x1
 1536 0230 03        		.byte	0x3
 1537 0231 F3        		.byte	0xf3
 1538 0232 01        		.uleb128 0x1
 1539 0233 66        		.byte	0x66
 1540 0234 00        		.byte	0
 1541 0235 00        		.byte	0
 1542 0236 16        		.uleb128 0x16
 1543 0237 7501 0000 		.long	0x175
 1544 023b 0000 0000 		.long	.LFB104
 1545 023f 0000 0000 		.long	.LFE104
 1546 0243 0000 0000 		.long	.LLST5
 1547 0247 01        		.byte	0x1
 1548 0248 6902 0000 		.long	0x269
 1549 024c 17        		.uleb128 0x17
 1550 024d 8201 0000 		.long	0x182
 1551 0251 0000 0000 		.long	.LLST6
 1552 0255 10        		.uleb128 0x10
 1553 0256 0000 0000 		.long	.LBB5
 1554 025a 0000 0000 		.long	.LBE5
 1555 025e 17        		.uleb128 0x17
 1556 025f 8201 0000 		.long	0x182
 1557 0263 0000 0000 		.long	.LLST7
 1558 0267 00        		.byte	0
 1559 0268 00        		.byte	0
 1560 0269 18        		.uleb128 0x18
 1561 026a 01        		.byte	0x1
 1562 026b 0000 0000 		.long	.LASF30
 1563 026f 01        		.byte	0x1
 1564 0270 0401      		.word	0x104
 1565 0272 0000 0000 		.long	.LFB105
 1566 0276 0000 0000 		.long	.LFE105
 1567 027a 0000 0000 		.long	.LLST8
 1568 027e 01        		.byte	0x1
 1569 027f C702 0000 		.long	0x2c7
 1570 0283 10        		.uleb128 0x10
 1571 0284 0000 0000 		.long	.LBB7
 1572 0288 0000 0000 		.long	.LBE7
 1573 028c 19        		.uleb128 0x19
 1574 028d 5F63 7200 		.string	"_cr"
 1575 0291 01        		.byte	0x1
 1576 0292 0601      		.word	0x106
GAS LISTING /tmp/ccChP33i.s 			page 37


 1577 0294 3000 0000 		.long	0x30
 1578 0298 0000 0000 		.long	.LLST9
 1579 029c 19        		.uleb128 0x19
 1580 029d 5F6D 6400 		.string	"_md"
 1581 02a1 01        		.byte	0x1
 1582 02a2 0701      		.word	0x107
 1583 02a4 3000 0000 		.long	0x30
 1584 02a8 0000 0000 		.long	.LLST10
 1585 02ac 19        		.uleb128 0x19
 1586 02ad 5F73 7400 		.string	"_st"
 1587 02b1 01        		.byte	0x1
 1588 02b2 0801      		.word	0x108
 1589 02b4 3000 0000 		.long	0x30
 1590 02b8 0000 0000 		.long	.LLST11
 1591 02bc 1A        		.uleb128 0x1a
 1592 02bd 0000 0000 		.long	.LVL36
 1593 02c1 7501 0000 		.long	0x175
 1594 02c5 00        		.byte	0
 1595 02c6 00        		.byte	0
 1596 02c7 1B        		.uleb128 0x1b
 1597 02c8 01        		.byte	0x1
 1598 02c9 0000 0000 		.long	.LASF31
 1599 02cd 01        		.byte	0x1
 1600 02ce 8F01      		.word	0x18f
 1601 02d0 0000 0000 		.long	.LFB106
 1602 02d4 0000 0000 		.long	.LFE106
 1603 02d8 03        		.byte	0x3
 1604 02d9 92        		.byte	0x92
 1605 02da 20        		.uleb128 0x20
 1606 02db 03        		.sleb128 3
 1607 02dc 01        		.byte	0x1
 1608 02dd F202 0000 		.long	0x2f2
 1609 02e1 1C        		.uleb128 0x1c
 1610 02e2 0000 0000 		.long	.LASF32
 1611 02e6 01        		.byte	0x1
 1612 02e7 8F01      		.word	0x18f
 1613 02e9 3000 0000 		.long	0x30
 1614 02ed 0000 0000 		.long	.LLST12
 1615 02f1 00        		.byte	0
 1616 02f2 1B        		.uleb128 0x1b
 1617 02f3 01        		.byte	0x1
 1618 02f4 0000 0000 		.long	.LASF33
 1619 02f8 01        		.byte	0x1
 1620 02f9 9B01      		.word	0x19b
 1621 02fb 0000 0000 		.long	.LFB107
 1622 02ff 0000 0000 		.long	.LFE107
 1623 0303 03        		.byte	0x3
 1624 0304 92        		.byte	0x92
 1625 0305 20        		.uleb128 0x20
 1626 0306 03        		.sleb128 3
 1627 0307 01        		.byte	0x1
 1628 0308 1D03 0000 		.long	0x31d
 1629 030c 1C        		.uleb128 0x1c
 1630 030d 0000 0000 		.long	.LASF32
 1631 0311 01        		.byte	0x1
 1632 0312 9B01      		.word	0x19b
 1633 0314 3000 0000 		.long	0x30
GAS LISTING /tmp/ccChP33i.s 			page 38


 1634 0318 0000 0000 		.long	.LLST13
 1635 031c 00        		.byte	0
 1636 031d 1B        		.uleb128 0x1b
 1637 031e 01        		.byte	0x1
 1638 031f 0000 0000 		.long	.LASF34
 1639 0323 01        		.byte	0x1
 1640 0324 AD01      		.word	0x1ad
 1641 0326 0000 0000 		.long	.LFB108
 1642 032a 0000 0000 		.long	.LFE108
 1643 032e 03        		.byte	0x3
 1644 032f 92        		.byte	0x92
 1645 0330 20        		.uleb128 0x20
 1646 0331 03        		.sleb128 3
 1647 0332 01        		.byte	0x1
 1648 0333 7C03 0000 		.long	0x37c
 1649 0337 1C        		.uleb128 0x1c
 1650 0338 0000 0000 		.long	.LASF32
 1651 033c 01        		.byte	0x1
 1652 033d AD01      		.word	0x1ad
 1653 033f 3000 0000 		.long	0x30
 1654 0343 0000 0000 		.long	.LLST14
 1655 0347 1C        		.uleb128 0x1c
 1656 0348 0000 0000 		.long	.LASF35
 1657 034c 01        		.byte	0x1
 1658 034d AD01      		.word	0x1ad
 1659 034f 7C03 0000 		.long	0x37c
 1660 0353 0000 0000 		.long	.LLST15
 1661 0357 1C        		.uleb128 0x1c
 1662 0358 0000 0000 		.long	.LASF36
 1663 035c 01        		.byte	0x1
 1664 035d AD01      		.word	0x1ad
 1665 035f 3000 0000 		.long	0x30
 1666 0363 0000 0000 		.long	.LLST16
 1667 0367 1D        		.uleb128 0x1d
 1668 0368 0000 0000 		.long	.LVL51
 1669 036c 01        		.byte	0x1
 1670 036d C702 0000 		.long	0x2c7
 1671 0371 15        		.uleb128 0x15
 1672 0372 01        		.byte	0x1
 1673 0373 68        		.byte	0x68
 1674 0374 05        		.byte	0x5
 1675 0375 F3        		.byte	0xf3
 1676 0376 01        		.uleb128 0x1
 1677 0377 68        		.byte	0x68
 1678 0378 31        		.byte	0x31
 1679 0379 24        		.byte	0x24
 1680 037a 00        		.byte	0
 1681 037b 00        		.byte	0
 1682 037c 05        		.uleb128 0x5
 1683 037d 02        		.byte	0x2
 1684 037e 8203 0000 		.long	0x382
 1685 0382 1E        		.uleb128 0x1e
 1686 0383 3000 0000 		.long	0x30
 1687 0387 1B        		.uleb128 0x1b
 1688 0388 01        		.byte	0x1
 1689 0389 0000 0000 		.long	.LASF37
 1690 038d 01        		.byte	0x1
GAS LISTING /tmp/ccChP33i.s 			page 39


 1691 038e B701      		.word	0x1b7
 1692 0390 0000 0000 		.long	.LFB109
 1693 0394 0000 0000 		.long	.LFE109
 1694 0398 03        		.byte	0x3
 1695 0399 92        		.byte	0x92
 1696 039a 20        		.uleb128 0x20
 1697 039b 03        		.sleb128 3
 1698 039c 01        		.byte	0x1
 1699 039d E803 0000 		.long	0x3e8
 1700 03a1 1C        		.uleb128 0x1c
 1701 03a2 0000 0000 		.long	.LASF32
 1702 03a6 01        		.byte	0x1
 1703 03a7 B701      		.word	0x1b7
 1704 03a9 3000 0000 		.long	0x30
 1705 03ad 0000 0000 		.long	.LLST17
 1706 03b1 1C        		.uleb128 0x1c
 1707 03b2 0000 0000 		.long	.LASF35
 1708 03b6 01        		.byte	0x1
 1709 03b7 B701      		.word	0x1b7
 1710 03b9 6F01 0000 		.long	0x16f
 1711 03bd 0000 0000 		.long	.LLST18
 1712 03c1 1C        		.uleb128 0x1c
 1713 03c2 0000 0000 		.long	.LASF36
 1714 03c6 01        		.byte	0x1
 1715 03c7 B701      		.word	0x1b7
 1716 03c9 3000 0000 		.long	0x30
 1717 03cd 0000 0000 		.long	.LLST19
 1718 03d1 1D        		.uleb128 0x1d
 1719 03d2 0000 0000 		.long	.LVL54
 1720 03d6 01        		.byte	0x1
 1721 03d7 C702 0000 		.long	0x2c7
 1722 03db 15        		.uleb128 0x15
 1723 03dc 01        		.byte	0x1
 1724 03dd 68        		.byte	0x68
 1725 03de 07        		.byte	0x7
 1726 03df F3        		.byte	0xf3
 1727 03e0 01        		.uleb128 0x1
 1728 03e1 68        		.byte	0x68
 1729 03e2 31        		.byte	0x31
 1730 03e3 24        		.byte	0x24
 1731 03e4 31        		.byte	0x31
 1732 03e5 21        		.byte	0x21
 1733 03e6 00        		.byte	0
 1734 03e7 00        		.byte	0
 1735 03e8 1F        		.uleb128 0x1f
 1736 03e9 01        		.byte	0x1
 1737 03ea 0000 0000 		.long	.LASF38
 1738 03ee 01        		.byte	0x1
 1739 03ef C201      		.word	0x1c2
 1740 03f1 0000 0000 		.long	.LFB110
 1741 03f5 0000 0000 		.long	.LFE110
 1742 03f9 0000 0000 		.long	.LLST20
 1743 03fd 01        		.byte	0x1
 1744 03fe 5704 0000 		.long	0x457
 1745 0402 1C        		.uleb128 0x1c
 1746 0403 0000 0000 		.long	.LASF32
 1747 0407 01        		.byte	0x1
GAS LISTING /tmp/ccChP33i.s 			page 40


 1748 0408 C201      		.word	0x1c2
 1749 040a 3000 0000 		.long	0x30
 1750 040e 0000 0000 		.long	.LLST21
 1751 0412 20        		.uleb128 0x20
 1752 0413 0000 0000 		.long	.LASF39
 1753 0417 01        		.byte	0x1
 1754 0418 C301      		.word	0x1c3
 1755 041a 6F01 0000 		.long	0x16f
 1756 041e 06        		.byte	0x6
 1757 041f 66        		.byte	0x66
 1758 0420 93        		.byte	0x93
 1759 0421 01        		.uleb128 0x1
 1760 0422 67        		.byte	0x67
 1761 0423 93        		.byte	0x93
 1762 0424 01        		.uleb128 0x1
 1763 0425 20        		.uleb128 0x20
 1764 0426 0000 0000 		.long	.LASF40
 1765 042a 01        		.byte	0x1
 1766 042b C301      		.word	0x1c3
 1767 042d 3000 0000 		.long	0x30
 1768 0431 01        		.byte	0x1
 1769 0432 64        		.byte	0x64
 1770 0433 20        		.uleb128 0x20
 1771 0434 0000 0000 		.long	.LASF35
 1772 0438 01        		.byte	0x1
 1773 0439 C401      		.word	0x1c4
 1774 043b 6F01 0000 		.long	0x16f
 1775 043f 06        		.byte	0x6
 1776 0440 62        		.byte	0x62
 1777 0441 93        		.byte	0x93
 1778 0442 01        		.uleb128 0x1
 1779 0443 63        		.byte	0x63
 1780 0444 93        		.byte	0x93
 1781 0445 01        		.uleb128 0x1
 1782 0446 1C        		.uleb128 0x1c
 1783 0447 0000 0000 		.long	.LASF41
 1784 044b 01        		.byte	0x1
 1785 044c C401      		.word	0x1c4
 1786 044e 3000 0000 		.long	0x30
 1787 0452 0000 0000 		.long	.LLST22
 1788 0456 00        		.byte	0
 1789 0457 1B        		.uleb128 0x1b
 1790 0458 01        		.byte	0x1
 1791 0459 0000 0000 		.long	.LASF42
 1792 045d 02        		.byte	0x2
 1793 045e E901      		.word	0x1e9
 1794 0460 0000 0000 		.long	.LFB111
 1795 0464 0000 0000 		.long	.LFE111
 1796 0468 03        		.byte	0x3
 1797 0469 92        		.byte	0x92
 1798 046a 20        		.uleb128 0x20
 1799 046b 03        		.sleb128 3
 1800 046c 01        		.byte	0x1
 1801 046d AA04 0000 		.long	0x4aa
 1802 0471 1C        		.uleb128 0x1c
 1803 0472 0000 0000 		.long	.LASF43
 1804 0476 02        		.byte	0x2
GAS LISTING /tmp/ccChP33i.s 			page 41


 1805 0477 E901      		.word	0x1e9
 1806 0479 3000 0000 		.long	0x30
 1807 047d 0000 0000 		.long	.LLST23
 1808 0481 21        		.uleb128 0x21
 1809 0482 5F72 7300 		.string	"_rs"
 1810 0486 02        		.byte	0x2
 1811 0487 E901      		.word	0x1e9
 1812 0489 3000 0000 		.long	0x30
 1813 048d 01        		.byte	0x1
 1814 048e 66        		.byte	0x66
 1815 048f 10        		.uleb128 0x10
 1816 0490 0000 0000 		.long	.LBB8
 1817 0494 0000 0000 		.long	.LBE8
 1818 0498 22        		.uleb128 0x22
 1819 0499 0000 0000 		.long	.LASF44
 1820 049d 02        		.byte	0x2
 1821 049e EB01      		.word	0x1eb
 1822 04a0 3000 0000 		.long	0x30
 1823 04a4 0000 0000 		.long	.LLST24
 1824 04a8 00        		.byte	0
 1825 04a9 00        		.byte	0
 1826 04aa 1F        		.uleb128 0x1f
 1827 04ab 01        		.byte	0x1
 1828 04ac 0000 0000 		.long	.LASF45
 1829 04b0 02        		.byte	0x2
 1830 04b1 FE01      		.word	0x1fe
 1831 04b3 0000 0000 		.long	.LFB112
 1832 04b7 0000 0000 		.long	.LFE112
 1833 04bb 0000 0000 		.long	.LLST25
 1834 04bf 01        		.byte	0x1
 1835 04c0 5505 0000 		.long	0x555
 1836 04c4 23        		.uleb128 0x23
 1837 04c5 6275 6600 		.string	"buf"
 1838 04c9 02        		.byte	0x2
 1839 04ca FE01      		.word	0x1fe
 1840 04cc 8900 0000 		.long	0x89
 1841 04d0 0000 0000 		.long	.LLST26
 1842 04d4 23        		.uleb128 0x23
 1843 04d5 6C65 6E00 		.string	"len"
 1844 04d9 02        		.byte	0x2
 1845 04da FE01      		.word	0x1fe
 1846 04dc 3000 0000 		.long	0x30
 1847 04e0 0000 0000 		.long	.LLST27
 1848 04e4 10        		.uleb128 0x10
 1849 04e5 0000 0000 		.long	.LBB9
 1850 04e9 0000 0000 		.long	.LBE9
 1851 04ed 19        		.uleb128 0x19
 1852 04ee 5F62 00   		.string	"_b"
 1853 04f1 02        		.byte	0x2
 1854 04f2 0002      		.word	0x200
 1855 04f4 6F01 0000 		.long	0x16f
 1856 04f8 0000 0000 		.long	.LLST28
 1857 04fc 19        		.uleb128 0x19
 1858 04fd 5F6C 00   		.string	"_l"
 1859 0500 02        		.byte	0x2
 1860 0501 0102      		.word	0x201
 1861 0503 3000 0000 		.long	0x30
GAS LISTING /tmp/ccChP33i.s 			page 42


 1862 0507 0000 0000 		.long	.LLST29
 1863 050b 24        		.uleb128 0x24
 1864 050c 0000 0000 		.long	.LVL73
 1865 0510 5704 0000 		.long	0x457
 1866 0514 1E05 0000 		.long	0x51e
 1867 0518 15        		.uleb128 0x15
 1868 0519 01        		.byte	0x1
 1869 051a 66        		.byte	0x66
 1870 051b 01        		.byte	0x1
 1871 051c 31        		.byte	0x31
 1872 051d 00        		.byte	0
 1873 051e 24        		.uleb128 0x24
 1874 051f 0000 0000 		.long	.LVL74
 1875 0523 1D03 0000 		.long	0x31d
 1876 0527 3F05 0000 		.long	0x53f
 1877 052b 15        		.uleb128 0x15
 1878 052c 06        		.byte	0x6
 1879 052d 66        		.byte	0x66
 1880 052e 93        		.byte	0x93
 1881 052f 01        		.uleb128 0x1
 1882 0530 67        		.byte	0x67
 1883 0531 93        		.byte	0x93
 1884 0532 01        		.uleb128 0x1
 1885 0533 05        		.byte	0x5
 1886 0534 03        		.byte	0x3
 1887 0535 0000 0000 		.long	lcdBuffer
 1888 0539 15        		.uleb128 0x15
 1889 053a 01        		.byte	0x1
 1890 053b 64        		.byte	0x64
 1891 053c 01        		.byte	0x1
 1892 053d 36        		.byte	0x36
 1893 053e 00        		.byte	0
 1894 053f 14        		.uleb128 0x14
 1895 0540 0000 0000 		.long	.LVL75
 1896 0544 3C0B 0000 		.long	0xb3c
 1897 0548 15        		.uleb128 0x15
 1898 0549 06        		.byte	0x6
 1899 054a 68        		.byte	0x68
 1900 054b 93        		.byte	0x93
 1901 054c 01        		.uleb128 0x1
 1902 054d 69        		.byte	0x69
 1903 054e 93        		.byte	0x93
 1904 054f 01        		.uleb128 0x1
 1905 0550 01        		.byte	0x1
 1906 0551 35        		.byte	0x35
 1907 0552 00        		.byte	0
 1908 0553 00        		.byte	0
 1909 0554 00        		.byte	0
 1910 0555 1B        		.uleb128 0x1b
 1911 0556 01        		.byte	0x1
 1912 0557 0000 0000 		.long	.LASF46
 1913 055b 02        		.byte	0x2
 1914 055c 0B02      		.word	0x20b
 1915 055e 0000 0000 		.long	.LFB113
 1916 0562 0000 0000 		.long	.LFE113
 1917 0566 03        		.byte	0x3
 1918 0567 92        		.byte	0x92
GAS LISTING /tmp/ccChP33i.s 			page 43


 1919 0568 20        		.uleb128 0x20
 1920 0569 03        		.sleb128 3
 1921 056a 01        		.byte	0x1
 1922 056b 0B07 0000 		.long	0x70b
 1923 056f 24        		.uleb128 0x24
 1924 0570 0000 0000 		.long	.LVL78
 1925 0574 5704 0000 		.long	0x457
 1926 0578 8205 0000 		.long	0x582
 1927 057c 15        		.uleb128 0x15
 1928 057d 01        		.byte	0x1
 1929 057e 66        		.byte	0x66
 1930 057f 01        		.byte	0x1
 1931 0580 30        		.byte	0x30
 1932 0581 00        		.byte	0
 1933 0582 24        		.uleb128 0x24
 1934 0583 0000 0000 		.long	.LVL79
 1935 0587 1D03 0000 		.long	0x31d
 1936 058b A305 0000 		.long	0x5a3
 1937 058f 15        		.uleb128 0x15
 1938 0590 06        		.byte	0x6
 1939 0591 66        		.byte	0x66
 1940 0592 93        		.byte	0x93
 1941 0593 01        		.uleb128 0x1
 1942 0594 67        		.byte	0x67
 1943 0595 93        		.byte	0x93
 1944 0596 01        		.uleb128 0x1
 1945 0597 05        		.byte	0x5
 1946 0598 03        		.byte	0x3
 1947 0599 0000 0000 		.long	lcdBuffer
 1948 059d 15        		.uleb128 0x15
 1949 059e 01        		.byte	0x1
 1950 059f 64        		.byte	0x64
 1951 05a0 01        		.byte	0x1
 1952 05a1 36        		.byte	0x36
 1953 05a2 00        		.byte	0
 1954 05a3 24        		.uleb128 0x24
 1955 05a4 0000 0000 		.long	.LVL80
 1956 05a8 3C0B 0000 		.long	0xb3c
 1957 05ac BB05 0000 		.long	0x5bb
 1958 05b0 15        		.uleb128 0x15
 1959 05b1 06        		.byte	0x6
 1960 05b2 68        		.byte	0x68
 1961 05b3 93        		.byte	0x93
 1962 05b4 01        		.uleb128 0x1
 1963 05b5 69        		.byte	0x69
 1964 05b6 93        		.byte	0x93
 1965 05b7 01        		.uleb128 0x1
 1966 05b8 01        		.byte	0x1
 1967 05b9 35        		.byte	0x35
 1968 05ba 00        		.byte	0
 1969 05bb 24        		.uleb128 0x24
 1970 05bc 0000 0000 		.long	.LVL81
 1971 05c0 5704 0000 		.long	0x457
 1972 05c4 CE05 0000 		.long	0x5ce
 1973 05c8 15        		.uleb128 0x15
 1974 05c9 01        		.byte	0x1
 1975 05ca 66        		.byte	0x66
GAS LISTING /tmp/ccChP33i.s 			page 44


 1976 05cb 01        		.byte	0x1
 1977 05cc 30        		.byte	0x30
 1978 05cd 00        		.byte	0
 1979 05ce 24        		.uleb128 0x24
 1980 05cf 0000 0000 		.long	.LVL82
 1981 05d3 1D03 0000 		.long	0x31d
 1982 05d7 EF05 0000 		.long	0x5ef
 1983 05db 15        		.uleb128 0x15
 1984 05dc 06        		.byte	0x6
 1985 05dd 66        		.byte	0x66
 1986 05de 93        		.byte	0x93
 1987 05df 01        		.uleb128 0x1
 1988 05e0 67        		.byte	0x67
 1989 05e1 93        		.byte	0x93
 1990 05e2 01        		.uleb128 0x1
 1991 05e3 05        		.byte	0x5
 1992 05e4 03        		.byte	0x3
 1993 05e5 0000 0000 		.long	lcdBuffer
 1994 05e9 15        		.uleb128 0x15
 1995 05ea 01        		.byte	0x1
 1996 05eb 64        		.byte	0x64
 1997 05ec 01        		.byte	0x1
 1998 05ed 36        		.byte	0x36
 1999 05ee 00        		.byte	0
 2000 05ef 24        		.uleb128 0x24
 2001 05f0 0000 0000 		.long	.LVL83
 2002 05f4 3C0B 0000 		.long	0xb3c
 2003 05f8 0706 0000 		.long	0x607
 2004 05fc 15        		.uleb128 0x15
 2005 05fd 06        		.byte	0x6
 2006 05fe 68        		.byte	0x68
 2007 05ff 93        		.byte	0x93
 2008 0600 01        		.uleb128 0x1
 2009 0601 69        		.byte	0x69
 2010 0602 93        		.byte	0x93
 2011 0603 01        		.uleb128 0x1
 2012 0604 01        		.byte	0x1
 2013 0605 35        		.byte	0x35
 2014 0606 00        		.byte	0
 2015 0607 24        		.uleb128 0x24
 2016 0608 0000 0000 		.long	.LVL84
 2017 060c 5704 0000 		.long	0x457
 2018 0610 1A06 0000 		.long	0x61a
 2019 0614 15        		.uleb128 0x15
 2020 0615 01        		.byte	0x1
 2021 0616 66        		.byte	0x66
 2022 0617 01        		.byte	0x1
 2023 0618 30        		.byte	0x30
 2024 0619 00        		.byte	0
 2025 061a 24        		.uleb128 0x24
 2026 061b 0000 0000 		.long	.LVL85
 2027 061f 1D03 0000 		.long	0x31d
 2028 0623 3B06 0000 		.long	0x63b
 2029 0627 15        		.uleb128 0x15
 2030 0628 06        		.byte	0x6
 2031 0629 66        		.byte	0x66
 2032 062a 93        		.byte	0x93
GAS LISTING /tmp/ccChP33i.s 			page 45


 2033 062b 01        		.uleb128 0x1
 2034 062c 67        		.byte	0x67
 2035 062d 93        		.byte	0x93
 2036 062e 01        		.uleb128 0x1
 2037 062f 05        		.byte	0x5
 2038 0630 03        		.byte	0x3
 2039 0631 0000 0000 		.long	lcdBuffer
 2040 0635 15        		.uleb128 0x15
 2041 0636 01        		.byte	0x1
 2042 0637 64        		.byte	0x64
 2043 0638 01        		.byte	0x1
 2044 0639 36        		.byte	0x36
 2045 063a 00        		.byte	0
 2046 063b 24        		.uleb128 0x24
 2047 063c 0000 0000 		.long	.LVL86
 2048 0640 3C0B 0000 		.long	0xb3c
 2049 0644 5306 0000 		.long	0x653
 2050 0648 15        		.uleb128 0x15
 2051 0649 06        		.byte	0x6
 2052 064a 68        		.byte	0x68
 2053 064b 93        		.byte	0x93
 2054 064c 01        		.uleb128 0x1
 2055 064d 69        		.byte	0x69
 2056 064e 93        		.byte	0x93
 2057 064f 01        		.uleb128 0x1
 2058 0650 01        		.byte	0x1
 2059 0651 35        		.byte	0x35
 2060 0652 00        		.byte	0
 2061 0653 24        		.uleb128 0x24
 2062 0654 0000 0000 		.long	.LVL87
 2063 0658 5704 0000 		.long	0x457
 2064 065c 6B06 0000 		.long	0x66b
 2065 0660 15        		.uleb128 0x15
 2066 0661 01        		.byte	0x1
 2067 0662 68        		.byte	0x68
 2068 0663 01        		.byte	0x1
 2069 0664 31        		.byte	0x31
 2070 0665 15        		.uleb128 0x15
 2071 0666 01        		.byte	0x1
 2072 0667 66        		.byte	0x66
 2073 0668 01        		.byte	0x1
 2074 0669 30        		.byte	0x30
 2075 066a 00        		.byte	0
 2076 066b 24        		.uleb128 0x24
 2077 066c 0000 0000 		.long	.LVL88
 2078 0670 1D03 0000 		.long	0x31d
 2079 0674 8C06 0000 		.long	0x68c
 2080 0678 15        		.uleb128 0x15
 2081 0679 06        		.byte	0x6
 2082 067a 66        		.byte	0x66
 2083 067b 93        		.byte	0x93
 2084 067c 01        		.uleb128 0x1
 2085 067d 67        		.byte	0x67
 2086 067e 93        		.byte	0x93
 2087 067f 01        		.uleb128 0x1
 2088 0680 05        		.byte	0x5
 2089 0681 03        		.byte	0x3
GAS LISTING /tmp/ccChP33i.s 			page 46


 2090 0682 0000 0000 		.long	lcdBuffer
 2091 0686 15        		.uleb128 0x15
 2092 0687 01        		.byte	0x1
 2093 0688 64        		.byte	0x64
 2094 0689 01        		.byte	0x1
 2095 068a 36        		.byte	0x36
 2096 068b 00        		.byte	0
 2097 068c 24        		.uleb128 0x24
 2098 068d 0000 0000 		.long	.LVL89
 2099 0691 3C0B 0000 		.long	0xb3c
 2100 0695 A406 0000 		.long	0x6a4
 2101 0699 15        		.uleb128 0x15
 2102 069a 06        		.byte	0x6
 2103 069b 68        		.byte	0x68
 2104 069c 93        		.byte	0x93
 2105 069d 01        		.uleb128 0x1
 2106 069e 69        		.byte	0x69
 2107 069f 93        		.byte	0x93
 2108 06a0 01        		.uleb128 0x1
 2109 06a1 01        		.byte	0x1
 2110 06a2 35        		.byte	0x35
 2111 06a3 00        		.byte	0
 2112 06a4 24        		.uleb128 0x24
 2113 06a5 0000 0000 		.long	.LVL90
 2114 06a9 3C0B 0000 		.long	0xb3c
 2115 06ad BC06 0000 		.long	0x6bc
 2116 06b1 15        		.uleb128 0x15
 2117 06b2 06        		.byte	0x6
 2118 06b3 68        		.byte	0x68
 2119 06b4 93        		.byte	0x93
 2120 06b5 01        		.uleb128 0x1
 2121 06b6 69        		.byte	0x69
 2122 06b7 93        		.byte	0x93
 2123 06b8 01        		.uleb128 0x1
 2124 06b9 01        		.byte	0x1
 2125 06ba 40        		.byte	0x40
 2126 06bb 00        		.byte	0
 2127 06bc 24        		.uleb128 0x24
 2128 06bd 0000 0000 		.long	.LVL91
 2129 06c1 5704 0000 		.long	0x457
 2130 06c5 D406 0000 		.long	0x6d4
 2131 06c9 15        		.uleb128 0x15
 2132 06ca 01        		.byte	0x1
 2133 06cb 68        		.byte	0x68
 2134 06cc 01        		.byte	0x1
 2135 06cd 32        		.byte	0x32
 2136 06ce 15        		.uleb128 0x15
 2137 06cf 01        		.byte	0x1
 2138 06d0 66        		.byte	0x66
 2139 06d1 01        		.byte	0x1
 2140 06d2 30        		.byte	0x30
 2141 06d3 00        		.byte	0
 2142 06d4 24        		.uleb128 0x24
 2143 06d5 0000 0000 		.long	.LVL92
 2144 06d9 1D03 0000 		.long	0x31d
 2145 06dd F506 0000 		.long	0x6f5
 2146 06e1 15        		.uleb128 0x15
GAS LISTING /tmp/ccChP33i.s 			page 47


 2147 06e2 06        		.byte	0x6
 2148 06e3 66        		.byte	0x66
 2149 06e4 93        		.byte	0x93
 2150 06e5 01        		.uleb128 0x1
 2151 06e6 67        		.byte	0x67
 2152 06e7 93        		.byte	0x93
 2153 06e8 01        		.uleb128 0x1
 2154 06e9 05        		.byte	0x5
 2155 06ea 03        		.byte	0x3
 2156 06eb 0000 0000 		.long	lcdBuffer
 2157 06ef 15        		.uleb128 0x15
 2158 06f0 01        		.byte	0x1
 2159 06f1 64        		.byte	0x64
 2160 06f2 01        		.byte	0x1
 2161 06f3 36        		.byte	0x36
 2162 06f4 00        		.byte	0
 2163 06f5 1D        		.uleb128 0x1d
 2164 06f6 0000 0000 		.long	.LVL93
 2165 06fa 01        		.byte	0x1
 2166 06fb 3C0B 0000 		.long	0xb3c
 2167 06ff 15        		.uleb128 0x15
 2168 0700 06        		.byte	0x6
 2169 0701 68        		.byte	0x68
 2170 0702 93        		.byte	0x93
 2171 0703 01        		.uleb128 0x1
 2172 0704 69        		.byte	0x69
 2173 0705 93        		.byte	0x93
 2174 0706 01        		.uleb128 0x1
 2175 0707 01        		.byte	0x1
 2176 0708 35        		.byte	0x35
 2177 0709 00        		.byte	0
 2178 070a 00        		.byte	0
 2179 070b 1F        		.uleb128 0x1f
 2180 070c 01        		.byte	0x1
 2181 070d 0000 0000 		.long	.LASF47
 2182 0711 02        		.byte	0x2
 2183 0712 1702      		.word	0x217
 2184 0714 0000 0000 		.long	.LFB114
 2185 0718 0000 0000 		.long	.LFE114
 2186 071c 0000 0000 		.long	.LLST30
 2187 0720 01        		.byte	0x1
 2188 0721 F308 0000 		.long	0x8f3
 2189 0725 1C        		.uleb128 0x1c
 2190 0726 0000 0000 		.long	.LASF48
 2191 072a 02        		.byte	0x2
 2192 072b 1702      		.word	0x217
 2193 072d 3000 0000 		.long	0x30
 2194 0731 0000 0000 		.long	.LLST31
 2195 0735 1C        		.uleb128 0x1c
 2196 0736 0000 0000 		.long	.LASF49
 2197 073a 02        		.byte	0x2
 2198 073b 1702      		.word	0x217
 2199 073d 3000 0000 		.long	0x30
 2200 0741 0000 0000 		.long	.LLST32
 2201 0745 1C        		.uleb128 0x1c
 2202 0746 0000 0000 		.long	.LASF50
 2203 074a 02        		.byte	0x2
GAS LISTING /tmp/ccChP33i.s 			page 48


 2204 074b 1702      		.word	0x217
 2205 074d 3000 0000 		.long	0x30
 2206 0751 0000 0000 		.long	.LLST33
 2207 0755 1C        		.uleb128 0x1c
 2208 0756 0000 0000 		.long	.LASF51
 2209 075a 02        		.byte	0x2
 2210 075b 1702      		.word	0x217
 2211 075d 3000 0000 		.long	0x30
 2212 0761 0000 0000 		.long	.LLST34
 2213 0765 24        		.uleb128 0x24
 2214 0766 0000 0000 		.long	.LVL100
 2215 076a E201 0000 		.long	0x1e2
 2216 076e 8C07 0000 		.long	0x78c
 2217 0772 15        		.uleb128 0x15
 2218 0773 0C        		.byte	0xc
 2219 0774 66        		.byte	0x66
 2220 0775 93        		.byte	0x93
 2221 0776 01        		.uleb128 0x1
 2222 0777 67        		.byte	0x67
 2223 0778 93        		.byte	0x93
 2224 0779 01        		.uleb128 0x1
 2225 077a 68        		.byte	0x68
 2226 077b 93        		.byte	0x93
 2227 077c 01        		.uleb128 0x1
 2228 077d 69        		.byte	0x69
 2229 077e 93        		.byte	0x93
 2230 077f 01        		.uleb128 0x1
 2231 0780 05        		.byte	0x5
 2232 0781 0C        		.byte	0xc
 2233 0782 A086 0100 		.long	0x186a0
 2234 0786 15        		.uleb128 0x15
 2235 0787 01        		.byte	0x1
 2236 0788 64        		.byte	0x64
 2237 0789 01        		.byte	0x1
 2238 078a 36        		.byte	0x36
 2239 078b 00        		.byte	0
 2240 078c 24        		.uleb128 0x24
 2241 078d 0000 0000 		.long	.LVL101
 2242 0791 5704 0000 		.long	0x457
 2243 0795 A507 0000 		.long	0x7a5
 2244 0799 15        		.uleb128 0x15
 2245 079a 01        		.byte	0x1
 2246 079b 68        		.byte	0x68
 2247 079c 02        		.byte	0x2
 2248 079d 08        		.byte	0x8
 2249 079e 30        		.byte	0x30
 2250 079f 15        		.uleb128 0x15
 2251 07a0 01        		.byte	0x1
 2252 07a1 66        		.byte	0x66
 2253 07a2 01        		.byte	0x1
 2254 07a3 30        		.byte	0x30
 2255 07a4 00        		.byte	0
 2256 07a5 24        		.uleb128 0x24
 2257 07a6 0000 0000 		.long	.LVL102
 2258 07aa 3C0B 0000 		.long	0xb3c
 2259 07ae BD07 0000 		.long	0x7bd
 2260 07b2 15        		.uleb128 0x15
GAS LISTING /tmp/ccChP33i.s 			page 49


 2261 07b3 06        		.byte	0x6
 2262 07b4 68        		.byte	0x68
 2263 07b5 93        		.byte	0x93
 2264 07b6 01        		.uleb128 0x1
 2265 07b7 69        		.byte	0x69
 2266 07b8 93        		.byte	0x93
 2267 07b9 01        		.uleb128 0x1
 2268 07ba 01        		.byte	0x1
 2269 07bb 3F        		.byte	0x3f
 2270 07bc 00        		.byte	0
 2271 07bd 24        		.uleb128 0x24
 2272 07be 0000 0000 		.long	.LVL103
 2273 07c2 1D03 0000 		.long	0x31d
 2274 07c6 DE07 0000 		.long	0x7de
 2275 07ca 15        		.uleb128 0x15
 2276 07cb 06        		.byte	0x6
 2277 07cc 66        		.byte	0x66
 2278 07cd 93        		.byte	0x93
 2279 07ce 01        		.uleb128 0x1
 2280 07cf 67        		.byte	0x67
 2281 07d0 93        		.byte	0x93
 2282 07d1 01        		.uleb128 0x1
 2283 07d2 05        		.byte	0x5
 2284 07d3 03        		.byte	0x3
 2285 07d4 0000 0000 		.long	lcdBuffer
 2286 07d8 15        		.uleb128 0x15
 2287 07d9 01        		.byte	0x1
 2288 07da 64        		.byte	0x64
 2289 07db 01        		.byte	0x1
 2290 07dc 33        		.byte	0x33
 2291 07dd 00        		.byte	0
 2292 07de 24        		.uleb128 0x24
 2293 07df 0000 0000 		.long	.LVL104
 2294 07e3 3C0B 0000 		.long	0xb3c
 2295 07e7 F607 0000 		.long	0x7f6
 2296 07eb 15        		.uleb128 0x15
 2297 07ec 06        		.byte	0x6
 2298 07ed 68        		.byte	0x68
 2299 07ee 93        		.byte	0x93
 2300 07ef 01        		.uleb128 0x1
 2301 07f0 69        		.byte	0x69
 2302 07f1 93        		.byte	0x93
 2303 07f2 01        		.uleb128 0x1
 2304 07f3 01        		.byte	0x1
 2305 07f4 35        		.byte	0x35
 2306 07f5 00        		.byte	0
 2307 07f6 24        		.uleb128 0x24
 2308 07f7 0000 0000 		.long	.LVL105
 2309 07fb 3C0B 0000 		.long	0xb3c
 2310 07ff 0E08 0000 		.long	0x80e
 2311 0803 15        		.uleb128 0x15
 2312 0804 06        		.byte	0x6
 2313 0805 68        		.byte	0x68
 2314 0806 93        		.byte	0x93
 2315 0807 01        		.uleb128 0x1
 2316 0808 69        		.byte	0x69
 2317 0809 93        		.byte	0x93
GAS LISTING /tmp/ccChP33i.s 			page 50


 2318 080a 01        		.uleb128 0x1
 2319 080b 01        		.byte	0x1
 2320 080c 35        		.byte	0x35
 2321 080d 00        		.byte	0
 2322 080e 24        		.uleb128 0x24
 2323 080f 0000 0000 		.long	.LVL106
 2324 0813 1D03 0000 		.long	0x31d
 2325 0817 2F08 0000 		.long	0x82f
 2326 081b 15        		.uleb128 0x15
 2327 081c 06        		.byte	0x6
 2328 081d 66        		.byte	0x66
 2329 081e 93        		.byte	0x93
 2330 081f 01        		.uleb128 0x1
 2331 0820 67        		.byte	0x67
 2332 0821 93        		.byte	0x93
 2333 0822 01        		.uleb128 0x1
 2334 0823 05        		.byte	0x5
 2335 0824 03        		.byte	0x3
 2336 0825 0000 0000 		.long	lcdBuffer
 2337 0829 15        		.uleb128 0x15
 2338 082a 01        		.byte	0x1
 2339 082b 64        		.byte	0x64
 2340 082c 01        		.byte	0x1
 2341 082d 33        		.byte	0x33
 2342 082e 00        		.byte	0
 2343 082f 24        		.uleb128 0x24
 2344 0830 0000 0000 		.long	.LVL107
 2345 0834 3C0B 0000 		.long	0xb3c
 2346 0838 4708 0000 		.long	0x847
 2347 083c 15        		.uleb128 0x15
 2348 083d 06        		.byte	0x6
 2349 083e 68        		.byte	0x68
 2350 083f 93        		.byte	0x93
 2351 0840 01        		.uleb128 0x1
 2352 0841 69        		.byte	0x69
 2353 0842 93        		.byte	0x93
 2354 0843 01        		.uleb128 0x1
 2355 0844 01        		.byte	0x1
 2356 0845 35        		.byte	0x35
 2357 0846 00        		.byte	0
 2358 0847 24        		.uleb128 0x24
 2359 0848 0000 0000 		.long	.LVL108
 2360 084c 1D03 0000 		.long	0x31d
 2361 0850 6808 0000 		.long	0x868
 2362 0854 15        		.uleb128 0x15
 2363 0855 06        		.byte	0x6
 2364 0856 66        		.byte	0x66
 2365 0857 93        		.byte	0x93
 2366 0858 01        		.uleb128 0x1
 2367 0859 67        		.byte	0x67
 2368 085a 93        		.byte	0x93
 2369 085b 01        		.uleb128 0x1
 2370 085c 05        		.byte	0x5
 2371 085d 03        		.byte	0x3
 2372 085e 0000 0000 		.long	lcdBuffer
 2373 0862 15        		.uleb128 0x15
 2374 0863 01        		.byte	0x1
GAS LISTING /tmp/ccChP33i.s 			page 51


 2375 0864 64        		.byte	0x64
 2376 0865 01        		.byte	0x1
 2377 0866 33        		.byte	0x33
 2378 0867 00        		.byte	0
 2379 0868 24        		.uleb128 0x24
 2380 0869 0000 0000 		.long	.LVL109
 2381 086d 3C0B 0000 		.long	0xb3c
 2382 0871 8008 0000 		.long	0x880
 2383 0875 15        		.uleb128 0x15
 2384 0876 06        		.byte	0x6
 2385 0877 68        		.byte	0x68
 2386 0878 93        		.byte	0x93
 2387 0879 01        		.uleb128 0x1
 2388 087a 69        		.byte	0x69
 2389 087b 93        		.byte	0x93
 2390 087c 01        		.uleb128 0x1
 2391 087d 01        		.byte	0x1
 2392 087e 35        		.byte	0x35
 2393 087f 00        		.byte	0
 2394 0880 24        		.uleb128 0x24
 2395 0881 0000 0000 		.long	.LVL110
 2396 0885 5704 0000 		.long	0x457
 2397 0889 9908 0000 		.long	0x899
 2398 088d 15        		.uleb128 0x15
 2399 088e 01        		.byte	0x1
 2400 088f 68        		.byte	0x68
 2401 0890 02        		.byte	0x2
 2402 0891 08        		.byte	0x8
 2403 0892 20        		.byte	0x20
 2404 0893 15        		.uleb128 0x15
 2405 0894 01        		.byte	0x1
 2406 0895 66        		.byte	0x66
 2407 0896 01        		.byte	0x1
 2408 0897 30        		.byte	0x30
 2409 0898 00        		.byte	0
 2410 0899 24        		.uleb128 0x24
 2411 089a 0000 0000 		.long	.LVL111
 2412 089e 1D03 0000 		.long	0x31d
 2413 08a2 BA08 0000 		.long	0x8ba
 2414 08a6 15        		.uleb128 0x15
 2415 08a7 06        		.byte	0x6
 2416 08a8 66        		.byte	0x66
 2417 08a9 93        		.byte	0x93
 2418 08aa 01        		.uleb128 0x1
 2419 08ab 67        		.byte	0x67
 2420 08ac 93        		.byte	0x93
 2421 08ad 01        		.uleb128 0x1
 2422 08ae 05        		.byte	0x5
 2423 08af 03        		.byte	0x3
 2424 08b0 0000 0000 		.long	lcdBuffer
 2425 08b4 15        		.uleb128 0x15
 2426 08b5 01        		.byte	0x1
 2427 08b6 64        		.byte	0x64
 2428 08b7 01        		.byte	0x1
 2429 08b8 33        		.byte	0x33
 2430 08b9 00        		.byte	0
 2431 08ba 24        		.uleb128 0x24
GAS LISTING /tmp/ccChP33i.s 			page 52


 2432 08bb 0000 0000 		.long	.LVL112
 2433 08bf 3C0B 0000 		.long	0xb3c
 2434 08c3 D208 0000 		.long	0x8d2
 2435 08c7 15        		.uleb128 0x15
 2436 08c8 06        		.byte	0x6
 2437 08c9 68        		.byte	0x68
 2438 08ca 93        		.byte	0x93
 2439 08cb 01        		.uleb128 0x1
 2440 08cc 69        		.byte	0x69
 2441 08cd 93        		.byte	0x93
 2442 08ce 01        		.uleb128 0x1
 2443 08cf 01        		.byte	0x1
 2444 08d0 35        		.byte	0x35
 2445 08d1 00        		.byte	0
 2446 08d2 1A        		.uleb128 0x1a
 2447 08d3 0000 0000 		.long	.LVL113
 2448 08d7 5505 0000 		.long	0x555
 2449 08db 1D        		.uleb128 0x1d
 2450 08dc 0000 0000 		.long	.LVL115
 2451 08e0 01        		.byte	0x1
 2452 08e1 3C0B 0000 		.long	0xb3c
 2453 08e5 15        		.uleb128 0x15
 2454 08e6 06        		.byte	0x6
 2455 08e7 68        		.byte	0x68
 2456 08e8 93        		.byte	0x93
 2457 08e9 01        		.uleb128 0x1
 2458 08ea 69        		.byte	0x69
 2459 08eb 93        		.byte	0x93
 2460 08ec 01        		.uleb128 0x1
 2461 08ed 03        		.byte	0x3
 2462 08ee 0A        		.byte	0xa
 2463 08ef F401      		.word	0x1f4
 2464 08f1 00        		.byte	0
 2465 08f2 00        		.byte	0
 2466 08f3 1B        		.uleb128 0x1b
 2467 08f4 01        		.byte	0x1
 2468 08f5 0000 0000 		.long	.LASF52
 2469 08f9 02        		.byte	0x2
 2470 08fa 4102      		.word	0x241
 2471 08fc 0000 0000 		.long	.LFB115
 2472 0900 0000 0000 		.long	.LFE115
 2473 0904 03        		.byte	0x3
 2474 0905 92        		.byte	0x92
 2475 0906 20        		.uleb128 0x20
 2476 0907 03        		.sleb128 3
 2477 0908 01        		.byte	0x1
 2478 0909 6509 0000 		.long	0x965
 2479 090d 10        		.uleb128 0x10
 2480 090e 0000 0000 		.long	.LBB10
 2481 0912 0000 0000 		.long	.LBE10
 2482 0916 25        		.uleb128 0x25
 2483 0917 0000 0000 		.long	.LASF82
 2484 091b 02        		.byte	0x2
 2485 091c 4202      		.word	0x242
 2486 091e 4900 0000 		.long	0x49
 2487 0922 24        		.uleb128 0x24
 2488 0923 0000 0000 		.long	.LVL116
GAS LISTING /tmp/ccChP33i.s 			page 53


 2489 0927 0B07 0000 		.long	0x70b
 2490 092b 4509 0000 		.long	0x945
 2491 092f 15        		.uleb128 0x15
 2492 0930 01        		.byte	0x1
 2493 0931 68        		.byte	0x68
 2494 0932 02        		.byte	0x2
 2495 0933 08        		.byte	0x8
 2496 0934 27        		.byte	0x27
 2497 0935 15        		.uleb128 0x15
 2498 0936 01        		.byte	0x1
 2499 0937 66        		.byte	0x66
 2500 0938 01        		.byte	0x1
 2501 0939 40        		.byte	0x40
 2502 093a 15        		.uleb128 0x15
 2503 093b 01        		.byte	0x1
 2504 093c 64        		.byte	0x64
 2505 093d 01        		.byte	0x1
 2506 093e 32        		.byte	0x32
 2507 093f 15        		.uleb128 0x15
 2508 0940 01        		.byte	0x1
 2509 0941 62        		.byte	0x62
 2510 0942 01        		.byte	0x1
 2511 0943 31        		.byte	0x31
 2512 0944 00        		.byte	0
 2513 0945 1D        		.uleb128 0x1d
 2514 0946 0000 0000 		.long	.LVL117
 2515 094a 01        		.byte	0x1
 2516 094b AA04 0000 		.long	0x4aa
 2517 094f 15        		.uleb128 0x15
 2518 0950 06        		.byte	0x6
 2519 0951 68        		.byte	0x68
 2520 0952 93        		.byte	0x93
 2521 0953 01        		.uleb128 0x1
 2522 0954 69        		.byte	0x69
 2523 0955 93        		.byte	0x93
 2524 0956 01        		.uleb128 0x1
 2525 0957 05        		.byte	0x5
 2526 0958 03        		.byte	0x3
 2527 0959 0000 0000 		.long	.LC0
 2528 095d 15        		.uleb128 0x15
 2529 095e 01        		.byte	0x1
 2530 095f 66        		.byte	0x66
 2531 0960 01        		.byte	0x1
 2532 0961 3D        		.byte	0x3d
 2533 0962 00        		.byte	0
 2534 0963 00        		.byte	0
 2535 0964 00        		.byte	0
 2536 0965 26        		.uleb128 0x26
 2537 0966 01        		.byte	0x1
 2538 0967 0000 0000 		.long	.LASF83
 2539 096b 02        		.byte	0x2
 2540 096c 4C02      		.word	0x24c
 2541 096e 0000 0000 		.long	.LFB116
 2542 0972 0000 0000 		.long	.LFE116
 2543 0976 03        		.byte	0x3
 2544 0977 92        		.byte	0x92
 2545 0978 20        		.uleb128 0x20
GAS LISTING /tmp/ccChP33i.s 			page 54


 2546 0979 03        		.sleb128 3
 2547 097a 01        		.byte	0x1
 2548 097b 27        		.uleb128 0x27
 2549 097c 0000 0000 		.long	.LASF53
 2550 0980 01        		.byte	0x1
 2551 0981 92        		.byte	0x92
 2552 0982 8D09 0000 		.long	0x98d
 2553 0986 01        		.byte	0x1
 2554 0987 05        		.byte	0x5
 2555 0988 03        		.byte	0x3
 2556 0989 0000 0000 		.long	twiMode
 2557 098d 28        		.uleb128 0x28
 2558 098e 3000 0000 		.long	0x30
 2559 0992 27        		.uleb128 0x27
 2560 0993 0000 0000 		.long	.LASF54
 2561 0997 01        		.byte	0x1
 2562 0998 93        		.byte	0x93
 2563 0999 8D09 0000 		.long	0x98d
 2564 099d 01        		.byte	0x1
 2565 099e 05        		.byte	0x5
 2566 099f 03        		.byte	0x3
 2567 09a0 0000 0000 		.long	twiState
 2568 09a4 27        		.uleb128 0x27
 2569 09a5 0000 0000 		.long	.LASF55
 2570 09a9 01        		.byte	0x1
 2571 09aa 94        		.byte	0x94
 2572 09ab 8D09 0000 		.long	0x98d
 2573 09af 01        		.byte	0x1
 2574 09b0 05        		.byte	0x5
 2575 09b1 03        		.byte	0x3
 2576 09b2 0000 0000 		.long	twiSLARW
 2577 09b6 27        		.uleb128 0x27
 2578 09b7 0000 0000 		.long	.LASF56
 2579 09bb 01        		.byte	0x1
 2580 09bc 96        		.byte	0x96
 2581 09bd 8D09 0000 		.long	0x98d
 2582 09c1 01        		.byte	0x1
 2583 09c2 05        		.byte	0x5
 2584 09c3 03        		.byte	0x3
 2585 09c4 0000 0000 		.long	twiMT_Count
 2586 09c8 27        		.uleb128 0x27
 2587 09c9 0000 0000 		.long	.LASF57
 2588 09cd 01        		.byte	0x1
 2589 09ce 97        		.byte	0x97
 2590 09cf DA09 0000 		.long	0x9da
 2591 09d3 01        		.byte	0x1
 2592 09d4 05        		.byte	0x5
 2593 09d5 03        		.byte	0x3
 2594 09d6 0000 0000 		.long	twiMT_Ptr
 2595 09da 05        		.uleb128 0x5
 2596 09db 02        		.byte	0x2
 2597 09dc 8D09 0000 		.long	0x98d
 2598 09e0 27        		.uleb128 0x27
 2599 09e1 0000 0000 		.long	.LASF58
 2600 09e5 01        		.byte	0x1
 2601 09e6 99        		.byte	0x99
 2602 09e7 8D09 0000 		.long	0x98d
GAS LISTING /tmp/ccChP33i.s 			page 55


 2603 09eb 01        		.byte	0x1
 2604 09ec 05        		.byte	0x5
 2605 09ed 03        		.byte	0x3
 2606 09ee 0000 0000 		.long	twiRX_Count
 2607 09f2 27        		.uleb128 0x27
 2608 09f3 0000 0000 		.long	.LASF59
 2609 09f7 01        		.byte	0x1
 2610 09f8 9A        		.byte	0x9a
 2611 09f9 DA09 0000 		.long	0x9da
 2612 09fd 01        		.byte	0x1
 2613 09fe 05        		.byte	0x5
 2614 09ff 03        		.byte	0x3
 2615 0a00 0000 0000 		.long	twiRX_Ptr
 2616 0a04 27        		.uleb128 0x27
 2617 0a05 0000 0000 		.long	.LASF60
 2618 0a09 01        		.byte	0x1
 2619 0a0a 9C        		.byte	0x9c
 2620 0a0b 8D09 0000 		.long	0x98d
 2621 0a0f 01        		.byte	0x1
 2622 0a10 05        		.byte	0x5
 2623 0a11 03        		.byte	0x3
 2624 0a12 0000 0000 		.long	twiST_Count
 2625 0a16 27        		.uleb128 0x27
 2626 0a17 0000 0000 		.long	.LASF61
 2627 0a1b 01        		.byte	0x1
 2628 0a1c 9D        		.byte	0x9d
 2629 0a1d DA09 0000 		.long	0x9da
 2630 0a21 01        		.byte	0x1
 2631 0a22 05        		.byte	0x5
 2632 0a23 03        		.byte	0x3
 2633 0a24 0000 0000 		.long	twiST_Ptr
 2634 0a28 29        		.uleb128 0x29
 2635 0a29 27        		.uleb128 0x27
 2636 0a2a 0000 0000 		.long	.LASF62
 2637 0a2e 01        		.byte	0x1
 2638 0a2f 9F        		.byte	0x9f
 2639 0a30 3B0A 0000 		.long	0xa3b
 2640 0a34 01        		.byte	0x1
 2641 0a35 05        		.byte	0x5
 2642 0a36 03        		.byte	0x3
 2643 0a37 0000 0000 		.long	twiHookRestart
 2644 0a3b 05        		.uleb128 0x5
 2645 0a3c 02        		.byte	0x2
 2646 0a3d 280A 0000 		.long	0xa28
 2647 0a41 27        		.uleb128 0x27
 2648 0a42 0000 0000 		.long	.LASF63
 2649 0a46 01        		.byte	0x1
 2650 0a47 A0        		.byte	0xa0
 2651 0a48 3B0A 0000 		.long	0xa3b
 2652 0a4c 01        		.byte	0x1
 2653 0a4d 05        		.byte	0x5
 2654 0a4e 03        		.byte	0x3
 2655 0a4f 0000 0000 		.long	twiMasterReader
 2656 0a53 27        		.uleb128 0x27
 2657 0a54 0000 0000 		.long	.LASF64
 2658 0a58 01        		.byte	0x1
 2659 0a59 A1        		.byte	0xa1
GAS LISTING /tmp/ccChP33i.s 			page 56


 2660 0a5a 3B0A 0000 		.long	0xa3b
 2661 0a5e 01        		.byte	0x1
 2662 0a5f 05        		.byte	0x5
 2663 0a60 03        		.byte	0x3
 2664 0a61 0000 0000 		.long	twiSlaveReader
 2665 0a65 27        		.uleb128 0x27
 2666 0a66 0000 0000 		.long	.LASF65
 2667 0a6a 01        		.byte	0x1
 2668 0a6b A2        		.byte	0xa2
 2669 0a6c 3B0A 0000 		.long	0xa3b
 2670 0a70 01        		.byte	0x1
 2671 0a71 05        		.byte	0x5
 2672 0a72 03        		.byte	0x3
 2673 0a73 0000 0000 		.long	twiSlaveWriter
 2674 0a77 11        		.uleb128 0x11
 2675 0a78 0000 0000 		.long	.LASF66
 2676 0a7c 01        		.byte	0x1
 2677 0a7d AA        		.byte	0xaa
 2678 0a7e 880A 0000 		.long	0xa88
 2679 0a82 05        		.byte	0x5
 2680 0a83 03        		.byte	0x3
 2681 0a84 0000 0000 		.long	_ZL12twiStatistic
 2682 0a88 28        		.uleb128 0x28
 2683 0a89 6401 0000 		.long	0x164
 2684 0a8d 2A        		.uleb128 0x2a
 2685 0a8e 0000 0000 		.long	.LASF67
 2686 0a92 02        		.byte	0x2
 2687 0a93 DB01      		.word	0x1db
 2688 0a95 3000 0000 		.long	0x30
 2689 0a99 01        		.byte	0x1
 2690 0a9a 05        		.byte	0x5
 2691 0a9b 03        		.byte	0x3
 2692 0a9c 0000 0000 		.long	lcdModes
 2693 0aa0 2A        		.uleb128 0x2a
 2694 0aa1 0000 0000 		.long	.LASF68
 2695 0aa5 02        		.byte	0x2
 2696 0aa6 DC01      		.word	0x1dc
 2697 0aa8 3000 0000 		.long	0x30
 2698 0aac 01        		.byte	0x1
 2699 0aad 05        		.byte	0x5
 2700 0aae 03        		.byte	0x3
 2701 0aaf 0000 0000 		.long	lcdShifts
 2702 0ab3 2A        		.uleb128 0x2a
 2703 0ab4 0000 0000 		.long	.LASF69
 2704 0ab8 02        		.byte	0x2
 2705 0ab9 DD01      		.word	0x1dd
 2706 0abb 3000 0000 		.long	0x30
 2707 0abf 01        		.byte	0x1
 2708 0ac0 05        		.byte	0x5
 2709 0ac1 03        		.byte	0x3
 2710 0ac2 0000 0000 		.long	lcdShows
 2711 0ac6 2A        		.uleb128 0x2a
 2712 0ac7 0000 0000 		.long	.LASF70
 2713 0acb 02        		.byte	0x2
 2714 0acc DE01      		.word	0x1de
 2715 0ace 3000 0000 		.long	0x30
 2716 0ad2 01        		.byte	0x1
GAS LISTING /tmp/ccChP33i.s 			page 57


 2717 0ad3 05        		.byte	0x5
 2718 0ad4 03        		.byte	0x3
 2719 0ad5 0000 0000 		.long	lcdBackLight
 2720 0ad9 2A        		.uleb128 0x2a
 2721 0ada 0000 0000 		.long	.LASF71
 2722 0ade 02        		.byte	0x2
 2723 0adf E001      		.word	0x1e0
 2724 0ae1 3000 0000 		.long	0x30
 2725 0ae5 01        		.byte	0x1
 2726 0ae6 05        		.byte	0x5
 2727 0ae7 03        		.byte	0x3
 2728 0ae8 0000 0000 		.long	lcdAddress
 2729 0aec 2A        		.uleb128 0x2a
 2730 0aed 0000 0000 		.long	.LASF72
 2731 0af1 02        		.byte	0x2
 2732 0af2 E101      		.word	0x1e1
 2733 0af4 3000 0000 		.long	0x30
 2734 0af8 01        		.byte	0x1
 2735 0af9 05        		.byte	0x5
 2736 0afa 03        		.byte	0x3
 2737 0afb 0000 0000 		.long	lcdCols
 2738 0aff 2A        		.uleb128 0x2a
 2739 0b00 0000 0000 		.long	.LASF73
 2740 0b04 02        		.byte	0x2
 2741 0b05 E201      		.word	0x1e2
 2742 0b07 3000 0000 		.long	0x30
 2743 0b0b 01        		.byte	0x1
 2744 0b0c 05        		.byte	0x5
 2745 0b0d 03        		.byte	0x3
 2746 0b0e 0000 0000 		.long	lcdRows
 2747 0b12 2B        		.uleb128 0x2b
 2748 0b13 3B00 0000 		.long	0x3b
 2749 0b17 220B 0000 		.long	0xb22
 2750 0b1b 2C        		.uleb128 0x2c
 2751 0b1c 220B 0000 		.long	0xb22
 2752 0b20 05        		.byte	0x5
 2753 0b21 00        		.byte	0
 2754 0b22 02        		.uleb128 0x2
 2755 0b23 02        		.byte	0x2
 2756 0b24 07        		.byte	0x7
 2757 0b25 0000 0000 		.long	.LASF74
 2758 0b29 2A        		.uleb128 0x2a
 2759 0b2a 0000 0000 		.long	.LASF75
 2760 0b2e 02        		.byte	0x2
 2761 0b2f E301      		.word	0x1e3
 2762 0b31 120B 0000 		.long	0xb12
 2763 0b35 01        		.byte	0x1
 2764 0b36 05        		.byte	0x5
 2765 0b37 03        		.byte	0x3
 2766 0b38 0000 0000 		.long	lcdBuffer
 2767 0b3c 2D        		.uleb128 0x2d
 2768 0b3d 01        		.byte	0x1
 2769 0b3e 0000 0000 		.long	.LASF84
 2770 0b42 04        		.byte	0x4
 2771 0b43 E101      		.word	0x1e1
 2772 0b45 01        		.byte	0x1
 2773 0b46 2E        		.uleb128 0x2e
GAS LISTING /tmp/ccChP33i.s 			page 58


 2774 0b47 4900 0000 		.long	0x49
 2775 0b4b 00        		.byte	0
 2776 0b4c 00        		.byte	0
 2777               		.section	.debug_abbrev,"",@progbits
 2778               	.Ldebug_abbrev0:
 2779 0000 01        		.uleb128 0x1
 2780 0001 11        		.uleb128 0x11
 2781 0002 01        		.byte	0x1
 2782 0003 25        		.uleb128 0x25
 2783 0004 0E        		.uleb128 0xe
 2784 0005 13        		.uleb128 0x13
 2785 0006 0B        		.uleb128 0xb
 2786 0007 03        		.uleb128 0x3
 2787 0008 0E        		.uleb128 0xe
 2788 0009 1B        		.uleb128 0x1b
 2789 000a 0E        		.uleb128 0xe
 2790 000b 55        		.uleb128 0x55
 2791 000c 06        		.uleb128 0x6
 2792 000d 11        		.uleb128 0x11
 2793 000e 01        		.uleb128 0x1
 2794 000f 52        		.uleb128 0x52
 2795 0010 01        		.uleb128 0x1
 2796 0011 10        		.uleb128 0x10
 2797 0012 06        		.uleb128 0x6
 2798 0013 00        		.byte	0
 2799 0014 00        		.byte	0
 2800 0015 02        		.uleb128 0x2
 2801 0016 24        		.uleb128 0x24
 2802 0017 00        		.byte	0
 2803 0018 0B        		.uleb128 0xb
 2804 0019 0B        		.uleb128 0xb
 2805 001a 3E        		.uleb128 0x3e
 2806 001b 0B        		.uleb128 0xb
 2807 001c 03        		.uleb128 0x3
 2808 001d 0E        		.uleb128 0xe
 2809 001e 00        		.byte	0
 2810 001f 00        		.byte	0
 2811 0020 03        		.uleb128 0x3
 2812 0021 16        		.uleb128 0x16
 2813 0022 00        		.byte	0
 2814 0023 03        		.uleb128 0x3
 2815 0024 0E        		.uleb128 0xe
 2816 0025 3A        		.uleb128 0x3a
 2817 0026 0B        		.uleb128 0xb
 2818 0027 3B        		.uleb128 0x3b
 2819 0028 0B        		.uleb128 0xb
 2820 0029 49        		.uleb128 0x49
 2821 002a 13        		.uleb128 0x13
 2822 002b 00        		.byte	0
 2823 002c 00        		.byte	0
 2824 002d 04        		.uleb128 0x4
 2825 002e 24        		.uleb128 0x24
 2826 002f 00        		.byte	0
 2827 0030 0B        		.uleb128 0xb
 2828 0031 0B        		.uleb128 0xb
 2829 0032 3E        		.uleb128 0x3e
 2830 0033 0B        		.uleb128 0xb
GAS LISTING /tmp/ccChP33i.s 			page 59


 2831 0034 03        		.uleb128 0x3
 2832 0035 08        		.uleb128 0x8
 2833 0036 00        		.byte	0
 2834 0037 00        		.byte	0
 2835 0038 05        		.uleb128 0x5
 2836 0039 0F        		.uleb128 0xf
 2837 003a 00        		.byte	0
 2838 003b 0B        		.uleb128 0xb
 2839 003c 0B        		.uleb128 0xb
 2840 003d 49        		.uleb128 0x49
 2841 003e 13        		.uleb128 0x13
 2842 003f 00        		.byte	0
 2843 0040 00        		.byte	0
 2844 0041 06        		.uleb128 0x6
 2845 0042 26        		.uleb128 0x26
 2846 0043 00        		.byte	0
 2847 0044 00        		.byte	0
 2848 0045 00        		.byte	0
 2849 0046 07        		.uleb128 0x7
 2850 0047 04        		.uleb128 0x4
 2851 0048 01        		.byte	0x1
 2852 0049 03        		.uleb128 0x3
 2853 004a 0E        		.uleb128 0xe
 2854 004b 0B        		.uleb128 0xb
 2855 004c 0B        		.uleb128 0xb
 2856 004d 3A        		.uleb128 0x3a
 2857 004e 0B        		.uleb128 0xb
 2858 004f 3B        		.uleb128 0x3b
 2859 0050 0B        		.uleb128 0xb
 2860 0051 01        		.uleb128 0x1
 2861 0052 13        		.uleb128 0x13
 2862 0053 00        		.byte	0
 2863 0054 00        		.byte	0
 2864 0055 08        		.uleb128 0x8
 2865 0056 28        		.uleb128 0x28
 2866 0057 00        		.byte	0
 2867 0058 03        		.uleb128 0x3
 2868 0059 0E        		.uleb128 0xe
 2869 005a 1C        		.uleb128 0x1c
 2870 005b 0D        		.uleb128 0xd
 2871 005c 00        		.byte	0
 2872 005d 00        		.byte	0
 2873 005e 09        		.uleb128 0x9
 2874 005f 13        		.uleb128 0x13
 2875 0060 01        		.byte	0x1
 2876 0061 0B        		.uleb128 0xb
 2877 0062 0B        		.uleb128 0xb
 2878 0063 3A        		.uleb128 0x3a
 2879 0064 0B        		.uleb128 0xb
 2880 0065 3B        		.uleb128 0x3b
 2881 0066 0B        		.uleb128 0xb
 2882 0067 8740      		.uleb128 0x2007
 2883 0069 0E        		.uleb128 0xe
 2884 006a 01        		.uleb128 0x1
 2885 006b 13        		.uleb128 0x13
 2886 006c 00        		.byte	0
 2887 006d 00        		.byte	0
GAS LISTING /tmp/ccChP33i.s 			page 60


 2888 006e 0A        		.uleb128 0xa
 2889 006f 0D        		.uleb128 0xd
 2890 0070 00        		.byte	0
 2891 0071 03        		.uleb128 0x3
 2892 0072 0E        		.uleb128 0xe
 2893 0073 3A        		.uleb128 0x3a
 2894 0074 0B        		.uleb128 0xb
 2895 0075 3B        		.uleb128 0x3b
 2896 0076 0B        		.uleb128 0xb
 2897 0077 49        		.uleb128 0x49
 2898 0078 13        		.uleb128 0x13
 2899 0079 38        		.uleb128 0x38
 2900 007a 0A        		.uleb128 0xa
 2901 007b 00        		.byte	0
 2902 007c 00        		.byte	0
 2903 007d 0B        		.uleb128 0xb
 2904 007e 0D        		.uleb128 0xd
 2905 007f 00        		.byte	0
 2906 0080 03        		.uleb128 0x3
 2907 0081 08        		.uleb128 0x8
 2908 0082 3A        		.uleb128 0x3a
 2909 0083 0B        		.uleb128 0xb
 2910 0084 3B        		.uleb128 0x3b
 2911 0085 0B        		.uleb128 0xb
 2912 0086 49        		.uleb128 0x49
 2913 0087 13        		.uleb128 0x13
 2914 0088 38        		.uleb128 0x38
 2915 0089 0A        		.uleb128 0xa
 2916 008a 00        		.byte	0
 2917 008b 00        		.byte	0
 2918 008c 0C        		.uleb128 0xc
 2919 008d 2E        		.uleb128 0x2e
 2920 008e 01        		.byte	0x1
 2921 008f 3F        		.uleb128 0x3f
 2922 0090 0C        		.uleb128 0xc
 2923 0091 03        		.uleb128 0x3
 2924 0092 0E        		.uleb128 0xe
 2925 0093 3A        		.uleb128 0x3a
 2926 0094 0B        		.uleb128 0xb
 2927 0095 3B        		.uleb128 0x3b
 2928 0096 0B        		.uleb128 0xb
 2929 0097 20        		.uleb128 0x20
 2930 0098 0B        		.uleb128 0xb
 2931 0099 01        		.uleb128 0x1
 2932 009a 13        		.uleb128 0x13
 2933 009b 00        		.byte	0
 2934 009c 00        		.byte	0
 2935 009d 0D        		.uleb128 0xd
 2936 009e 05        		.uleb128 0x5
 2937 009f 00        		.byte	0
 2938 00a0 03        		.uleb128 0x3
 2939 00a1 08        		.uleb128 0x8
 2940 00a2 3A        		.uleb128 0x3a
 2941 00a3 0B        		.uleb128 0xb
 2942 00a4 3B        		.uleb128 0x3b
 2943 00a5 0B        		.uleb128 0xb
 2944 00a6 49        		.uleb128 0x49
GAS LISTING /tmp/ccChP33i.s 			page 61


 2945 00a7 13        		.uleb128 0x13
 2946 00a8 00        		.byte	0
 2947 00a9 00        		.byte	0
 2948 00aa 0E        		.uleb128 0xe
 2949 00ab 2E        		.uleb128 0x2e
 2950 00ac 01        		.byte	0x1
 2951 00ad 3F        		.uleb128 0x3f
 2952 00ae 0C        		.uleb128 0xc
 2953 00af 03        		.uleb128 0x3
 2954 00b0 0E        		.uleb128 0xe
 2955 00b1 3A        		.uleb128 0x3a
 2956 00b2 0B        		.uleb128 0xb
 2957 00b3 3B        		.uleb128 0x3b
 2958 00b4 0B        		.uleb128 0xb
 2959 00b5 11        		.uleb128 0x11
 2960 00b6 01        		.uleb128 0x1
 2961 00b7 12        		.uleb128 0x12
 2962 00b8 01        		.uleb128 0x1
 2963 00b9 40        		.uleb128 0x40
 2964 00ba 0A        		.uleb128 0xa
 2965 00bb 9742      		.uleb128 0x2117
 2966 00bd 0C        		.uleb128 0xc
 2967 00be 01        		.uleb128 0x1
 2968 00bf 13        		.uleb128 0x13
 2969 00c0 00        		.byte	0
 2970 00c1 00        		.byte	0
 2971 00c2 0F        		.uleb128 0xf
 2972 00c3 05        		.uleb128 0x5
 2973 00c4 00        		.byte	0
 2974 00c5 03        		.uleb128 0x3
 2975 00c6 0E        		.uleb128 0xe
 2976 00c7 3A        		.uleb128 0x3a
 2977 00c8 0B        		.uleb128 0xb
 2978 00c9 3B        		.uleb128 0x3b
 2979 00ca 0B        		.uleb128 0xb
 2980 00cb 49        		.uleb128 0x49
 2981 00cc 13        		.uleb128 0x13
 2982 00cd 02        		.uleb128 0x2
 2983 00ce 06        		.uleb128 0x6
 2984 00cf 00        		.byte	0
 2985 00d0 00        		.byte	0
 2986 00d1 10        		.uleb128 0x10
 2987 00d2 0B        		.uleb128 0xb
 2988 00d3 01        		.byte	0x1
 2989 00d4 11        		.uleb128 0x11
 2990 00d5 01        		.uleb128 0x1
 2991 00d6 12        		.uleb128 0x12
 2992 00d7 01        		.uleb128 0x1
 2993 00d8 00        		.byte	0
 2994 00d9 00        		.byte	0
 2995 00da 11        		.uleb128 0x11
 2996 00db 34        		.uleb128 0x34
 2997 00dc 00        		.byte	0
 2998 00dd 03        		.uleb128 0x3
 2999 00de 0E        		.uleb128 0xe
 3000 00df 3A        		.uleb128 0x3a
 3001 00e0 0B        		.uleb128 0xb
GAS LISTING /tmp/ccChP33i.s 			page 62


 3002 00e1 3B        		.uleb128 0x3b
 3003 00e2 0B        		.uleb128 0xb
 3004 00e3 49        		.uleb128 0x49
 3005 00e4 13        		.uleb128 0x13
 3006 00e5 02        		.uleb128 0x2
 3007 00e6 0A        		.uleb128 0xa
 3008 00e7 00        		.byte	0
 3009 00e8 00        		.byte	0
 3010 00e9 12        		.uleb128 0x12
 3011 00ea 34        		.uleb128 0x34
 3012 00eb 00        		.byte	0
 3013 00ec 03        		.uleb128 0x3
 3014 00ed 0E        		.uleb128 0xe
 3015 00ee 3A        		.uleb128 0x3a
 3016 00ef 0B        		.uleb128 0xb
 3017 00f0 3B        		.uleb128 0x3b
 3018 00f1 0B        		.uleb128 0xb
 3019 00f2 49        		.uleb128 0x49
 3020 00f3 13        		.uleb128 0x13
 3021 00f4 02        		.uleb128 0x2
 3022 00f5 06        		.uleb128 0x6
 3023 00f6 00        		.byte	0
 3024 00f7 00        		.byte	0
 3025 00f8 13        		.uleb128 0x13
 3026 00f9 2E        		.uleb128 0x2e
 3027 00fa 01        		.byte	0x1
 3028 00fb 3F        		.uleb128 0x3f
 3029 00fc 0C        		.uleb128 0xc
 3030 00fd 03        		.uleb128 0x3
 3031 00fe 0E        		.uleb128 0xe
 3032 00ff 3A        		.uleb128 0x3a
 3033 0100 0B        		.uleb128 0xb
 3034 0101 3B        		.uleb128 0x3b
 3035 0102 0B        		.uleb128 0xb
 3036 0103 11        		.uleb128 0x11
 3037 0104 01        		.uleb128 0x1
 3038 0105 12        		.uleb128 0x12
 3039 0106 01        		.uleb128 0x1
 3040 0107 40        		.uleb128 0x40
 3041 0108 06        		.uleb128 0x6
 3042 0109 9742      		.uleb128 0x2117
 3043 010b 0C        		.uleb128 0xc
 3044 010c 01        		.uleb128 0x1
 3045 010d 13        		.uleb128 0x13
 3046 010e 00        		.byte	0
 3047 010f 00        		.byte	0
 3048 0110 14        		.uleb128 0x14
 3049 0111 8982 01   		.uleb128 0x4109
 3050 0114 01        		.byte	0x1
 3051 0115 11        		.uleb128 0x11
 3052 0116 01        		.uleb128 0x1
 3053 0117 31        		.uleb128 0x31
 3054 0118 13        		.uleb128 0x13
 3055 0119 00        		.byte	0
 3056 011a 00        		.byte	0
 3057 011b 15        		.uleb128 0x15
 3058 011c 8A82 01   		.uleb128 0x410a
GAS LISTING /tmp/ccChP33i.s 			page 63


 3059 011f 00        		.byte	0
 3060 0120 02        		.uleb128 0x2
 3061 0121 0A        		.uleb128 0xa
 3062 0122 9142      		.uleb128 0x2111
 3063 0124 0A        		.uleb128 0xa
 3064 0125 00        		.byte	0
 3065 0126 00        		.byte	0
 3066 0127 16        		.uleb128 0x16
 3067 0128 2E        		.uleb128 0x2e
 3068 0129 01        		.byte	0x1
 3069 012a 31        		.uleb128 0x31
 3070 012b 13        		.uleb128 0x13
 3071 012c 11        		.uleb128 0x11
 3072 012d 01        		.uleb128 0x1
 3073 012e 12        		.uleb128 0x12
 3074 012f 01        		.uleb128 0x1
 3075 0130 40        		.uleb128 0x40
 3076 0131 06        		.uleb128 0x6
 3077 0132 9642      		.uleb128 0x2116
 3078 0134 0C        		.uleb128 0xc
 3079 0135 01        		.uleb128 0x1
 3080 0136 13        		.uleb128 0x13
 3081 0137 00        		.byte	0
 3082 0138 00        		.byte	0
 3083 0139 17        		.uleb128 0x17
 3084 013a 05        		.uleb128 0x5
 3085 013b 00        		.byte	0
 3086 013c 31        		.uleb128 0x31
 3087 013d 13        		.uleb128 0x13
 3088 013e 02        		.uleb128 0x2
 3089 013f 06        		.uleb128 0x6
 3090 0140 00        		.byte	0
 3091 0141 00        		.byte	0
 3092 0142 18        		.uleb128 0x18
 3093 0143 2E        		.uleb128 0x2e
 3094 0144 01        		.byte	0x1
 3095 0145 3F        		.uleb128 0x3f
 3096 0146 0C        		.uleb128 0xc
 3097 0147 03        		.uleb128 0x3
 3098 0148 0E        		.uleb128 0xe
 3099 0149 3A        		.uleb128 0x3a
 3100 014a 0B        		.uleb128 0xb
 3101 014b 3B        		.uleb128 0x3b
 3102 014c 05        		.uleb128 0x5
 3103 014d 11        		.uleb128 0x11
 3104 014e 01        		.uleb128 0x1
 3105 014f 12        		.uleb128 0x12
 3106 0150 01        		.uleb128 0x1
 3107 0151 40        		.uleb128 0x40
 3108 0152 06        		.uleb128 0x6
 3109 0153 9642      		.uleb128 0x2116
 3110 0155 0C        		.uleb128 0xc
 3111 0156 01        		.uleb128 0x1
 3112 0157 13        		.uleb128 0x13
 3113 0158 00        		.byte	0
 3114 0159 00        		.byte	0
 3115 015a 19        		.uleb128 0x19
GAS LISTING /tmp/ccChP33i.s 			page 64


 3116 015b 34        		.uleb128 0x34
 3117 015c 00        		.byte	0
 3118 015d 03        		.uleb128 0x3
 3119 015e 08        		.uleb128 0x8
 3120 015f 3A        		.uleb128 0x3a
 3121 0160 0B        		.uleb128 0xb
 3122 0161 3B        		.uleb128 0x3b
 3123 0162 05        		.uleb128 0x5
 3124 0163 49        		.uleb128 0x49
 3125 0164 13        		.uleb128 0x13
 3126 0165 02        		.uleb128 0x2
 3127 0166 06        		.uleb128 0x6
 3128 0167 00        		.byte	0
 3129 0168 00        		.byte	0
 3130 0169 1A        		.uleb128 0x1a
 3131 016a 8982 01   		.uleb128 0x4109
 3132 016d 00        		.byte	0
 3133 016e 11        		.uleb128 0x11
 3134 016f 01        		.uleb128 0x1
 3135 0170 31        		.uleb128 0x31
 3136 0171 13        		.uleb128 0x13
 3137 0172 00        		.byte	0
 3138 0173 00        		.byte	0
 3139 0174 1B        		.uleb128 0x1b
 3140 0175 2E        		.uleb128 0x2e
 3141 0176 01        		.byte	0x1
 3142 0177 3F        		.uleb128 0x3f
 3143 0178 0C        		.uleb128 0xc
 3144 0179 03        		.uleb128 0x3
 3145 017a 0E        		.uleb128 0xe
 3146 017b 3A        		.uleb128 0x3a
 3147 017c 0B        		.uleb128 0xb
 3148 017d 3B        		.uleb128 0x3b
 3149 017e 05        		.uleb128 0x5
 3150 017f 11        		.uleb128 0x11
 3151 0180 01        		.uleb128 0x1
 3152 0181 12        		.uleb128 0x12
 3153 0182 01        		.uleb128 0x1
 3154 0183 40        		.uleb128 0x40
 3155 0184 0A        		.uleb128 0xa
 3156 0185 9742      		.uleb128 0x2117
 3157 0187 0C        		.uleb128 0xc
 3158 0188 01        		.uleb128 0x1
 3159 0189 13        		.uleb128 0x13
 3160 018a 00        		.byte	0
 3161 018b 00        		.byte	0
 3162 018c 1C        		.uleb128 0x1c
 3163 018d 05        		.uleb128 0x5
 3164 018e 00        		.byte	0
 3165 018f 03        		.uleb128 0x3
 3166 0190 0E        		.uleb128 0xe
 3167 0191 3A        		.uleb128 0x3a
 3168 0192 0B        		.uleb128 0xb
 3169 0193 3B        		.uleb128 0x3b
 3170 0194 05        		.uleb128 0x5
 3171 0195 49        		.uleb128 0x49
 3172 0196 13        		.uleb128 0x13
GAS LISTING /tmp/ccChP33i.s 			page 65


 3173 0197 02        		.uleb128 0x2
 3174 0198 06        		.uleb128 0x6
 3175 0199 00        		.byte	0
 3176 019a 00        		.byte	0
 3177 019b 1D        		.uleb128 0x1d
 3178 019c 8982 01   		.uleb128 0x4109
 3179 019f 01        		.byte	0x1
 3180 01a0 11        		.uleb128 0x11
 3181 01a1 01        		.uleb128 0x1
 3182 01a2 9542      		.uleb128 0x2115
 3183 01a4 0C        		.uleb128 0xc
 3184 01a5 31        		.uleb128 0x31
 3185 01a6 13        		.uleb128 0x13
 3186 01a7 00        		.byte	0
 3187 01a8 00        		.byte	0
 3188 01a9 1E        		.uleb128 0x1e
 3189 01aa 26        		.uleb128 0x26
 3190 01ab 00        		.byte	0
 3191 01ac 49        		.uleb128 0x49
 3192 01ad 13        		.uleb128 0x13
 3193 01ae 00        		.byte	0
 3194 01af 00        		.byte	0
 3195 01b0 1F        		.uleb128 0x1f
 3196 01b1 2E        		.uleb128 0x2e
 3197 01b2 01        		.byte	0x1
 3198 01b3 3F        		.uleb128 0x3f
 3199 01b4 0C        		.uleb128 0xc
 3200 01b5 03        		.uleb128 0x3
 3201 01b6 0E        		.uleb128 0xe
 3202 01b7 3A        		.uleb128 0x3a
 3203 01b8 0B        		.uleb128 0xb
 3204 01b9 3B        		.uleb128 0x3b
 3205 01ba 05        		.uleb128 0x5
 3206 01bb 11        		.uleb128 0x11
 3207 01bc 01        		.uleb128 0x1
 3208 01bd 12        		.uleb128 0x12
 3209 01be 01        		.uleb128 0x1
 3210 01bf 40        		.uleb128 0x40
 3211 01c0 06        		.uleb128 0x6
 3212 01c1 9742      		.uleb128 0x2117
 3213 01c3 0C        		.uleb128 0xc
 3214 01c4 01        		.uleb128 0x1
 3215 01c5 13        		.uleb128 0x13
 3216 01c6 00        		.byte	0
 3217 01c7 00        		.byte	0
 3218 01c8 20        		.uleb128 0x20
 3219 01c9 05        		.uleb128 0x5
 3220 01ca 00        		.byte	0
 3221 01cb 03        		.uleb128 0x3
 3222 01cc 0E        		.uleb128 0xe
 3223 01cd 3A        		.uleb128 0x3a
 3224 01ce 0B        		.uleb128 0xb
 3225 01cf 3B        		.uleb128 0x3b
 3226 01d0 05        		.uleb128 0x5
 3227 01d1 49        		.uleb128 0x49
 3228 01d2 13        		.uleb128 0x13
 3229 01d3 02        		.uleb128 0x2
GAS LISTING /tmp/ccChP33i.s 			page 66


 3230 01d4 0A        		.uleb128 0xa
 3231 01d5 00        		.byte	0
 3232 01d6 00        		.byte	0
 3233 01d7 21        		.uleb128 0x21
 3234 01d8 05        		.uleb128 0x5
 3235 01d9 00        		.byte	0
 3236 01da 03        		.uleb128 0x3
 3237 01db 08        		.uleb128 0x8
 3238 01dc 3A        		.uleb128 0x3a
 3239 01dd 0B        		.uleb128 0xb
 3240 01de 3B        		.uleb128 0x3b
 3241 01df 05        		.uleb128 0x5
 3242 01e0 49        		.uleb128 0x49
 3243 01e1 13        		.uleb128 0x13
 3244 01e2 02        		.uleb128 0x2
 3245 01e3 0A        		.uleb128 0xa
 3246 01e4 00        		.byte	0
 3247 01e5 00        		.byte	0
 3248 01e6 22        		.uleb128 0x22
 3249 01e7 34        		.uleb128 0x34
 3250 01e8 00        		.byte	0
 3251 01e9 03        		.uleb128 0x3
 3252 01ea 0E        		.uleb128 0xe
 3253 01eb 3A        		.uleb128 0x3a
 3254 01ec 0B        		.uleb128 0xb
 3255 01ed 3B        		.uleb128 0x3b
 3256 01ee 05        		.uleb128 0x5
 3257 01ef 49        		.uleb128 0x49
 3258 01f0 13        		.uleb128 0x13
 3259 01f1 02        		.uleb128 0x2
 3260 01f2 06        		.uleb128 0x6
 3261 01f3 00        		.byte	0
 3262 01f4 00        		.byte	0
 3263 01f5 23        		.uleb128 0x23
 3264 01f6 05        		.uleb128 0x5
 3265 01f7 00        		.byte	0
 3266 01f8 03        		.uleb128 0x3
 3267 01f9 08        		.uleb128 0x8
 3268 01fa 3A        		.uleb128 0x3a
 3269 01fb 0B        		.uleb128 0xb
 3270 01fc 3B        		.uleb128 0x3b
 3271 01fd 05        		.uleb128 0x5
 3272 01fe 49        		.uleb128 0x49
 3273 01ff 13        		.uleb128 0x13
 3274 0200 02        		.uleb128 0x2
 3275 0201 06        		.uleb128 0x6
 3276 0202 00        		.byte	0
 3277 0203 00        		.byte	0
 3278 0204 24        		.uleb128 0x24
 3279 0205 8982 01   		.uleb128 0x4109
 3280 0208 01        		.byte	0x1
 3281 0209 11        		.uleb128 0x11
 3282 020a 01        		.uleb128 0x1
 3283 020b 31        		.uleb128 0x31
 3284 020c 13        		.uleb128 0x13
 3285 020d 01        		.uleb128 0x1
 3286 020e 13        		.uleb128 0x13
GAS LISTING /tmp/ccChP33i.s 			page 67


 3287 020f 00        		.byte	0
 3288 0210 00        		.byte	0
 3289 0211 25        		.uleb128 0x25
 3290 0212 34        		.uleb128 0x34
 3291 0213 00        		.byte	0
 3292 0214 03        		.uleb128 0x3
 3293 0215 0E        		.uleb128 0xe
 3294 0216 3A        		.uleb128 0x3a
 3295 0217 0B        		.uleb128 0xb
 3296 0218 3B        		.uleb128 0x3b
 3297 0219 05        		.uleb128 0x5
 3298 021a 49        		.uleb128 0x49
 3299 021b 13        		.uleb128 0x13
 3300 021c 00        		.byte	0
 3301 021d 00        		.byte	0
 3302 021e 26        		.uleb128 0x26
 3303 021f 2E        		.uleb128 0x2e
 3304 0220 00        		.byte	0
 3305 0221 3F        		.uleb128 0x3f
 3306 0222 0C        		.uleb128 0xc
 3307 0223 03        		.uleb128 0x3
 3308 0224 0E        		.uleb128 0xe
 3309 0225 3A        		.uleb128 0x3a
 3310 0226 0B        		.uleb128 0xb
 3311 0227 3B        		.uleb128 0x3b
 3312 0228 05        		.uleb128 0x5
 3313 0229 11        		.uleb128 0x11
 3314 022a 01        		.uleb128 0x1
 3315 022b 12        		.uleb128 0x12
 3316 022c 01        		.uleb128 0x1
 3317 022d 40        		.uleb128 0x40
 3318 022e 0A        		.uleb128 0xa
 3319 022f 9742      		.uleb128 0x2117
 3320 0231 0C        		.uleb128 0xc
 3321 0232 00        		.byte	0
 3322 0233 00        		.byte	0
 3323 0234 27        		.uleb128 0x27
 3324 0235 34        		.uleb128 0x34
 3325 0236 00        		.byte	0
 3326 0237 03        		.uleb128 0x3
 3327 0238 0E        		.uleb128 0xe
 3328 0239 3A        		.uleb128 0x3a
 3329 023a 0B        		.uleb128 0xb
 3330 023b 3B        		.uleb128 0x3b
 3331 023c 0B        		.uleb128 0xb
 3332 023d 49        		.uleb128 0x49
 3333 023e 13        		.uleb128 0x13
 3334 023f 3F        		.uleb128 0x3f
 3335 0240 0C        		.uleb128 0xc
 3336 0241 02        		.uleb128 0x2
 3337 0242 0A        		.uleb128 0xa
 3338 0243 00        		.byte	0
 3339 0244 00        		.byte	0
 3340 0245 28        		.uleb128 0x28
 3341 0246 35        		.uleb128 0x35
 3342 0247 00        		.byte	0
 3343 0248 49        		.uleb128 0x49
GAS LISTING /tmp/ccChP33i.s 			page 68


 3344 0249 13        		.uleb128 0x13
 3345 024a 00        		.byte	0
 3346 024b 00        		.byte	0
 3347 024c 29        		.uleb128 0x29
 3348 024d 15        		.uleb128 0x15
 3349 024e 00        		.byte	0
 3350 024f 00        		.byte	0
 3351 0250 00        		.byte	0
 3352 0251 2A        		.uleb128 0x2a
 3353 0252 34        		.uleb128 0x34
 3354 0253 00        		.byte	0
 3355 0254 03        		.uleb128 0x3
 3356 0255 0E        		.uleb128 0xe
 3357 0256 3A        		.uleb128 0x3a
 3358 0257 0B        		.uleb128 0xb
 3359 0258 3B        		.uleb128 0x3b
 3360 0259 05        		.uleb128 0x5
 3361 025a 49        		.uleb128 0x49
 3362 025b 13        		.uleb128 0x13
 3363 025c 3F        		.uleb128 0x3f
 3364 025d 0C        		.uleb128 0xc
 3365 025e 02        		.uleb128 0x2
 3366 025f 0A        		.uleb128 0xa
 3367 0260 00        		.byte	0
 3368 0261 00        		.byte	0
 3369 0262 2B        		.uleb128 0x2b
 3370 0263 01        		.uleb128 0x1
 3371 0264 01        		.byte	0x1
 3372 0265 49        		.uleb128 0x49
 3373 0266 13        		.uleb128 0x13
 3374 0267 01        		.uleb128 0x1
 3375 0268 13        		.uleb128 0x13
 3376 0269 00        		.byte	0
 3377 026a 00        		.byte	0
 3378 026b 2C        		.uleb128 0x2c
 3379 026c 21        		.uleb128 0x21
 3380 026d 00        		.byte	0
 3381 026e 49        		.uleb128 0x49
 3382 026f 13        		.uleb128 0x13
 3383 0270 2F        		.uleb128 0x2f
 3384 0271 0B        		.uleb128 0xb
 3385 0272 00        		.byte	0
 3386 0273 00        		.byte	0
 3387 0274 2D        		.uleb128 0x2d
 3388 0275 2E        		.uleb128 0x2e
 3389 0276 01        		.byte	0x1
 3390 0277 3F        		.uleb128 0x3f
 3391 0278 0C        		.uleb128 0xc
 3392 0279 03        		.uleb128 0x3
 3393 027a 0E        		.uleb128 0xe
 3394 027b 3A        		.uleb128 0x3a
 3395 027c 0B        		.uleb128 0xb
 3396 027d 3B        		.uleb128 0x3b
 3397 027e 05        		.uleb128 0x5
 3398 027f 3C        		.uleb128 0x3c
 3399 0280 0C        		.uleb128 0xc
 3400 0281 00        		.byte	0
GAS LISTING /tmp/ccChP33i.s 			page 69


 3401 0282 00        		.byte	0
 3402 0283 2E        		.uleb128 0x2e
 3403 0284 05        		.uleb128 0x5
 3404 0285 00        		.byte	0
 3405 0286 49        		.uleb128 0x49
 3406 0287 13        		.uleb128 0x13
 3407 0288 00        		.byte	0
 3408 0289 00        		.byte	0
 3409 028a 00        		.byte	0
 3410               		.section	.debug_loc,"",@progbits
 3411               	.Ldebug_loc0:
 3412               	.LLST0:
 3413 0000 0000 0000 		.long	.LVL0
 3414 0004 0000 0000 		.long	.LVL1
 3415 0008 0C00      		.word	0xc
 3416 000a 66        		.byte	0x66
 3417 000b 93        		.byte	0x93
 3418 000c 01        		.uleb128 0x1
 3419 000d 67        		.byte	0x67
 3420 000e 93        		.byte	0x93
 3421 000f 01        		.uleb128 0x1
 3422 0010 68        		.byte	0x68
 3423 0011 93        		.byte	0x93
 3424 0012 01        		.uleb128 0x1
 3425 0013 69        		.byte	0x69
 3426 0014 93        		.byte	0x93
 3427 0015 01        		.uleb128 0x1
 3428 0016 0000 0000 		.long	.LVL1
 3429 001a 0000 0000 		.long	.LVL2
 3430 001e 0C00      		.word	0xc
 3431 0020 62        		.byte	0x62
 3432 0021 93        		.byte	0x93
 3433 0022 01        		.uleb128 0x1
 3434 0023 63        		.byte	0x63
 3435 0024 93        		.byte	0x93
 3436 0025 01        		.uleb128 0x1
 3437 0026 64        		.byte	0x64
 3438 0027 93        		.byte	0x93
 3439 0028 01        		.uleb128 0x1
 3440 0029 65        		.byte	0x65
 3441 002a 93        		.byte	0x93
 3442 002b 01        		.uleb128 0x1
 3443 002c 0000 0000 		.long	.LVL2
 3444 0030 0000 0000 		.long	.LFE102
 3445 0034 0400      		.word	0x4
 3446 0036 F3        		.byte	0xf3
 3447 0037 01        		.uleb128 0x1
 3448 0038 66        		.byte	0x66
 3449 0039 9F        		.byte	0x9f
 3450 003a 0000 0000 		.long	0
 3451 003e 0000 0000 		.long	0
 3452               	.LLST1:
 3453 0042 0000 0000 		.long	.LVL3
 3454 0046 0000 0000 		.long	.LVL4
 3455 004a 0200      		.word	0x2
 3456 004c 30        		.byte	0x30
 3457 004d 9F        		.byte	0x9f
GAS LISTING /tmp/ccChP33i.s 			page 70


 3458 004e 0000 0000 		.long	.LVL4
 3459 0052 0000 0000 		.long	.LFE102
 3460 0056 0100      		.word	0x1
 3461 0058 68        		.byte	0x68
 3462 0059 0000 0000 		.long	0
 3463 005d 0000 0000 		.long	0
 3464               	.LLST2:
 3465 0061 0000 0000 		.long	.LFB103
 3466 0065 0000 0000 		.long	.LCFI0
 3467 0069 0300      		.word	0x3
 3468 006b 92        		.byte	0x92
 3469 006c 20        		.uleb128 0x20
 3470 006d 03        		.sleb128 3
 3471 006e 0000 0000 		.long	.LCFI0
 3472 0072 0000 0000 		.long	.LCFI1
 3473 0076 0300      		.word	0x3
 3474 0078 92        		.byte	0x92
 3475 0079 20        		.uleb128 0x20
 3476 007a 04        		.sleb128 4
 3477 007b 0000 0000 		.long	.LCFI1
 3478 007f 0000 0000 		.long	.LCFI2
 3479 0083 0300      		.word	0x3
 3480 0085 92        		.byte	0x92
 3481 0086 20        		.uleb128 0x20
 3482 0087 05        		.sleb128 5
 3483 0088 0000 0000 		.long	.LCFI2
 3484 008c 0000 0000 		.long	.LCFI3
 3485 0090 0300      		.word	0x3
 3486 0092 92        		.byte	0x92
 3487 0093 20        		.uleb128 0x20
 3488 0094 06        		.sleb128 6
 3489 0095 0000 0000 		.long	.LCFI3
 3490 0099 0000 0000 		.long	.LFE103
 3491 009d 0200      		.word	0x2
 3492 009f 8C        		.byte	0x8c
 3493 00a0 06        		.sleb128 6
 3494 00a1 0000 0000 		.long	0
 3495 00a5 0000 0000 		.long	0
 3496               	.LLST3:
 3497 00a9 0000 0000 		.long	.LVL9
 3498 00ad 0000 0000 		.long	.LVL10-1
 3499 00b1 0C00      		.word	0xc
 3500 00b3 66        		.byte	0x66
 3501 00b4 93        		.byte	0x93
 3502 00b5 01        		.uleb128 0x1
 3503 00b6 67        		.byte	0x67
 3504 00b7 93        		.byte	0x93
 3505 00b8 01        		.uleb128 0x1
 3506 00b9 68        		.byte	0x68
 3507 00ba 93        		.byte	0x93
 3508 00bb 01        		.uleb128 0x1
 3509 00bc 69        		.byte	0x69
 3510 00bd 93        		.byte	0x93
 3511 00be 01        		.uleb128 0x1
 3512 00bf 0000 0000 		.long	.LVL10-1
 3513 00c3 0000 0000 		.long	.LFE103
 3514 00c7 0400      		.word	0x4
GAS LISTING /tmp/ccChP33i.s 			page 71


 3515 00c9 F3        		.byte	0xf3
 3516 00ca 01        		.uleb128 0x1
 3517 00cb 66        		.byte	0x66
 3518 00cc 9F        		.byte	0x9f
 3519 00cd 0000 0000 		.long	0
 3520 00d1 0000 0000 		.long	0
 3521               	.LLST4:
 3522 00d5 0000 0000 		.long	.LVL9
 3523 00d9 0000 0000 		.long	.LVL10-1
 3524 00dd 0100      		.word	0x1
 3525 00df 64        		.byte	0x64
 3526 00e0 0000 0000 		.long	.LVL10-1
 3527 00e4 0000 0000 		.long	.LFE103
 3528 00e8 0400      		.word	0x4
 3529 00ea F3        		.byte	0xf3
 3530 00eb 01        		.uleb128 0x1
 3531 00ec 64        		.byte	0x64
 3532 00ed 9F        		.byte	0x9f
 3533 00ee 0000 0000 		.long	0
 3534 00f2 0000 0000 		.long	0
 3535               	.LLST5:
 3536 00f6 0000 0000 		.long	.LFB104
 3537 00fa 0000 0000 		.long	.LCFI4
 3538 00fe 0300      		.word	0x3
 3539 0100 92        		.byte	0x92
 3540 0101 20        		.uleb128 0x20
 3541 0102 03        		.sleb128 3
 3542 0103 0000 0000 		.long	.LCFI4
 3543 0107 0000 0000 		.long	.LFE104
 3544 010b 0300      		.word	0x3
 3545 010d 92        		.byte	0x92
 3546 010e 20        		.uleb128 0x20
 3547 010f 04        		.sleb128 4
 3548 0110 0000 0000 		.long	0
 3549 0114 0000 0000 		.long	0
 3550               	.LLST6:
 3551 0118 0000 0000 		.long	.LVL11
 3552 011c 0000 0000 		.long	.LVL12
 3553 0120 0100      		.word	0x1
 3554 0122 68        		.byte	0x68
 3555 0123 0000 0000 		.long	.LVL12
 3556 0127 0000 0000 		.long	.LVL13
 3557 012b 0400      		.word	0x4
 3558 012d F3        		.byte	0xf3
 3559 012e 01        		.uleb128 0x1
 3560 012f 68        		.byte	0x68
 3561 0130 9F        		.byte	0x9f
 3562 0131 0000 0000 		.long	.LVL13
 3563 0135 0000 0000 		.long	.LVL14
 3564 0139 0100      		.word	0x1
 3565 013b 68        		.byte	0x68
 3566 013c 0000 0000 		.long	.LVL14
 3567 0140 0000 0000 		.long	.LVL15
 3568 0144 0400      		.word	0x4
 3569 0146 F3        		.byte	0xf3
 3570 0147 01        		.uleb128 0x1
 3571 0148 68        		.byte	0x68
GAS LISTING /tmp/ccChP33i.s 			page 72


 3572 0149 9F        		.byte	0x9f
 3573 014a 0000 0000 		.long	.LVL15
 3574 014e 0000 0000 		.long	.LVL16-1
 3575 0152 0100      		.word	0x1
 3576 0154 68        		.byte	0x68
 3577 0155 0000 0000 		.long	.LVL16-1
 3578 0159 0000 0000 		.long	.LVL17
 3579 015d 0400      		.word	0x4
 3580 015f F3        		.byte	0xf3
 3581 0160 01        		.uleb128 0x1
 3582 0161 68        		.byte	0x68
 3583 0162 9F        		.byte	0x9f
 3584 0163 0000 0000 		.long	.LVL17
 3585 0167 0000 0000 		.long	.LVL18
 3586 016b 0100      		.word	0x1
 3587 016d 68        		.byte	0x68
 3588 016e 0000 0000 		.long	.LVL18
 3589 0172 0000 0000 		.long	.LFE104
 3590 0176 0400      		.word	0x4
 3591 0178 F3        		.byte	0xf3
 3592 0179 01        		.uleb128 0x1
 3593 017a 68        		.byte	0x68
 3594 017b 9F        		.byte	0x9f
 3595 017c 0000 0000 		.long	0
 3596 0180 0000 0000 		.long	0
 3597               	.LLST7:
 3598 0184 0000 0000 		.long	.LVL15
 3599 0188 0000 0000 		.long	.LVL16-1
 3600 018c 0100      		.word	0x1
 3601 018e 68        		.byte	0x68
 3602 018f 0000 0000 		.long	.LVL16-1
 3603 0193 0000 0000 		.long	.LVL17
 3604 0197 0400      		.word	0x4
 3605 0199 F3        		.byte	0xf3
 3606 019a 01        		.uleb128 0x1
 3607 019b 68        		.byte	0x68
 3608 019c 9F        		.byte	0x9f
 3609 019d 0000 0000 		.long	.LVL17
 3610 01a1 0000 0000 		.long	.LVL18
 3611 01a5 0100      		.word	0x1
 3612 01a7 68        		.byte	0x68
 3613 01a8 0000 0000 		.long	.LVL18
 3614 01ac 0000 0000 		.long	.LVL19
 3615 01b0 0400      		.word	0x4
 3616 01b2 F3        		.byte	0xf3
 3617 01b3 01        		.uleb128 0x1
 3618 01b4 68        		.byte	0x68
 3619 01b5 9F        		.byte	0x9f
 3620 01b6 0000 0000 		.long	0
 3621 01ba 0000 0000 		.long	0
 3622               	.LLST8:
 3623 01be 0000 0000 		.long	.LFB105
 3624 01c2 0000 0000 		.long	.LCFI5
 3625 01c6 0300      		.word	0x3
 3626 01c8 92        		.byte	0x92
 3627 01c9 20        		.uleb128 0x20
 3628 01ca 03        		.sleb128 3
GAS LISTING /tmp/ccChP33i.s 			page 73


 3629 01cb 0000 0000 		.long	.LCFI5
 3630 01cf 0000 0000 		.long	.LCFI6
 3631 01d3 0300      		.word	0x3
 3632 01d5 92        		.byte	0x92
 3633 01d6 20        		.uleb128 0x20
 3634 01d7 04        		.sleb128 4
 3635 01d8 0000 0000 		.long	.LCFI6
 3636 01dc 0000 0000 		.long	.LCFI7
 3637 01e0 0300      		.word	0x3
 3638 01e2 92        		.byte	0x92
 3639 01e3 20        		.uleb128 0x20
 3640 01e4 05        		.sleb128 5
 3641 01e5 0000 0000 		.long	.LCFI7
 3642 01e9 0000 0000 		.long	.LCFI8
 3643 01ed 0300      		.word	0x3
 3644 01ef 92        		.byte	0x92
 3645 01f0 20        		.uleb128 0x20
 3646 01f1 06        		.sleb128 6
 3647 01f2 0000 0000 		.long	.LCFI8
 3648 01f6 0000 0000 		.long	.LCFI9
 3649 01fa 0300      		.word	0x3
 3650 01fc 92        		.byte	0x92
 3651 01fd 20        		.uleb128 0x20
 3652 01fe 07        		.sleb128 7
 3653 01ff 0000 0000 		.long	.LCFI9
 3654 0203 0000 0000 		.long	.LCFI10
 3655 0207 0300      		.word	0x3
 3656 0209 92        		.byte	0x92
 3657 020a 20        		.uleb128 0x20
 3658 020b 08        		.sleb128 8
 3659 020c 0000 0000 		.long	.LCFI10
 3660 0210 0000 0000 		.long	.LCFI11
 3661 0214 0300      		.word	0x3
 3662 0216 92        		.byte	0x92
 3663 0217 20        		.uleb128 0x20
 3664 0218 09        		.sleb128 9
 3665 0219 0000 0000 		.long	.LCFI11
 3666 021d 0000 0000 		.long	.LCFI12
 3667 0221 0300      		.word	0x3
 3668 0223 92        		.byte	0x92
 3669 0224 20        		.uleb128 0x20
 3670 0225 0A        		.sleb128 10
 3671 0226 0000 0000 		.long	.LCFI12
 3672 022a 0000 0000 		.long	.LCFI13
 3673 022e 0300      		.word	0x3
 3674 0230 92        		.byte	0x92
 3675 0231 20        		.uleb128 0x20
 3676 0232 0B        		.sleb128 11
 3677 0233 0000 0000 		.long	.LCFI13
 3678 0237 0000 0000 		.long	.LCFI14
 3679 023b 0300      		.word	0x3
 3680 023d 92        		.byte	0x92
 3681 023e 20        		.uleb128 0x20
 3682 023f 0C        		.sleb128 12
 3683 0240 0000 0000 		.long	.LCFI14
 3684 0244 0000 0000 		.long	.LCFI15
 3685 0248 0300      		.word	0x3
GAS LISTING /tmp/ccChP33i.s 			page 74


 3686 024a 92        		.byte	0x92
 3687 024b 20        		.uleb128 0x20
 3688 024c 0D        		.sleb128 13
 3689 024d 0000 0000 		.long	.LCFI15
 3690 0251 0000 0000 		.long	.LCFI16
 3691 0255 0300      		.word	0x3
 3692 0257 92        		.byte	0x92
 3693 0258 20        		.uleb128 0x20
 3694 0259 0E        		.sleb128 14
 3695 025a 0000 0000 		.long	.LCFI16
 3696 025e 0000 0000 		.long	.LCFI17
 3697 0262 0300      		.word	0x3
 3698 0264 92        		.byte	0x92
 3699 0265 20        		.uleb128 0x20
 3700 0266 0F        		.sleb128 15
 3701 0267 0000 0000 		.long	.LCFI17
 3702 026b 0000 0000 		.long	.LCFI18
 3703 026f 0300      		.word	0x3
 3704 0271 92        		.byte	0x92
 3705 0272 20        		.uleb128 0x20
 3706 0273 10        		.sleb128 16
 3707 0274 0000 0000 		.long	.LCFI18
 3708 0278 0000 0000 		.long	.LFE105
 3709 027c 0300      		.word	0x3
 3710 027e 92        		.byte	0x92
 3711 027f 20        		.uleb128 0x20
 3712 0280 11        		.sleb128 17
 3713 0281 0000 0000 		.long	0
 3714 0285 0000 0000 		.long	0
 3715               	.LLST9:
 3716 0289 0000 0000 		.long	.LVL41
 3717 028d 0000 0000 		.long	.LVL42
 3718 0291 0100      		.word	0x1
 3719 0293 69        		.byte	0x69
 3720 0294 0000 0000 		.long	0
 3721 0298 0000 0000 		.long	0
 3722               	.LLST10:
 3723 029c 0000 0000 		.long	.LVL20
 3724 02a0 0000 0000 		.long	.LVL28
 3725 02a4 0100      		.word	0x1
 3726 02a6 68        		.byte	0x68
 3727 02a7 0000 0000 		.long	.LVL28
 3728 02ab 0000 0000 		.long	.LVL29
 3729 02af 0100      		.word	0x1
 3730 02b1 69        		.byte	0x69
 3731 02b2 0000 0000 		.long	.LVL29
 3732 02b6 0000 0000 		.long	.LVL33
 3733 02ba 0100      		.word	0x1
 3734 02bc 68        		.byte	0x68
 3735 02bd 0000 0000 		.long	.LVL35
 3736 02c1 0000 0000 		.long	.LVL36-1
 3737 02c5 0100      		.word	0x1
 3738 02c7 68        		.byte	0x68
 3739 02c8 0000 0000 		.long	.LVL37
 3740 02cc 0000 0000 		.long	.LVL38
 3741 02d0 0100      		.word	0x1
 3742 02d2 68        		.byte	0x68
GAS LISTING /tmp/ccChP33i.s 			page 75


 3743 02d3 0000 0000 		.long	.LVL38
 3744 02d7 0000 0000 		.long	.LVL39
 3745 02db 0100      		.word	0x1
 3746 02dd 69        		.byte	0x69
 3747 02de 0000 0000 		.long	.LVL39
 3748 02e2 0000 0000 		.long	.LVL42
 3749 02e6 0100      		.word	0x1
 3750 02e8 68        		.byte	0x68
 3751 02e9 0000 0000 		.long	0
 3752 02ed 0000 0000 		.long	0
 3753               	.LLST11:
 3754 02f1 0000 0000 		.long	.LVL21
 3755 02f5 0000 0000 		.long	.LVL22
 3756 02f9 0100      		.word	0x1
 3757 02fb 69        		.byte	0x69
 3758 02fc 0000 0000 		.long	.LVL22
 3759 0300 0000 0000 		.long	.LVL23
 3760 0304 0500      		.word	0x5
 3761 0306 03        		.byte	0x3
 3762 0307 0000 0000 		.long	twiState
 3763 030b 0000 0000 		.long	.LVL23
 3764 030f 0000 0000 		.long	.LVL24
 3765 0313 0100      		.word	0x1
 3766 0315 69        		.byte	0x69
 3767 0316 0000 0000 		.long	.LVL24
 3768 031a 0000 0000 		.long	.LVL25
 3769 031e 0500      		.word	0x5
 3770 0320 03        		.byte	0x3
 3771 0321 0000 0000 		.long	twiState
 3772 0325 0000 0000 		.long	.LVL26
 3773 0329 0000 0000 		.long	.LVL27
 3774 032d 0100      		.word	0x1
 3775 032f 69        		.byte	0x69
 3776 0330 0000 0000 		.long	.LVL27
 3777 0334 0000 0000 		.long	.LVL29
 3778 0338 0500      		.word	0x5
 3779 033a 03        		.byte	0x3
 3780 033b 0000 0000 		.long	twiState
 3781 033f 0000 0000 		.long	.LVL29
 3782 0343 0000 0000 		.long	.LVL30
 3783 0347 0100      		.word	0x1
 3784 0349 69        		.byte	0x69
 3785 034a 0000 0000 		.long	.LVL30
 3786 034e 0000 0000 		.long	.LVL31
 3787 0352 0500      		.word	0x5
 3788 0354 03        		.byte	0x3
 3789 0355 0000 0000 		.long	twiState
 3790 0359 0000 0000 		.long	.LVL32
 3791 035d 0000 0000 		.long	.LVL34-1
 3792 0361 0100      		.word	0x1
 3793 0363 69        		.byte	0x69
 3794 0364 0000 0000 		.long	.LVL38
 3795 0368 0000 0000 		.long	.LVL40
 3796 036c 0500      		.word	0x5
 3797 036e 03        		.byte	0x3
 3798 036f 0000 0000 		.long	twiState
 3799 0373 0000 0000 		.long	0
GAS LISTING /tmp/ccChP33i.s 			page 76


 3800 0377 0000 0000 		.long	0
 3801               	.LLST12:
 3802 037b 0000 0000 		.long	.LVL43
 3803 037f 0000 0000 		.long	.LVL44
 3804 0383 0100      		.word	0x1
 3805 0385 68        		.byte	0x68
 3806 0386 0000 0000 		.long	.LVL44
 3807 038a 0000 0000 		.long	.LVL45
 3808 038e 0500      		.word	0x5
 3809 0390 03        		.byte	0x3
 3810 0391 0000 0000 		.long	twiSLARW
 3811 0395 0000 0000 		.long	.LVL45
 3812 0399 0000 0000 		.long	.LFE106
 3813 039d 0400      		.word	0x4
 3814 039f F3        		.byte	0xf3
 3815 03a0 01        		.uleb128 0x1
 3816 03a1 68        		.byte	0x68
 3817 03a2 9F        		.byte	0x9f
 3818 03a3 0000 0000 		.long	0
 3819 03a7 0000 0000 		.long	0
 3820               	.LLST13:
 3821 03ab 0000 0000 		.long	.LVL46
 3822 03af 0000 0000 		.long	.LVL47
 3823 03b3 0100      		.word	0x1
 3824 03b5 68        		.byte	0x68
 3825 03b6 0000 0000 		.long	.LVL47
 3826 03ba 0000 0000 		.long	.LVL48
 3827 03be 0500      		.word	0x5
 3828 03c0 03        		.byte	0x3
 3829 03c1 0000 0000 		.long	twiSLARW
 3830 03c5 0000 0000 		.long	.LVL48
 3831 03c9 0000 0000 		.long	.LFE107
 3832 03cd 0400      		.word	0x4
 3833 03cf F3        		.byte	0xf3
 3834 03d0 01        		.uleb128 0x1
 3835 03d1 68        		.byte	0x68
 3836 03d2 9F        		.byte	0x9f
 3837 03d3 0000 0000 		.long	0
 3838 03d7 0000 0000 		.long	0
 3839               	.LLST14:
 3840 03db 0000 0000 		.long	.LVL49
 3841 03df 0000 0000 		.long	.LVL50
 3842 03e3 0100      		.word	0x1
 3843 03e5 68        		.byte	0x68
 3844 03e6 0000 0000 		.long	.LVL50
 3845 03ea 0000 0000 		.long	.LFE108
 3846 03ee 0400      		.word	0x4
 3847 03f0 F3        		.byte	0xf3
 3848 03f1 01        		.uleb128 0x1
 3849 03f2 68        		.byte	0x68
 3850 03f3 9F        		.byte	0x9f
 3851 03f4 0000 0000 		.long	0
 3852 03f8 0000 0000 		.long	0
 3853               	.LLST15:
 3854 03fc 0000 0000 		.long	.LVL49
 3855 0400 0000 0000 		.long	.LVL51-1
 3856 0404 0600      		.word	0x6
GAS LISTING /tmp/ccChP33i.s 			page 77


 3857 0406 66        		.byte	0x66
 3858 0407 93        		.byte	0x93
 3859 0408 01        		.uleb128 0x1
 3860 0409 67        		.byte	0x67
 3861 040a 93        		.byte	0x93
 3862 040b 01        		.uleb128 0x1
 3863 040c 0000 0000 		.long	.LVL51-1
 3864 0410 0000 0000 		.long	.LFE108
 3865 0414 0400      		.word	0x4
 3866 0416 F3        		.byte	0xf3
 3867 0417 01        		.uleb128 0x1
 3868 0418 66        		.byte	0x66
 3869 0419 9F        		.byte	0x9f
 3870 041a 0000 0000 		.long	0
 3871 041e 0000 0000 		.long	0
 3872               	.LLST16:
 3873 0422 0000 0000 		.long	.LVL49
 3874 0426 0000 0000 		.long	.LVL51-1
 3875 042a 0100      		.word	0x1
 3876 042c 64        		.byte	0x64
 3877 042d 0000 0000 		.long	.LVL51-1
 3878 0431 0000 0000 		.long	.LFE108
 3879 0435 0400      		.word	0x4
 3880 0437 F3        		.byte	0xf3
 3881 0438 01        		.uleb128 0x1
 3882 0439 64        		.byte	0x64
 3883 043a 9F        		.byte	0x9f
 3884 043b 0000 0000 		.long	0
 3885 043f 0000 0000 		.long	0
 3886               	.LLST17:
 3887 0443 0000 0000 		.long	.LVL52
 3888 0447 0000 0000 		.long	.LVL53
 3889 044b 0100      		.word	0x1
 3890 044d 68        		.byte	0x68
 3891 044e 0000 0000 		.long	.LVL53
 3892 0452 0000 0000 		.long	.LFE109
 3893 0456 0400      		.word	0x4
 3894 0458 F3        		.byte	0xf3
 3895 0459 01        		.uleb128 0x1
 3896 045a 68        		.byte	0x68
 3897 045b 9F        		.byte	0x9f
 3898 045c 0000 0000 		.long	0
 3899 0460 0000 0000 		.long	0
 3900               	.LLST18:
 3901 0464 0000 0000 		.long	.LVL52
 3902 0468 0000 0000 		.long	.LVL54-1
 3903 046c 0600      		.word	0x6
 3904 046e 66        		.byte	0x66
 3905 046f 93        		.byte	0x93
 3906 0470 01        		.uleb128 0x1
 3907 0471 67        		.byte	0x67
 3908 0472 93        		.byte	0x93
 3909 0473 01        		.uleb128 0x1
 3910 0474 0000 0000 		.long	.LVL54-1
 3911 0478 0000 0000 		.long	.LFE109
 3912 047c 0400      		.word	0x4
 3913 047e F3        		.byte	0xf3
GAS LISTING /tmp/ccChP33i.s 			page 78


 3914 047f 01        		.uleb128 0x1
 3915 0480 66        		.byte	0x66
 3916 0481 9F        		.byte	0x9f
 3917 0482 0000 0000 		.long	0
 3918 0486 0000 0000 		.long	0
 3919               	.LLST19:
 3920 048a 0000 0000 		.long	.LVL52
 3921 048e 0000 0000 		.long	.LVL54-1
 3922 0492 0100      		.word	0x1
 3923 0494 64        		.byte	0x64
 3924 0495 0000 0000 		.long	.LVL54-1
 3925 0499 0000 0000 		.long	.LFE109
 3926 049d 0400      		.word	0x4
 3927 049f F3        		.byte	0xf3
 3928 04a0 01        		.uleb128 0x1
 3929 04a1 64        		.byte	0x64
 3930 04a2 9F        		.byte	0x9f
 3931 04a3 0000 0000 		.long	0
 3932 04a7 0000 0000 		.long	0
 3933               	.LLST20:
 3934 04ab 0000 0000 		.long	.LFB110
 3935 04af 0000 0000 		.long	.LCFI19
 3936 04b3 0300      		.word	0x3
 3937 04b5 92        		.byte	0x92
 3938 04b6 20        		.uleb128 0x20
 3939 04b7 03        		.sleb128 3
 3940 04b8 0000 0000 		.long	.LCFI19
 3941 04bc 0000 0000 		.long	.LFE110
 3942 04c0 0300      		.word	0x3
 3943 04c2 92        		.byte	0x92
 3944 04c3 20        		.uleb128 0x20
 3945 04c4 04        		.sleb128 4
 3946 04c5 0000 0000 		.long	0
 3947 04c9 0000 0000 		.long	0
 3948               	.LLST21:
 3949 04cd 0000 0000 		.long	.LVL55
 3950 04d1 0000 0000 		.long	.LVL56
 3951 04d5 0100      		.word	0x1
 3952 04d7 68        		.byte	0x68
 3953 04d8 0000 0000 		.long	.LVL56
 3954 04dc 0000 0000 		.long	.LFE110
 3955 04e0 0400      		.word	0x4
 3956 04e2 F3        		.byte	0xf3
 3957 04e3 01        		.uleb128 0x1
 3958 04e4 68        		.byte	0x68
 3959 04e5 9F        		.byte	0x9f
 3960 04e6 0000 0000 		.long	0
 3961 04ea 0000 0000 		.long	0
 3962               	.LLST22:
 3963 04ee 0000 0000 		.long	.LVL55
 3964 04f2 0000 0000 		.long	.LVL57
 3965 04f6 0100      		.word	0x1
 3966 04f8 60        		.byte	0x60
 3967 04f9 0000 0000 		.long	.LVL57
 3968 04fd 0000 0000 		.long	.LFE110
 3969 0501 0400      		.word	0x4
 3970 0503 F3        		.byte	0xf3
GAS LISTING /tmp/ccChP33i.s 			page 79


 3971 0504 01        		.uleb128 0x1
 3972 0505 60        		.byte	0x60
 3973 0506 9F        		.byte	0x9f
 3974 0507 0000 0000 		.long	0
 3975 050b 0000 0000 		.long	0
 3976               	.LLST23:
 3977 050f 0000 0000 		.long	.LVL58
 3978 0513 0000 0000 		.long	.LVL63
 3979 0517 0100      		.word	0x1
 3980 0519 68        		.byte	0x68
 3981 051a 0000 0000 		.long	.LVL63
 3982 051e 0000 0000 		.long	.LFE111
 3983 0522 0400      		.word	0x4
 3984 0524 F3        		.byte	0xf3
 3985 0525 01        		.uleb128 0x1
 3986 0526 68        		.byte	0x68
 3987 0527 9F        		.byte	0x9f
 3988 0528 0000 0000 		.long	0
 3989 052c 0000 0000 		.long	0
 3990               	.LLST24:
 3991 0530 0000 0000 		.long	.LVL59
 3992 0534 0000 0000 		.long	.LVL61
 3993 0538 0100      		.word	0x1
 3994 053a 69        		.byte	0x69
 3995 053b 0000 0000 		.long	.LVL61
 3996 053f 0000 0000 		.long	.LVL62
 3997 0543 0500      		.word	0x5
 3998 0545 89        		.byte	0x89
 3999 0546 00        		.sleb128 0
 4000 0547 34        		.byte	0x34
 4001 0548 21        		.byte	0x21
 4002 0549 9F        		.byte	0x9f
 4003 054a 0000 0000 		.long	.LVL62
 4004 054e 0000 0000 		.long	.LVL64
 4005 0552 0100      		.word	0x1
 4006 0554 69        		.byte	0x69
 4007 0555 0000 0000 		.long	.LVL64
 4008 0559 0000 0000 		.long	.LVL66
 4009 055d 0100      		.word	0x1
 4010 055f 68        		.byte	0x68
 4011 0560 0000 0000 		.long	.LVL66
 4012 0564 0000 0000 		.long	.LVL67
 4013 0568 0500      		.word	0x5
 4014 056a 88        		.byte	0x88
 4015 056b 00        		.sleb128 0
 4016 056c 34        		.byte	0x34
 4017 056d 21        		.byte	0x21
 4018 056e 9F        		.byte	0x9f
 4019 056f 0000 0000 		.long	.LVL67
 4020 0573 0000 0000 		.long	.LFE111
 4021 0577 0100      		.word	0x1
 4022 0579 68        		.byte	0x68
 4023 057a 0000 0000 		.long	0
 4024 057e 0000 0000 		.long	0
 4025               	.LLST25:
 4026 0582 0000 0000 		.long	.LFB112
 4027 0586 0000 0000 		.long	.LCFI20
GAS LISTING /tmp/ccChP33i.s 			page 80


 4028 058a 0300      		.word	0x3
 4029 058c 92        		.byte	0x92
 4030 058d 20        		.uleb128 0x20
 4031 058e 03        		.sleb128 3
 4032 058f 0000 0000 		.long	.LCFI20
 4033 0593 0000 0000 		.long	.LCFI21
 4034 0597 0300      		.word	0x3
 4035 0599 92        		.byte	0x92
 4036 059a 20        		.uleb128 0x20
 4037 059b 04        		.sleb128 4
 4038 059c 0000 0000 		.long	.LCFI21
 4039 05a0 0000 0000 		.long	.LCFI22
 4040 05a4 0300      		.word	0x3
 4041 05a6 92        		.byte	0x92
 4042 05a7 20        		.uleb128 0x20
 4043 05a8 05        		.sleb128 5
 4044 05a9 0000 0000 		.long	.LCFI22
 4045 05ad 0000 0000 		.long	.LFE112
 4046 05b1 0300      		.word	0x3
 4047 05b3 92        		.byte	0x92
 4048 05b4 20        		.uleb128 0x20
 4049 05b5 06        		.sleb128 6
 4050 05b6 0000 0000 		.long	0
 4051 05ba 0000 0000 		.long	0
 4052               	.LLST26:
 4053 05be 0000 0000 		.long	.LVL68
 4054 05c2 0000 0000 		.long	.LVL70
 4055 05c6 0600      		.word	0x6
 4056 05c8 68        		.byte	0x68
 4057 05c9 93        		.byte	0x93
 4058 05ca 01        		.uleb128 0x1
 4059 05cb 69        		.byte	0x69
 4060 05cc 93        		.byte	0x93
 4061 05cd 01        		.uleb128 0x1
 4062 05ce 0000 0000 		.long	.LVL70
 4063 05d2 0000 0000 		.long	.LFE112
 4064 05d6 0400      		.word	0x4
 4065 05d8 F3        		.byte	0xf3
 4066 05d9 01        		.uleb128 0x1
 4067 05da 68        		.byte	0x68
 4068 05db 9F        		.byte	0x9f
 4069 05dc 0000 0000 		.long	0
 4070 05e0 0000 0000 		.long	0
 4071               	.LLST27:
 4072 05e4 0000 0000 		.long	.LVL68
 4073 05e8 0000 0000 		.long	.LVL70
 4074 05ec 0100      		.word	0x1
 4075 05ee 66        		.byte	0x66
 4076 05ef 0000 0000 		.long	.LVL70
 4077 05f3 0000 0000 		.long	.LFE112
 4078 05f7 0400      		.word	0x4
 4079 05f9 F3        		.byte	0xf3
 4080 05fa 01        		.uleb128 0x1
 4081 05fb 66        		.byte	0x66
 4082 05fc 9F        		.byte	0x9f
 4083 05fd 0000 0000 		.long	0
 4084 0601 0000 0000 		.long	0
GAS LISTING /tmp/ccChP33i.s 			page 81


 4085               	.LLST28:
 4086 0605 0000 0000 		.long	.LVL69
 4087 0609 0000 0000 		.long	.LVL70
 4088 060d 0600      		.word	0x6
 4089 060f 68        		.byte	0x68
 4090 0610 93        		.byte	0x93
 4091 0611 01        		.uleb128 0x1
 4092 0612 69        		.byte	0x69
 4093 0613 93        		.byte	0x93
 4094 0614 01        		.uleb128 0x1
 4095 0615 0000 0000 		.long	.LVL70
 4096 0619 0000 0000 		.long	.LVL71
 4097 061d 0600      		.word	0x6
 4098 061f 6C        		.byte	0x6c
 4099 0620 93        		.byte	0x93
 4100 0621 01        		.uleb128 0x1
 4101 0622 6D        		.byte	0x6d
 4102 0623 93        		.byte	0x93
 4103 0624 01        		.uleb128 0x1
 4104 0625 0000 0000 		.long	.LVL71
 4105 0629 0000 0000 		.long	.LVL72
 4106 062d 0300      		.word	0x3
 4107 062f 8C        		.byte	0x8c
 4108 0630 01        		.sleb128 1
 4109 0631 9F        		.byte	0x9f
 4110 0632 0000 0000 		.long	.LVL72
 4111 0636 0000 0000 		.long	.LVL77
 4112 063a 0600      		.word	0x6
 4113 063c 6C        		.byte	0x6c
 4114 063d 93        		.byte	0x93
 4115 063e 01        		.uleb128 0x1
 4116 063f 6D        		.byte	0x6d
 4117 0640 93        		.byte	0x93
 4118 0641 01        		.uleb128 0x1
 4119 0642 0000 0000 		.long	0
 4120 0646 0000 0000 		.long	0
 4121               	.LLST29:
 4122 064a 0000 0000 		.long	.LVL69
 4123 064e 0000 0000 		.long	.LVL70
 4124 0652 0100      		.word	0x1
 4125 0654 66        		.byte	0x66
 4126 0655 0000 0000 		.long	.LVL70
 4127 0659 0000 0000 		.long	.LVL72
 4128 065d 0C00      		.word	0xc
 4129 065f 8C        		.byte	0x8c
 4130 0660 00        		.sleb128 0
 4131 0661 20        		.byte	0x20
 4132 0662 F3        		.byte	0xf3
 4133 0663 01        		.uleb128 0x1
 4134 0664 66        		.byte	0x66
 4135 0665 22        		.byte	0x22
 4136 0666 F3        		.byte	0xf3
 4137 0667 01        		.uleb128 0x1
 4138 0668 68        		.byte	0x68
 4139 0669 22        		.byte	0x22
 4140 066a 9F        		.byte	0x9f
 4141 066b 0000 0000 		.long	.LVL72
GAS LISTING /tmp/ccChP33i.s 			page 82


 4142 066f 0000 0000 		.long	.LVL76
 4143 0673 0B00      		.word	0xb
 4144 0675 F3        		.byte	0xf3
 4145 0676 01        		.uleb128 0x1
 4146 0677 66        		.byte	0x66
 4147 0678 8C        		.byte	0x8c
 4148 0679 00        		.sleb128 0
 4149 067a 1C        		.byte	0x1c
 4150 067b F3        		.byte	0xf3
 4151 067c 01        		.uleb128 0x1
 4152 067d 68        		.byte	0x68
 4153 067e 22        		.byte	0x22
 4154 067f 9F        		.byte	0x9f
 4155 0680 0000 0000 		.long	.LVL76
 4156 0684 0000 0000 		.long	.LVL77
 4157 0688 0C00      		.word	0xc
 4158 068a 8C        		.byte	0x8c
 4159 068b 00        		.sleb128 0
 4160 068c 20        		.byte	0x20
 4161 068d F3        		.byte	0xf3
 4162 068e 01        		.uleb128 0x1
 4163 068f 66        		.byte	0x66
 4164 0690 22        		.byte	0x22
 4165 0691 F3        		.byte	0xf3
 4166 0692 01        		.uleb128 0x1
 4167 0693 68        		.byte	0x68
 4168 0694 22        		.byte	0x22
 4169 0695 9F        		.byte	0x9f
 4170 0696 0000 0000 		.long	0
 4171 069a 0000 0000 		.long	0
 4172               	.LLST30:
 4173 069e 0000 0000 		.long	.LFB114
 4174 06a2 0000 0000 		.long	.LCFI23
 4175 06a6 0300      		.word	0x3
 4176 06a8 92        		.byte	0x92
 4177 06a9 20        		.uleb128 0x20
 4178 06aa 03        		.sleb128 3
 4179 06ab 0000 0000 		.long	.LCFI23
 4180 06af 0000 0000 		.long	.LFE114
 4181 06b3 0300      		.word	0x3
 4182 06b5 92        		.byte	0x92
 4183 06b6 20        		.uleb128 0x20
 4184 06b7 04        		.sleb128 4
 4185 06b8 0000 0000 		.long	0
 4186 06bc 0000 0000 		.long	0
 4187               	.LLST31:
 4188 06c0 0000 0000 		.long	.LVL94
 4189 06c4 0000 0000 		.long	.LVL95
 4190 06c8 0100      		.word	0x1
 4191 06ca 68        		.byte	0x68
 4192 06cb 0000 0000 		.long	.LVL95
 4193 06cf 0000 0000 		.long	.LVL96
 4194 06d3 0500      		.word	0x5
 4195 06d5 03        		.byte	0x3
 4196 06d6 0000 0000 		.long	lcdAddress
 4197 06da 0000 0000 		.long	.LVL96
 4198 06de 0000 0000 		.long	.LVL97
GAS LISTING /tmp/ccChP33i.s 			page 83


 4199 06e2 0100      		.word	0x1
 4200 06e4 68        		.byte	0x68
 4201 06e5 0000 0000 		.long	.LVL97
 4202 06e9 0000 0000 		.long	.LVL100-1
 4203 06ed 0500      		.word	0x5
 4204 06ef 03        		.byte	0x3
 4205 06f0 0000 0000 		.long	lcdAddress
 4206 06f4 0000 0000 		.long	.LVL100-1
 4207 06f8 0000 0000 		.long	.LFE114
 4208 06fc 0400      		.word	0x4
 4209 06fe F3        		.byte	0xf3
 4210 06ff 01        		.uleb128 0x1
 4211 0700 68        		.byte	0x68
 4212 0701 9F        		.byte	0x9f
 4213 0702 0000 0000 		.long	0
 4214 0706 0000 0000 		.long	0
 4215               	.LLST32:
 4216 070a 0000 0000 		.long	.LVL94
 4217 070e 0000 0000 		.long	.LVL99
 4218 0712 0100      		.word	0x1
 4219 0714 66        		.byte	0x66
 4220 0715 0000 0000 		.long	.LVL99
 4221 0719 0000 0000 		.long	.LVL100-1
 4222 071d 0500      		.word	0x5
 4223 071f 03        		.byte	0x3
 4224 0720 0000 0000 		.long	lcdCols
 4225 0724 0000 0000 		.long	.LVL100-1
 4226 0728 0000 0000 		.long	.LFE114
 4227 072c 0400      		.word	0x4
 4228 072e F3        		.byte	0xf3
 4229 072f 01        		.uleb128 0x1
 4230 0730 66        		.byte	0x66
 4231 0731 9F        		.byte	0x9f
 4232 0732 0000 0000 		.long	0
 4233 0736 0000 0000 		.long	0
 4234               	.LLST33:
 4235 073a 0000 0000 		.long	.LVL94
 4236 073e 0000 0000 		.long	.LVL98
 4237 0742 0100      		.word	0x1
 4238 0744 64        		.byte	0x64
 4239 0745 0000 0000 		.long	.LVL98
 4240 0749 0000 0000 		.long	.LVL114
 4241 074d 0100      		.word	0x1
 4242 074f 6C        		.byte	0x6c
 4243 0750 0000 0000 		.long	.LVL114
 4244 0754 0000 0000 		.long	.LFE114
 4245 0758 0400      		.word	0x4
 4246 075a F3        		.byte	0xf3
 4247 075b 01        		.uleb128 0x1
 4248 075c 64        		.byte	0x64
 4249 075d 9F        		.byte	0x9f
 4250 075e 0000 0000 		.long	0
 4251 0762 0000 0000 		.long	0
 4252               	.LLST34:
 4253 0766 0000 0000 		.long	.LVL94
 4254 076a 0000 0000 		.long	.LVL100-1
 4255 076e 0100      		.word	0x1
GAS LISTING /tmp/ccChP33i.s 			page 84


 4256 0770 62        		.byte	0x62
 4257 0771 0000 0000 		.long	.LVL100-1
 4258 0775 0000 0000 		.long	.LFE114
 4259 0779 0400      		.word	0x4
 4260 077b F3        		.byte	0xf3
 4261 077c 01        		.uleb128 0x1
 4262 077d 62        		.byte	0x62
 4263 077e 9F        		.byte	0x9f
 4264 077f 0000 0000 		.long	0
 4265 0783 0000 0000 		.long	0
 4266               		.section	.debug_aranges,"",@progbits
 4267 0000 8C00 0000 		.long	0x8c
 4268 0004 0200      		.word	0x2
 4269 0006 0000 0000 		.long	.Ldebug_info0
 4270 000a 04        		.byte	0x4
 4271 000b 00        		.byte	0
 4272 000c 0000      		.word	0
 4273 000e 0000      		.word	0
 4274 0010 0000 0000 		.long	.LFB102
 4275 0014 4800 0000 		.long	.LFE102-.LFB102
 4276 0018 0000 0000 		.long	.LFB103
 4277 001c 3000 0000 		.long	.LFE103-.LFB103
 4278 0020 0000 0000 		.long	.LFB104
 4279 0024 5800 0000 		.long	.LFE104-.LFB104
 4280 0028 0000 0000 		.long	.LFB105
 4281 002c 3601 0000 		.long	.LFE105-.LFB105
 4282 0030 0000 0000 		.long	.LFB106
 4283 0034 2200 0000 		.long	.LFE106-.LFB106
 4284 0038 0000 0000 		.long	.LFB107
 4285 003c 2200 0000 		.long	.LFE107-.LFB107
 4286 0040 0000 0000 		.long	.LFB108
 4287 0044 2400 0000 		.long	.LFE108-.LFB108
 4288 0048 0000 0000 		.long	.LFB109
 4289 004c 2600 0000 		.long	.LFE109-.LFB109
 4290 0050 0000 0000 		.long	.LFB110
 4291 0054 5A00 0000 		.long	.LFE110-.LFB110
 4292 0058 0000 0000 		.long	.LFB111
 4293 005c 3A00 0000 		.long	.LFE111-.LFB111
 4294 0060 0000 0000 		.long	.LFB112
 4295 0064 4400 0000 		.long	.LFE112-.LFB112
 4296 0068 0000 0000 		.long	.LFB113
 4297 006c A400 0000 		.long	.LFE113-.LFB113
 4298 0070 0000 0000 		.long	.LFB114
 4299 0074 DA00 0000 		.long	.LFE114-.LFB114
 4300 0078 0000 0000 		.long	.LFB115
 4301 007c 1600 0000 		.long	.LFE115-.LFB115
 4302 0080 0000 0000 		.long	.LFB116
 4303 0084 0200 0000 		.long	.LFE116-.LFB116
 4304 0088 0000 0000 		.long	0
 4305 008c 0000 0000 		.long	0
 4306               		.section	.debug_ranges,"",@progbits
 4307               	.Ldebug_ranges0:
 4308 0000 0000 0000 		.long	.LFB102
 4309 0004 0000 0000 		.long	.LFE102
 4310 0008 0000 0000 		.long	.LFB103
 4311 000c 0000 0000 		.long	.LFE103
 4312 0010 0000 0000 		.long	.LFB104
GAS LISTING /tmp/ccChP33i.s 			page 85


 4313 0014 0000 0000 		.long	.LFE104
 4314 0018 0000 0000 		.long	.LFB105
 4315 001c 0000 0000 		.long	.LFE105
 4316 0020 0000 0000 		.long	.LFB106
 4317 0024 0000 0000 		.long	.LFE106
 4318 0028 0000 0000 		.long	.LFB107
 4319 002c 0000 0000 		.long	.LFE107
 4320 0030 0000 0000 		.long	.LFB108
 4321 0034 0000 0000 		.long	.LFE108
 4322 0038 0000 0000 		.long	.LFB109
 4323 003c 0000 0000 		.long	.LFE109
 4324 0040 0000 0000 		.long	.LFB110
 4325 0044 0000 0000 		.long	.LFE110
 4326 0048 0000 0000 		.long	.LFB111
 4327 004c 0000 0000 		.long	.LFE111
 4328 0050 0000 0000 		.long	.LFB112
 4329 0054 0000 0000 		.long	.LFE112
 4330 0058 0000 0000 		.long	.LFB113
 4331 005c 0000 0000 		.long	.LFE113
 4332 0060 0000 0000 		.long	.LFB114
 4333 0064 0000 0000 		.long	.LFE114
 4334 0068 0000 0000 		.long	.LFB115
 4335 006c 0000 0000 		.long	.LFE115
 4336 0070 0000 0000 		.long	.LFB116
 4337 0074 0000 0000 		.long	.LFE116
 4338 0078 0000 0000 		.long	0
 4339 007c 0000 0000 		.long	0
 4340               		.section	.debug_line,"",@progbits
 4341               	.Ldebug_line0:
 4342 0000 0D03 0000 		.section	.debug_str,"MS",@progbits,1
 4342      0200 B400 
 4342      0000 0201 
 4342      FB0E 0D00 
 4342      0101 0101 
 4343               	.LASF27:
 4344 0000 7477 6953 		.string	"twiSetup"
 4344      6574 7570 
 4344      00
 4345               	.LASF43:
 4346 0009 5F64 6174 		.string	"_data"
 4346      6100 
 4347               	.LASF9:
 4348 000f 6C6F 6E67 		.string	"long long unsigned int"
 4348      206C 6F6E 
 4348      6720 756E 
 4348      7369 676E 
 4348      6564 2069 
 4349               	.LASF18:
 4350 0026 7374 6172 		.string	"starts"
 4350      7473 00
 4351               	.LASF68:
 4352 002d 6C63 6453 		.string	"lcdShifts"
 4352      6869 6674 
 4352      7300 
 4353               	.LASF58:
 4354 0037 7477 6952 		.string	"twiRX_Count"
 4354      585F 436F 
GAS LISTING /tmp/ccChP33i.s 			page 86


 4354      756E 7400 
 4355               	.LASF8:
 4356 0043 6C6F 6E67 		.string	"long long int"
 4356      206C 6F6E 
 4356      6720 696E 
 4356      7400 
 4357               	.LASF0:
 4358 0051 7369 676E 		.string	"signed char"
 4358      6564 2063 
 4358      6861 7200 
 4359               	.LASF28:
 4360 005d 6672 6571 		.string	"freq"
 4360      00
 4361               	.LASF20:
 4362 0062 7374 6F70 		.string	"stops"
 4362      7300 
 4363               	.LASF17:
 4364 0068 5457 495F 		.string	"TWI_READY"
 4364      5245 4144 
 4364      5900 
 4365               	.LASF69:
 4366 0072 6C63 6453 		.string	"lcdShows"
 4366      686F 7773 
 4366      00
 4367               	.LASF5:
 4368 007b 6C6F 6E67 		.string	"long int"
 4368      2069 6E74 
 4368      00
 4369               	.LASF30:
 4370 0084 5F5F 7665 		.string	"__vector_39"
 4370      6374 6F72 
 4370      5F33 3900 
 4371               	.LASF66:
 4372 0090 7477 6953 		.string	"twiStatistic"
 4372      7461 7469 
 4372      7374 6963 
 4372      00
 4373               	.LASF3:
 4374 009d 7569 6E74 		.string	"uint16_t"
 4374      3136 5F74 
 4374      00
 4375               	.LASF13:
 4376 00a6 646F 7562 		.string	"double"
 4376      6C65 00
 4377               	.LASF40:
 4378 00ad 636C 656E 		.string	"clength"
 4378      6774 6800 
 4379               	.LASF65:
 4380 00b5 7477 6953 		.string	"twiSlaveWriter"
 4380      6C61 7665 
 4380      5772 6974 
 4380      6572 00
 4381               	.LASF38:
 4382 00c4 7477 6952 		.string	"twiRAW"
 4382      4157 00
 4383               	.LASF45:
 4384 00cb 6C63 6457 		.string	"lcdWrite"
GAS LISTING /tmp/ccChP33i.s 			page 87


 4384      7269 7465 
 4384      00
 4385               	.LASF37:
 4386 00d4 7477 6952 		.string	"twiRead"
 4386      6561 6400 
 4387               	.LASF25:
 4388 00dc 6269 744D 		.string	"bitMul"
 4388      756C 00
 4389               	.LASF4:
 4390 00e3 756E 7369 		.string	"unsigned int"
 4390      676E 6564 
 4390      2069 6E74 
 4390      00
 4391               	.LASF71:
 4392 00f0 6C63 6441 		.string	"lcdAddress"
 4392      6464 7265 
 4392      7373 00
 4393               	.LASF59:
 4394 00fb 7477 6952 		.string	"twiRX_Ptr"
 4394      585F 5074 
 4394      7200 
 4395               	.LASF39:
 4396 0105 636F 6D6D 		.string	"command"
 4396      616E 6400 
 4397               	.LASF83:
 4398 010d 6C6F 6F70 		.string	"loop"
 4398      00
 4399               	.LASF47:
 4400 0112 6C63 6453 		.string	"lcdSetup"
 4400      6574 7570 
 4400      00
 4401               	.LASF7:
 4402 011b 6C6F 6E67 		.string	"long unsigned int"
 4402      2075 6E73 
 4402      6967 6E65 
 4402      6420 696E 
 4402      7400 
 4403               	.LASF55:
 4404 012d 7477 6953 		.string	"twiSLARW"
 4404      4C41 5257 
 4404      00
 4405               	.LASF48:
 4406 0136 5F61 6464 		.string	"_address"
 4406      7265 7373 
 4406      00
 4407               	.LASF35:
 4408 013f 6461 7461 		.string	"data"
 4408      00
 4409               	.LASF14:
 4410 0144 7368 6F72 		.string	"short unsigned int"
 4410      7420 756E 
 4410      7369 676E 
 4410      6564 2069 
 4410      6E74 00
 4411               	.LASF23:
 4412 0157 5457 495F 		.string	"TWI_Stat"
 4412      5374 6174 
GAS LISTING /tmp/ccChP33i.s 			page 88


 4412      00
 4413               	.LASF50:
 4414 0160 5F72 6F77 		.string	"_rows"
 4414      7300 
 4415               	.LASF10:
 4416 0166 626F 6F6C 		.string	"bool"
 4416      00
 4417               	.LASF53:
 4418 016b 7477 694D 		.string	"twiMode"
 4418      6F64 6500 
 4419               	.LASF63:
 4420 0173 7477 694D 		.string	"twiMasterReader"
 4420      6173 7465 
 4420      7252 6561 
 4420      6465 7200 
 4421               	.LASF79:
 4422 0183 5457 495F 		.string	"TWI_Modes"
 4422      4D6F 6465 
 4422      7300 
 4423               	.LASF56:
 4424 018d 7477 694D 		.string	"twiMT_Count"
 4424      545F 436F 
 4424      756E 7400 
 4425               	.LASF81:
 4426 0199 7477 6953 		.string	"twiSendStop"
 4426      656E 6453 
 4426      746F 7000 
 4427               	.LASF32:
 4428 01a5 6164 6472 		.string	"address"
 4428      6573 7300 
 4429               	.LASF31:
 4430 01ad 5F74 7769 		.string	"_twiStartTo"
 4430      5374 6172 
 4430      7454 6F00 
 4431               	.LASF52:
 4432 01b9 7365 7475 		.string	"setup"
 4432      7000 
 4433               	.LASF12:
 4434 01bf 666C 6F61 		.string	"float"
 4434      7400 
 4435               	.LASF73:
 4436 01c5 6C63 6452 		.string	"lcdRows"
 4436      6F77 7300 
 4437               	.LASF84:
 4438 01cd 7469 6D65 		.string	"time_delay16"
 4438      5F64 656C 
 4438      6179 3136 
 4438      00
 4439               	.LASF57:
 4440 01da 7477 694D 		.string	"twiMT_Ptr"
 4440      545F 5074 
 4440      7200 
 4441               	.LASF42:
 4442 01e4 6C63 6450 		.string	"lcdPrepare"
 4442      7265 7061 
 4442      7265 00
 4443               	.LASF19:
GAS LISTING /tmp/ccChP33i.s 			page 89


 4444 01ef 7265 7374 		.string	"restarts"
 4444      6172 7473 
 4444      00
 4445               	.LASF51:
 4446 01f8 5F62 6163 		.string	"_backLight"
 4446      6B4C 6967 
 4446      6874 00
 4447               	.LASF76:
 4448 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4448      432B 2B20 
 4448      342E 382E 
 4448      3120 2D6D 
 4448      6D63 753D 
 4449               	.LASF1:
 4450 0295 756E 7369 		.string	"unsigned char"
 4450      676E 6564 
 4450      2063 6861 
 4450      7200 
 4451               	.LASF49:
 4452 02a3 5F63 6F6C 		.string	"_cols"
 4452      7300 
 4453               	.LASF78:
 4454 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4454      2F62 7569 
 4454      6C64 3132 
 4454      3336 3837 
 4454      3935 3737 
 4455               	.LASF24:
 4456 02cb 6269 7452 		.string	"bitRate"
 4456      6174 6500 
 4457               	.LASF54:
 4458 02d3 7477 6953 		.string	"twiState"
 4458      7461 7465 
 4458      00
 4459               	.LASF77:
 4460 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4460      2F62 7569 
 4460      6C64 3132 
 4460      3336 3837 
 4460      3935 3737 
 4461               	.LASF6:
 4462 030c 7569 6E74 		.string	"uint32_t"
 4462      3332 5F74 
 4462      00
 4463               	.LASF75:
 4464 0315 6C63 6442 		.string	"lcdBuffer"
 4464      7566 6665 
 4464      7200 
 4465               	.LASF22:
 4466 031f 6E6F 736C 		.string	"noslarw"
 4466      6172 7700 
 4467               	.LASF36:
 4468 0327 6C65 6E67 		.string	"length"
 4468      7468 00
 4469               	.LASF11:
 4470 032e 6368 6172 		.string	"char"
 4470      00
GAS LISTING /tmp/ccChP33i.s 			page 90


 4471               	.LASF41:
 4472 0333 646C 656E 		.string	"dlength"
 4472      6774 6800 
 4473               	.LASF29:
 4474 033b 6D6F 6465 		.string	"mode"
 4474      00
 4475               	.LASF72:
 4476 0340 6C63 6443 		.string	"lcdCols"
 4476      6F6C 7300 
 4477               	.LASF21:
 4478 0348 6C6F 7374 		.string	"losts"
 4478      7300 
 4479               	.LASF82:
 4480 034e 7469 6D65 		.string	"time"
 4480      00
 4481               	.LASF26:
 4482 0353 7477 6953 		.string	"twiSpeed"
 4482      7065 6564 
 4482      00
 4483               	.LASF16:
 4484 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4484      5345 4E44 
 4484      5F53 544F 
 4484      5000 
 4485               	.LASF70:
 4486 036a 6C63 6442 		.string	"lcdBackLight"
 4486      6163 6B4C 
 4486      6967 6874 
 4486      00
 4487               	.LASF2:
 4488 0377 7569 6E74 		.string	"uint8_t"
 4488      385F 7400 
 4489               	.LASF80:
 4490 037f 3854 5749 		.string	"8TWI_Stat"
 4490      5F53 7461 
 4490      7400 
 4491               	.LASF74:
 4492 0389 7369 7A65 		.string	"sizetype"
 4492      7479 7065 
 4492      00
 4493               	.LASF46:
 4494 0392 6C63 6449 		.string	"lcdInit"
 4494      6E69 7400 
 4495               	.LASF64:
 4496 039a 7477 6953 		.string	"twiSlaveReader"
 4496      6C61 7665 
 4496      5265 6164 
 4496      6572 00
 4497               	.LASF62:
 4498 03a9 7477 6948 		.string	"twiHookRestart"
 4498      6F6F 6B52 
 4498      6573 7461 
 4498      7274 00
 4499               	.LASF61:
 4500 03b8 7477 6953 		.string	"twiST_Ptr"
 4500      545F 5074 
 4500      7200 
GAS LISTING /tmp/ccChP33i.s 			page 91


 4501               	.LASF33:
 4502 03c2 5F74 7769 		.string	"_twiStartRe"
 4502      5374 6172 
 4502      7452 6500 
 4503               	.LASF34:
 4504 03ce 7477 6957 		.string	"twiWrite"
 4504      7269 7465 
 4504      00
 4505               	.LASF67:
 4506 03d7 6C63 644D 		.string	"lcdModes"
 4506      6F64 6573 
 4506      00
 4507               	.LASF44:
 4508 03e0 6E69 6262 		.string	"nibble"
 4508      6C65 00
 4509               	.LASF60:
 4510 03e7 7477 6953 		.string	"twiST_Count"
 4510      545F 436F 
 4510      756E 7400 
 4511               	.LASF15:
 4512 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4512      4953 5F53 
 4512      4C41 5645 
 4512      00
 4513               		.ident	"GCC: (GNU) 4.8.1"
 4514               	.global __do_copy_data
 4515               	.global __do_clear_bss
GAS LISTING /tmp/ccChP33i.s 			page 92


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccChP33i.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccChP33i.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccChP33i.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccChP33i.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccChP33i.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccChP33i.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccChP33i.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccChP33i.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccChP33i.s:1239   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccChP33i.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccChP33i.s:1185   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccChP33i.s:1227   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccChP33i.s:226    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccChP33i.s:1233   .bss.twiState:0000000000000000 twiState
     /tmp/ccChP33i.s:1221   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccChP33i.s:1215   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccChP33i.s:1203   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccChP33i.s:1209   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccChP33i.s:1179   .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccChP33i.s:485    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccChP33i.s:520    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccChP33i.s:555    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccChP33i.s:588    .text.twiRead:0000000000000000 twiRead
     /tmp/ccChP33i.s:622    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccChP33i.s:686    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccChP33i.s:1138   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccChP33i.s:1114   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccChP33i.s:749    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccChP33i.s:1132   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccChP33i.s:820    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccChP33i.s:1156   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccChP33i.s:1144   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccChP33i.s:1150   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccChP33i.s:913    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccChP33i.s:1126   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccChP33i.s:1120   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccChP33i.s:1069   .text.setup:0000000000000000 setup
     /tmp/ccChP33i.s:1098   .text.loop:0000000000000000 loop
     /tmp/ccChP33i.s:1161   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccChP33i.s:1167   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccChP33i.s:1173   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccChP33i.s:1191   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccChP33i.s:1197   .bss.twiST_Count:0000000000000000 twiST_Count

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
