GAS LISTING /tmp/ccB4vTv5.s 			page 1


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
GAS LISTING /tmp/ccB4vTv5.s 			page 2


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
GAS LISTING /tmp/ccB4vTv5.s 			page 3


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
GAS LISTING /tmp/ccB4vTv5.s 			page 4


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
GAS LISTING /tmp/ccB4vTv5.s 			page 5


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
GAS LISTING /tmp/ccB4vTv5.s 			page 6


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
GAS LISTING /tmp/ccB4vTv5.s 			page 7


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
GAS LISTING /tmp/ccB4vTv5.s 			page 8


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
GAS LISTING /tmp/ccB4vTv5.s 			page 9


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
GAS LISTING /tmp/ccB4vTv5.s 			page 10


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
 300 002a 3091 B900 		lds r19,185
 301 002e 932F      		mov r25,r19
 302 0030 987F      		andi r25,lo8(-8)
 303 0032 9093 0000 		sts twiState,r25
 304               	.LVL21:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
GAS LISTING /tmp/ccB4vTv5.s 			page 11


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
GAS LISTING /tmp/ccB4vTv5.s 			page 12


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
 315               	.L40:
 316 0042 9093 BB00 		sts 187,r25
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
 317               		.loc 1 328 0
 318 0046 80FD      		sbrc r24,0
 319 0048 00C0      		rjmp .L24
 320 004a 25E8      		ldi r18,lo8(-123)
 321 004c 00C0      		rjmp .L25
 322               	.LVL23:
 323               	.L23:
 329:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 330:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
 324               		.loc 1 330 0
 325 004e 387E      		andi r19,lo8(-24)
 326 0050 3032      		cpi r19,lo8(32)
 327 0052 01F0      		breq .L29
 331:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 332:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
 333:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликае
 334:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 twiSendStop(_md); return;
 335:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 336:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
 328               		.loc 1 336 0
 329 0054 9831      		cpi r25,lo8(24)
 330 0056 01F0      		breq .L28
 331               		.loc 1 336 0 is_stmt 0 discriminator 1
 332 0058 9832      		cpi r25,lo8(40)
 333 005a 01F4      		brne .L25
 334               	.L28:
 337:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 338:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Адрес получателя отправлен успешно, начи�
 339:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Байт данных отправлен, продолжаем
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( twiMT_Count-- ){
 335               		.loc 1 340 0 is_stmt 1
 336 005c 9091 0000 		lds r25,twiMT_Count
 337               	.LVL24:
 338 0060 2FEF      		ldi r18,lo8(-1)
 339 0062 290F      		add r18,r25
 340 0064 2093 0000 		sts twiMT_Count,r18
 341               	.LVL25:
 342 0068 9923      		tst r25
 343 006a 01F0      		breq .L29
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *twiMT_Ptr++;
GAS LISTING /tmp/ccB4vTv5.s 			page 13


 344               		.loc 1 341 0
 345 006c E091 0000 		lds r30,twiMT_Ptr
 346 0070 F091 0000 		lds r31,twiMT_Ptr+1
 347 0074 9F01      		movw r18,r30
 348 0076 2F5F      		subi r18,-1
 349 0078 3F4F      		sbci r19,-1
 350 007a 3093 0000 		sts twiMT_Ptr+1,r19
 351 007e 2093 0000 		sts twiMT_Ptr,r18
 352 0082 9081      		ld r25,Z
 353 0084 00C0      		rjmp .L40
 354               	.L24:
 342:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(_md & TWI_IS_SLAVE);
 355               		.loc 1 342 0
 356 0086 25EC      		ldi r18,lo8(-59)
 357 0088 00C0      		rjmp .L25
 358               	.L29:
 343:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 344:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 359               		.loc 1 344 0
 360 008a 0E94 0000 		call twiSendStop
 361               	.LVL26:
 362 008e 00C0      		rjmp .L21
 363               	.LVL27:
 364               	.L25:
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
 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 376:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 377:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
GAS LISTING /tmp/ccB4vTv5.s 			page 14


 378:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_RX
 379:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON&TWI_MASTER_TX)
 380:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 381:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 382:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 383:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 384:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 385:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_SLAVE_ON
 386:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = _md;
 365               		.loc 1 386 0
 366 0090 8093 0000 		sts twiMode,r24
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 367               		.loc 1 387 0
 368 0094 2093 BC00 		sts 188,r18
 369               	.LVL28:
 370               	.L21:
 371               	/* epilogue start */
 372               	.LBE7:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 373               		.loc 1 388 0
 374 0098 FF91      		pop r31
 375 009a EF91      		pop r30
 376 009c BF91      		pop r27
 377 009e AF91      		pop r26
 378 00a0 9F91      		pop r25
 379 00a2 8F91      		pop r24
 380 00a4 7F91      		pop r23
 381 00a6 6F91      		pop r22
 382 00a8 5F91      		pop r21
 383 00aa 4F91      		pop r20
 384 00ac 3F91      		pop r19
 385 00ae 2F91      		pop r18
 386 00b0 0F90      		pop r0
 387 00b2 0BBE      		out __RAMPZ__,r0
 388 00b4 0F90      		pop r0
 389 00b6 0FBE      		out __SREG__,r0
 390 00b8 0F90      		pop r0
 391 00ba 1F90      		pop r1
 392 00bc 1895      		reti
 393               		.cfi_endproc
 394               	.LFE105:
 395               		.size	__vector_39, .-__vector_39
 396               		.section	.text._twiStartTo,"ax",@progbits
 397               	.global	_twiStartTo
 398               		.type	_twiStartTo, @function
 399               	_twiStartTo:
 400               	.LFB106:
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
GAS LISTING /tmp/ccB4vTv5.s 			page 15


 399:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartTo(uint8_t address)
 400:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 401               		.loc 1 400 0
 402               		.cfi_startproc
 403               	.LVL29:
 404               	/* prologue: function */
 405               	/* frame size = 0 */
 406               	/* stack size = 0 */
 407               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 408               		.loc 1 401 0
 409 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 410               		.loc 1 402 0
 411 0004 8091 0000 		lds r24,twiMode
 412               	.LVL30:
 413 0008 8260      		ori r24,lo8(2)
 414 000a 8093 0000 		sts twiMode,r24
 415               	.LVL31:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 416               		.loc 1 403 0
 417 000e 8091 0000 		lds r24,twiMode
 418 0012 80FF      		sbrs r24,0
 419 0014 00C0      		rjmp .L43
 420 0016 85EE      		ldi r24,lo8(-27)
 421 0018 00C0      		rjmp .L42
 422               	.L43:
 423 001a 85EA      		ldi r24,lo8(-91)
 424               	.L42:
 425               		.loc 1 403 0 is_stmt 0 discriminator 3
 426 001c 8093 BC00 		sts 188,r24
 427 0020 0895      		ret
 428               		.cfi_endproc
 429               	.LFE106:
 430               		.size	_twiStartTo, .-_twiStartTo
 431               		.section	.text._twiStartRe,"ax",@progbits
 432               	.global	_twiStartRe
 433               		.type	_twiStartRe, @function
 434               	_twiStartRe:
 435               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 436               		.loc 1 412 0 is_stmt 1
 437               		.cfi_startproc
 438               	.LVL32:
 439               	/* prologue: function */
 440               	/* frame size = 0 */
 441               	/* stack size = 0 */
 442               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
GAS LISTING /tmp/ccB4vTv5.s 			page 16


 443               		.loc 1 413 0
 444 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 445               		.loc 1 414 0
 446 0004 8091 0000 		lds r24,twiMode
 447               	.LVL33:
 448 0008 8D7F      		andi r24,lo8(-3)
 449 000a 8093 0000 		sts twiMode,r24
 450               	.LVL34:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 451               		.loc 1 415 0
 452 000e 8091 0000 		lds r24,twiMode
 453 0012 80FF      		sbrs r24,0
 454 0014 00C0      		rjmp .L46
 455 0016 85EE      		ldi r24,lo8(-27)
 456 0018 00C0      		rjmp .L45
 457               	.L46:
 458 001a 85EA      		ldi r24,lo8(-91)
 459               	.L45:
 460               		.loc 1 415 0 is_stmt 0 discriminator 3
 461 001c 8093 BC00 		sts 188,r24
 462 0020 0895      		ret
 463               		.cfi_endproc
 464               	.LFE107:
 465               		.size	_twiStartRe, .-_twiStartRe
 466               		.section	.text.twiWrite,"ax",@progbits
 467               	.global	twiWrite
 468               		.type	twiWrite, @function
 469               	twiWrite:
 470               	.LFB108:
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
 471               		.loc 1 430 0 is_stmt 1
 472               		.cfi_startproc
 473               	/* prologue: function */
 474               	/* frame size = 0 */
 475               	/* stack size = 0 */
 476               	.L__stack_usage = 0
 477               	.LVL35:
 478               	.L49:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 479               		.loc 1 431 0 discriminator 1
 480 0000 9091 0000 		lds r25,twiMode
 481 0004 92FF      		sbrs r25,2
GAS LISTING /tmp/ccB4vTv5.s 			page 17


 482 0006 00C0      		rjmp .L49
 483               		.loc 1 431 0 is_stmt 0 discriminator 2
 484 0008 9091 0000 		lds r25,twiMode
 485 000c 9B7F      		andi r25,lo8(-5)
 486 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 487               		.loc 1 432 0 is_stmt 1 discriminator 2
 488 0012 7093 0000 		sts twiMT_Ptr+1,r23
 489 0016 6093 0000 		sts twiMT_Ptr,r22
 490 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 491               		.loc 1 433 0 discriminator 2
 492 001e 880F      		lsl r24
 493               	.LVL36:
 494 0020 0C94 0000 		jmp _twiStartTo
 495               	.LVL37:
 496               		.cfi_endproc
 497               	.LFE108:
 498               		.size	twiWrite, .-twiWrite
 499               		.section	.text.twiRead,"ax",@progbits
 500               	.global	twiRead
 501               		.type	twiRead, @function
 502               	twiRead:
 503               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 504               		.loc 1 440 0
 505               		.cfi_startproc
 506               	/* prologue: function */
 507               	/* frame size = 0 */
 508               	/* stack size = 0 */
 509               	.L__stack_usage = 0
 510               	.LVL38:
 511               	.L52:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 512               		.loc 1 441 0 discriminator 1
 513 0000 9091 0000 		lds r25,twiMode
 514 0004 92FF      		sbrs r25,2
 515 0006 00C0      		rjmp .L52
 516               		.loc 1 441 0 is_stmt 0 discriminator 2
 517 0008 9091 0000 		lds r25,twiMode
 518 000c 9B7F      		andi r25,lo8(-5)
 519 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 520               		.loc 1 442 0 is_stmt 1 discriminator 2
 521 0012 7093 0000 		sts twiRX_Ptr+1,r23
 522 0016 6093 0000 		sts twiRX_Ptr,r22
 523 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 524               		.loc 1 443 0 discriminator 2
 525 001e 880F      		lsl r24
 526               	.LVL39:
GAS LISTING /tmp/ccB4vTv5.s 			page 18


 527 0020 8160      		ori r24,lo8(1)
 528 0022 0C94 0000 		jmp _twiStartTo
 529               	.LVL40:
 530               		.cfi_endproc
 531               	.LFE109:
 532               		.size	twiRead, .-twiRead
 533               		.section	.text.twiRAW,"ax",@progbits
 534               	.global	twiRAW
 535               		.type	twiRAW, @function
 536               	twiRAW:
 537               	.LFB110:
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
 538               		.loc 1 453 0
 539               		.cfi_startproc
 540               	.LVL41:
 541 0000 0F93      		push r16
 542               	.LCFI19:
 543               		.cfi_def_cfa_offset 4
 544               		.cfi_offset 16, -3
 545               	/* prologue: function */
 546               	/* frame size = 0 */
 547               	/* stack size = 1 */
 548               	.L__stack_usage = 1
 549               	.L55:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 550               		.loc 1 454 0 discriminator 1
 551 0002 9091 0000 		lds r25,twiMode
 552 0006 92FF      		sbrs r25,2
 553 0008 00C0      		rjmp .L55
 554               		.loc 1 454 0 is_stmt 0 discriminator 2
 555 000a 9091 0000 		lds r25,twiMode
 556 000e 9B7F      		andi r25,lo8(-5)
 557 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 558               		.loc 1 455 0 is_stmt 1 discriminator 2
 559 0014 7093 0000 		sts twiMT_Ptr+1,r23
 560 0018 6093 0000 		sts twiMT_Ptr,r22
 561 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 562               		.loc 1 456 0 discriminator 2
 563 0020 3093 0000 		sts twiRX_Ptr+1,r19
 564 0024 2093 0000 		sts twiRX_Ptr,r18
 565 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 566               		.loc 1 458 0 discriminator 2
 567 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 568 0030 1092 0000 		sts twiHookRestart,__zero_reg__
GAS LISTING /tmp/ccB4vTv5.s 			page 19


 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 569               		.loc 1 459 0 discriminator 2
 570 0034 9091 0000 		lds r25,twiMode
 571 0038 9D7F      		andi r25,lo8(-3)
 572 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 573               		.loc 1 460 0 discriminator 2
 574 003e 880F      		lsl r24
 575               	.LVL42:
 576 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 577               		.loc 1 461 0 discriminator 2
 578 0044 8091 0000 		lds r24,twiMode
 579 0048 80FF      		sbrs r24,0
 580 004a 00C0      		rjmp .L57
 581               		.loc 1 461 0 is_stmt 0
 582 004c 85EE      		ldi r24,lo8(-27)
 583 004e 00C0      		rjmp .L56
 584               	.L57:
 585 0050 85EA      		ldi r24,lo8(-91)
 586               	.L56:
 587               		.loc 1 461 0 discriminator 3
 588 0052 8093 BC00 		sts 188,r24
 589               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 590               		.loc 1 462 0 is_stmt 1 discriminator 3
 591 0056 0F91      		pop r16
 592               	.LVL43:
 593 0058 0895      		ret
 594               		.cfi_endproc
 595               	.LFE110:
 596               		.size	twiRAW, .-twiRAW
 597               		.section	.text.lcdPrepare,"ax",@progbits
 598               	.global	lcdPrepare
 599               		.type	lcdPrepare, @function
 600               	lcdPrepare:
 601               	.LFB111:
 602               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 603               		.loc 2 490 0
 604               		.cfi_startproc
 605               	.LVL44:
 606               	/* prologue: function */
 607               	/* frame size = 0 */
 608               	/* stack size = 0 */
 609               	.L__stack_usage = 0
 610               	.LBB8:
 611               		.loc 2 491 0
 612 0000 2091 0000 		lds r18,lcdBackLight
 613 0004 982F      		mov r25,r24
 614 0006 907F      		andi r25,lo8(-16)
 615 0008 922B      		or r25,r18
 616               	.LVL45:
 617               		.loc 2 493 0
 618 000a 6111      		cpse r22,__zero_reg__
 619               		.loc 2 493 0 is_stmt 0 discriminator 1
 620 000c 9160      		ori r25,lo8(1)
GAS LISTING /tmp/ccB4vTv5.s 			page 20


 621               	.LVL46:
 622               	.L59:
 623               		.loc 2 494 0 is_stmt 1
 624 000e 9093 0000 		sts lcdBuffer,r25
 625 0012 9093 0000 		sts lcdBuffer+2,r25
 626               	.LVL47:
 627               		.loc 2 495 0
 628 0016 9460      		ori r25,lo8(4)
 629               	.LVL48:
 630               		.loc 2 496 0
 631 0018 9093 0000 		sts lcdBuffer+1,r25
 632               		.loc 2 498 0
 633 001c 30E1      		ldi r19,lo8(16)
 634 001e 839F      		mul r24,r19
 635 0020 C001      		movw r24,r0
 636 0022 1124      		clr __zero_reg__
 637               	.LVL49:
 638 0024 822B      		or r24,r18
 639               	.LVL50:
 640               		.loc 2 500 0
 641 0026 6111      		cpse r22,__zero_reg__
 642               		.loc 2 500 0 is_stmt 0 discriminator 1
 643 0028 8160      		ori r24,lo8(1)
 644               	.LVL51:
 645               	.L60:
 646               		.loc 2 501 0 is_stmt 1
 647 002a 8093 0000 		sts lcdBuffer+3,r24
 648 002e 8093 0000 		sts lcdBuffer+5,r24
 649               	.LVL52:
 650               		.loc 2 502 0
 651 0032 8460      		ori r24,lo8(4)
 652               	.LVL53:
 653               		.loc 2 503 0
 654 0034 8093 0000 		sts lcdBuffer+4,r24
 655 0038 0895      		ret
 656               	.LBE8:
 657               		.cfi_endproc
 658               	.LFE111:
 659               		.size	lcdPrepare, .-lcdPrepare
 660               		.section	.text.lcdWrite,"ax",@progbits
 661               	.global	lcdWrite
 662               		.type	lcdWrite, @function
 663               	lcdWrite:
 664               	.LFB112:
 665               		.loc 2 511 0
 666               		.cfi_startproc
 667               	.LVL54:
 668 0000 1F93      		push r17
 669               	.LCFI20:
 670               		.cfi_def_cfa_offset 4
 671               		.cfi_offset 17, -3
 672 0002 CF93      		push r28
 673               	.LCFI21:
 674               		.cfi_def_cfa_offset 5
 675               		.cfi_offset 28, -4
 676 0004 DF93      		push r29
 677               	.LCFI22:
GAS LISTING /tmp/ccB4vTv5.s 			page 21


 678               		.cfi_def_cfa_offset 6
 679               		.cfi_offset 29, -5
 680               	/* prologue: function */
 681               	/* frame size = 0 */
 682               	/* stack size = 3 */
 683               	.L__stack_usage = 3
 684 0006 162F      		mov r17,r22
 685               	.LVL55:
 686               	.LBB9:
 687               		.loc 2 515 0
 688 0008 2091 0000 		lds r18,twiMode
 689 000c 2260      		ori r18,lo8(2)
 690 000e 2093 0000 		sts twiMode,r18
 691               		.loc 2 516 0
 692 0012 C82F      		mov r28,r24
 693 0014 D92F      		mov r29,r25
 694 0016 180F      		add r17,r24
 695               	.LVL56:
 696               	.L68:
 697               		.loc 2 516 0 is_stmt 0 discriminator 1
 698 0018 1C17      		cp r17,r28
 699 001a 01F0      		breq .L70
 700               	.LVL57:
 701               		.loc 2 517 0 is_stmt 1
 702 001c 61E0      		ldi r22,lo8(1)
 703 001e 8991      		ld r24,Y+
 704               	.LVL58:
 705 0020 0E94 0000 		call lcdPrepare
 706               	.LVL59:
 707 0024 46E0      		ldi r20,lo8(6)
 708 0026 60E0      		ldi r22,lo8(lcdBuffer)
 709 0028 70E0      		ldi r23,hi8(lcdBuffer)
 710 002a 8091 0000 		lds r24,lcdAddress
 711 002e 0E94 0000 		call twiWrite
 712               	.LVL60:
 713 0032 85E0      		ldi r24,lo8(5)
 714 0034 90E0      		ldi r25,0
 715 0036 0E94 0000 		call time_delay16
 716               	.LVL61:
 717 003a 00C0      		rjmp .L68
 718               	.LVL62:
 719               	.L70:
 720               	/* epilogue start */
 721               	.LBE9:
 722               		.loc 2 518 0
 723 003c DF91      		pop r29
 724 003e CF91      		pop r28
 725               	.LVL63:
 726 0040 1F91      		pop r17
 727 0042 0895      		ret
 728               		.cfi_endproc
 729               	.LFE112:
 730               		.size	lcdWrite, .-lcdWrite
 731               		.section	.text.lcdInit,"ax",@progbits
 732               	.global	lcdInit
 733               		.type	lcdInit, @function
 734               	lcdInit:
GAS LISTING /tmp/ccB4vTv5.s 			page 22


 735               	.LFB113:
 736               		.loc 2 524 0
 737               		.cfi_startproc
 738               	/* prologue: function */
 739               	/* frame size = 0 */
 740               	/* stack size = 0 */
 741               	.L__stack_usage = 0
 742               		.loc 2 525 0
 743 0000 60E0      		ldi r22,0
 744 0002 8091 0000 		lds r24,lcdModes
 745 0006 0E94 0000 		call lcdPrepare
 746               	.LVL64:
 747 000a 46E0      		ldi r20,lo8(6)
 748 000c 60E0      		ldi r22,lo8(lcdBuffer)
 749 000e 70E0      		ldi r23,hi8(lcdBuffer)
 750 0010 8091 0000 		lds r24,lcdAddress
 751 0014 0E94 0000 		call twiWrite
 752               	.LVL65:
 753 0018 85E0      		ldi r24,lo8(5)
 754 001a 90E0      		ldi r25,0
 755 001c 0E94 0000 		call time_delay16
 756               	.LVL66:
 757               		.loc 2 526 0
 758 0020 60E0      		ldi r22,0
 759 0022 8091 0000 		lds r24,lcdShows
 760 0026 0E94 0000 		call lcdPrepare
 761               	.LVL67:
 762 002a 46E0      		ldi r20,lo8(6)
 763 002c 60E0      		ldi r22,lo8(lcdBuffer)
 764 002e 70E0      		ldi r23,hi8(lcdBuffer)
 765 0030 8091 0000 		lds r24,lcdAddress
 766 0034 0E94 0000 		call twiWrite
 767               	.LVL68:
 768 0038 85E0      		ldi r24,lo8(5)
 769 003a 90E0      		ldi r25,0
 770 003c 0E94 0000 		call time_delay16
 771               	.LVL69:
 772               		.loc 2 527 0
 773 0040 60E0      		ldi r22,0
 774 0042 8091 0000 		lds r24,lcdShifts
 775 0046 0E94 0000 		call lcdPrepare
 776               	.LVL70:
 777 004a 46E0      		ldi r20,lo8(6)
 778 004c 60E0      		ldi r22,lo8(lcdBuffer)
 779 004e 70E0      		ldi r23,hi8(lcdBuffer)
 780 0050 8091 0000 		lds r24,lcdAddress
 781 0054 0E94 0000 		call twiWrite
 782               	.LVL71:
 783 0058 85E0      		ldi r24,lo8(5)
 784 005a 90E0      		ldi r25,0
 785 005c 0E94 0000 		call time_delay16
 786               	.LVL72:
 787               		.loc 2 528 0
 788 0060 60E0      		ldi r22,0
 789 0062 81E0      		ldi r24,lo8(1)
 790 0064 0E94 0000 		call lcdPrepare
 791               	.LVL73:
GAS LISTING /tmp/ccB4vTv5.s 			page 23


 792 0068 46E0      		ldi r20,lo8(6)
 793 006a 60E0      		ldi r22,lo8(lcdBuffer)
 794 006c 70E0      		ldi r23,hi8(lcdBuffer)
 795 006e 8091 0000 		lds r24,lcdAddress
 796 0072 0E94 0000 		call twiWrite
 797               	.LVL74:
 798 0076 85E0      		ldi r24,lo8(5)
 799 0078 90E0      		ldi r25,0
 800 007a 0E94 0000 		call time_delay16
 801               	.LVL75:
 802 007e 80E1      		ldi r24,lo8(16)
 803 0080 90E0      		ldi r25,0
 804 0082 0E94 0000 		call time_delay16
 805               	.LVL76:
 806               		.loc 2 529 0
 807 0086 60E0      		ldi r22,0
 808 0088 82E0      		ldi r24,lo8(2)
 809 008a 0E94 0000 		call lcdPrepare
 810               	.LVL77:
 811 008e 46E0      		ldi r20,lo8(6)
 812 0090 60E0      		ldi r22,lo8(lcdBuffer)
 813 0092 70E0      		ldi r23,hi8(lcdBuffer)
 814 0094 8091 0000 		lds r24,lcdAddress
 815 0098 0E94 0000 		call twiWrite
 816               	.LVL78:
 817 009c 85E0      		ldi r24,lo8(5)
 818 009e 90E0      		ldi r25,0
 819 00a0 0C94 0000 		jmp time_delay16
 820               	.LVL79:
 821               		.cfi_endproc
 822               	.LFE113:
 823               		.size	lcdInit, .-lcdInit
 824               		.section	.text.lcdSetup,"ax",@progbits
 825               	.global	lcdSetup
 826               		.type	lcdSetup, @function
 827               	lcdSetup:
 828               	.LFB114:
 829               		.loc 2 536 0
 830               		.cfi_startproc
 831               	.LVL80:
 832 0000 CF93      		push r28
 833               	.LCFI23:
 834               		.cfi_def_cfa_offset 4
 835               		.cfi_offset 28, -3
 836               	/* prologue: function */
 837               	/* frame size = 0 */
 838               	/* stack size = 1 */
 839               	.L__stack_usage = 1
 840 0002 C42F      		mov r28,r20
 841               		.loc 2 537 0
 842 0004 8093 0000 		sts lcdAddress,r24
 843               		.loc 2 538 0
 844 0008 6093 0000 		sts lcdCols,r22
 845               		.loc 2 539 0
 846 000c 4093 0000 		sts lcdRows,r20
 847               		.loc 2 540 0
 848 0010 2223      		tst r18
GAS LISTING /tmp/ccB4vTv5.s 			page 24


 849 0012 01F0      		breq .L75
 850 0014 88E0      		ldi r24,lo8(8)
 851               	.LVL81:
 852 0016 00C0      		rjmp .L73
 853               	.LVL82:
 854               	.L75:
 855 0018 80E0      		ldi r24,0
 856               	.LVL83:
 857               	.L73:
 858               		.loc 2 540 0 is_stmt 0 discriminator 3
 859 001a 8093 0000 		sts lcdBackLight,r24
 860               		.loc 2 541 0 is_stmt 1 discriminator 3
 861 001e 80E2      		ldi r24,lo8(32)
 862 0020 8093 0000 		sts lcdModes,r24
 863               		.loc 2 542 0 discriminator 3
 864 0024 86E0      		ldi r24,lo8(6)
 865 0026 8093 0000 		sts lcdShifts,r24
 866               		.loc 2 543 0 discriminator 3
 867 002a 8CE0      		ldi r24,lo8(12)
 868 002c 8093 0000 		sts lcdShows,r24
 869               		.loc 2 547 0 discriminator 3
 870 0030 46E0      		ldi r20,lo8(6)
 871               	.LVL84:
 872 0032 60EA      		ldi r22,lo8(-96)
 873 0034 76E8      		ldi r23,lo8(-122)
 874 0036 81E0      		ldi r24,lo8(1)
 875 0038 90E0      		ldi r25,0
 876               	.LVL85:
 877 003a 0E94 0000 		call twiSetup
 878               	.LVL86:
 879               		.loc 2 551 0 discriminator 3
 880 003e C230      		cpi r28,lo8(2)
 881 0040 00F0      		brlo .L74
 882               		.loc 2 551 0 is_stmt 0 discriminator 1
 883 0042 8091 0000 		lds r24,lcdModes
 884 0046 8860      		ori r24,lo8(8)
 885 0048 8093 0000 		sts lcdModes,r24
 886               	.L74:
 887               		.loc 2 555 0 is_stmt 1
 888 004c 60E0      		ldi r22,0
 889 004e 80E3      		ldi r24,lo8(48)
 890 0050 0E94 0000 		call lcdPrepare
 891               	.LVL87:
 892               		.loc 2 557 0
 893 0054 8FE0      		ldi r24,lo8(15)
 894 0056 90E0      		ldi r25,0
 895 0058 0E94 0000 		call time_delay16
 896               	.LVL88:
 897               		.loc 2 558 0
 898 005c 43E0      		ldi r20,lo8(3)
 899 005e 60E0      		ldi r22,lo8(lcdBuffer)
 900 0060 70E0      		ldi r23,hi8(lcdBuffer)
 901 0062 8091 0000 		lds r24,lcdAddress
 902 0066 0E94 0000 		call twiWrite
 903               	.LVL89:
 904 006a 85E0      		ldi r24,lo8(5)
 905 006c 90E0      		ldi r25,0
GAS LISTING /tmp/ccB4vTv5.s 			page 25


 906 006e 0E94 0000 		call time_delay16
 907               	.LVL90:
 908               		.loc 2 559 0
 909 0072 85E0      		ldi r24,lo8(5)
 910 0074 90E0      		ldi r25,0
 911 0076 0E94 0000 		call time_delay16
 912               	.LVL91:
 913               		.loc 2 560 0
 914 007a 43E0      		ldi r20,lo8(3)
 915 007c 60E0      		ldi r22,lo8(lcdBuffer)
 916 007e 70E0      		ldi r23,hi8(lcdBuffer)
 917 0080 8091 0000 		lds r24,lcdAddress
 918 0084 0E94 0000 		call twiWrite
 919               	.LVL92:
 920 0088 85E0      		ldi r24,lo8(5)
 921 008a 90E0      		ldi r25,0
 922 008c 0E94 0000 		call time_delay16
 923               	.LVL93:
 924               		.loc 2 561 0
 925 0090 80E9      		ldi r24,lo8(-112)
 926 0092 91E0      		ldi r25,lo8(1)
 927               	/* #APP */
 928               	 ;  561 "LCD1602ex.ino" 1
 929 0094 0197      		1: sbiw r24,1 
 930 0096 01F4      		brne 1b
 931               		
 932               	 ;  0 "" 2
 933               		.loc 2 562 0
 934               	/* #NOAPP */
 935 0098 43E0      		ldi r20,lo8(3)
 936 009a 60E0      		ldi r22,lo8(lcdBuffer)
 937 009c 70E0      		ldi r23,hi8(lcdBuffer)
 938 009e 8091 0000 		lds r24,lcdAddress
 939 00a2 0E94 0000 		call twiWrite
 940               	.LVL94:
 941 00a6 85E0      		ldi r24,lo8(5)
 942 00a8 90E0      		ldi r25,0
 943 00aa 0E94 0000 		call time_delay16
 944               	.LVL95:
 945               		.loc 2 564 0
 946 00ae 60E0      		ldi r22,0
 947 00b0 80E2      		ldi r24,lo8(32)
 948 00b2 0E94 0000 		call lcdPrepare
 949               	.LVL96:
 950               		.loc 2 565 0
 951 00b6 43E0      		ldi r20,lo8(3)
 952 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 953 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 954 00bc 8091 0000 		lds r24,lcdAddress
 955 00c0 0E94 0000 		call twiWrite
 956               	.LVL97:
 957 00c4 85E0      		ldi r24,lo8(5)
 958 00c6 90E0      		ldi r25,0
 959 00c8 0E94 0000 		call time_delay16
 960               	.LVL98:
 961               		.loc 2 567 0
 962 00cc 0E94 0000 		call lcdInit
GAS LISTING /tmp/ccB4vTv5.s 			page 26


 963               	.LVL99:
 964               		.loc 2 568 0
 965 00d0 84EF      		ldi r24,lo8(-12)
 966 00d2 91E0      		ldi r25,lo8(1)
 967               	/* epilogue start */
 968               		.loc 2 569 0
 969 00d4 CF91      		pop r28
 970               	.LVL100:
 971               		.loc 2 568 0
 972 00d6 0C94 0000 		jmp time_delay16
 973               	.LVL101:
 974               		.cfi_endproc
 975               	.LFE114:
 976               		.size	lcdSetup, .-lcdSetup
 977               		.section	.rodata.str1.1,"aMS",@progbits,1
 978               	.LC0:
 979 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 979      6F2C 2041 
 979      4141 4141 
 979      4100 
 980               		.section	.text.setup,"ax",@progbits
 981               	.global	setup
 982               		.type	setup, @function
 983               	setup:
 984               	.LFB115:
 985               		.loc 2 577 0
 986               		.cfi_startproc
 987               	/* prologue: function */
 988               	/* frame size = 0 */
 989               	/* stack size = 0 */
 990               	.L__stack_usage = 0
 991               	.LBB10:
 992               		.loc 2 581 0
 993 0000 21E0      		ldi r18,lo8(1)
 994 0002 42E0      		ldi r20,lo8(2)
 995 0004 60E1      		ldi r22,lo8(16)
 996 0006 87E2      		ldi r24,lo8(39)
 997 0008 0E94 0000 		call lcdSetup
 998               	.LVL102:
 999               		.loc 2 582 0
 1000 000c 6DE0      		ldi r22,lo8(13)
 1001 000e 80E0      		ldi r24,lo8(.LC0)
 1002 0010 90E0      		ldi r25,hi8(.LC0)
 1003 0012 0C94 0000 		jmp lcdWrite
 1004               	.LVL103:
 1005               	.LBE10:
 1006               		.cfi_endproc
 1007               	.LFE115:
 1008               		.size	setup, .-setup
 1009               		.section	.text.loop,"ax",@progbits
 1010               	.global	loop
 1011               		.type	loop, @function
 1012               	loop:
 1013               	.LFB116:
 1014               		.loc 2 588 0
 1015               		.cfi_startproc
 1016               	/* prologue: function */
GAS LISTING /tmp/ccB4vTv5.s 			page 27


 1017               	/* frame size = 0 */
 1018               	/* stack size = 0 */
 1019               	.L__stack_usage = 0
 1020 0000 0895      		ret
 1021               		.cfi_endproc
 1022               	.LFE116:
 1023               		.size	loop, .-loop
 1024               	.global	lcdBuffer
 1025               		.section	.bss.lcdBuffer,"aw",@nobits
 1026               		.type	lcdBuffer, @object
 1027               		.size	lcdBuffer, 6
 1028               	lcdBuffer:
 1029 0000 0000 0000 		.zero	6
 1029      0000 
 1030               	.global	lcdRows
 1031               		.section	.data.lcdRows,"aw",@progbits
 1032               		.type	lcdRows, @object
 1033               		.size	lcdRows, 1
 1034               	lcdRows:
 1035 0000 02        		.byte	2
 1036               	.global	lcdCols
 1037               		.section	.data.lcdCols,"aw",@progbits
 1038               		.type	lcdCols, @object
 1039               		.size	lcdCols, 1
 1040               	lcdCols:
 1041 0000 10        		.byte	16
 1042               	.global	lcdAddress
 1043               		.section	.data.lcdAddress,"aw",@progbits
 1044               		.type	lcdAddress, @object
 1045               		.size	lcdAddress, 1
 1046               	lcdAddress:
 1047 0000 27        		.byte	39
 1048               	.global	lcdBackLight
 1049               		.section	.data.lcdBackLight,"aw",@progbits
 1050               		.type	lcdBackLight, @object
 1051               		.size	lcdBackLight, 1
 1052               	lcdBackLight:
 1053 0000 08        		.byte	8
 1054               	.global	lcdShows
 1055               		.section	.data.lcdShows,"aw",@progbits
 1056               		.type	lcdShows, @object
 1057               		.size	lcdShows, 1
 1058               	lcdShows:
 1059 0000 08        		.byte	8
 1060               	.global	lcdShifts
 1061               		.section	.data.lcdShifts,"aw",@progbits
 1062               		.type	lcdShifts, @object
 1063               		.size	lcdShifts, 1
 1064               	lcdShifts:
 1065 0000 06        		.byte	6
 1066               	.global	lcdModes
 1067               		.section	.data.lcdModes,"aw",@progbits
 1068               		.type	lcdModes, @object
 1069               		.size	lcdModes, 1
 1070               	lcdModes:
 1071 0000 30        		.byte	48
 1072               		.section	.bss._ZL12twiStatistic,"aw",@nobits
GAS LISTING /tmp/ccB4vTv5.s 			page 28


 1073               		.type	_ZL12twiStatistic, @object
 1074               		.size	_ZL12twiStatistic, 20
 1075               	_ZL12twiStatistic:
 1076 0000 0000 0000 		.zero	20
 1076      0000 0000 
 1076      0000 0000 
 1076      0000 0000 
 1076      0000 0000 
 1077               	.global	twiSlaveWriter
 1078               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1079               		.type	twiSlaveWriter, @object
 1080               		.size	twiSlaveWriter, 2
 1081               	twiSlaveWriter:
 1082 0000 0000      		.zero	2
 1083               	.global	twiSlaveReader
 1084               		.section	.bss.twiSlaveReader,"aw",@nobits
 1085               		.type	twiSlaveReader, @object
 1086               		.size	twiSlaveReader, 2
 1087               	twiSlaveReader:
 1088 0000 0000      		.zero	2
 1089               	.global	twiMasterReader
 1090               		.section	.bss.twiMasterReader,"aw",@nobits
 1091               		.type	twiMasterReader, @object
 1092               		.size	twiMasterReader, 2
 1093               	twiMasterReader:
 1094 0000 0000      		.zero	2
 1095               	.global	twiHookRestart
 1096               		.section	.bss.twiHookRestart,"aw",@nobits
 1097               		.type	twiHookRestart, @object
 1098               		.size	twiHookRestart, 2
 1099               	twiHookRestart:
 1100 0000 0000      		.zero	2
 1101               	.global	twiST_Ptr
 1102               		.section	.bss.twiST_Ptr,"aw",@nobits
 1103               		.type	twiST_Ptr, @object
 1104               		.size	twiST_Ptr, 2
 1105               	twiST_Ptr:
 1106 0000 0000      		.zero	2
 1107               	.global	twiST_Count
 1108               		.section	.bss.twiST_Count,"aw",@nobits
 1109               		.type	twiST_Count, @object
 1110               		.size	twiST_Count, 1
 1111               	twiST_Count:
 1112 0000 00        		.zero	1
 1113               	.global	twiRX_Ptr
 1114               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1115               		.type	twiRX_Ptr, @object
 1116               		.size	twiRX_Ptr, 2
 1117               	twiRX_Ptr:
 1118 0000 0000      		.zero	2
 1119               	.global	twiRX_Count
 1120               		.section	.bss.twiRX_Count,"aw",@nobits
 1121               		.type	twiRX_Count, @object
 1122               		.size	twiRX_Count, 1
 1123               	twiRX_Count:
 1124 0000 00        		.zero	1
 1125               	.global	twiMT_Ptr
GAS LISTING /tmp/ccB4vTv5.s 			page 29


 1126               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1127               		.type	twiMT_Ptr, @object
 1128               		.size	twiMT_Ptr, 2
 1129               	twiMT_Ptr:
 1130 0000 0000      		.zero	2
 1131               	.global	twiMT_Count
 1132               		.section	.bss.twiMT_Count,"aw",@nobits
 1133               		.type	twiMT_Count, @object
 1134               		.size	twiMT_Count, 1
 1135               	twiMT_Count:
 1136 0000 00        		.zero	1
 1137               	.global	twiSLARW
 1138               		.section	.bss.twiSLARW,"aw",@nobits
 1139               		.type	twiSLARW, @object
 1140               		.size	twiSLARW, 1
 1141               	twiSLARW:
 1142 0000 00        		.zero	1
 1143               	.global	twiState
 1144               		.section	.bss.twiState,"aw",@nobits
 1145               		.type	twiState, @object
 1146               		.size	twiState, 1
 1147               	twiState:
 1148 0000 00        		.zero	1
 1149               	.global	twiMode
 1150               		.section	.bss.twiMode,"aw",@nobits
 1151               		.type	twiMode, @object
 1152               		.size	twiMode, 1
 1153               	twiMode:
 1154 0000 00        		.zero	1
 1155               		.text
 1156               	.Letext0:
 1157               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1158               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1159               		.section	.debug_info,"",@progbits
 1160               	.Ldebug_info0:
 1161 0000 490B 0000 		.long	0xb49
 1162 0004 0200      		.word	0x2
 1163 0006 0000 0000 		.long	.Ldebug_abbrev0
 1164 000a 04        		.byte	0x4
 1165 000b 01        		.uleb128 0x1
 1166 000c 0000 0000 		.long	.LASF76
 1167 0010 04        		.byte	0x4
 1168 0011 0000 0000 		.long	.LASF77
 1169 0015 0000 0000 		.long	.LASF78
 1170 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1171 001d 0000 0000 		.long	0
 1172 0021 0000 0000 		.long	0
 1173 0025 0000 0000 		.long	.Ldebug_line0
 1174 0029 02        		.uleb128 0x2
 1175 002a 01        		.byte	0x1
 1176 002b 06        		.byte	0x6
 1177 002c 0000 0000 		.long	.LASF0
 1178 0030 03        		.uleb128 0x3
 1179 0031 0000 0000 		.long	.LASF2
 1180 0035 03        		.byte	0x3
 1181 0036 7A        		.byte	0x7a
 1182 0037 3B00 0000 		.long	0x3b
GAS LISTING /tmp/ccB4vTv5.s 			page 30


 1183 003b 02        		.uleb128 0x2
 1184 003c 01        		.byte	0x1
 1185 003d 08        		.byte	0x8
 1186 003e 0000 0000 		.long	.LASF1
 1187 0042 04        		.uleb128 0x4
 1188 0043 02        		.byte	0x2
 1189 0044 05        		.byte	0x5
 1190 0045 696E 7400 		.string	"int"
 1191 0049 03        		.uleb128 0x3
 1192 004a 0000 0000 		.long	.LASF3
 1193 004e 03        		.byte	0x3
 1194 004f 7C        		.byte	0x7c
 1195 0050 5400 0000 		.long	0x54
 1196 0054 02        		.uleb128 0x2
 1197 0055 02        		.byte	0x2
 1198 0056 07        		.byte	0x7
 1199 0057 0000 0000 		.long	.LASF4
 1200 005b 02        		.uleb128 0x2
 1201 005c 04        		.byte	0x4
 1202 005d 05        		.byte	0x5
 1203 005e 0000 0000 		.long	.LASF5
 1204 0062 03        		.uleb128 0x3
 1205 0063 0000 0000 		.long	.LASF6
 1206 0067 03        		.byte	0x3
 1207 0068 7E        		.byte	0x7e
 1208 0069 6D00 0000 		.long	0x6d
 1209 006d 02        		.uleb128 0x2
 1210 006e 04        		.byte	0x4
 1211 006f 07        		.byte	0x7
 1212 0070 0000 0000 		.long	.LASF7
 1213 0074 02        		.uleb128 0x2
 1214 0075 08        		.byte	0x8
 1215 0076 05        		.byte	0x5
 1216 0077 0000 0000 		.long	.LASF8
 1217 007b 02        		.uleb128 0x2
 1218 007c 08        		.byte	0x8
 1219 007d 07        		.byte	0x7
 1220 007e 0000 0000 		.long	.LASF9
 1221 0082 02        		.uleb128 0x2
 1222 0083 01        		.byte	0x1
 1223 0084 02        		.byte	0x2
 1224 0085 0000 0000 		.long	.LASF10
 1225 0089 05        		.uleb128 0x5
 1226 008a 02        		.byte	0x2
 1227 008b 8F00 0000 		.long	0x8f
 1228 008f 06        		.uleb128 0x6
 1229 0090 02        		.uleb128 0x2
 1230 0091 01        		.byte	0x1
 1231 0092 06        		.byte	0x6
 1232 0093 0000 0000 		.long	.LASF11
 1233 0097 02        		.uleb128 0x2
 1234 0098 04        		.byte	0x4
 1235 0099 04        		.byte	0x4
 1236 009a 0000 0000 		.long	.LASF12
 1237 009e 02        		.uleb128 0x2
 1238 009f 04        		.byte	0x4
 1239 00a0 04        		.byte	0x4
GAS LISTING /tmp/ccB4vTv5.s 			page 31


 1240 00a1 0000 0000 		.long	.LASF13
 1241 00a5 02        		.uleb128 0x2
 1242 00a6 02        		.byte	0x2
 1243 00a7 07        		.byte	0x7
 1244 00a8 0000 0000 		.long	.LASF14
 1245 00ac 07        		.uleb128 0x7
 1246 00ad 0000 0000 		.long	.LASF79
 1247 00b1 02        		.byte	0x2
 1248 00b2 01        		.byte	0x1
 1249 00b3 8C        		.byte	0x8c
 1250 00b4 CB00 0000 		.long	0xcb
 1251 00b8 08        		.uleb128 0x8
 1252 00b9 0000 0000 		.long	.LASF15
 1253 00bd 01        		.sleb128 1
 1254 00be 08        		.uleb128 0x8
 1255 00bf 0000 0000 		.long	.LASF16
 1256 00c3 02        		.sleb128 2
 1257 00c4 08        		.uleb128 0x8
 1258 00c5 0000 0000 		.long	.LASF17
 1259 00c9 04        		.sleb128 4
 1260 00ca 00        		.byte	0
 1261 00cb 09        		.uleb128 0x9
 1262 00cc 14        		.byte	0x14
 1263 00cd 01        		.byte	0x1
 1264 00ce A6        		.byte	0xa6
 1265 00cf 0000 0000 		.long	.LASF80
 1266 00d3 6401 0000 		.long	0x164
 1267 00d7 0A        		.uleb128 0xa
 1268 00d8 0000 0000 		.long	.LASF18
 1269 00dc 01        		.byte	0x1
 1270 00dd A7        		.byte	0xa7
 1271 00de 4900 0000 		.long	0x49
 1272 00e2 02        		.byte	0x2
 1273 00e3 23        		.byte	0x23
 1274 00e4 00        		.uleb128 0
 1275 00e5 0A        		.uleb128 0xa
 1276 00e6 0000 0000 		.long	.LASF19
 1277 00ea 01        		.byte	0x1
 1278 00eb A7        		.byte	0xa7
 1279 00ec 4900 0000 		.long	0x49
 1280 00f0 02        		.byte	0x2
 1281 00f1 23        		.byte	0x23
 1282 00f2 02        		.uleb128 0x2
 1283 00f3 0A        		.uleb128 0xa
 1284 00f4 0000 0000 		.long	.LASF20
 1285 00f8 01        		.byte	0x1
 1286 00f9 A7        		.byte	0xa7
 1287 00fa 4900 0000 		.long	0x49
 1288 00fe 02        		.byte	0x2
 1289 00ff 23        		.byte	0x23
 1290 0100 04        		.uleb128 0x4
 1291 0101 0A        		.uleb128 0xa
 1292 0102 0000 0000 		.long	.LASF21
 1293 0106 01        		.byte	0x1
 1294 0107 A7        		.byte	0xa7
 1295 0108 4900 0000 		.long	0x49
 1296 010c 02        		.byte	0x2
GAS LISTING /tmp/ccB4vTv5.s 			page 32


 1297 010d 23        		.byte	0x23
 1298 010e 06        		.uleb128 0x6
 1299 010f 0A        		.uleb128 0xa
 1300 0110 0000 0000 		.long	.LASF22
 1301 0114 01        		.byte	0x1
 1302 0115 A7        		.byte	0xa7
 1303 0116 4900 0000 		.long	0x49
 1304 011a 02        		.byte	0x2
 1305 011b 23        		.byte	0x23
 1306 011c 08        		.uleb128 0x8
 1307 011d 0B        		.uleb128 0xb
 1308 011e 6D74 7800 		.string	"mtx"
 1309 0122 01        		.byte	0x1
 1310 0123 A7        		.byte	0xa7
 1311 0124 4900 0000 		.long	0x49
 1312 0128 02        		.byte	0x2
 1313 0129 23        		.byte	0x23
 1314 012a 0A        		.uleb128 0xa
 1315 012b 0B        		.uleb128 0xb
 1316 012c 6D72 7800 		.string	"mrx"
 1317 0130 01        		.byte	0x1
 1318 0131 A7        		.byte	0xa7
 1319 0132 4900 0000 		.long	0x49
 1320 0136 02        		.byte	0x2
 1321 0137 23        		.byte	0x23
 1322 0138 0C        		.uleb128 0xc
 1323 0139 0B        		.uleb128 0xb
 1324 013a 7372 7800 		.string	"srx"
 1325 013e 01        		.byte	0x1
 1326 013f A7        		.byte	0xa7
 1327 0140 4900 0000 		.long	0x49
 1328 0144 02        		.byte	0x2
 1329 0145 23        		.byte	0x23
 1330 0146 0E        		.uleb128 0xe
 1331 0147 0B        		.uleb128 0xb
 1332 0148 6772 7800 		.string	"grx"
 1333 014c 01        		.byte	0x1
 1334 014d A7        		.byte	0xa7
 1335 014e 4900 0000 		.long	0x49
 1336 0152 02        		.byte	0x2
 1337 0153 23        		.byte	0x23
 1338 0154 10        		.uleb128 0x10
 1339 0155 0B        		.uleb128 0xb
 1340 0156 7374 7800 		.string	"stx"
 1341 015a 01        		.byte	0x1
 1342 015b A7        		.byte	0xa7
 1343 015c 4900 0000 		.long	0x49
 1344 0160 02        		.byte	0x2
 1345 0161 23        		.byte	0x23
 1346 0162 12        		.uleb128 0x12
 1347 0163 00        		.byte	0
 1348 0164 03        		.uleb128 0x3
 1349 0165 0000 0000 		.long	.LASF23
 1350 0169 01        		.byte	0x1
 1351 016a A8        		.byte	0xa8
 1352 016b CB00 0000 		.long	0xcb
 1353 016f 05        		.uleb128 0x5
GAS LISTING /tmp/ccB4vTv5.s 			page 33


 1354 0170 02        		.byte	0x2
 1355 0171 3000 0000 		.long	0x30
 1356 0175 0C        		.uleb128 0xc
 1357 0176 01        		.byte	0x1
 1358 0177 0000 0000 		.long	.LASF81
 1359 017b 01        		.byte	0x1
 1360 017c EF        		.byte	0xef
 1361 017d 01        		.byte	0x1
 1362 017e 8E01 0000 		.long	0x18e
 1363 0182 0D        		.uleb128 0xd
 1364 0183 5F6D 6400 		.string	"_md"
 1365 0187 01        		.byte	0x1
 1366 0188 EF        		.byte	0xef
 1367 0189 3000 0000 		.long	0x30
 1368 018d 00        		.byte	0
 1369 018e 0E        		.uleb128 0xe
 1370 018f 01        		.byte	0x1
 1371 0190 0000 0000 		.long	.LASF26
 1372 0194 01        		.byte	0x1
 1373 0195 B7        		.byte	0xb7
 1374 0196 0000 0000 		.long	.LFB102
 1375 019a 0000 0000 		.long	.LFE102
 1376 019e 03        		.byte	0x3
 1377 019f 92        		.byte	0x92
 1378 01a0 20        		.uleb128 0x20
 1379 01a1 03        		.sleb128 3
 1380 01a2 01        		.byte	0x1
 1381 01a3 E201 0000 		.long	0x1e2
 1382 01a7 0F        		.uleb128 0xf
 1383 01a8 0000 0000 		.long	.LASF28
 1384 01ac 01        		.byte	0x1
 1385 01ad B7        		.byte	0xb7
 1386 01ae 6200 0000 		.long	0x62
 1387 01b2 0000 0000 		.long	.LLST0
 1388 01b6 10        		.uleb128 0x10
 1389 01b7 0000 0000 		.long	.LBB2
 1390 01bb 0000 0000 		.long	.LBE2
 1391 01bf 11        		.uleb128 0x11
 1392 01c0 0000 0000 		.long	.LASF24
 1393 01c4 01        		.byte	0x1
 1394 01c5 B9        		.byte	0xb9
 1395 01c6 4900 0000 		.long	0x49
 1396 01ca 06        		.byte	0x6
 1397 01cb 62        		.byte	0x62
 1398 01cc 93        		.byte	0x93
 1399 01cd 01        		.uleb128 0x1
 1400 01ce 63        		.byte	0x63
 1401 01cf 93        		.byte	0x93
 1402 01d0 01        		.uleb128 0x1
 1403 01d1 12        		.uleb128 0x12
 1404 01d2 0000 0000 		.long	.LASF25
 1405 01d6 01        		.byte	0x1
 1406 01d7 BA        		.byte	0xba
 1407 01d8 3000 0000 		.long	0x30
 1408 01dc 0000 0000 		.long	.LLST1
 1409 01e0 00        		.byte	0
 1410 01e1 00        		.byte	0
GAS LISTING /tmp/ccB4vTv5.s 			page 34


 1411 01e2 13        		.uleb128 0x13
 1412 01e3 01        		.byte	0x1
 1413 01e4 0000 0000 		.long	.LASF27
 1414 01e8 01        		.byte	0x1
 1415 01e9 C8        		.byte	0xc8
 1416 01ea 0000 0000 		.long	.LFB103
 1417 01ee 0000 0000 		.long	.LFE103
 1418 01f2 0000 0000 		.long	.LLST2
 1419 01f6 01        		.byte	0x1
 1420 01f7 3602 0000 		.long	0x236
 1421 01fb 0F        		.uleb128 0xf
 1422 01fc 0000 0000 		.long	.LASF28
 1423 0200 01        		.byte	0x1
 1424 0201 C8        		.byte	0xc8
 1425 0202 6200 0000 		.long	0x62
 1426 0206 0000 0000 		.long	.LLST3
 1427 020a 0F        		.uleb128 0xf
 1428 020b 0000 0000 		.long	.LASF29
 1429 020f 01        		.byte	0x1
 1430 0210 C8        		.byte	0xc8
 1431 0211 3000 0000 		.long	0x30
 1432 0215 0000 0000 		.long	.LLST4
 1433 0219 14        		.uleb128 0x14
 1434 021a 0000 0000 		.long	.LVL10
 1435 021e 8E01 0000 		.long	0x18e
 1436 0222 15        		.uleb128 0x15
 1437 0223 0C        		.byte	0xc
 1438 0224 66        		.byte	0x66
 1439 0225 93        		.byte	0x93
 1440 0226 01        		.uleb128 0x1
 1441 0227 67        		.byte	0x67
 1442 0228 93        		.byte	0x93
 1443 0229 01        		.uleb128 0x1
 1444 022a 68        		.byte	0x68
 1445 022b 93        		.byte	0x93
 1446 022c 01        		.uleb128 0x1
 1447 022d 69        		.byte	0x69
 1448 022e 93        		.byte	0x93
 1449 022f 01        		.uleb128 0x1
 1450 0230 03        		.byte	0x3
 1451 0231 F3        		.byte	0xf3
 1452 0232 01        		.uleb128 0x1
 1453 0233 66        		.byte	0x66
 1454 0234 00        		.byte	0
 1455 0235 00        		.byte	0
 1456 0236 16        		.uleb128 0x16
 1457 0237 7501 0000 		.long	0x175
 1458 023b 0000 0000 		.long	.LFB104
 1459 023f 0000 0000 		.long	.LFE104
 1460 0243 0000 0000 		.long	.LLST5
 1461 0247 01        		.byte	0x1
 1462 0248 6902 0000 		.long	0x269
 1463 024c 17        		.uleb128 0x17
 1464 024d 8201 0000 		.long	0x182
 1465 0251 0000 0000 		.long	.LLST6
 1466 0255 10        		.uleb128 0x10
 1467 0256 0000 0000 		.long	.LBB5
GAS LISTING /tmp/ccB4vTv5.s 			page 35


 1468 025a 0000 0000 		.long	.LBE5
 1469 025e 17        		.uleb128 0x17
 1470 025f 8201 0000 		.long	0x182
 1471 0263 0000 0000 		.long	.LLST7
 1472 0267 00        		.byte	0
 1473 0268 00        		.byte	0
 1474 0269 18        		.uleb128 0x18
 1475 026a 01        		.byte	0x1
 1476 026b 0000 0000 		.long	.LASF30
 1477 026f 01        		.byte	0x1
 1478 0270 0401      		.word	0x104
 1479 0272 0000 0000 		.long	.LFB105
 1480 0276 0000 0000 		.long	.LFE105
 1481 027a 0000 0000 		.long	.LLST8
 1482 027e 01        		.byte	0x1
 1483 027f C702 0000 		.long	0x2c7
 1484 0283 10        		.uleb128 0x10
 1485 0284 0000 0000 		.long	.LBB7
 1486 0288 0000 0000 		.long	.LBE7
 1487 028c 19        		.uleb128 0x19
 1488 028d 5F63 7200 		.string	"_cr"
 1489 0291 01        		.byte	0x1
 1490 0292 0601      		.word	0x106
 1491 0294 3000 0000 		.long	0x30
 1492 0298 0000 0000 		.long	.LLST9
 1493 029c 19        		.uleb128 0x19
 1494 029d 5F6D 6400 		.string	"_md"
 1495 02a1 01        		.byte	0x1
 1496 02a2 0701      		.word	0x107
 1497 02a4 3000 0000 		.long	0x30
 1498 02a8 0000 0000 		.long	.LLST10
 1499 02ac 19        		.uleb128 0x19
 1500 02ad 5F73 7400 		.string	"_st"
 1501 02b1 01        		.byte	0x1
 1502 02b2 0801      		.word	0x108
 1503 02b4 3000 0000 		.long	0x30
 1504 02b8 0000 0000 		.long	.LLST11
 1505 02bc 1A        		.uleb128 0x1a
 1506 02bd 0000 0000 		.long	.LVL26
 1507 02c1 7501 0000 		.long	0x175
 1508 02c5 00        		.byte	0
 1509 02c6 00        		.byte	0
 1510 02c7 1B        		.uleb128 0x1b
 1511 02c8 01        		.byte	0x1
 1512 02c9 0000 0000 		.long	.LASF31
 1513 02cd 01        		.byte	0x1
 1514 02ce 8F01      		.word	0x18f
 1515 02d0 0000 0000 		.long	.LFB106
 1516 02d4 0000 0000 		.long	.LFE106
 1517 02d8 03        		.byte	0x3
 1518 02d9 92        		.byte	0x92
 1519 02da 20        		.uleb128 0x20
 1520 02db 03        		.sleb128 3
 1521 02dc 01        		.byte	0x1
 1522 02dd F202 0000 		.long	0x2f2
 1523 02e1 1C        		.uleb128 0x1c
 1524 02e2 0000 0000 		.long	.LASF32
GAS LISTING /tmp/ccB4vTv5.s 			page 36


 1525 02e6 01        		.byte	0x1
 1526 02e7 8F01      		.word	0x18f
 1527 02e9 3000 0000 		.long	0x30
 1528 02ed 0000 0000 		.long	.LLST12
 1529 02f1 00        		.byte	0
 1530 02f2 1B        		.uleb128 0x1b
 1531 02f3 01        		.byte	0x1
 1532 02f4 0000 0000 		.long	.LASF33
 1533 02f8 01        		.byte	0x1
 1534 02f9 9B01      		.word	0x19b
 1535 02fb 0000 0000 		.long	.LFB107
 1536 02ff 0000 0000 		.long	.LFE107
 1537 0303 03        		.byte	0x3
 1538 0304 92        		.byte	0x92
 1539 0305 20        		.uleb128 0x20
 1540 0306 03        		.sleb128 3
 1541 0307 01        		.byte	0x1
 1542 0308 1D03 0000 		.long	0x31d
 1543 030c 1C        		.uleb128 0x1c
 1544 030d 0000 0000 		.long	.LASF32
 1545 0311 01        		.byte	0x1
 1546 0312 9B01      		.word	0x19b
 1547 0314 3000 0000 		.long	0x30
 1548 0318 0000 0000 		.long	.LLST13
 1549 031c 00        		.byte	0
 1550 031d 1B        		.uleb128 0x1b
 1551 031e 01        		.byte	0x1
 1552 031f 0000 0000 		.long	.LASF34
 1553 0323 01        		.byte	0x1
 1554 0324 AD01      		.word	0x1ad
 1555 0326 0000 0000 		.long	.LFB108
 1556 032a 0000 0000 		.long	.LFE108
 1557 032e 03        		.byte	0x3
 1558 032f 92        		.byte	0x92
 1559 0330 20        		.uleb128 0x20
 1560 0331 03        		.sleb128 3
 1561 0332 01        		.byte	0x1
 1562 0333 7C03 0000 		.long	0x37c
 1563 0337 1C        		.uleb128 0x1c
 1564 0338 0000 0000 		.long	.LASF32
 1565 033c 01        		.byte	0x1
 1566 033d AD01      		.word	0x1ad
 1567 033f 3000 0000 		.long	0x30
 1568 0343 0000 0000 		.long	.LLST14
 1569 0347 1C        		.uleb128 0x1c
 1570 0348 0000 0000 		.long	.LASF35
 1571 034c 01        		.byte	0x1
 1572 034d AD01      		.word	0x1ad
 1573 034f 7C03 0000 		.long	0x37c
 1574 0353 0000 0000 		.long	.LLST15
 1575 0357 1C        		.uleb128 0x1c
 1576 0358 0000 0000 		.long	.LASF36
 1577 035c 01        		.byte	0x1
 1578 035d AD01      		.word	0x1ad
 1579 035f 3000 0000 		.long	0x30
 1580 0363 0000 0000 		.long	.LLST16
 1581 0367 1D        		.uleb128 0x1d
GAS LISTING /tmp/ccB4vTv5.s 			page 37


 1582 0368 0000 0000 		.long	.LVL37
 1583 036c 01        		.byte	0x1
 1584 036d C702 0000 		.long	0x2c7
 1585 0371 15        		.uleb128 0x15
 1586 0372 01        		.byte	0x1
 1587 0373 68        		.byte	0x68
 1588 0374 05        		.byte	0x5
 1589 0375 F3        		.byte	0xf3
 1590 0376 01        		.uleb128 0x1
 1591 0377 68        		.byte	0x68
 1592 0378 31        		.byte	0x31
 1593 0379 24        		.byte	0x24
 1594 037a 00        		.byte	0
 1595 037b 00        		.byte	0
 1596 037c 05        		.uleb128 0x5
 1597 037d 02        		.byte	0x2
 1598 037e 8203 0000 		.long	0x382
 1599 0382 1E        		.uleb128 0x1e
 1600 0383 3000 0000 		.long	0x30
 1601 0387 1B        		.uleb128 0x1b
 1602 0388 01        		.byte	0x1
 1603 0389 0000 0000 		.long	.LASF37
 1604 038d 01        		.byte	0x1
 1605 038e B701      		.word	0x1b7
 1606 0390 0000 0000 		.long	.LFB109
 1607 0394 0000 0000 		.long	.LFE109
 1608 0398 03        		.byte	0x3
 1609 0399 92        		.byte	0x92
 1610 039a 20        		.uleb128 0x20
 1611 039b 03        		.sleb128 3
 1612 039c 01        		.byte	0x1
 1613 039d E803 0000 		.long	0x3e8
 1614 03a1 1C        		.uleb128 0x1c
 1615 03a2 0000 0000 		.long	.LASF32
 1616 03a6 01        		.byte	0x1
 1617 03a7 B701      		.word	0x1b7
 1618 03a9 3000 0000 		.long	0x30
 1619 03ad 0000 0000 		.long	.LLST17
 1620 03b1 1C        		.uleb128 0x1c
 1621 03b2 0000 0000 		.long	.LASF35
 1622 03b6 01        		.byte	0x1
 1623 03b7 B701      		.word	0x1b7
 1624 03b9 6F01 0000 		.long	0x16f
 1625 03bd 0000 0000 		.long	.LLST18
 1626 03c1 1C        		.uleb128 0x1c
 1627 03c2 0000 0000 		.long	.LASF36
 1628 03c6 01        		.byte	0x1
 1629 03c7 B701      		.word	0x1b7
 1630 03c9 3000 0000 		.long	0x30
 1631 03cd 0000 0000 		.long	.LLST19
 1632 03d1 1D        		.uleb128 0x1d
 1633 03d2 0000 0000 		.long	.LVL40
 1634 03d6 01        		.byte	0x1
 1635 03d7 C702 0000 		.long	0x2c7
 1636 03db 15        		.uleb128 0x15
 1637 03dc 01        		.byte	0x1
 1638 03dd 68        		.byte	0x68
GAS LISTING /tmp/ccB4vTv5.s 			page 38


 1639 03de 07        		.byte	0x7
 1640 03df F3        		.byte	0xf3
 1641 03e0 01        		.uleb128 0x1
 1642 03e1 68        		.byte	0x68
 1643 03e2 31        		.byte	0x31
 1644 03e3 24        		.byte	0x24
 1645 03e4 31        		.byte	0x31
 1646 03e5 21        		.byte	0x21
 1647 03e6 00        		.byte	0
 1648 03e7 00        		.byte	0
 1649 03e8 18        		.uleb128 0x18
 1650 03e9 01        		.byte	0x1
 1651 03ea 0000 0000 		.long	.LASF38
 1652 03ee 01        		.byte	0x1
 1653 03ef C201      		.word	0x1c2
 1654 03f1 0000 0000 		.long	.LFB110
 1655 03f5 0000 0000 		.long	.LFE110
 1656 03f9 0000 0000 		.long	.LLST20
 1657 03fd 01        		.byte	0x1
 1658 03fe 5704 0000 		.long	0x457
 1659 0402 1C        		.uleb128 0x1c
 1660 0403 0000 0000 		.long	.LASF32
 1661 0407 01        		.byte	0x1
 1662 0408 C201      		.word	0x1c2
 1663 040a 3000 0000 		.long	0x30
 1664 040e 0000 0000 		.long	.LLST21
 1665 0412 1F        		.uleb128 0x1f
 1666 0413 0000 0000 		.long	.LASF39
 1667 0417 01        		.byte	0x1
 1668 0418 C301      		.word	0x1c3
 1669 041a 6F01 0000 		.long	0x16f
 1670 041e 06        		.byte	0x6
 1671 041f 66        		.byte	0x66
 1672 0420 93        		.byte	0x93
 1673 0421 01        		.uleb128 0x1
 1674 0422 67        		.byte	0x67
 1675 0423 93        		.byte	0x93
 1676 0424 01        		.uleb128 0x1
 1677 0425 1F        		.uleb128 0x1f
 1678 0426 0000 0000 		.long	.LASF40
 1679 042a 01        		.byte	0x1
 1680 042b C301      		.word	0x1c3
 1681 042d 3000 0000 		.long	0x30
 1682 0431 01        		.byte	0x1
 1683 0432 64        		.byte	0x64
 1684 0433 1F        		.uleb128 0x1f
 1685 0434 0000 0000 		.long	.LASF35
 1686 0438 01        		.byte	0x1
 1687 0439 C401      		.word	0x1c4
 1688 043b 6F01 0000 		.long	0x16f
 1689 043f 06        		.byte	0x6
 1690 0440 62        		.byte	0x62
 1691 0441 93        		.byte	0x93
 1692 0442 01        		.uleb128 0x1
 1693 0443 63        		.byte	0x63
 1694 0444 93        		.byte	0x93
 1695 0445 01        		.uleb128 0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 39


 1696 0446 1C        		.uleb128 0x1c
 1697 0447 0000 0000 		.long	.LASF41
 1698 044b 01        		.byte	0x1
 1699 044c C401      		.word	0x1c4
 1700 044e 3000 0000 		.long	0x30
 1701 0452 0000 0000 		.long	.LLST22
 1702 0456 00        		.byte	0
 1703 0457 1B        		.uleb128 0x1b
 1704 0458 01        		.byte	0x1
 1705 0459 0000 0000 		.long	.LASF42
 1706 045d 02        		.byte	0x2
 1707 045e E901      		.word	0x1e9
 1708 0460 0000 0000 		.long	.LFB111
 1709 0464 0000 0000 		.long	.LFE111
 1710 0468 03        		.byte	0x3
 1711 0469 92        		.byte	0x92
 1712 046a 20        		.uleb128 0x20
 1713 046b 03        		.sleb128 3
 1714 046c 01        		.byte	0x1
 1715 046d AA04 0000 		.long	0x4aa
 1716 0471 1C        		.uleb128 0x1c
 1717 0472 0000 0000 		.long	.LASF43
 1718 0476 02        		.byte	0x2
 1719 0477 E901      		.word	0x1e9
 1720 0479 3000 0000 		.long	0x30
 1721 047d 0000 0000 		.long	.LLST23
 1722 0481 20        		.uleb128 0x20
 1723 0482 5F72 7300 		.string	"_rs"
 1724 0486 02        		.byte	0x2
 1725 0487 E901      		.word	0x1e9
 1726 0489 3000 0000 		.long	0x30
 1727 048d 01        		.byte	0x1
 1728 048e 66        		.byte	0x66
 1729 048f 10        		.uleb128 0x10
 1730 0490 0000 0000 		.long	.LBB8
 1731 0494 0000 0000 		.long	.LBE8
 1732 0498 21        		.uleb128 0x21
 1733 0499 0000 0000 		.long	.LASF44
 1734 049d 02        		.byte	0x2
 1735 049e EB01      		.word	0x1eb
 1736 04a0 3000 0000 		.long	0x30
 1737 04a4 0000 0000 		.long	.LLST24
 1738 04a8 00        		.byte	0
 1739 04a9 00        		.byte	0
 1740 04aa 18        		.uleb128 0x18
 1741 04ab 01        		.byte	0x1
 1742 04ac 0000 0000 		.long	.LASF45
 1743 04b0 02        		.byte	0x2
 1744 04b1 FE01      		.word	0x1fe
 1745 04b3 0000 0000 		.long	.LFB112
 1746 04b7 0000 0000 		.long	.LFE112
 1747 04bb 0000 0000 		.long	.LLST25
 1748 04bf 01        		.byte	0x1
 1749 04c0 5505 0000 		.long	0x555
 1750 04c4 22        		.uleb128 0x22
 1751 04c5 6275 6600 		.string	"buf"
 1752 04c9 02        		.byte	0x2
GAS LISTING /tmp/ccB4vTv5.s 			page 40


 1753 04ca FE01      		.word	0x1fe
 1754 04cc 8900 0000 		.long	0x89
 1755 04d0 0000 0000 		.long	.LLST26
 1756 04d4 22        		.uleb128 0x22
 1757 04d5 6C65 6E00 		.string	"len"
 1758 04d9 02        		.byte	0x2
 1759 04da FE01      		.word	0x1fe
 1760 04dc 3000 0000 		.long	0x30
 1761 04e0 0000 0000 		.long	.LLST27
 1762 04e4 10        		.uleb128 0x10
 1763 04e5 0000 0000 		.long	.LBB9
 1764 04e9 0000 0000 		.long	.LBE9
 1765 04ed 19        		.uleb128 0x19
 1766 04ee 5F62 00   		.string	"_b"
 1767 04f1 02        		.byte	0x2
 1768 04f2 0002      		.word	0x200
 1769 04f4 6F01 0000 		.long	0x16f
 1770 04f8 0000 0000 		.long	.LLST28
 1771 04fc 19        		.uleb128 0x19
 1772 04fd 5F6C 00   		.string	"_l"
 1773 0500 02        		.byte	0x2
 1774 0501 0102      		.word	0x201
 1775 0503 3000 0000 		.long	0x30
 1776 0507 0000 0000 		.long	.LLST29
 1777 050b 23        		.uleb128 0x23
 1778 050c 0000 0000 		.long	.LVL59
 1779 0510 5704 0000 		.long	0x457
 1780 0514 1E05 0000 		.long	0x51e
 1781 0518 15        		.uleb128 0x15
 1782 0519 01        		.byte	0x1
 1783 051a 66        		.byte	0x66
 1784 051b 01        		.byte	0x1
 1785 051c 31        		.byte	0x31
 1786 051d 00        		.byte	0
 1787 051e 23        		.uleb128 0x23
 1788 051f 0000 0000 		.long	.LVL60
 1789 0523 1D03 0000 		.long	0x31d
 1790 0527 3F05 0000 		.long	0x53f
 1791 052b 15        		.uleb128 0x15
 1792 052c 06        		.byte	0x6
 1793 052d 66        		.byte	0x66
 1794 052e 93        		.byte	0x93
 1795 052f 01        		.uleb128 0x1
 1796 0530 67        		.byte	0x67
 1797 0531 93        		.byte	0x93
 1798 0532 01        		.uleb128 0x1
 1799 0533 05        		.byte	0x5
 1800 0534 03        		.byte	0x3
 1801 0535 0000 0000 		.long	lcdBuffer
 1802 0539 15        		.uleb128 0x15
 1803 053a 01        		.byte	0x1
 1804 053b 64        		.byte	0x64
 1805 053c 01        		.byte	0x1
 1806 053d 36        		.byte	0x36
 1807 053e 00        		.byte	0
 1808 053f 14        		.uleb128 0x14
 1809 0540 0000 0000 		.long	.LVL61
GAS LISTING /tmp/ccB4vTv5.s 			page 41


 1810 0544 3C0B 0000 		.long	0xb3c
 1811 0548 15        		.uleb128 0x15
 1812 0549 06        		.byte	0x6
 1813 054a 68        		.byte	0x68
 1814 054b 93        		.byte	0x93
 1815 054c 01        		.uleb128 0x1
 1816 054d 69        		.byte	0x69
 1817 054e 93        		.byte	0x93
 1818 054f 01        		.uleb128 0x1
 1819 0550 01        		.byte	0x1
 1820 0551 35        		.byte	0x35
 1821 0552 00        		.byte	0
 1822 0553 00        		.byte	0
 1823 0554 00        		.byte	0
 1824 0555 1B        		.uleb128 0x1b
 1825 0556 01        		.byte	0x1
 1826 0557 0000 0000 		.long	.LASF46
 1827 055b 02        		.byte	0x2
 1828 055c 0B02      		.word	0x20b
 1829 055e 0000 0000 		.long	.LFB113
 1830 0562 0000 0000 		.long	.LFE113
 1831 0566 03        		.byte	0x3
 1832 0567 92        		.byte	0x92
 1833 0568 20        		.uleb128 0x20
 1834 0569 03        		.sleb128 3
 1835 056a 01        		.byte	0x1
 1836 056b 0B07 0000 		.long	0x70b
 1837 056f 23        		.uleb128 0x23
 1838 0570 0000 0000 		.long	.LVL64
 1839 0574 5704 0000 		.long	0x457
 1840 0578 8205 0000 		.long	0x582
 1841 057c 15        		.uleb128 0x15
 1842 057d 01        		.byte	0x1
 1843 057e 66        		.byte	0x66
 1844 057f 01        		.byte	0x1
 1845 0580 30        		.byte	0x30
 1846 0581 00        		.byte	0
 1847 0582 23        		.uleb128 0x23
 1848 0583 0000 0000 		.long	.LVL65
 1849 0587 1D03 0000 		.long	0x31d
 1850 058b A305 0000 		.long	0x5a3
 1851 058f 15        		.uleb128 0x15
 1852 0590 06        		.byte	0x6
 1853 0591 66        		.byte	0x66
 1854 0592 93        		.byte	0x93
 1855 0593 01        		.uleb128 0x1
 1856 0594 67        		.byte	0x67
 1857 0595 93        		.byte	0x93
 1858 0596 01        		.uleb128 0x1
 1859 0597 05        		.byte	0x5
 1860 0598 03        		.byte	0x3
 1861 0599 0000 0000 		.long	lcdBuffer
 1862 059d 15        		.uleb128 0x15
 1863 059e 01        		.byte	0x1
 1864 059f 64        		.byte	0x64
 1865 05a0 01        		.byte	0x1
 1866 05a1 36        		.byte	0x36
GAS LISTING /tmp/ccB4vTv5.s 			page 42


 1867 05a2 00        		.byte	0
 1868 05a3 23        		.uleb128 0x23
 1869 05a4 0000 0000 		.long	.LVL66
 1870 05a8 3C0B 0000 		.long	0xb3c
 1871 05ac BB05 0000 		.long	0x5bb
 1872 05b0 15        		.uleb128 0x15
 1873 05b1 06        		.byte	0x6
 1874 05b2 68        		.byte	0x68
 1875 05b3 93        		.byte	0x93
 1876 05b4 01        		.uleb128 0x1
 1877 05b5 69        		.byte	0x69
 1878 05b6 93        		.byte	0x93
 1879 05b7 01        		.uleb128 0x1
 1880 05b8 01        		.byte	0x1
 1881 05b9 35        		.byte	0x35
 1882 05ba 00        		.byte	0
 1883 05bb 23        		.uleb128 0x23
 1884 05bc 0000 0000 		.long	.LVL67
 1885 05c0 5704 0000 		.long	0x457
 1886 05c4 CE05 0000 		.long	0x5ce
 1887 05c8 15        		.uleb128 0x15
 1888 05c9 01        		.byte	0x1
 1889 05ca 66        		.byte	0x66
 1890 05cb 01        		.byte	0x1
 1891 05cc 30        		.byte	0x30
 1892 05cd 00        		.byte	0
 1893 05ce 23        		.uleb128 0x23
 1894 05cf 0000 0000 		.long	.LVL68
 1895 05d3 1D03 0000 		.long	0x31d
 1896 05d7 EF05 0000 		.long	0x5ef
 1897 05db 15        		.uleb128 0x15
 1898 05dc 06        		.byte	0x6
 1899 05dd 66        		.byte	0x66
 1900 05de 93        		.byte	0x93
 1901 05df 01        		.uleb128 0x1
 1902 05e0 67        		.byte	0x67
 1903 05e1 93        		.byte	0x93
 1904 05e2 01        		.uleb128 0x1
 1905 05e3 05        		.byte	0x5
 1906 05e4 03        		.byte	0x3
 1907 05e5 0000 0000 		.long	lcdBuffer
 1908 05e9 15        		.uleb128 0x15
 1909 05ea 01        		.byte	0x1
 1910 05eb 64        		.byte	0x64
 1911 05ec 01        		.byte	0x1
 1912 05ed 36        		.byte	0x36
 1913 05ee 00        		.byte	0
 1914 05ef 23        		.uleb128 0x23
 1915 05f0 0000 0000 		.long	.LVL69
 1916 05f4 3C0B 0000 		.long	0xb3c
 1917 05f8 0706 0000 		.long	0x607
 1918 05fc 15        		.uleb128 0x15
 1919 05fd 06        		.byte	0x6
 1920 05fe 68        		.byte	0x68
 1921 05ff 93        		.byte	0x93
 1922 0600 01        		.uleb128 0x1
 1923 0601 69        		.byte	0x69
GAS LISTING /tmp/ccB4vTv5.s 			page 43


 1924 0602 93        		.byte	0x93
 1925 0603 01        		.uleb128 0x1
 1926 0604 01        		.byte	0x1
 1927 0605 35        		.byte	0x35
 1928 0606 00        		.byte	0
 1929 0607 23        		.uleb128 0x23
 1930 0608 0000 0000 		.long	.LVL70
 1931 060c 5704 0000 		.long	0x457
 1932 0610 1A06 0000 		.long	0x61a
 1933 0614 15        		.uleb128 0x15
 1934 0615 01        		.byte	0x1
 1935 0616 66        		.byte	0x66
 1936 0617 01        		.byte	0x1
 1937 0618 30        		.byte	0x30
 1938 0619 00        		.byte	0
 1939 061a 23        		.uleb128 0x23
 1940 061b 0000 0000 		.long	.LVL71
 1941 061f 1D03 0000 		.long	0x31d
 1942 0623 3B06 0000 		.long	0x63b
 1943 0627 15        		.uleb128 0x15
 1944 0628 06        		.byte	0x6
 1945 0629 66        		.byte	0x66
 1946 062a 93        		.byte	0x93
 1947 062b 01        		.uleb128 0x1
 1948 062c 67        		.byte	0x67
 1949 062d 93        		.byte	0x93
 1950 062e 01        		.uleb128 0x1
 1951 062f 05        		.byte	0x5
 1952 0630 03        		.byte	0x3
 1953 0631 0000 0000 		.long	lcdBuffer
 1954 0635 15        		.uleb128 0x15
 1955 0636 01        		.byte	0x1
 1956 0637 64        		.byte	0x64
 1957 0638 01        		.byte	0x1
 1958 0639 36        		.byte	0x36
 1959 063a 00        		.byte	0
 1960 063b 23        		.uleb128 0x23
 1961 063c 0000 0000 		.long	.LVL72
 1962 0640 3C0B 0000 		.long	0xb3c
 1963 0644 5306 0000 		.long	0x653
 1964 0648 15        		.uleb128 0x15
 1965 0649 06        		.byte	0x6
 1966 064a 68        		.byte	0x68
 1967 064b 93        		.byte	0x93
 1968 064c 01        		.uleb128 0x1
 1969 064d 69        		.byte	0x69
 1970 064e 93        		.byte	0x93
 1971 064f 01        		.uleb128 0x1
 1972 0650 01        		.byte	0x1
 1973 0651 35        		.byte	0x35
 1974 0652 00        		.byte	0
 1975 0653 23        		.uleb128 0x23
 1976 0654 0000 0000 		.long	.LVL73
 1977 0658 5704 0000 		.long	0x457
 1978 065c 6B06 0000 		.long	0x66b
 1979 0660 15        		.uleb128 0x15
 1980 0661 01        		.byte	0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 44


 1981 0662 68        		.byte	0x68
 1982 0663 01        		.byte	0x1
 1983 0664 31        		.byte	0x31
 1984 0665 15        		.uleb128 0x15
 1985 0666 01        		.byte	0x1
 1986 0667 66        		.byte	0x66
 1987 0668 01        		.byte	0x1
 1988 0669 30        		.byte	0x30
 1989 066a 00        		.byte	0
 1990 066b 23        		.uleb128 0x23
 1991 066c 0000 0000 		.long	.LVL74
 1992 0670 1D03 0000 		.long	0x31d
 1993 0674 8C06 0000 		.long	0x68c
 1994 0678 15        		.uleb128 0x15
 1995 0679 06        		.byte	0x6
 1996 067a 66        		.byte	0x66
 1997 067b 93        		.byte	0x93
 1998 067c 01        		.uleb128 0x1
 1999 067d 67        		.byte	0x67
 2000 067e 93        		.byte	0x93
 2001 067f 01        		.uleb128 0x1
 2002 0680 05        		.byte	0x5
 2003 0681 03        		.byte	0x3
 2004 0682 0000 0000 		.long	lcdBuffer
 2005 0686 15        		.uleb128 0x15
 2006 0687 01        		.byte	0x1
 2007 0688 64        		.byte	0x64
 2008 0689 01        		.byte	0x1
 2009 068a 36        		.byte	0x36
 2010 068b 00        		.byte	0
 2011 068c 23        		.uleb128 0x23
 2012 068d 0000 0000 		.long	.LVL75
 2013 0691 3C0B 0000 		.long	0xb3c
 2014 0695 A406 0000 		.long	0x6a4
 2015 0699 15        		.uleb128 0x15
 2016 069a 06        		.byte	0x6
 2017 069b 68        		.byte	0x68
 2018 069c 93        		.byte	0x93
 2019 069d 01        		.uleb128 0x1
 2020 069e 69        		.byte	0x69
 2021 069f 93        		.byte	0x93
 2022 06a0 01        		.uleb128 0x1
 2023 06a1 01        		.byte	0x1
 2024 06a2 35        		.byte	0x35
 2025 06a3 00        		.byte	0
 2026 06a4 23        		.uleb128 0x23
 2027 06a5 0000 0000 		.long	.LVL76
 2028 06a9 3C0B 0000 		.long	0xb3c
 2029 06ad BC06 0000 		.long	0x6bc
 2030 06b1 15        		.uleb128 0x15
 2031 06b2 06        		.byte	0x6
 2032 06b3 68        		.byte	0x68
 2033 06b4 93        		.byte	0x93
 2034 06b5 01        		.uleb128 0x1
 2035 06b6 69        		.byte	0x69
 2036 06b7 93        		.byte	0x93
 2037 06b8 01        		.uleb128 0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 45


 2038 06b9 01        		.byte	0x1
 2039 06ba 40        		.byte	0x40
 2040 06bb 00        		.byte	0
 2041 06bc 23        		.uleb128 0x23
 2042 06bd 0000 0000 		.long	.LVL77
 2043 06c1 5704 0000 		.long	0x457
 2044 06c5 D406 0000 		.long	0x6d4
 2045 06c9 15        		.uleb128 0x15
 2046 06ca 01        		.byte	0x1
 2047 06cb 68        		.byte	0x68
 2048 06cc 01        		.byte	0x1
 2049 06cd 32        		.byte	0x32
 2050 06ce 15        		.uleb128 0x15
 2051 06cf 01        		.byte	0x1
 2052 06d0 66        		.byte	0x66
 2053 06d1 01        		.byte	0x1
 2054 06d2 30        		.byte	0x30
 2055 06d3 00        		.byte	0
 2056 06d4 23        		.uleb128 0x23
 2057 06d5 0000 0000 		.long	.LVL78
 2058 06d9 1D03 0000 		.long	0x31d
 2059 06dd F506 0000 		.long	0x6f5
 2060 06e1 15        		.uleb128 0x15
 2061 06e2 06        		.byte	0x6
 2062 06e3 66        		.byte	0x66
 2063 06e4 93        		.byte	0x93
 2064 06e5 01        		.uleb128 0x1
 2065 06e6 67        		.byte	0x67
 2066 06e7 93        		.byte	0x93
 2067 06e8 01        		.uleb128 0x1
 2068 06e9 05        		.byte	0x5
 2069 06ea 03        		.byte	0x3
 2070 06eb 0000 0000 		.long	lcdBuffer
 2071 06ef 15        		.uleb128 0x15
 2072 06f0 01        		.byte	0x1
 2073 06f1 64        		.byte	0x64
 2074 06f2 01        		.byte	0x1
 2075 06f3 36        		.byte	0x36
 2076 06f4 00        		.byte	0
 2077 06f5 1D        		.uleb128 0x1d
 2078 06f6 0000 0000 		.long	.LVL79
 2079 06fa 01        		.byte	0x1
 2080 06fb 3C0B 0000 		.long	0xb3c
 2081 06ff 15        		.uleb128 0x15
 2082 0700 06        		.byte	0x6
 2083 0701 68        		.byte	0x68
 2084 0702 93        		.byte	0x93
 2085 0703 01        		.uleb128 0x1
 2086 0704 69        		.byte	0x69
 2087 0705 93        		.byte	0x93
 2088 0706 01        		.uleb128 0x1
 2089 0707 01        		.byte	0x1
 2090 0708 35        		.byte	0x35
 2091 0709 00        		.byte	0
 2092 070a 00        		.byte	0
 2093 070b 18        		.uleb128 0x18
 2094 070c 01        		.byte	0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 46


 2095 070d 0000 0000 		.long	.LASF47
 2096 0711 02        		.byte	0x2
 2097 0712 1702      		.word	0x217
 2098 0714 0000 0000 		.long	.LFB114
 2099 0718 0000 0000 		.long	.LFE114
 2100 071c 0000 0000 		.long	.LLST30
 2101 0720 01        		.byte	0x1
 2102 0721 F308 0000 		.long	0x8f3
 2103 0725 1C        		.uleb128 0x1c
 2104 0726 0000 0000 		.long	.LASF48
 2105 072a 02        		.byte	0x2
 2106 072b 1702      		.word	0x217
 2107 072d 3000 0000 		.long	0x30
 2108 0731 0000 0000 		.long	.LLST31
 2109 0735 1C        		.uleb128 0x1c
 2110 0736 0000 0000 		.long	.LASF49
 2111 073a 02        		.byte	0x2
 2112 073b 1702      		.word	0x217
 2113 073d 3000 0000 		.long	0x30
 2114 0741 0000 0000 		.long	.LLST32
 2115 0745 1C        		.uleb128 0x1c
 2116 0746 0000 0000 		.long	.LASF50
 2117 074a 02        		.byte	0x2
 2118 074b 1702      		.word	0x217
 2119 074d 3000 0000 		.long	0x30
 2120 0751 0000 0000 		.long	.LLST33
 2121 0755 1C        		.uleb128 0x1c
 2122 0756 0000 0000 		.long	.LASF51
 2123 075a 02        		.byte	0x2
 2124 075b 1702      		.word	0x217
 2125 075d 3000 0000 		.long	0x30
 2126 0761 0000 0000 		.long	.LLST34
 2127 0765 23        		.uleb128 0x23
 2128 0766 0000 0000 		.long	.LVL86
 2129 076a E201 0000 		.long	0x1e2
 2130 076e 8C07 0000 		.long	0x78c
 2131 0772 15        		.uleb128 0x15
 2132 0773 0C        		.byte	0xc
 2133 0774 66        		.byte	0x66
 2134 0775 93        		.byte	0x93
 2135 0776 01        		.uleb128 0x1
 2136 0777 67        		.byte	0x67
 2137 0778 93        		.byte	0x93
 2138 0779 01        		.uleb128 0x1
 2139 077a 68        		.byte	0x68
 2140 077b 93        		.byte	0x93
 2141 077c 01        		.uleb128 0x1
 2142 077d 69        		.byte	0x69
 2143 077e 93        		.byte	0x93
 2144 077f 01        		.uleb128 0x1
 2145 0780 05        		.byte	0x5
 2146 0781 0C        		.byte	0xc
 2147 0782 A086 0100 		.long	0x186a0
 2148 0786 15        		.uleb128 0x15
 2149 0787 01        		.byte	0x1
 2150 0788 64        		.byte	0x64
 2151 0789 01        		.byte	0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 47


 2152 078a 36        		.byte	0x36
 2153 078b 00        		.byte	0
 2154 078c 23        		.uleb128 0x23
 2155 078d 0000 0000 		.long	.LVL87
 2156 0791 5704 0000 		.long	0x457
 2157 0795 A507 0000 		.long	0x7a5
 2158 0799 15        		.uleb128 0x15
 2159 079a 01        		.byte	0x1
 2160 079b 68        		.byte	0x68
 2161 079c 02        		.byte	0x2
 2162 079d 08        		.byte	0x8
 2163 079e 30        		.byte	0x30
 2164 079f 15        		.uleb128 0x15
 2165 07a0 01        		.byte	0x1
 2166 07a1 66        		.byte	0x66
 2167 07a2 01        		.byte	0x1
 2168 07a3 30        		.byte	0x30
 2169 07a4 00        		.byte	0
 2170 07a5 23        		.uleb128 0x23
 2171 07a6 0000 0000 		.long	.LVL88
 2172 07aa 3C0B 0000 		.long	0xb3c
 2173 07ae BD07 0000 		.long	0x7bd
 2174 07b2 15        		.uleb128 0x15
 2175 07b3 06        		.byte	0x6
 2176 07b4 68        		.byte	0x68
 2177 07b5 93        		.byte	0x93
 2178 07b6 01        		.uleb128 0x1
 2179 07b7 69        		.byte	0x69
 2180 07b8 93        		.byte	0x93
 2181 07b9 01        		.uleb128 0x1
 2182 07ba 01        		.byte	0x1
 2183 07bb 3F        		.byte	0x3f
 2184 07bc 00        		.byte	0
 2185 07bd 23        		.uleb128 0x23
 2186 07be 0000 0000 		.long	.LVL89
 2187 07c2 1D03 0000 		.long	0x31d
 2188 07c6 DE07 0000 		.long	0x7de
 2189 07ca 15        		.uleb128 0x15
 2190 07cb 06        		.byte	0x6
 2191 07cc 66        		.byte	0x66
 2192 07cd 93        		.byte	0x93
 2193 07ce 01        		.uleb128 0x1
 2194 07cf 67        		.byte	0x67
 2195 07d0 93        		.byte	0x93
 2196 07d1 01        		.uleb128 0x1
 2197 07d2 05        		.byte	0x5
 2198 07d3 03        		.byte	0x3
 2199 07d4 0000 0000 		.long	lcdBuffer
 2200 07d8 15        		.uleb128 0x15
 2201 07d9 01        		.byte	0x1
 2202 07da 64        		.byte	0x64
 2203 07db 01        		.byte	0x1
 2204 07dc 33        		.byte	0x33
 2205 07dd 00        		.byte	0
 2206 07de 23        		.uleb128 0x23
 2207 07df 0000 0000 		.long	.LVL90
 2208 07e3 3C0B 0000 		.long	0xb3c
GAS LISTING /tmp/ccB4vTv5.s 			page 48


 2209 07e7 F607 0000 		.long	0x7f6
 2210 07eb 15        		.uleb128 0x15
 2211 07ec 06        		.byte	0x6
 2212 07ed 68        		.byte	0x68
 2213 07ee 93        		.byte	0x93
 2214 07ef 01        		.uleb128 0x1
 2215 07f0 69        		.byte	0x69
 2216 07f1 93        		.byte	0x93
 2217 07f2 01        		.uleb128 0x1
 2218 07f3 01        		.byte	0x1
 2219 07f4 35        		.byte	0x35
 2220 07f5 00        		.byte	0
 2221 07f6 23        		.uleb128 0x23
 2222 07f7 0000 0000 		.long	.LVL91
 2223 07fb 3C0B 0000 		.long	0xb3c
 2224 07ff 0E08 0000 		.long	0x80e
 2225 0803 15        		.uleb128 0x15
 2226 0804 06        		.byte	0x6
 2227 0805 68        		.byte	0x68
 2228 0806 93        		.byte	0x93
 2229 0807 01        		.uleb128 0x1
 2230 0808 69        		.byte	0x69
 2231 0809 93        		.byte	0x93
 2232 080a 01        		.uleb128 0x1
 2233 080b 01        		.byte	0x1
 2234 080c 35        		.byte	0x35
 2235 080d 00        		.byte	0
 2236 080e 23        		.uleb128 0x23
 2237 080f 0000 0000 		.long	.LVL92
 2238 0813 1D03 0000 		.long	0x31d
 2239 0817 2F08 0000 		.long	0x82f
 2240 081b 15        		.uleb128 0x15
 2241 081c 06        		.byte	0x6
 2242 081d 66        		.byte	0x66
 2243 081e 93        		.byte	0x93
 2244 081f 01        		.uleb128 0x1
 2245 0820 67        		.byte	0x67
 2246 0821 93        		.byte	0x93
 2247 0822 01        		.uleb128 0x1
 2248 0823 05        		.byte	0x5
 2249 0824 03        		.byte	0x3
 2250 0825 0000 0000 		.long	lcdBuffer
 2251 0829 15        		.uleb128 0x15
 2252 082a 01        		.byte	0x1
 2253 082b 64        		.byte	0x64
 2254 082c 01        		.byte	0x1
 2255 082d 33        		.byte	0x33
 2256 082e 00        		.byte	0
 2257 082f 23        		.uleb128 0x23
 2258 0830 0000 0000 		.long	.LVL93
 2259 0834 3C0B 0000 		.long	0xb3c
 2260 0838 4708 0000 		.long	0x847
 2261 083c 15        		.uleb128 0x15
 2262 083d 06        		.byte	0x6
 2263 083e 68        		.byte	0x68
 2264 083f 93        		.byte	0x93
 2265 0840 01        		.uleb128 0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 49


 2266 0841 69        		.byte	0x69
 2267 0842 93        		.byte	0x93
 2268 0843 01        		.uleb128 0x1
 2269 0844 01        		.byte	0x1
 2270 0845 35        		.byte	0x35
 2271 0846 00        		.byte	0
 2272 0847 23        		.uleb128 0x23
 2273 0848 0000 0000 		.long	.LVL94
 2274 084c 1D03 0000 		.long	0x31d
 2275 0850 6808 0000 		.long	0x868
 2276 0854 15        		.uleb128 0x15
 2277 0855 06        		.byte	0x6
 2278 0856 66        		.byte	0x66
 2279 0857 93        		.byte	0x93
 2280 0858 01        		.uleb128 0x1
 2281 0859 67        		.byte	0x67
 2282 085a 93        		.byte	0x93
 2283 085b 01        		.uleb128 0x1
 2284 085c 05        		.byte	0x5
 2285 085d 03        		.byte	0x3
 2286 085e 0000 0000 		.long	lcdBuffer
 2287 0862 15        		.uleb128 0x15
 2288 0863 01        		.byte	0x1
 2289 0864 64        		.byte	0x64
 2290 0865 01        		.byte	0x1
 2291 0866 33        		.byte	0x33
 2292 0867 00        		.byte	0
 2293 0868 23        		.uleb128 0x23
 2294 0869 0000 0000 		.long	.LVL95
 2295 086d 3C0B 0000 		.long	0xb3c
 2296 0871 8008 0000 		.long	0x880
 2297 0875 15        		.uleb128 0x15
 2298 0876 06        		.byte	0x6
 2299 0877 68        		.byte	0x68
 2300 0878 93        		.byte	0x93
 2301 0879 01        		.uleb128 0x1
 2302 087a 69        		.byte	0x69
 2303 087b 93        		.byte	0x93
 2304 087c 01        		.uleb128 0x1
 2305 087d 01        		.byte	0x1
 2306 087e 35        		.byte	0x35
 2307 087f 00        		.byte	0
 2308 0880 23        		.uleb128 0x23
 2309 0881 0000 0000 		.long	.LVL96
 2310 0885 5704 0000 		.long	0x457
 2311 0889 9908 0000 		.long	0x899
 2312 088d 15        		.uleb128 0x15
 2313 088e 01        		.byte	0x1
 2314 088f 68        		.byte	0x68
 2315 0890 02        		.byte	0x2
 2316 0891 08        		.byte	0x8
 2317 0892 20        		.byte	0x20
 2318 0893 15        		.uleb128 0x15
 2319 0894 01        		.byte	0x1
 2320 0895 66        		.byte	0x66
 2321 0896 01        		.byte	0x1
 2322 0897 30        		.byte	0x30
GAS LISTING /tmp/ccB4vTv5.s 			page 50


 2323 0898 00        		.byte	0
 2324 0899 23        		.uleb128 0x23
 2325 089a 0000 0000 		.long	.LVL97
 2326 089e 1D03 0000 		.long	0x31d
 2327 08a2 BA08 0000 		.long	0x8ba
 2328 08a6 15        		.uleb128 0x15
 2329 08a7 06        		.byte	0x6
 2330 08a8 66        		.byte	0x66
 2331 08a9 93        		.byte	0x93
 2332 08aa 01        		.uleb128 0x1
 2333 08ab 67        		.byte	0x67
 2334 08ac 93        		.byte	0x93
 2335 08ad 01        		.uleb128 0x1
 2336 08ae 05        		.byte	0x5
 2337 08af 03        		.byte	0x3
 2338 08b0 0000 0000 		.long	lcdBuffer
 2339 08b4 15        		.uleb128 0x15
 2340 08b5 01        		.byte	0x1
 2341 08b6 64        		.byte	0x64
 2342 08b7 01        		.byte	0x1
 2343 08b8 33        		.byte	0x33
 2344 08b9 00        		.byte	0
 2345 08ba 23        		.uleb128 0x23
 2346 08bb 0000 0000 		.long	.LVL98
 2347 08bf 3C0B 0000 		.long	0xb3c
 2348 08c3 D208 0000 		.long	0x8d2
 2349 08c7 15        		.uleb128 0x15
 2350 08c8 06        		.byte	0x6
 2351 08c9 68        		.byte	0x68
 2352 08ca 93        		.byte	0x93
 2353 08cb 01        		.uleb128 0x1
 2354 08cc 69        		.byte	0x69
 2355 08cd 93        		.byte	0x93
 2356 08ce 01        		.uleb128 0x1
 2357 08cf 01        		.byte	0x1
 2358 08d0 35        		.byte	0x35
 2359 08d1 00        		.byte	0
 2360 08d2 1A        		.uleb128 0x1a
 2361 08d3 0000 0000 		.long	.LVL99
 2362 08d7 5505 0000 		.long	0x555
 2363 08db 1D        		.uleb128 0x1d
 2364 08dc 0000 0000 		.long	.LVL101
 2365 08e0 01        		.byte	0x1
 2366 08e1 3C0B 0000 		.long	0xb3c
 2367 08e5 15        		.uleb128 0x15
 2368 08e6 06        		.byte	0x6
 2369 08e7 68        		.byte	0x68
 2370 08e8 93        		.byte	0x93
 2371 08e9 01        		.uleb128 0x1
 2372 08ea 69        		.byte	0x69
 2373 08eb 93        		.byte	0x93
 2374 08ec 01        		.uleb128 0x1
 2375 08ed 03        		.byte	0x3
 2376 08ee 0A        		.byte	0xa
 2377 08ef F401      		.word	0x1f4
 2378 08f1 00        		.byte	0
 2379 08f2 00        		.byte	0
GAS LISTING /tmp/ccB4vTv5.s 			page 51


 2380 08f3 1B        		.uleb128 0x1b
 2381 08f4 01        		.byte	0x1
 2382 08f5 0000 0000 		.long	.LASF52
 2383 08f9 02        		.byte	0x2
 2384 08fa 4102      		.word	0x241
 2385 08fc 0000 0000 		.long	.LFB115
 2386 0900 0000 0000 		.long	.LFE115
 2387 0904 03        		.byte	0x3
 2388 0905 92        		.byte	0x92
 2389 0906 20        		.uleb128 0x20
 2390 0907 03        		.sleb128 3
 2391 0908 01        		.byte	0x1
 2392 0909 6509 0000 		.long	0x965
 2393 090d 10        		.uleb128 0x10
 2394 090e 0000 0000 		.long	.LBB10
 2395 0912 0000 0000 		.long	.LBE10
 2396 0916 24        		.uleb128 0x24
 2397 0917 0000 0000 		.long	.LASF82
 2398 091b 02        		.byte	0x2
 2399 091c 4202      		.word	0x242
 2400 091e 4900 0000 		.long	0x49
 2401 0922 23        		.uleb128 0x23
 2402 0923 0000 0000 		.long	.LVL102
 2403 0927 0B07 0000 		.long	0x70b
 2404 092b 4509 0000 		.long	0x945
 2405 092f 15        		.uleb128 0x15
 2406 0930 01        		.byte	0x1
 2407 0931 68        		.byte	0x68
 2408 0932 02        		.byte	0x2
 2409 0933 08        		.byte	0x8
 2410 0934 27        		.byte	0x27
 2411 0935 15        		.uleb128 0x15
 2412 0936 01        		.byte	0x1
 2413 0937 66        		.byte	0x66
 2414 0938 01        		.byte	0x1
 2415 0939 40        		.byte	0x40
 2416 093a 15        		.uleb128 0x15
 2417 093b 01        		.byte	0x1
 2418 093c 64        		.byte	0x64
 2419 093d 01        		.byte	0x1
 2420 093e 32        		.byte	0x32
 2421 093f 15        		.uleb128 0x15
 2422 0940 01        		.byte	0x1
 2423 0941 62        		.byte	0x62
 2424 0942 01        		.byte	0x1
 2425 0943 31        		.byte	0x31
 2426 0944 00        		.byte	0
 2427 0945 1D        		.uleb128 0x1d
 2428 0946 0000 0000 		.long	.LVL103
 2429 094a 01        		.byte	0x1
 2430 094b AA04 0000 		.long	0x4aa
 2431 094f 15        		.uleb128 0x15
 2432 0950 06        		.byte	0x6
 2433 0951 68        		.byte	0x68
 2434 0952 93        		.byte	0x93
 2435 0953 01        		.uleb128 0x1
 2436 0954 69        		.byte	0x69
GAS LISTING /tmp/ccB4vTv5.s 			page 52


 2437 0955 93        		.byte	0x93
 2438 0956 01        		.uleb128 0x1
 2439 0957 05        		.byte	0x5
 2440 0958 03        		.byte	0x3
 2441 0959 0000 0000 		.long	.LC0
 2442 095d 15        		.uleb128 0x15
 2443 095e 01        		.byte	0x1
 2444 095f 66        		.byte	0x66
 2445 0960 01        		.byte	0x1
 2446 0961 3D        		.byte	0x3d
 2447 0962 00        		.byte	0
 2448 0963 00        		.byte	0
 2449 0964 00        		.byte	0
 2450 0965 25        		.uleb128 0x25
 2451 0966 01        		.byte	0x1
 2452 0967 0000 0000 		.long	.LASF83
 2453 096b 02        		.byte	0x2
 2454 096c 4C02      		.word	0x24c
 2455 096e 0000 0000 		.long	.LFB116
 2456 0972 0000 0000 		.long	.LFE116
 2457 0976 03        		.byte	0x3
 2458 0977 92        		.byte	0x92
 2459 0978 20        		.uleb128 0x20
 2460 0979 03        		.sleb128 3
 2461 097a 01        		.byte	0x1
 2462 097b 26        		.uleb128 0x26
 2463 097c 0000 0000 		.long	.LASF53
 2464 0980 01        		.byte	0x1
 2465 0981 92        		.byte	0x92
 2466 0982 8D09 0000 		.long	0x98d
 2467 0986 01        		.byte	0x1
 2468 0987 05        		.byte	0x5
 2469 0988 03        		.byte	0x3
 2470 0989 0000 0000 		.long	twiMode
 2471 098d 27        		.uleb128 0x27
 2472 098e 3000 0000 		.long	0x30
 2473 0992 26        		.uleb128 0x26
 2474 0993 0000 0000 		.long	.LASF54
 2475 0997 01        		.byte	0x1
 2476 0998 93        		.byte	0x93
 2477 0999 8D09 0000 		.long	0x98d
 2478 099d 01        		.byte	0x1
 2479 099e 05        		.byte	0x5
 2480 099f 03        		.byte	0x3
 2481 09a0 0000 0000 		.long	twiState
 2482 09a4 26        		.uleb128 0x26
 2483 09a5 0000 0000 		.long	.LASF55
 2484 09a9 01        		.byte	0x1
 2485 09aa 94        		.byte	0x94
 2486 09ab 8D09 0000 		.long	0x98d
 2487 09af 01        		.byte	0x1
 2488 09b0 05        		.byte	0x5
 2489 09b1 03        		.byte	0x3
 2490 09b2 0000 0000 		.long	twiSLARW
 2491 09b6 26        		.uleb128 0x26
 2492 09b7 0000 0000 		.long	.LASF56
 2493 09bb 01        		.byte	0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 53


 2494 09bc 96        		.byte	0x96
 2495 09bd 8D09 0000 		.long	0x98d
 2496 09c1 01        		.byte	0x1
 2497 09c2 05        		.byte	0x5
 2498 09c3 03        		.byte	0x3
 2499 09c4 0000 0000 		.long	twiMT_Count
 2500 09c8 26        		.uleb128 0x26
 2501 09c9 0000 0000 		.long	.LASF57
 2502 09cd 01        		.byte	0x1
 2503 09ce 97        		.byte	0x97
 2504 09cf DA09 0000 		.long	0x9da
 2505 09d3 01        		.byte	0x1
 2506 09d4 05        		.byte	0x5
 2507 09d5 03        		.byte	0x3
 2508 09d6 0000 0000 		.long	twiMT_Ptr
 2509 09da 05        		.uleb128 0x5
 2510 09db 02        		.byte	0x2
 2511 09dc 8D09 0000 		.long	0x98d
 2512 09e0 26        		.uleb128 0x26
 2513 09e1 0000 0000 		.long	.LASF58
 2514 09e5 01        		.byte	0x1
 2515 09e6 99        		.byte	0x99
 2516 09e7 8D09 0000 		.long	0x98d
 2517 09eb 01        		.byte	0x1
 2518 09ec 05        		.byte	0x5
 2519 09ed 03        		.byte	0x3
 2520 09ee 0000 0000 		.long	twiRX_Count
 2521 09f2 26        		.uleb128 0x26
 2522 09f3 0000 0000 		.long	.LASF59
 2523 09f7 01        		.byte	0x1
 2524 09f8 9A        		.byte	0x9a
 2525 09f9 DA09 0000 		.long	0x9da
 2526 09fd 01        		.byte	0x1
 2527 09fe 05        		.byte	0x5
 2528 09ff 03        		.byte	0x3
 2529 0a00 0000 0000 		.long	twiRX_Ptr
 2530 0a04 26        		.uleb128 0x26
 2531 0a05 0000 0000 		.long	.LASF60
 2532 0a09 01        		.byte	0x1
 2533 0a0a 9C        		.byte	0x9c
 2534 0a0b 8D09 0000 		.long	0x98d
 2535 0a0f 01        		.byte	0x1
 2536 0a10 05        		.byte	0x5
 2537 0a11 03        		.byte	0x3
 2538 0a12 0000 0000 		.long	twiST_Count
 2539 0a16 26        		.uleb128 0x26
 2540 0a17 0000 0000 		.long	.LASF61
 2541 0a1b 01        		.byte	0x1
 2542 0a1c 9D        		.byte	0x9d
 2543 0a1d DA09 0000 		.long	0x9da
 2544 0a21 01        		.byte	0x1
 2545 0a22 05        		.byte	0x5
 2546 0a23 03        		.byte	0x3
 2547 0a24 0000 0000 		.long	twiST_Ptr
 2548 0a28 28        		.uleb128 0x28
 2549 0a29 26        		.uleb128 0x26
 2550 0a2a 0000 0000 		.long	.LASF62
GAS LISTING /tmp/ccB4vTv5.s 			page 54


 2551 0a2e 01        		.byte	0x1
 2552 0a2f 9F        		.byte	0x9f
 2553 0a30 3B0A 0000 		.long	0xa3b
 2554 0a34 01        		.byte	0x1
 2555 0a35 05        		.byte	0x5
 2556 0a36 03        		.byte	0x3
 2557 0a37 0000 0000 		.long	twiHookRestart
 2558 0a3b 05        		.uleb128 0x5
 2559 0a3c 02        		.byte	0x2
 2560 0a3d 280A 0000 		.long	0xa28
 2561 0a41 26        		.uleb128 0x26
 2562 0a42 0000 0000 		.long	.LASF63
 2563 0a46 01        		.byte	0x1
 2564 0a47 A0        		.byte	0xa0
 2565 0a48 3B0A 0000 		.long	0xa3b
 2566 0a4c 01        		.byte	0x1
 2567 0a4d 05        		.byte	0x5
 2568 0a4e 03        		.byte	0x3
 2569 0a4f 0000 0000 		.long	twiMasterReader
 2570 0a53 26        		.uleb128 0x26
 2571 0a54 0000 0000 		.long	.LASF64
 2572 0a58 01        		.byte	0x1
 2573 0a59 A1        		.byte	0xa1
 2574 0a5a 3B0A 0000 		.long	0xa3b
 2575 0a5e 01        		.byte	0x1
 2576 0a5f 05        		.byte	0x5
 2577 0a60 03        		.byte	0x3
 2578 0a61 0000 0000 		.long	twiSlaveReader
 2579 0a65 26        		.uleb128 0x26
 2580 0a66 0000 0000 		.long	.LASF65
 2581 0a6a 01        		.byte	0x1
 2582 0a6b A2        		.byte	0xa2
 2583 0a6c 3B0A 0000 		.long	0xa3b
 2584 0a70 01        		.byte	0x1
 2585 0a71 05        		.byte	0x5
 2586 0a72 03        		.byte	0x3
 2587 0a73 0000 0000 		.long	twiSlaveWriter
 2588 0a77 11        		.uleb128 0x11
 2589 0a78 0000 0000 		.long	.LASF66
 2590 0a7c 01        		.byte	0x1
 2591 0a7d AA        		.byte	0xaa
 2592 0a7e 880A 0000 		.long	0xa88
 2593 0a82 05        		.byte	0x5
 2594 0a83 03        		.byte	0x3
 2595 0a84 0000 0000 		.long	_ZL12twiStatistic
 2596 0a88 27        		.uleb128 0x27
 2597 0a89 6401 0000 		.long	0x164
 2598 0a8d 29        		.uleb128 0x29
 2599 0a8e 0000 0000 		.long	.LASF67
 2600 0a92 02        		.byte	0x2
 2601 0a93 DB01      		.word	0x1db
 2602 0a95 3000 0000 		.long	0x30
 2603 0a99 01        		.byte	0x1
 2604 0a9a 05        		.byte	0x5
 2605 0a9b 03        		.byte	0x3
 2606 0a9c 0000 0000 		.long	lcdModes
 2607 0aa0 29        		.uleb128 0x29
GAS LISTING /tmp/ccB4vTv5.s 			page 55


 2608 0aa1 0000 0000 		.long	.LASF68
 2609 0aa5 02        		.byte	0x2
 2610 0aa6 DC01      		.word	0x1dc
 2611 0aa8 3000 0000 		.long	0x30
 2612 0aac 01        		.byte	0x1
 2613 0aad 05        		.byte	0x5
 2614 0aae 03        		.byte	0x3
 2615 0aaf 0000 0000 		.long	lcdShifts
 2616 0ab3 29        		.uleb128 0x29
 2617 0ab4 0000 0000 		.long	.LASF69
 2618 0ab8 02        		.byte	0x2
 2619 0ab9 DD01      		.word	0x1dd
 2620 0abb 3000 0000 		.long	0x30
 2621 0abf 01        		.byte	0x1
 2622 0ac0 05        		.byte	0x5
 2623 0ac1 03        		.byte	0x3
 2624 0ac2 0000 0000 		.long	lcdShows
 2625 0ac6 29        		.uleb128 0x29
 2626 0ac7 0000 0000 		.long	.LASF70
 2627 0acb 02        		.byte	0x2
 2628 0acc DE01      		.word	0x1de
 2629 0ace 3000 0000 		.long	0x30
 2630 0ad2 01        		.byte	0x1
 2631 0ad3 05        		.byte	0x5
 2632 0ad4 03        		.byte	0x3
 2633 0ad5 0000 0000 		.long	lcdBackLight
 2634 0ad9 29        		.uleb128 0x29
 2635 0ada 0000 0000 		.long	.LASF71
 2636 0ade 02        		.byte	0x2
 2637 0adf E001      		.word	0x1e0
 2638 0ae1 3000 0000 		.long	0x30
 2639 0ae5 01        		.byte	0x1
 2640 0ae6 05        		.byte	0x5
 2641 0ae7 03        		.byte	0x3
 2642 0ae8 0000 0000 		.long	lcdAddress
 2643 0aec 29        		.uleb128 0x29
 2644 0aed 0000 0000 		.long	.LASF72
 2645 0af1 02        		.byte	0x2
 2646 0af2 E101      		.word	0x1e1
 2647 0af4 3000 0000 		.long	0x30
 2648 0af8 01        		.byte	0x1
 2649 0af9 05        		.byte	0x5
 2650 0afa 03        		.byte	0x3
 2651 0afb 0000 0000 		.long	lcdCols
 2652 0aff 29        		.uleb128 0x29
 2653 0b00 0000 0000 		.long	.LASF73
 2654 0b04 02        		.byte	0x2
 2655 0b05 E201      		.word	0x1e2
 2656 0b07 3000 0000 		.long	0x30
 2657 0b0b 01        		.byte	0x1
 2658 0b0c 05        		.byte	0x5
 2659 0b0d 03        		.byte	0x3
 2660 0b0e 0000 0000 		.long	lcdRows
 2661 0b12 2A        		.uleb128 0x2a
 2662 0b13 3B00 0000 		.long	0x3b
 2663 0b17 220B 0000 		.long	0xb22
 2664 0b1b 2B        		.uleb128 0x2b
GAS LISTING /tmp/ccB4vTv5.s 			page 56


 2665 0b1c 220B 0000 		.long	0xb22
 2666 0b20 05        		.byte	0x5
 2667 0b21 00        		.byte	0
 2668 0b22 02        		.uleb128 0x2
 2669 0b23 02        		.byte	0x2
 2670 0b24 07        		.byte	0x7
 2671 0b25 0000 0000 		.long	.LASF74
 2672 0b29 29        		.uleb128 0x29
 2673 0b2a 0000 0000 		.long	.LASF75
 2674 0b2e 02        		.byte	0x2
 2675 0b2f E301      		.word	0x1e3
 2676 0b31 120B 0000 		.long	0xb12
 2677 0b35 01        		.byte	0x1
 2678 0b36 05        		.byte	0x5
 2679 0b37 03        		.byte	0x3
 2680 0b38 0000 0000 		.long	lcdBuffer
 2681 0b3c 2C        		.uleb128 0x2c
 2682 0b3d 01        		.byte	0x1
 2683 0b3e 0000 0000 		.long	.LASF84
 2684 0b42 04        		.byte	0x4
 2685 0b43 E101      		.word	0x1e1
 2686 0b45 01        		.byte	0x1
 2687 0b46 2D        		.uleb128 0x2d
 2688 0b47 4900 0000 		.long	0x49
 2689 0b4b 00        		.byte	0
 2690 0b4c 00        		.byte	0
 2691               		.section	.debug_abbrev,"",@progbits
 2692               	.Ldebug_abbrev0:
 2693 0000 01        		.uleb128 0x1
 2694 0001 11        		.uleb128 0x11
 2695 0002 01        		.byte	0x1
 2696 0003 25        		.uleb128 0x25
 2697 0004 0E        		.uleb128 0xe
 2698 0005 13        		.uleb128 0x13
 2699 0006 0B        		.uleb128 0xb
 2700 0007 03        		.uleb128 0x3
 2701 0008 0E        		.uleb128 0xe
 2702 0009 1B        		.uleb128 0x1b
 2703 000a 0E        		.uleb128 0xe
 2704 000b 55        		.uleb128 0x55
 2705 000c 06        		.uleb128 0x6
 2706 000d 11        		.uleb128 0x11
 2707 000e 01        		.uleb128 0x1
 2708 000f 52        		.uleb128 0x52
 2709 0010 01        		.uleb128 0x1
 2710 0011 10        		.uleb128 0x10
 2711 0012 06        		.uleb128 0x6
 2712 0013 00        		.byte	0
 2713 0014 00        		.byte	0
 2714 0015 02        		.uleb128 0x2
 2715 0016 24        		.uleb128 0x24
 2716 0017 00        		.byte	0
 2717 0018 0B        		.uleb128 0xb
 2718 0019 0B        		.uleb128 0xb
 2719 001a 3E        		.uleb128 0x3e
 2720 001b 0B        		.uleb128 0xb
 2721 001c 03        		.uleb128 0x3
GAS LISTING /tmp/ccB4vTv5.s 			page 57


 2722 001d 0E        		.uleb128 0xe
 2723 001e 00        		.byte	0
 2724 001f 00        		.byte	0
 2725 0020 03        		.uleb128 0x3
 2726 0021 16        		.uleb128 0x16
 2727 0022 00        		.byte	0
 2728 0023 03        		.uleb128 0x3
 2729 0024 0E        		.uleb128 0xe
 2730 0025 3A        		.uleb128 0x3a
 2731 0026 0B        		.uleb128 0xb
 2732 0027 3B        		.uleb128 0x3b
 2733 0028 0B        		.uleb128 0xb
 2734 0029 49        		.uleb128 0x49
 2735 002a 13        		.uleb128 0x13
 2736 002b 00        		.byte	0
 2737 002c 00        		.byte	0
 2738 002d 04        		.uleb128 0x4
 2739 002e 24        		.uleb128 0x24
 2740 002f 00        		.byte	0
 2741 0030 0B        		.uleb128 0xb
 2742 0031 0B        		.uleb128 0xb
 2743 0032 3E        		.uleb128 0x3e
 2744 0033 0B        		.uleb128 0xb
 2745 0034 03        		.uleb128 0x3
 2746 0035 08        		.uleb128 0x8
 2747 0036 00        		.byte	0
 2748 0037 00        		.byte	0
 2749 0038 05        		.uleb128 0x5
 2750 0039 0F        		.uleb128 0xf
 2751 003a 00        		.byte	0
 2752 003b 0B        		.uleb128 0xb
 2753 003c 0B        		.uleb128 0xb
 2754 003d 49        		.uleb128 0x49
 2755 003e 13        		.uleb128 0x13
 2756 003f 00        		.byte	0
 2757 0040 00        		.byte	0
 2758 0041 06        		.uleb128 0x6
 2759 0042 26        		.uleb128 0x26
 2760 0043 00        		.byte	0
 2761 0044 00        		.byte	0
 2762 0045 00        		.byte	0
 2763 0046 07        		.uleb128 0x7
 2764 0047 04        		.uleb128 0x4
 2765 0048 01        		.byte	0x1
 2766 0049 03        		.uleb128 0x3
 2767 004a 0E        		.uleb128 0xe
 2768 004b 0B        		.uleb128 0xb
 2769 004c 0B        		.uleb128 0xb
 2770 004d 3A        		.uleb128 0x3a
 2771 004e 0B        		.uleb128 0xb
 2772 004f 3B        		.uleb128 0x3b
 2773 0050 0B        		.uleb128 0xb
 2774 0051 01        		.uleb128 0x1
 2775 0052 13        		.uleb128 0x13
 2776 0053 00        		.byte	0
 2777 0054 00        		.byte	0
 2778 0055 08        		.uleb128 0x8
GAS LISTING /tmp/ccB4vTv5.s 			page 58


 2779 0056 28        		.uleb128 0x28
 2780 0057 00        		.byte	0
 2781 0058 03        		.uleb128 0x3
 2782 0059 0E        		.uleb128 0xe
 2783 005a 1C        		.uleb128 0x1c
 2784 005b 0D        		.uleb128 0xd
 2785 005c 00        		.byte	0
 2786 005d 00        		.byte	0
 2787 005e 09        		.uleb128 0x9
 2788 005f 13        		.uleb128 0x13
 2789 0060 01        		.byte	0x1
 2790 0061 0B        		.uleb128 0xb
 2791 0062 0B        		.uleb128 0xb
 2792 0063 3A        		.uleb128 0x3a
 2793 0064 0B        		.uleb128 0xb
 2794 0065 3B        		.uleb128 0x3b
 2795 0066 0B        		.uleb128 0xb
 2796 0067 8740      		.uleb128 0x2007
 2797 0069 0E        		.uleb128 0xe
 2798 006a 01        		.uleb128 0x1
 2799 006b 13        		.uleb128 0x13
 2800 006c 00        		.byte	0
 2801 006d 00        		.byte	0
 2802 006e 0A        		.uleb128 0xa
 2803 006f 0D        		.uleb128 0xd
 2804 0070 00        		.byte	0
 2805 0071 03        		.uleb128 0x3
 2806 0072 0E        		.uleb128 0xe
 2807 0073 3A        		.uleb128 0x3a
 2808 0074 0B        		.uleb128 0xb
 2809 0075 3B        		.uleb128 0x3b
 2810 0076 0B        		.uleb128 0xb
 2811 0077 49        		.uleb128 0x49
 2812 0078 13        		.uleb128 0x13
 2813 0079 38        		.uleb128 0x38
 2814 007a 0A        		.uleb128 0xa
 2815 007b 00        		.byte	0
 2816 007c 00        		.byte	0
 2817 007d 0B        		.uleb128 0xb
 2818 007e 0D        		.uleb128 0xd
 2819 007f 00        		.byte	0
 2820 0080 03        		.uleb128 0x3
 2821 0081 08        		.uleb128 0x8
 2822 0082 3A        		.uleb128 0x3a
 2823 0083 0B        		.uleb128 0xb
 2824 0084 3B        		.uleb128 0x3b
 2825 0085 0B        		.uleb128 0xb
 2826 0086 49        		.uleb128 0x49
 2827 0087 13        		.uleb128 0x13
 2828 0088 38        		.uleb128 0x38
 2829 0089 0A        		.uleb128 0xa
 2830 008a 00        		.byte	0
 2831 008b 00        		.byte	0
 2832 008c 0C        		.uleb128 0xc
 2833 008d 2E        		.uleb128 0x2e
 2834 008e 01        		.byte	0x1
 2835 008f 3F        		.uleb128 0x3f
GAS LISTING /tmp/ccB4vTv5.s 			page 59


 2836 0090 0C        		.uleb128 0xc
 2837 0091 03        		.uleb128 0x3
 2838 0092 0E        		.uleb128 0xe
 2839 0093 3A        		.uleb128 0x3a
 2840 0094 0B        		.uleb128 0xb
 2841 0095 3B        		.uleb128 0x3b
 2842 0096 0B        		.uleb128 0xb
 2843 0097 20        		.uleb128 0x20
 2844 0098 0B        		.uleb128 0xb
 2845 0099 01        		.uleb128 0x1
 2846 009a 13        		.uleb128 0x13
 2847 009b 00        		.byte	0
 2848 009c 00        		.byte	0
 2849 009d 0D        		.uleb128 0xd
 2850 009e 05        		.uleb128 0x5
 2851 009f 00        		.byte	0
 2852 00a0 03        		.uleb128 0x3
 2853 00a1 08        		.uleb128 0x8
 2854 00a2 3A        		.uleb128 0x3a
 2855 00a3 0B        		.uleb128 0xb
 2856 00a4 3B        		.uleb128 0x3b
 2857 00a5 0B        		.uleb128 0xb
 2858 00a6 49        		.uleb128 0x49
 2859 00a7 13        		.uleb128 0x13
 2860 00a8 00        		.byte	0
 2861 00a9 00        		.byte	0
 2862 00aa 0E        		.uleb128 0xe
 2863 00ab 2E        		.uleb128 0x2e
 2864 00ac 01        		.byte	0x1
 2865 00ad 3F        		.uleb128 0x3f
 2866 00ae 0C        		.uleb128 0xc
 2867 00af 03        		.uleb128 0x3
 2868 00b0 0E        		.uleb128 0xe
 2869 00b1 3A        		.uleb128 0x3a
 2870 00b2 0B        		.uleb128 0xb
 2871 00b3 3B        		.uleb128 0x3b
 2872 00b4 0B        		.uleb128 0xb
 2873 00b5 11        		.uleb128 0x11
 2874 00b6 01        		.uleb128 0x1
 2875 00b7 12        		.uleb128 0x12
 2876 00b8 01        		.uleb128 0x1
 2877 00b9 40        		.uleb128 0x40
 2878 00ba 0A        		.uleb128 0xa
 2879 00bb 9742      		.uleb128 0x2117
 2880 00bd 0C        		.uleb128 0xc
 2881 00be 01        		.uleb128 0x1
 2882 00bf 13        		.uleb128 0x13
 2883 00c0 00        		.byte	0
 2884 00c1 00        		.byte	0
 2885 00c2 0F        		.uleb128 0xf
 2886 00c3 05        		.uleb128 0x5
 2887 00c4 00        		.byte	0
 2888 00c5 03        		.uleb128 0x3
 2889 00c6 0E        		.uleb128 0xe
 2890 00c7 3A        		.uleb128 0x3a
 2891 00c8 0B        		.uleb128 0xb
 2892 00c9 3B        		.uleb128 0x3b
GAS LISTING /tmp/ccB4vTv5.s 			page 60


 2893 00ca 0B        		.uleb128 0xb
 2894 00cb 49        		.uleb128 0x49
 2895 00cc 13        		.uleb128 0x13
 2896 00cd 02        		.uleb128 0x2
 2897 00ce 06        		.uleb128 0x6
 2898 00cf 00        		.byte	0
 2899 00d0 00        		.byte	0
 2900 00d1 10        		.uleb128 0x10
 2901 00d2 0B        		.uleb128 0xb
 2902 00d3 01        		.byte	0x1
 2903 00d4 11        		.uleb128 0x11
 2904 00d5 01        		.uleb128 0x1
 2905 00d6 12        		.uleb128 0x12
 2906 00d7 01        		.uleb128 0x1
 2907 00d8 00        		.byte	0
 2908 00d9 00        		.byte	0
 2909 00da 11        		.uleb128 0x11
 2910 00db 34        		.uleb128 0x34
 2911 00dc 00        		.byte	0
 2912 00dd 03        		.uleb128 0x3
 2913 00de 0E        		.uleb128 0xe
 2914 00df 3A        		.uleb128 0x3a
 2915 00e0 0B        		.uleb128 0xb
 2916 00e1 3B        		.uleb128 0x3b
 2917 00e2 0B        		.uleb128 0xb
 2918 00e3 49        		.uleb128 0x49
 2919 00e4 13        		.uleb128 0x13
 2920 00e5 02        		.uleb128 0x2
 2921 00e6 0A        		.uleb128 0xa
 2922 00e7 00        		.byte	0
 2923 00e8 00        		.byte	0
 2924 00e9 12        		.uleb128 0x12
 2925 00ea 34        		.uleb128 0x34
 2926 00eb 00        		.byte	0
 2927 00ec 03        		.uleb128 0x3
 2928 00ed 0E        		.uleb128 0xe
 2929 00ee 3A        		.uleb128 0x3a
 2930 00ef 0B        		.uleb128 0xb
 2931 00f0 3B        		.uleb128 0x3b
 2932 00f1 0B        		.uleb128 0xb
 2933 00f2 49        		.uleb128 0x49
 2934 00f3 13        		.uleb128 0x13
 2935 00f4 02        		.uleb128 0x2
 2936 00f5 06        		.uleb128 0x6
 2937 00f6 00        		.byte	0
 2938 00f7 00        		.byte	0
 2939 00f8 13        		.uleb128 0x13
 2940 00f9 2E        		.uleb128 0x2e
 2941 00fa 01        		.byte	0x1
 2942 00fb 3F        		.uleb128 0x3f
 2943 00fc 0C        		.uleb128 0xc
 2944 00fd 03        		.uleb128 0x3
 2945 00fe 0E        		.uleb128 0xe
 2946 00ff 3A        		.uleb128 0x3a
 2947 0100 0B        		.uleb128 0xb
 2948 0101 3B        		.uleb128 0x3b
 2949 0102 0B        		.uleb128 0xb
GAS LISTING /tmp/ccB4vTv5.s 			page 61


 2950 0103 11        		.uleb128 0x11
 2951 0104 01        		.uleb128 0x1
 2952 0105 12        		.uleb128 0x12
 2953 0106 01        		.uleb128 0x1
 2954 0107 40        		.uleb128 0x40
 2955 0108 06        		.uleb128 0x6
 2956 0109 9742      		.uleb128 0x2117
 2957 010b 0C        		.uleb128 0xc
 2958 010c 01        		.uleb128 0x1
 2959 010d 13        		.uleb128 0x13
 2960 010e 00        		.byte	0
 2961 010f 00        		.byte	0
 2962 0110 14        		.uleb128 0x14
 2963 0111 8982 01   		.uleb128 0x4109
 2964 0114 01        		.byte	0x1
 2965 0115 11        		.uleb128 0x11
 2966 0116 01        		.uleb128 0x1
 2967 0117 31        		.uleb128 0x31
 2968 0118 13        		.uleb128 0x13
 2969 0119 00        		.byte	0
 2970 011a 00        		.byte	0
 2971 011b 15        		.uleb128 0x15
 2972 011c 8A82 01   		.uleb128 0x410a
 2973 011f 00        		.byte	0
 2974 0120 02        		.uleb128 0x2
 2975 0121 0A        		.uleb128 0xa
 2976 0122 9142      		.uleb128 0x2111
 2977 0124 0A        		.uleb128 0xa
 2978 0125 00        		.byte	0
 2979 0126 00        		.byte	0
 2980 0127 16        		.uleb128 0x16
 2981 0128 2E        		.uleb128 0x2e
 2982 0129 01        		.byte	0x1
 2983 012a 31        		.uleb128 0x31
 2984 012b 13        		.uleb128 0x13
 2985 012c 11        		.uleb128 0x11
 2986 012d 01        		.uleb128 0x1
 2987 012e 12        		.uleb128 0x12
 2988 012f 01        		.uleb128 0x1
 2989 0130 40        		.uleb128 0x40
 2990 0131 06        		.uleb128 0x6
 2991 0132 9642      		.uleb128 0x2116
 2992 0134 0C        		.uleb128 0xc
 2993 0135 01        		.uleb128 0x1
 2994 0136 13        		.uleb128 0x13
 2995 0137 00        		.byte	0
 2996 0138 00        		.byte	0
 2997 0139 17        		.uleb128 0x17
 2998 013a 05        		.uleb128 0x5
 2999 013b 00        		.byte	0
 3000 013c 31        		.uleb128 0x31
 3001 013d 13        		.uleb128 0x13
 3002 013e 02        		.uleb128 0x2
 3003 013f 06        		.uleb128 0x6
 3004 0140 00        		.byte	0
 3005 0141 00        		.byte	0
 3006 0142 18        		.uleb128 0x18
GAS LISTING /tmp/ccB4vTv5.s 			page 62


 3007 0143 2E        		.uleb128 0x2e
 3008 0144 01        		.byte	0x1
 3009 0145 3F        		.uleb128 0x3f
 3010 0146 0C        		.uleb128 0xc
 3011 0147 03        		.uleb128 0x3
 3012 0148 0E        		.uleb128 0xe
 3013 0149 3A        		.uleb128 0x3a
 3014 014a 0B        		.uleb128 0xb
 3015 014b 3B        		.uleb128 0x3b
 3016 014c 05        		.uleb128 0x5
 3017 014d 11        		.uleb128 0x11
 3018 014e 01        		.uleb128 0x1
 3019 014f 12        		.uleb128 0x12
 3020 0150 01        		.uleb128 0x1
 3021 0151 40        		.uleb128 0x40
 3022 0152 06        		.uleb128 0x6
 3023 0153 9742      		.uleb128 0x2117
 3024 0155 0C        		.uleb128 0xc
 3025 0156 01        		.uleb128 0x1
 3026 0157 13        		.uleb128 0x13
 3027 0158 00        		.byte	0
 3028 0159 00        		.byte	0
 3029 015a 19        		.uleb128 0x19
 3030 015b 34        		.uleb128 0x34
 3031 015c 00        		.byte	0
 3032 015d 03        		.uleb128 0x3
 3033 015e 08        		.uleb128 0x8
 3034 015f 3A        		.uleb128 0x3a
 3035 0160 0B        		.uleb128 0xb
 3036 0161 3B        		.uleb128 0x3b
 3037 0162 05        		.uleb128 0x5
 3038 0163 49        		.uleb128 0x49
 3039 0164 13        		.uleb128 0x13
 3040 0165 02        		.uleb128 0x2
 3041 0166 06        		.uleb128 0x6
 3042 0167 00        		.byte	0
 3043 0168 00        		.byte	0
 3044 0169 1A        		.uleb128 0x1a
 3045 016a 8982 01   		.uleb128 0x4109
 3046 016d 00        		.byte	0
 3047 016e 11        		.uleb128 0x11
 3048 016f 01        		.uleb128 0x1
 3049 0170 31        		.uleb128 0x31
 3050 0171 13        		.uleb128 0x13
 3051 0172 00        		.byte	0
 3052 0173 00        		.byte	0
 3053 0174 1B        		.uleb128 0x1b
 3054 0175 2E        		.uleb128 0x2e
 3055 0176 01        		.byte	0x1
 3056 0177 3F        		.uleb128 0x3f
 3057 0178 0C        		.uleb128 0xc
 3058 0179 03        		.uleb128 0x3
 3059 017a 0E        		.uleb128 0xe
 3060 017b 3A        		.uleb128 0x3a
 3061 017c 0B        		.uleb128 0xb
 3062 017d 3B        		.uleb128 0x3b
 3063 017e 05        		.uleb128 0x5
GAS LISTING /tmp/ccB4vTv5.s 			page 63


 3064 017f 11        		.uleb128 0x11
 3065 0180 01        		.uleb128 0x1
 3066 0181 12        		.uleb128 0x12
 3067 0182 01        		.uleb128 0x1
 3068 0183 40        		.uleb128 0x40
 3069 0184 0A        		.uleb128 0xa
 3070 0185 9742      		.uleb128 0x2117
 3071 0187 0C        		.uleb128 0xc
 3072 0188 01        		.uleb128 0x1
 3073 0189 13        		.uleb128 0x13
 3074 018a 00        		.byte	0
 3075 018b 00        		.byte	0
 3076 018c 1C        		.uleb128 0x1c
 3077 018d 05        		.uleb128 0x5
 3078 018e 00        		.byte	0
 3079 018f 03        		.uleb128 0x3
 3080 0190 0E        		.uleb128 0xe
 3081 0191 3A        		.uleb128 0x3a
 3082 0192 0B        		.uleb128 0xb
 3083 0193 3B        		.uleb128 0x3b
 3084 0194 05        		.uleb128 0x5
 3085 0195 49        		.uleb128 0x49
 3086 0196 13        		.uleb128 0x13
 3087 0197 02        		.uleb128 0x2
 3088 0198 06        		.uleb128 0x6
 3089 0199 00        		.byte	0
 3090 019a 00        		.byte	0
 3091 019b 1D        		.uleb128 0x1d
 3092 019c 8982 01   		.uleb128 0x4109
 3093 019f 01        		.byte	0x1
 3094 01a0 11        		.uleb128 0x11
 3095 01a1 01        		.uleb128 0x1
 3096 01a2 9542      		.uleb128 0x2115
 3097 01a4 0C        		.uleb128 0xc
 3098 01a5 31        		.uleb128 0x31
 3099 01a6 13        		.uleb128 0x13
 3100 01a7 00        		.byte	0
 3101 01a8 00        		.byte	0
 3102 01a9 1E        		.uleb128 0x1e
 3103 01aa 26        		.uleb128 0x26
 3104 01ab 00        		.byte	0
 3105 01ac 49        		.uleb128 0x49
 3106 01ad 13        		.uleb128 0x13
 3107 01ae 00        		.byte	0
 3108 01af 00        		.byte	0
 3109 01b0 1F        		.uleb128 0x1f
 3110 01b1 05        		.uleb128 0x5
 3111 01b2 00        		.byte	0
 3112 01b3 03        		.uleb128 0x3
 3113 01b4 0E        		.uleb128 0xe
 3114 01b5 3A        		.uleb128 0x3a
 3115 01b6 0B        		.uleb128 0xb
 3116 01b7 3B        		.uleb128 0x3b
 3117 01b8 05        		.uleb128 0x5
 3118 01b9 49        		.uleb128 0x49
 3119 01ba 13        		.uleb128 0x13
 3120 01bb 02        		.uleb128 0x2
GAS LISTING /tmp/ccB4vTv5.s 			page 64


 3121 01bc 0A        		.uleb128 0xa
 3122 01bd 00        		.byte	0
 3123 01be 00        		.byte	0
 3124 01bf 20        		.uleb128 0x20
 3125 01c0 05        		.uleb128 0x5
 3126 01c1 00        		.byte	0
 3127 01c2 03        		.uleb128 0x3
 3128 01c3 08        		.uleb128 0x8
 3129 01c4 3A        		.uleb128 0x3a
 3130 01c5 0B        		.uleb128 0xb
 3131 01c6 3B        		.uleb128 0x3b
 3132 01c7 05        		.uleb128 0x5
 3133 01c8 49        		.uleb128 0x49
 3134 01c9 13        		.uleb128 0x13
 3135 01ca 02        		.uleb128 0x2
 3136 01cb 0A        		.uleb128 0xa
 3137 01cc 00        		.byte	0
 3138 01cd 00        		.byte	0
 3139 01ce 21        		.uleb128 0x21
 3140 01cf 34        		.uleb128 0x34
 3141 01d0 00        		.byte	0
 3142 01d1 03        		.uleb128 0x3
 3143 01d2 0E        		.uleb128 0xe
 3144 01d3 3A        		.uleb128 0x3a
 3145 01d4 0B        		.uleb128 0xb
 3146 01d5 3B        		.uleb128 0x3b
 3147 01d6 05        		.uleb128 0x5
 3148 01d7 49        		.uleb128 0x49
 3149 01d8 13        		.uleb128 0x13
 3150 01d9 02        		.uleb128 0x2
 3151 01da 06        		.uleb128 0x6
 3152 01db 00        		.byte	0
 3153 01dc 00        		.byte	0
 3154 01dd 22        		.uleb128 0x22
 3155 01de 05        		.uleb128 0x5
 3156 01df 00        		.byte	0
 3157 01e0 03        		.uleb128 0x3
 3158 01e1 08        		.uleb128 0x8
 3159 01e2 3A        		.uleb128 0x3a
 3160 01e3 0B        		.uleb128 0xb
 3161 01e4 3B        		.uleb128 0x3b
 3162 01e5 05        		.uleb128 0x5
 3163 01e6 49        		.uleb128 0x49
 3164 01e7 13        		.uleb128 0x13
 3165 01e8 02        		.uleb128 0x2
 3166 01e9 06        		.uleb128 0x6
 3167 01ea 00        		.byte	0
 3168 01eb 00        		.byte	0
 3169 01ec 23        		.uleb128 0x23
 3170 01ed 8982 01   		.uleb128 0x4109
 3171 01f0 01        		.byte	0x1
 3172 01f1 11        		.uleb128 0x11
 3173 01f2 01        		.uleb128 0x1
 3174 01f3 31        		.uleb128 0x31
 3175 01f4 13        		.uleb128 0x13
 3176 01f5 01        		.uleb128 0x1
 3177 01f6 13        		.uleb128 0x13
GAS LISTING /tmp/ccB4vTv5.s 			page 65


 3178 01f7 00        		.byte	0
 3179 01f8 00        		.byte	0
 3180 01f9 24        		.uleb128 0x24
 3181 01fa 34        		.uleb128 0x34
 3182 01fb 00        		.byte	0
 3183 01fc 03        		.uleb128 0x3
 3184 01fd 0E        		.uleb128 0xe
 3185 01fe 3A        		.uleb128 0x3a
 3186 01ff 0B        		.uleb128 0xb
 3187 0200 3B        		.uleb128 0x3b
 3188 0201 05        		.uleb128 0x5
 3189 0202 49        		.uleb128 0x49
 3190 0203 13        		.uleb128 0x13
 3191 0204 00        		.byte	0
 3192 0205 00        		.byte	0
 3193 0206 25        		.uleb128 0x25
 3194 0207 2E        		.uleb128 0x2e
 3195 0208 00        		.byte	0
 3196 0209 3F        		.uleb128 0x3f
 3197 020a 0C        		.uleb128 0xc
 3198 020b 03        		.uleb128 0x3
 3199 020c 0E        		.uleb128 0xe
 3200 020d 3A        		.uleb128 0x3a
 3201 020e 0B        		.uleb128 0xb
 3202 020f 3B        		.uleb128 0x3b
 3203 0210 05        		.uleb128 0x5
 3204 0211 11        		.uleb128 0x11
 3205 0212 01        		.uleb128 0x1
 3206 0213 12        		.uleb128 0x12
 3207 0214 01        		.uleb128 0x1
 3208 0215 40        		.uleb128 0x40
 3209 0216 0A        		.uleb128 0xa
 3210 0217 9742      		.uleb128 0x2117
 3211 0219 0C        		.uleb128 0xc
 3212 021a 00        		.byte	0
 3213 021b 00        		.byte	0
 3214 021c 26        		.uleb128 0x26
 3215 021d 34        		.uleb128 0x34
 3216 021e 00        		.byte	0
 3217 021f 03        		.uleb128 0x3
 3218 0220 0E        		.uleb128 0xe
 3219 0221 3A        		.uleb128 0x3a
 3220 0222 0B        		.uleb128 0xb
 3221 0223 3B        		.uleb128 0x3b
 3222 0224 0B        		.uleb128 0xb
 3223 0225 49        		.uleb128 0x49
 3224 0226 13        		.uleb128 0x13
 3225 0227 3F        		.uleb128 0x3f
 3226 0228 0C        		.uleb128 0xc
 3227 0229 02        		.uleb128 0x2
 3228 022a 0A        		.uleb128 0xa
 3229 022b 00        		.byte	0
 3230 022c 00        		.byte	0
 3231 022d 27        		.uleb128 0x27
 3232 022e 35        		.uleb128 0x35
 3233 022f 00        		.byte	0
 3234 0230 49        		.uleb128 0x49
GAS LISTING /tmp/ccB4vTv5.s 			page 66


 3235 0231 13        		.uleb128 0x13
 3236 0232 00        		.byte	0
 3237 0233 00        		.byte	0
 3238 0234 28        		.uleb128 0x28
 3239 0235 15        		.uleb128 0x15
 3240 0236 00        		.byte	0
 3241 0237 00        		.byte	0
 3242 0238 00        		.byte	0
 3243 0239 29        		.uleb128 0x29
 3244 023a 34        		.uleb128 0x34
 3245 023b 00        		.byte	0
 3246 023c 03        		.uleb128 0x3
 3247 023d 0E        		.uleb128 0xe
 3248 023e 3A        		.uleb128 0x3a
 3249 023f 0B        		.uleb128 0xb
 3250 0240 3B        		.uleb128 0x3b
 3251 0241 05        		.uleb128 0x5
 3252 0242 49        		.uleb128 0x49
 3253 0243 13        		.uleb128 0x13
 3254 0244 3F        		.uleb128 0x3f
 3255 0245 0C        		.uleb128 0xc
 3256 0246 02        		.uleb128 0x2
 3257 0247 0A        		.uleb128 0xa
 3258 0248 00        		.byte	0
 3259 0249 00        		.byte	0
 3260 024a 2A        		.uleb128 0x2a
 3261 024b 01        		.uleb128 0x1
 3262 024c 01        		.byte	0x1
 3263 024d 49        		.uleb128 0x49
 3264 024e 13        		.uleb128 0x13
 3265 024f 01        		.uleb128 0x1
 3266 0250 13        		.uleb128 0x13
 3267 0251 00        		.byte	0
 3268 0252 00        		.byte	0
 3269 0253 2B        		.uleb128 0x2b
 3270 0254 21        		.uleb128 0x21
 3271 0255 00        		.byte	0
 3272 0256 49        		.uleb128 0x49
 3273 0257 13        		.uleb128 0x13
 3274 0258 2F        		.uleb128 0x2f
 3275 0259 0B        		.uleb128 0xb
 3276 025a 00        		.byte	0
 3277 025b 00        		.byte	0
 3278 025c 2C        		.uleb128 0x2c
 3279 025d 2E        		.uleb128 0x2e
 3280 025e 01        		.byte	0x1
 3281 025f 3F        		.uleb128 0x3f
 3282 0260 0C        		.uleb128 0xc
 3283 0261 03        		.uleb128 0x3
 3284 0262 0E        		.uleb128 0xe
 3285 0263 3A        		.uleb128 0x3a
 3286 0264 0B        		.uleb128 0xb
 3287 0265 3B        		.uleb128 0x3b
 3288 0266 05        		.uleb128 0x5
 3289 0267 3C        		.uleb128 0x3c
 3290 0268 0C        		.uleb128 0xc
 3291 0269 00        		.byte	0
GAS LISTING /tmp/ccB4vTv5.s 			page 67


 3292 026a 00        		.byte	0
 3293 026b 2D        		.uleb128 0x2d
 3294 026c 05        		.uleb128 0x5
 3295 026d 00        		.byte	0
 3296 026e 49        		.uleb128 0x49
 3297 026f 13        		.uleb128 0x13
 3298 0270 00        		.byte	0
 3299 0271 00        		.byte	0
 3300 0272 00        		.byte	0
 3301               		.section	.debug_loc,"",@progbits
 3302               	.Ldebug_loc0:
 3303               	.LLST0:
 3304 0000 0000 0000 		.long	.LVL0
 3305 0004 0000 0000 		.long	.LVL1
 3306 0008 0C00      		.word	0xc
 3307 000a 66        		.byte	0x66
 3308 000b 93        		.byte	0x93
 3309 000c 01        		.uleb128 0x1
 3310 000d 67        		.byte	0x67
 3311 000e 93        		.byte	0x93
 3312 000f 01        		.uleb128 0x1
 3313 0010 68        		.byte	0x68
 3314 0011 93        		.byte	0x93
 3315 0012 01        		.uleb128 0x1
 3316 0013 69        		.byte	0x69
 3317 0014 93        		.byte	0x93
 3318 0015 01        		.uleb128 0x1
 3319 0016 0000 0000 		.long	.LVL1
 3320 001a 0000 0000 		.long	.LVL2
 3321 001e 0C00      		.word	0xc
 3322 0020 62        		.byte	0x62
 3323 0021 93        		.byte	0x93
 3324 0022 01        		.uleb128 0x1
 3325 0023 63        		.byte	0x63
 3326 0024 93        		.byte	0x93
 3327 0025 01        		.uleb128 0x1
 3328 0026 64        		.byte	0x64
 3329 0027 93        		.byte	0x93
 3330 0028 01        		.uleb128 0x1
 3331 0029 65        		.byte	0x65
 3332 002a 93        		.byte	0x93
 3333 002b 01        		.uleb128 0x1
 3334 002c 0000 0000 		.long	.LVL2
 3335 0030 0000 0000 		.long	.LFE102
 3336 0034 0400      		.word	0x4
 3337 0036 F3        		.byte	0xf3
 3338 0037 01        		.uleb128 0x1
 3339 0038 66        		.byte	0x66
 3340 0039 9F        		.byte	0x9f
 3341 003a 0000 0000 		.long	0
 3342 003e 0000 0000 		.long	0
 3343               	.LLST1:
 3344 0042 0000 0000 		.long	.LVL3
 3345 0046 0000 0000 		.long	.LVL4
 3346 004a 0200      		.word	0x2
 3347 004c 30        		.byte	0x30
 3348 004d 9F        		.byte	0x9f
GAS LISTING /tmp/ccB4vTv5.s 			page 68


 3349 004e 0000 0000 		.long	.LVL4
 3350 0052 0000 0000 		.long	.LFE102
 3351 0056 0100      		.word	0x1
 3352 0058 68        		.byte	0x68
 3353 0059 0000 0000 		.long	0
 3354 005d 0000 0000 		.long	0
 3355               	.LLST2:
 3356 0061 0000 0000 		.long	.LFB103
 3357 0065 0000 0000 		.long	.LCFI0
 3358 0069 0300      		.word	0x3
 3359 006b 92        		.byte	0x92
 3360 006c 20        		.uleb128 0x20
 3361 006d 03        		.sleb128 3
 3362 006e 0000 0000 		.long	.LCFI0
 3363 0072 0000 0000 		.long	.LCFI1
 3364 0076 0300      		.word	0x3
 3365 0078 92        		.byte	0x92
 3366 0079 20        		.uleb128 0x20
 3367 007a 04        		.sleb128 4
 3368 007b 0000 0000 		.long	.LCFI1
 3369 007f 0000 0000 		.long	.LCFI2
 3370 0083 0300      		.word	0x3
 3371 0085 92        		.byte	0x92
 3372 0086 20        		.uleb128 0x20
 3373 0087 05        		.sleb128 5
 3374 0088 0000 0000 		.long	.LCFI2
 3375 008c 0000 0000 		.long	.LCFI3
 3376 0090 0300      		.word	0x3
 3377 0092 92        		.byte	0x92
 3378 0093 20        		.uleb128 0x20
 3379 0094 06        		.sleb128 6
 3380 0095 0000 0000 		.long	.LCFI3
 3381 0099 0000 0000 		.long	.LFE103
 3382 009d 0200      		.word	0x2
 3383 009f 8C        		.byte	0x8c
 3384 00a0 06        		.sleb128 6
 3385 00a1 0000 0000 		.long	0
 3386 00a5 0000 0000 		.long	0
 3387               	.LLST3:
 3388 00a9 0000 0000 		.long	.LVL9
 3389 00ad 0000 0000 		.long	.LVL10-1
 3390 00b1 0C00      		.word	0xc
 3391 00b3 66        		.byte	0x66
 3392 00b4 93        		.byte	0x93
 3393 00b5 01        		.uleb128 0x1
 3394 00b6 67        		.byte	0x67
 3395 00b7 93        		.byte	0x93
 3396 00b8 01        		.uleb128 0x1
 3397 00b9 68        		.byte	0x68
 3398 00ba 93        		.byte	0x93
 3399 00bb 01        		.uleb128 0x1
 3400 00bc 69        		.byte	0x69
 3401 00bd 93        		.byte	0x93
 3402 00be 01        		.uleb128 0x1
 3403 00bf 0000 0000 		.long	.LVL10-1
 3404 00c3 0000 0000 		.long	.LFE103
 3405 00c7 0400      		.word	0x4
GAS LISTING /tmp/ccB4vTv5.s 			page 69


 3406 00c9 F3        		.byte	0xf3
 3407 00ca 01        		.uleb128 0x1
 3408 00cb 66        		.byte	0x66
 3409 00cc 9F        		.byte	0x9f
 3410 00cd 0000 0000 		.long	0
 3411 00d1 0000 0000 		.long	0
 3412               	.LLST4:
 3413 00d5 0000 0000 		.long	.LVL9
 3414 00d9 0000 0000 		.long	.LVL10-1
 3415 00dd 0100      		.word	0x1
 3416 00df 64        		.byte	0x64
 3417 00e0 0000 0000 		.long	.LVL10-1
 3418 00e4 0000 0000 		.long	.LFE103
 3419 00e8 0400      		.word	0x4
 3420 00ea F3        		.byte	0xf3
 3421 00eb 01        		.uleb128 0x1
 3422 00ec 64        		.byte	0x64
 3423 00ed 9F        		.byte	0x9f
 3424 00ee 0000 0000 		.long	0
 3425 00f2 0000 0000 		.long	0
 3426               	.LLST5:
 3427 00f6 0000 0000 		.long	.LFB104
 3428 00fa 0000 0000 		.long	.LCFI4
 3429 00fe 0300      		.word	0x3
 3430 0100 92        		.byte	0x92
 3431 0101 20        		.uleb128 0x20
 3432 0102 03        		.sleb128 3
 3433 0103 0000 0000 		.long	.LCFI4
 3434 0107 0000 0000 		.long	.LFE104
 3435 010b 0300      		.word	0x3
 3436 010d 92        		.byte	0x92
 3437 010e 20        		.uleb128 0x20
 3438 010f 04        		.sleb128 4
 3439 0110 0000 0000 		.long	0
 3440 0114 0000 0000 		.long	0
 3441               	.LLST6:
 3442 0118 0000 0000 		.long	.LVL11
 3443 011c 0000 0000 		.long	.LVL12
 3444 0120 0100      		.word	0x1
 3445 0122 68        		.byte	0x68
 3446 0123 0000 0000 		.long	.LVL12
 3447 0127 0000 0000 		.long	.LVL13
 3448 012b 0400      		.word	0x4
 3449 012d F3        		.byte	0xf3
 3450 012e 01        		.uleb128 0x1
 3451 012f 68        		.byte	0x68
 3452 0130 9F        		.byte	0x9f
 3453 0131 0000 0000 		.long	.LVL13
 3454 0135 0000 0000 		.long	.LVL14
 3455 0139 0100      		.word	0x1
 3456 013b 68        		.byte	0x68
 3457 013c 0000 0000 		.long	.LVL14
 3458 0140 0000 0000 		.long	.LVL15
 3459 0144 0400      		.word	0x4
 3460 0146 F3        		.byte	0xf3
 3461 0147 01        		.uleb128 0x1
 3462 0148 68        		.byte	0x68
GAS LISTING /tmp/ccB4vTv5.s 			page 70


 3463 0149 9F        		.byte	0x9f
 3464 014a 0000 0000 		.long	.LVL15
 3465 014e 0000 0000 		.long	.LVL16-1
 3466 0152 0100      		.word	0x1
 3467 0154 68        		.byte	0x68
 3468 0155 0000 0000 		.long	.LVL16-1
 3469 0159 0000 0000 		.long	.LVL17
 3470 015d 0400      		.word	0x4
 3471 015f F3        		.byte	0xf3
 3472 0160 01        		.uleb128 0x1
 3473 0161 68        		.byte	0x68
 3474 0162 9F        		.byte	0x9f
 3475 0163 0000 0000 		.long	.LVL17
 3476 0167 0000 0000 		.long	.LVL18
 3477 016b 0100      		.word	0x1
 3478 016d 68        		.byte	0x68
 3479 016e 0000 0000 		.long	.LVL18
 3480 0172 0000 0000 		.long	.LFE104
 3481 0176 0400      		.word	0x4
 3482 0178 F3        		.byte	0xf3
 3483 0179 01        		.uleb128 0x1
 3484 017a 68        		.byte	0x68
 3485 017b 9F        		.byte	0x9f
 3486 017c 0000 0000 		.long	0
 3487 0180 0000 0000 		.long	0
 3488               	.LLST7:
 3489 0184 0000 0000 		.long	.LVL15
 3490 0188 0000 0000 		.long	.LVL16-1
 3491 018c 0100      		.word	0x1
 3492 018e 68        		.byte	0x68
 3493 018f 0000 0000 		.long	.LVL16-1
 3494 0193 0000 0000 		.long	.LVL17
 3495 0197 0400      		.word	0x4
 3496 0199 F3        		.byte	0xf3
 3497 019a 01        		.uleb128 0x1
 3498 019b 68        		.byte	0x68
 3499 019c 9F        		.byte	0x9f
 3500 019d 0000 0000 		.long	.LVL17
 3501 01a1 0000 0000 		.long	.LVL18
 3502 01a5 0100      		.word	0x1
 3503 01a7 68        		.byte	0x68
 3504 01a8 0000 0000 		.long	.LVL18
 3505 01ac 0000 0000 		.long	.LVL19
 3506 01b0 0400      		.word	0x4
 3507 01b2 F3        		.byte	0xf3
 3508 01b3 01        		.uleb128 0x1
 3509 01b4 68        		.byte	0x68
 3510 01b5 9F        		.byte	0x9f
 3511 01b6 0000 0000 		.long	0
 3512 01ba 0000 0000 		.long	0
 3513               	.LLST8:
 3514 01be 0000 0000 		.long	.LFB105
 3515 01c2 0000 0000 		.long	.LCFI5
 3516 01c6 0300      		.word	0x3
 3517 01c8 92        		.byte	0x92
 3518 01c9 20        		.uleb128 0x20
 3519 01ca 03        		.sleb128 3
GAS LISTING /tmp/ccB4vTv5.s 			page 71


 3520 01cb 0000 0000 		.long	.LCFI5
 3521 01cf 0000 0000 		.long	.LCFI6
 3522 01d3 0300      		.word	0x3
 3523 01d5 92        		.byte	0x92
 3524 01d6 20        		.uleb128 0x20
 3525 01d7 04        		.sleb128 4
 3526 01d8 0000 0000 		.long	.LCFI6
 3527 01dc 0000 0000 		.long	.LCFI7
 3528 01e0 0300      		.word	0x3
 3529 01e2 92        		.byte	0x92
 3530 01e3 20        		.uleb128 0x20
 3531 01e4 05        		.sleb128 5
 3532 01e5 0000 0000 		.long	.LCFI7
 3533 01e9 0000 0000 		.long	.LCFI8
 3534 01ed 0300      		.word	0x3
 3535 01ef 92        		.byte	0x92
 3536 01f0 20        		.uleb128 0x20
 3537 01f1 06        		.sleb128 6
 3538 01f2 0000 0000 		.long	.LCFI8
 3539 01f6 0000 0000 		.long	.LCFI9
 3540 01fa 0300      		.word	0x3
 3541 01fc 92        		.byte	0x92
 3542 01fd 20        		.uleb128 0x20
 3543 01fe 07        		.sleb128 7
 3544 01ff 0000 0000 		.long	.LCFI9
 3545 0203 0000 0000 		.long	.LCFI10
 3546 0207 0300      		.word	0x3
 3547 0209 92        		.byte	0x92
 3548 020a 20        		.uleb128 0x20
 3549 020b 08        		.sleb128 8
 3550 020c 0000 0000 		.long	.LCFI10
 3551 0210 0000 0000 		.long	.LCFI11
 3552 0214 0300      		.word	0x3
 3553 0216 92        		.byte	0x92
 3554 0217 20        		.uleb128 0x20
 3555 0218 09        		.sleb128 9
 3556 0219 0000 0000 		.long	.LCFI11
 3557 021d 0000 0000 		.long	.LCFI12
 3558 0221 0300      		.word	0x3
 3559 0223 92        		.byte	0x92
 3560 0224 20        		.uleb128 0x20
 3561 0225 0A        		.sleb128 10
 3562 0226 0000 0000 		.long	.LCFI12
 3563 022a 0000 0000 		.long	.LCFI13
 3564 022e 0300      		.word	0x3
 3565 0230 92        		.byte	0x92
 3566 0231 20        		.uleb128 0x20
 3567 0232 0B        		.sleb128 11
 3568 0233 0000 0000 		.long	.LCFI13
 3569 0237 0000 0000 		.long	.LCFI14
 3570 023b 0300      		.word	0x3
 3571 023d 92        		.byte	0x92
 3572 023e 20        		.uleb128 0x20
 3573 023f 0C        		.sleb128 12
 3574 0240 0000 0000 		.long	.LCFI14
 3575 0244 0000 0000 		.long	.LCFI15
 3576 0248 0300      		.word	0x3
GAS LISTING /tmp/ccB4vTv5.s 			page 72


 3577 024a 92        		.byte	0x92
 3578 024b 20        		.uleb128 0x20
 3579 024c 0D        		.sleb128 13
 3580 024d 0000 0000 		.long	.LCFI15
 3581 0251 0000 0000 		.long	.LCFI16
 3582 0255 0300      		.word	0x3
 3583 0257 92        		.byte	0x92
 3584 0258 20        		.uleb128 0x20
 3585 0259 0E        		.sleb128 14
 3586 025a 0000 0000 		.long	.LCFI16
 3587 025e 0000 0000 		.long	.LCFI17
 3588 0262 0300      		.word	0x3
 3589 0264 92        		.byte	0x92
 3590 0265 20        		.uleb128 0x20
 3591 0266 0F        		.sleb128 15
 3592 0267 0000 0000 		.long	.LCFI17
 3593 026b 0000 0000 		.long	.LCFI18
 3594 026f 0300      		.word	0x3
 3595 0271 92        		.byte	0x92
 3596 0272 20        		.uleb128 0x20
 3597 0273 10        		.sleb128 16
 3598 0274 0000 0000 		.long	.LCFI18
 3599 0278 0000 0000 		.long	.LFE105
 3600 027c 0300      		.word	0x3
 3601 027e 92        		.byte	0x92
 3602 027f 20        		.uleb128 0x20
 3603 0280 11        		.sleb128 17
 3604 0281 0000 0000 		.long	0
 3605 0285 0000 0000 		.long	0
 3606               	.LLST9:
 3607 0289 0000 0000 		.long	.LVL27
 3608 028d 0000 0000 		.long	.LVL28
 3609 0291 0100      		.word	0x1
 3610 0293 62        		.byte	0x62
 3611 0294 0000 0000 		.long	0
 3612 0298 0000 0000 		.long	0
 3613               	.LLST10:
 3614 029c 0000 0000 		.long	.LVL20
 3615 02a0 0000 0000 		.long	.LVL26-1
 3616 02a4 0100      		.word	0x1
 3617 02a6 68        		.byte	0x68
 3618 02a7 0000 0000 		.long	.LVL27
 3619 02ab 0000 0000 		.long	.LVL28
 3620 02af 0100      		.word	0x1
 3621 02b1 68        		.byte	0x68
 3622 02b2 0000 0000 		.long	0
 3623 02b6 0000 0000 		.long	0
 3624               	.LLST11:
 3625 02ba 0000 0000 		.long	.LVL21
 3626 02be 0000 0000 		.long	.LVL22
 3627 02c2 0100      		.word	0x1
 3628 02c4 69        		.byte	0x69
 3629 02c5 0000 0000 		.long	.LVL23
 3630 02c9 0000 0000 		.long	.LVL24
 3631 02cd 0100      		.word	0x1
 3632 02cf 69        		.byte	0x69
 3633 02d0 0000 0000 		.long	.LVL24
GAS LISTING /tmp/ccB4vTv5.s 			page 73


 3634 02d4 0000 0000 		.long	.LVL25
 3635 02d8 0500      		.word	0x5
 3636 02da 03        		.byte	0x3
 3637 02db 0000 0000 		.long	twiState
 3638 02df 0000 0000 		.long	0
 3639 02e3 0000 0000 		.long	0
 3640               	.LLST12:
 3641 02e7 0000 0000 		.long	.LVL29
 3642 02eb 0000 0000 		.long	.LVL30
 3643 02ef 0100      		.word	0x1
 3644 02f1 68        		.byte	0x68
 3645 02f2 0000 0000 		.long	.LVL30
 3646 02f6 0000 0000 		.long	.LVL31
 3647 02fa 0500      		.word	0x5
 3648 02fc 03        		.byte	0x3
 3649 02fd 0000 0000 		.long	twiSLARW
 3650 0301 0000 0000 		.long	.LVL31
 3651 0305 0000 0000 		.long	.LFE106
 3652 0309 0400      		.word	0x4
 3653 030b F3        		.byte	0xf3
 3654 030c 01        		.uleb128 0x1
 3655 030d 68        		.byte	0x68
 3656 030e 9F        		.byte	0x9f
 3657 030f 0000 0000 		.long	0
 3658 0313 0000 0000 		.long	0
 3659               	.LLST13:
 3660 0317 0000 0000 		.long	.LVL32
 3661 031b 0000 0000 		.long	.LVL33
 3662 031f 0100      		.word	0x1
 3663 0321 68        		.byte	0x68
 3664 0322 0000 0000 		.long	.LVL33
 3665 0326 0000 0000 		.long	.LVL34
 3666 032a 0500      		.word	0x5
 3667 032c 03        		.byte	0x3
 3668 032d 0000 0000 		.long	twiSLARW
 3669 0331 0000 0000 		.long	.LVL34
 3670 0335 0000 0000 		.long	.LFE107
 3671 0339 0400      		.word	0x4
 3672 033b F3        		.byte	0xf3
 3673 033c 01        		.uleb128 0x1
 3674 033d 68        		.byte	0x68
 3675 033e 9F        		.byte	0x9f
 3676 033f 0000 0000 		.long	0
 3677 0343 0000 0000 		.long	0
 3678               	.LLST14:
 3679 0347 0000 0000 		.long	.LVL35
 3680 034b 0000 0000 		.long	.LVL36
 3681 034f 0100      		.word	0x1
 3682 0351 68        		.byte	0x68
 3683 0352 0000 0000 		.long	.LVL36
 3684 0356 0000 0000 		.long	.LFE108
 3685 035a 0400      		.word	0x4
 3686 035c F3        		.byte	0xf3
 3687 035d 01        		.uleb128 0x1
 3688 035e 68        		.byte	0x68
 3689 035f 9F        		.byte	0x9f
 3690 0360 0000 0000 		.long	0
GAS LISTING /tmp/ccB4vTv5.s 			page 74


 3691 0364 0000 0000 		.long	0
 3692               	.LLST15:
 3693 0368 0000 0000 		.long	.LVL35
 3694 036c 0000 0000 		.long	.LVL37-1
 3695 0370 0600      		.word	0x6
 3696 0372 66        		.byte	0x66
 3697 0373 93        		.byte	0x93
 3698 0374 01        		.uleb128 0x1
 3699 0375 67        		.byte	0x67
 3700 0376 93        		.byte	0x93
 3701 0377 01        		.uleb128 0x1
 3702 0378 0000 0000 		.long	.LVL37-1
 3703 037c 0000 0000 		.long	.LFE108
 3704 0380 0400      		.word	0x4
 3705 0382 F3        		.byte	0xf3
 3706 0383 01        		.uleb128 0x1
 3707 0384 66        		.byte	0x66
 3708 0385 9F        		.byte	0x9f
 3709 0386 0000 0000 		.long	0
 3710 038a 0000 0000 		.long	0
 3711               	.LLST16:
 3712 038e 0000 0000 		.long	.LVL35
 3713 0392 0000 0000 		.long	.LVL37-1
 3714 0396 0100      		.word	0x1
 3715 0398 64        		.byte	0x64
 3716 0399 0000 0000 		.long	.LVL37-1
 3717 039d 0000 0000 		.long	.LFE108
 3718 03a1 0400      		.word	0x4
 3719 03a3 F3        		.byte	0xf3
 3720 03a4 01        		.uleb128 0x1
 3721 03a5 64        		.byte	0x64
 3722 03a6 9F        		.byte	0x9f
 3723 03a7 0000 0000 		.long	0
 3724 03ab 0000 0000 		.long	0
 3725               	.LLST17:
 3726 03af 0000 0000 		.long	.LVL38
 3727 03b3 0000 0000 		.long	.LVL39
 3728 03b7 0100      		.word	0x1
 3729 03b9 68        		.byte	0x68
 3730 03ba 0000 0000 		.long	.LVL39
 3731 03be 0000 0000 		.long	.LFE109
 3732 03c2 0400      		.word	0x4
 3733 03c4 F3        		.byte	0xf3
 3734 03c5 01        		.uleb128 0x1
 3735 03c6 68        		.byte	0x68
 3736 03c7 9F        		.byte	0x9f
 3737 03c8 0000 0000 		.long	0
 3738 03cc 0000 0000 		.long	0
 3739               	.LLST18:
 3740 03d0 0000 0000 		.long	.LVL38
 3741 03d4 0000 0000 		.long	.LVL40-1
 3742 03d8 0600      		.word	0x6
 3743 03da 66        		.byte	0x66
 3744 03db 93        		.byte	0x93
 3745 03dc 01        		.uleb128 0x1
 3746 03dd 67        		.byte	0x67
 3747 03de 93        		.byte	0x93
GAS LISTING /tmp/ccB4vTv5.s 			page 75


 3748 03df 01        		.uleb128 0x1
 3749 03e0 0000 0000 		.long	.LVL40-1
 3750 03e4 0000 0000 		.long	.LFE109
 3751 03e8 0400      		.word	0x4
 3752 03ea F3        		.byte	0xf3
 3753 03eb 01        		.uleb128 0x1
 3754 03ec 66        		.byte	0x66
 3755 03ed 9F        		.byte	0x9f
 3756 03ee 0000 0000 		.long	0
 3757 03f2 0000 0000 		.long	0
 3758               	.LLST19:
 3759 03f6 0000 0000 		.long	.LVL38
 3760 03fa 0000 0000 		.long	.LVL40-1
 3761 03fe 0100      		.word	0x1
 3762 0400 64        		.byte	0x64
 3763 0401 0000 0000 		.long	.LVL40-1
 3764 0405 0000 0000 		.long	.LFE109
 3765 0409 0400      		.word	0x4
 3766 040b F3        		.byte	0xf3
 3767 040c 01        		.uleb128 0x1
 3768 040d 64        		.byte	0x64
 3769 040e 9F        		.byte	0x9f
 3770 040f 0000 0000 		.long	0
 3771 0413 0000 0000 		.long	0
 3772               	.LLST20:
 3773 0417 0000 0000 		.long	.LFB110
 3774 041b 0000 0000 		.long	.LCFI19
 3775 041f 0300      		.word	0x3
 3776 0421 92        		.byte	0x92
 3777 0422 20        		.uleb128 0x20
 3778 0423 03        		.sleb128 3
 3779 0424 0000 0000 		.long	.LCFI19
 3780 0428 0000 0000 		.long	.LFE110
 3781 042c 0300      		.word	0x3
 3782 042e 92        		.byte	0x92
 3783 042f 20        		.uleb128 0x20
 3784 0430 04        		.sleb128 4
 3785 0431 0000 0000 		.long	0
 3786 0435 0000 0000 		.long	0
 3787               	.LLST21:
 3788 0439 0000 0000 		.long	.LVL41
 3789 043d 0000 0000 		.long	.LVL42
 3790 0441 0100      		.word	0x1
 3791 0443 68        		.byte	0x68
 3792 0444 0000 0000 		.long	.LVL42
 3793 0448 0000 0000 		.long	.LFE110
 3794 044c 0400      		.word	0x4
 3795 044e F3        		.byte	0xf3
 3796 044f 01        		.uleb128 0x1
 3797 0450 68        		.byte	0x68
 3798 0451 9F        		.byte	0x9f
 3799 0452 0000 0000 		.long	0
 3800 0456 0000 0000 		.long	0
 3801               	.LLST22:
 3802 045a 0000 0000 		.long	.LVL41
 3803 045e 0000 0000 		.long	.LVL43
 3804 0462 0100      		.word	0x1
GAS LISTING /tmp/ccB4vTv5.s 			page 76


 3805 0464 60        		.byte	0x60
 3806 0465 0000 0000 		.long	.LVL43
 3807 0469 0000 0000 		.long	.LFE110
 3808 046d 0400      		.word	0x4
 3809 046f F3        		.byte	0xf3
 3810 0470 01        		.uleb128 0x1
 3811 0471 60        		.byte	0x60
 3812 0472 9F        		.byte	0x9f
 3813 0473 0000 0000 		.long	0
 3814 0477 0000 0000 		.long	0
 3815               	.LLST23:
 3816 047b 0000 0000 		.long	.LVL44
 3817 047f 0000 0000 		.long	.LVL49
 3818 0483 0100      		.word	0x1
 3819 0485 68        		.byte	0x68
 3820 0486 0000 0000 		.long	.LVL49
 3821 048a 0000 0000 		.long	.LFE111
 3822 048e 0400      		.word	0x4
 3823 0490 F3        		.byte	0xf3
 3824 0491 01        		.uleb128 0x1
 3825 0492 68        		.byte	0x68
 3826 0493 9F        		.byte	0x9f
 3827 0494 0000 0000 		.long	0
 3828 0498 0000 0000 		.long	0
 3829               	.LLST24:
 3830 049c 0000 0000 		.long	.LVL45
 3831 04a0 0000 0000 		.long	.LVL47
 3832 04a4 0100      		.word	0x1
 3833 04a6 69        		.byte	0x69
 3834 04a7 0000 0000 		.long	.LVL47
 3835 04ab 0000 0000 		.long	.LVL48
 3836 04af 0500      		.word	0x5
 3837 04b1 89        		.byte	0x89
 3838 04b2 00        		.sleb128 0
 3839 04b3 34        		.byte	0x34
 3840 04b4 21        		.byte	0x21
 3841 04b5 9F        		.byte	0x9f
 3842 04b6 0000 0000 		.long	.LVL48
 3843 04ba 0000 0000 		.long	.LVL50
 3844 04be 0100      		.word	0x1
 3845 04c0 69        		.byte	0x69
 3846 04c1 0000 0000 		.long	.LVL50
 3847 04c5 0000 0000 		.long	.LVL52
 3848 04c9 0100      		.word	0x1
 3849 04cb 68        		.byte	0x68
 3850 04cc 0000 0000 		.long	.LVL52
 3851 04d0 0000 0000 		.long	.LVL53
 3852 04d4 0500      		.word	0x5
 3853 04d6 88        		.byte	0x88
 3854 04d7 00        		.sleb128 0
 3855 04d8 34        		.byte	0x34
 3856 04d9 21        		.byte	0x21
 3857 04da 9F        		.byte	0x9f
 3858 04db 0000 0000 		.long	.LVL53
 3859 04df 0000 0000 		.long	.LFE111
 3860 04e3 0100      		.word	0x1
 3861 04e5 68        		.byte	0x68
GAS LISTING /tmp/ccB4vTv5.s 			page 77


 3862 04e6 0000 0000 		.long	0
 3863 04ea 0000 0000 		.long	0
 3864               	.LLST25:
 3865 04ee 0000 0000 		.long	.LFB112
 3866 04f2 0000 0000 		.long	.LCFI20
 3867 04f6 0300      		.word	0x3
 3868 04f8 92        		.byte	0x92
 3869 04f9 20        		.uleb128 0x20
 3870 04fa 03        		.sleb128 3
 3871 04fb 0000 0000 		.long	.LCFI20
 3872 04ff 0000 0000 		.long	.LCFI21
 3873 0503 0300      		.word	0x3
 3874 0505 92        		.byte	0x92
 3875 0506 20        		.uleb128 0x20
 3876 0507 04        		.sleb128 4
 3877 0508 0000 0000 		.long	.LCFI21
 3878 050c 0000 0000 		.long	.LCFI22
 3879 0510 0300      		.word	0x3
 3880 0512 92        		.byte	0x92
 3881 0513 20        		.uleb128 0x20
 3882 0514 05        		.sleb128 5
 3883 0515 0000 0000 		.long	.LCFI22
 3884 0519 0000 0000 		.long	.LFE112
 3885 051d 0300      		.word	0x3
 3886 051f 92        		.byte	0x92
 3887 0520 20        		.uleb128 0x20
 3888 0521 06        		.sleb128 6
 3889 0522 0000 0000 		.long	0
 3890 0526 0000 0000 		.long	0
 3891               	.LLST26:
 3892 052a 0000 0000 		.long	.LVL54
 3893 052e 0000 0000 		.long	.LVL56
 3894 0532 0600      		.word	0x6
 3895 0534 68        		.byte	0x68
 3896 0535 93        		.byte	0x93
 3897 0536 01        		.uleb128 0x1
 3898 0537 69        		.byte	0x69
 3899 0538 93        		.byte	0x93
 3900 0539 01        		.uleb128 0x1
 3901 053a 0000 0000 		.long	.LVL56
 3902 053e 0000 0000 		.long	.LFE112
 3903 0542 0400      		.word	0x4
 3904 0544 F3        		.byte	0xf3
 3905 0545 01        		.uleb128 0x1
 3906 0546 68        		.byte	0x68
 3907 0547 9F        		.byte	0x9f
 3908 0548 0000 0000 		.long	0
 3909 054c 0000 0000 		.long	0
 3910               	.LLST27:
 3911 0550 0000 0000 		.long	.LVL54
 3912 0554 0000 0000 		.long	.LVL56
 3913 0558 0100      		.word	0x1
 3914 055a 66        		.byte	0x66
 3915 055b 0000 0000 		.long	.LVL56
 3916 055f 0000 0000 		.long	.LFE112
 3917 0563 0400      		.word	0x4
 3918 0565 F3        		.byte	0xf3
GAS LISTING /tmp/ccB4vTv5.s 			page 78


 3919 0566 01        		.uleb128 0x1
 3920 0567 66        		.byte	0x66
 3921 0568 9F        		.byte	0x9f
 3922 0569 0000 0000 		.long	0
 3923 056d 0000 0000 		.long	0
 3924               	.LLST28:
 3925 0571 0000 0000 		.long	.LVL55
 3926 0575 0000 0000 		.long	.LVL56
 3927 0579 0600      		.word	0x6
 3928 057b 68        		.byte	0x68
 3929 057c 93        		.byte	0x93
 3930 057d 01        		.uleb128 0x1
 3931 057e 69        		.byte	0x69
 3932 057f 93        		.byte	0x93
 3933 0580 01        		.uleb128 0x1
 3934 0581 0000 0000 		.long	.LVL56
 3935 0585 0000 0000 		.long	.LVL57
 3936 0589 0600      		.word	0x6
 3937 058b 6C        		.byte	0x6c
 3938 058c 93        		.byte	0x93
 3939 058d 01        		.uleb128 0x1
 3940 058e 6D        		.byte	0x6d
 3941 058f 93        		.byte	0x93
 3942 0590 01        		.uleb128 0x1
 3943 0591 0000 0000 		.long	.LVL57
 3944 0595 0000 0000 		.long	.LVL58
 3945 0599 0300      		.word	0x3
 3946 059b 8C        		.byte	0x8c
 3947 059c 01        		.sleb128 1
 3948 059d 9F        		.byte	0x9f
 3949 059e 0000 0000 		.long	.LVL58
 3950 05a2 0000 0000 		.long	.LVL63
 3951 05a6 0600      		.word	0x6
 3952 05a8 6C        		.byte	0x6c
 3953 05a9 93        		.byte	0x93
 3954 05aa 01        		.uleb128 0x1
 3955 05ab 6D        		.byte	0x6d
 3956 05ac 93        		.byte	0x93
 3957 05ad 01        		.uleb128 0x1
 3958 05ae 0000 0000 		.long	0
 3959 05b2 0000 0000 		.long	0
 3960               	.LLST29:
 3961 05b6 0000 0000 		.long	.LVL55
 3962 05ba 0000 0000 		.long	.LVL56
 3963 05be 0100      		.word	0x1
 3964 05c0 66        		.byte	0x66
 3965 05c1 0000 0000 		.long	.LVL56
 3966 05c5 0000 0000 		.long	.LVL58
 3967 05c9 0C00      		.word	0xc
 3968 05cb 8C        		.byte	0x8c
 3969 05cc 00        		.sleb128 0
 3970 05cd 20        		.byte	0x20
 3971 05ce F3        		.byte	0xf3
 3972 05cf 01        		.uleb128 0x1
 3973 05d0 66        		.byte	0x66
 3974 05d1 22        		.byte	0x22
 3975 05d2 F3        		.byte	0xf3
GAS LISTING /tmp/ccB4vTv5.s 			page 79


 3976 05d3 01        		.uleb128 0x1
 3977 05d4 68        		.byte	0x68
 3978 05d5 22        		.byte	0x22
 3979 05d6 9F        		.byte	0x9f
 3980 05d7 0000 0000 		.long	.LVL58
 3981 05db 0000 0000 		.long	.LVL62
 3982 05df 0B00      		.word	0xb
 3983 05e1 F3        		.byte	0xf3
 3984 05e2 01        		.uleb128 0x1
 3985 05e3 66        		.byte	0x66
 3986 05e4 8C        		.byte	0x8c
 3987 05e5 00        		.sleb128 0
 3988 05e6 1C        		.byte	0x1c
 3989 05e7 F3        		.byte	0xf3
 3990 05e8 01        		.uleb128 0x1
 3991 05e9 68        		.byte	0x68
 3992 05ea 22        		.byte	0x22
 3993 05eb 9F        		.byte	0x9f
 3994 05ec 0000 0000 		.long	.LVL62
 3995 05f0 0000 0000 		.long	.LVL63
 3996 05f4 0C00      		.word	0xc
 3997 05f6 8C        		.byte	0x8c
 3998 05f7 00        		.sleb128 0
 3999 05f8 20        		.byte	0x20
 4000 05f9 F3        		.byte	0xf3
 4001 05fa 01        		.uleb128 0x1
 4002 05fb 66        		.byte	0x66
 4003 05fc 22        		.byte	0x22
 4004 05fd F3        		.byte	0xf3
 4005 05fe 01        		.uleb128 0x1
 4006 05ff 68        		.byte	0x68
 4007 0600 22        		.byte	0x22
 4008 0601 9F        		.byte	0x9f
 4009 0602 0000 0000 		.long	0
 4010 0606 0000 0000 		.long	0
 4011               	.LLST30:
 4012 060a 0000 0000 		.long	.LFB114
 4013 060e 0000 0000 		.long	.LCFI23
 4014 0612 0300      		.word	0x3
 4015 0614 92        		.byte	0x92
 4016 0615 20        		.uleb128 0x20
 4017 0616 03        		.sleb128 3
 4018 0617 0000 0000 		.long	.LCFI23
 4019 061b 0000 0000 		.long	.LFE114
 4020 061f 0300      		.word	0x3
 4021 0621 92        		.byte	0x92
 4022 0622 20        		.uleb128 0x20
 4023 0623 04        		.sleb128 4
 4024 0624 0000 0000 		.long	0
 4025 0628 0000 0000 		.long	0
 4026               	.LLST31:
 4027 062c 0000 0000 		.long	.LVL80
 4028 0630 0000 0000 		.long	.LVL81
 4029 0634 0100      		.word	0x1
 4030 0636 68        		.byte	0x68
 4031 0637 0000 0000 		.long	.LVL81
 4032 063b 0000 0000 		.long	.LVL82
GAS LISTING /tmp/ccB4vTv5.s 			page 80


 4033 063f 0500      		.word	0x5
 4034 0641 03        		.byte	0x3
 4035 0642 0000 0000 		.long	lcdAddress
 4036 0646 0000 0000 		.long	.LVL82
 4037 064a 0000 0000 		.long	.LVL83
 4038 064e 0100      		.word	0x1
 4039 0650 68        		.byte	0x68
 4040 0651 0000 0000 		.long	.LVL83
 4041 0655 0000 0000 		.long	.LVL86-1
 4042 0659 0500      		.word	0x5
 4043 065b 03        		.byte	0x3
 4044 065c 0000 0000 		.long	lcdAddress
 4045 0660 0000 0000 		.long	.LVL86-1
 4046 0664 0000 0000 		.long	.LFE114
 4047 0668 0400      		.word	0x4
 4048 066a F3        		.byte	0xf3
 4049 066b 01        		.uleb128 0x1
 4050 066c 68        		.byte	0x68
 4051 066d 9F        		.byte	0x9f
 4052 066e 0000 0000 		.long	0
 4053 0672 0000 0000 		.long	0
 4054               	.LLST32:
 4055 0676 0000 0000 		.long	.LVL80
 4056 067a 0000 0000 		.long	.LVL85
 4057 067e 0100      		.word	0x1
 4058 0680 66        		.byte	0x66
 4059 0681 0000 0000 		.long	.LVL85
 4060 0685 0000 0000 		.long	.LVL86-1
 4061 0689 0500      		.word	0x5
 4062 068b 03        		.byte	0x3
 4063 068c 0000 0000 		.long	lcdCols
 4064 0690 0000 0000 		.long	.LVL86-1
 4065 0694 0000 0000 		.long	.LFE114
 4066 0698 0400      		.word	0x4
 4067 069a F3        		.byte	0xf3
 4068 069b 01        		.uleb128 0x1
 4069 069c 66        		.byte	0x66
 4070 069d 9F        		.byte	0x9f
 4071 069e 0000 0000 		.long	0
 4072 06a2 0000 0000 		.long	0
 4073               	.LLST33:
 4074 06a6 0000 0000 		.long	.LVL80
 4075 06aa 0000 0000 		.long	.LVL84
 4076 06ae 0100      		.word	0x1
 4077 06b0 64        		.byte	0x64
 4078 06b1 0000 0000 		.long	.LVL84
 4079 06b5 0000 0000 		.long	.LVL100
 4080 06b9 0100      		.word	0x1
 4081 06bb 6C        		.byte	0x6c
 4082 06bc 0000 0000 		.long	.LVL100
 4083 06c0 0000 0000 		.long	.LFE114
 4084 06c4 0400      		.word	0x4
 4085 06c6 F3        		.byte	0xf3
 4086 06c7 01        		.uleb128 0x1
 4087 06c8 64        		.byte	0x64
 4088 06c9 9F        		.byte	0x9f
 4089 06ca 0000 0000 		.long	0
GAS LISTING /tmp/ccB4vTv5.s 			page 81


 4090 06ce 0000 0000 		.long	0
 4091               	.LLST34:
 4092 06d2 0000 0000 		.long	.LVL80
 4093 06d6 0000 0000 		.long	.LVL86-1
 4094 06da 0100      		.word	0x1
 4095 06dc 62        		.byte	0x62
 4096 06dd 0000 0000 		.long	.LVL86-1
 4097 06e1 0000 0000 		.long	.LFE114
 4098 06e5 0400      		.word	0x4
 4099 06e7 F3        		.byte	0xf3
 4100 06e8 01        		.uleb128 0x1
 4101 06e9 62        		.byte	0x62
 4102 06ea 9F        		.byte	0x9f
 4103 06eb 0000 0000 		.long	0
 4104 06ef 0000 0000 		.long	0
 4105               		.section	.debug_aranges,"",@progbits
 4106 0000 8C00 0000 		.long	0x8c
 4107 0004 0200      		.word	0x2
 4108 0006 0000 0000 		.long	.Ldebug_info0
 4109 000a 04        		.byte	0x4
 4110 000b 00        		.byte	0
 4111 000c 0000      		.word	0
 4112 000e 0000      		.word	0
 4113 0010 0000 0000 		.long	.LFB102
 4114 0014 4800 0000 		.long	.LFE102-.LFB102
 4115 0018 0000 0000 		.long	.LFB103
 4116 001c 3000 0000 		.long	.LFE103-.LFB103
 4117 0020 0000 0000 		.long	.LFB104
 4118 0024 5800 0000 		.long	.LFE104-.LFB104
 4119 0028 0000 0000 		.long	.LFB105
 4120 002c BE00 0000 		.long	.LFE105-.LFB105
 4121 0030 0000 0000 		.long	.LFB106
 4122 0034 2200 0000 		.long	.LFE106-.LFB106
 4123 0038 0000 0000 		.long	.LFB107
 4124 003c 2200 0000 		.long	.LFE107-.LFB107
 4125 0040 0000 0000 		.long	.LFB108
 4126 0044 2400 0000 		.long	.LFE108-.LFB108
 4127 0048 0000 0000 		.long	.LFB109
 4128 004c 2600 0000 		.long	.LFE109-.LFB109
 4129 0050 0000 0000 		.long	.LFB110
 4130 0054 5A00 0000 		.long	.LFE110-.LFB110
 4131 0058 0000 0000 		.long	.LFB111
 4132 005c 3A00 0000 		.long	.LFE111-.LFB111
 4133 0060 0000 0000 		.long	.LFB112
 4134 0064 4400 0000 		.long	.LFE112-.LFB112
 4135 0068 0000 0000 		.long	.LFB113
 4136 006c A400 0000 		.long	.LFE113-.LFB113
 4137 0070 0000 0000 		.long	.LFB114
 4138 0074 DA00 0000 		.long	.LFE114-.LFB114
 4139 0078 0000 0000 		.long	.LFB115
 4140 007c 1600 0000 		.long	.LFE115-.LFB115
 4141 0080 0000 0000 		.long	.LFB116
 4142 0084 0200 0000 		.long	.LFE116-.LFB116
 4143 0088 0000 0000 		.long	0
 4144 008c 0000 0000 		.long	0
 4145               		.section	.debug_ranges,"",@progbits
 4146               	.Ldebug_ranges0:
GAS LISTING /tmp/ccB4vTv5.s 			page 82


 4147 0000 0000 0000 		.long	.LFB102
 4148 0004 0000 0000 		.long	.LFE102
 4149 0008 0000 0000 		.long	.LFB103
 4150 000c 0000 0000 		.long	.LFE103
 4151 0010 0000 0000 		.long	.LFB104
 4152 0014 0000 0000 		.long	.LFE104
 4153 0018 0000 0000 		.long	.LFB105
 4154 001c 0000 0000 		.long	.LFE105
 4155 0020 0000 0000 		.long	.LFB106
 4156 0024 0000 0000 		.long	.LFE106
 4157 0028 0000 0000 		.long	.LFB107
 4158 002c 0000 0000 		.long	.LFE107
 4159 0030 0000 0000 		.long	.LFB108
 4160 0034 0000 0000 		.long	.LFE108
 4161 0038 0000 0000 		.long	.LFB109
 4162 003c 0000 0000 		.long	.LFE109
 4163 0040 0000 0000 		.long	.LFB110
 4164 0044 0000 0000 		.long	.LFE110
 4165 0048 0000 0000 		.long	.LFB111
 4166 004c 0000 0000 		.long	.LFE111
 4167 0050 0000 0000 		.long	.LFB112
 4168 0054 0000 0000 		.long	.LFE112
 4169 0058 0000 0000 		.long	.LFB113
 4170 005c 0000 0000 		.long	.LFE113
 4171 0060 0000 0000 		.long	.LFB114
 4172 0064 0000 0000 		.long	.LFE114
 4173 0068 0000 0000 		.long	.LFB115
 4174 006c 0000 0000 		.long	.LFE115
 4175 0070 0000 0000 		.long	.LFB116
 4176 0074 0000 0000 		.long	.LFE116
 4177 0078 0000 0000 		.long	0
 4178 007c 0000 0000 		.long	0
 4179               		.section	.debug_line,"",@progbits
 4180               	.Ldebug_line0:
 4181 0000 E602 0000 		.section	.debug_str,"MS",@progbits,1
 4181      0200 B400 
 4181      0000 0201 
 4181      FB0E 0D00 
 4181      0101 0101 
 4182               	.LASF27:
 4183 0000 7477 6953 		.string	"twiSetup"
 4183      6574 7570 
 4183      00
 4184               	.LASF43:
 4185 0009 5F64 6174 		.string	"_data"
 4185      6100 
 4186               	.LASF9:
 4187 000f 6C6F 6E67 		.string	"long long unsigned int"
 4187      206C 6F6E 
 4187      6720 756E 
 4187      7369 676E 
 4187      6564 2069 
 4188               	.LASF18:
 4189 0026 7374 6172 		.string	"starts"
 4189      7473 00
 4190               	.LASF68:
 4191 002d 6C63 6453 		.string	"lcdShifts"
GAS LISTING /tmp/ccB4vTv5.s 			page 83


 4191      6869 6674 
 4191      7300 
 4192               	.LASF58:
 4193 0037 7477 6952 		.string	"twiRX_Count"
 4193      585F 436F 
 4193      756E 7400 
 4194               	.LASF8:
 4195 0043 6C6F 6E67 		.string	"long long int"
 4195      206C 6F6E 
 4195      6720 696E 
 4195      7400 
 4196               	.LASF0:
 4197 0051 7369 676E 		.string	"signed char"
 4197      6564 2063 
 4197      6861 7200 
 4198               	.LASF28:
 4199 005d 6672 6571 		.string	"freq"
 4199      00
 4200               	.LASF20:
 4201 0062 7374 6F70 		.string	"stops"
 4201      7300 
 4202               	.LASF17:
 4203 0068 5457 495F 		.string	"TWI_READY"
 4203      5245 4144 
 4203      5900 
 4204               	.LASF69:
 4205 0072 6C63 6453 		.string	"lcdShows"
 4205      686F 7773 
 4205      00
 4206               	.LASF5:
 4207 007b 6C6F 6E67 		.string	"long int"
 4207      2069 6E74 
 4207      00
 4208               	.LASF30:
 4209 0084 5F5F 7665 		.string	"__vector_39"
 4209      6374 6F72 
 4209      5F33 3900 
 4210               	.LASF66:
 4211 0090 7477 6953 		.string	"twiStatistic"
 4211      7461 7469 
 4211      7374 6963 
 4211      00
 4212               	.LASF3:
 4213 009d 7569 6E74 		.string	"uint16_t"
 4213      3136 5F74 
 4213      00
 4214               	.LASF13:
 4215 00a6 646F 7562 		.string	"double"
 4215      6C65 00
 4216               	.LASF40:
 4217 00ad 636C 656E 		.string	"clength"
 4217      6774 6800 
 4218               	.LASF65:
 4219 00b5 7477 6953 		.string	"twiSlaveWriter"
 4219      6C61 7665 
 4219      5772 6974 
 4219      6572 00
GAS LISTING /tmp/ccB4vTv5.s 			page 84


 4220               	.LASF38:
 4221 00c4 7477 6952 		.string	"twiRAW"
 4221      4157 00
 4222               	.LASF45:
 4223 00cb 6C63 6457 		.string	"lcdWrite"
 4223      7269 7465 
 4223      00
 4224               	.LASF37:
 4225 00d4 7477 6952 		.string	"twiRead"
 4225      6561 6400 
 4226               	.LASF25:
 4227 00dc 6269 744D 		.string	"bitMul"
 4227      756C 00
 4228               	.LASF4:
 4229 00e3 756E 7369 		.string	"unsigned int"
 4229      676E 6564 
 4229      2069 6E74 
 4229      00
 4230               	.LASF71:
 4231 00f0 6C63 6441 		.string	"lcdAddress"
 4231      6464 7265 
 4231      7373 00
 4232               	.LASF59:
 4233 00fb 7477 6952 		.string	"twiRX_Ptr"
 4233      585F 5074 
 4233      7200 
 4234               	.LASF39:
 4235 0105 636F 6D6D 		.string	"command"
 4235      616E 6400 
 4236               	.LASF83:
 4237 010d 6C6F 6F70 		.string	"loop"
 4237      00
 4238               	.LASF47:
 4239 0112 6C63 6453 		.string	"lcdSetup"
 4239      6574 7570 
 4239      00
 4240               	.LASF7:
 4241 011b 6C6F 6E67 		.string	"long unsigned int"
 4241      2075 6E73 
 4241      6967 6E65 
 4241      6420 696E 
 4241      7400 
 4242               	.LASF55:
 4243 012d 7477 6953 		.string	"twiSLARW"
 4243      4C41 5257 
 4243      00
 4244               	.LASF48:
 4245 0136 5F61 6464 		.string	"_address"
 4245      7265 7373 
 4245      00
 4246               	.LASF35:
 4247 013f 6461 7461 		.string	"data"
 4247      00
 4248               	.LASF14:
 4249 0144 7368 6F72 		.string	"short unsigned int"
 4249      7420 756E 
 4249      7369 676E 
GAS LISTING /tmp/ccB4vTv5.s 			page 85


 4249      6564 2069 
 4249      6E74 00
 4250               	.LASF23:
 4251 0157 5457 495F 		.string	"TWI_Stat"
 4251      5374 6174 
 4251      00
 4252               	.LASF50:
 4253 0160 5F72 6F77 		.string	"_rows"
 4253      7300 
 4254               	.LASF10:
 4255 0166 626F 6F6C 		.string	"bool"
 4255      00
 4256               	.LASF53:
 4257 016b 7477 694D 		.string	"twiMode"
 4257      6F64 6500 
 4258               	.LASF63:
 4259 0173 7477 694D 		.string	"twiMasterReader"
 4259      6173 7465 
 4259      7252 6561 
 4259      6465 7200 
 4260               	.LASF79:
 4261 0183 5457 495F 		.string	"TWI_Modes"
 4261      4D6F 6465 
 4261      7300 
 4262               	.LASF56:
 4263 018d 7477 694D 		.string	"twiMT_Count"
 4263      545F 436F 
 4263      756E 7400 
 4264               	.LASF81:
 4265 0199 7477 6953 		.string	"twiSendStop"
 4265      656E 6453 
 4265      746F 7000 
 4266               	.LASF32:
 4267 01a5 6164 6472 		.string	"address"
 4267      6573 7300 
 4268               	.LASF31:
 4269 01ad 5F74 7769 		.string	"_twiStartTo"
 4269      5374 6172 
 4269      7454 6F00 
 4270               	.LASF52:
 4271 01b9 7365 7475 		.string	"setup"
 4271      7000 
 4272               	.LASF12:
 4273 01bf 666C 6F61 		.string	"float"
 4273      7400 
 4274               	.LASF73:
 4275 01c5 6C63 6452 		.string	"lcdRows"
 4275      6F77 7300 
 4276               	.LASF84:
 4277 01cd 7469 6D65 		.string	"time_delay16"
 4277      5F64 656C 
 4277      6179 3136 
 4277      00
 4278               	.LASF57:
 4279 01da 7477 694D 		.string	"twiMT_Ptr"
 4279      545F 5074 
 4279      7200 
GAS LISTING /tmp/ccB4vTv5.s 			page 86


 4280               	.LASF42:
 4281 01e4 6C63 6450 		.string	"lcdPrepare"
 4281      7265 7061 
 4281      7265 00
 4282               	.LASF19:
 4283 01ef 7265 7374 		.string	"restarts"
 4283      6172 7473 
 4283      00
 4284               	.LASF51:
 4285 01f8 5F62 6163 		.string	"_backLight"
 4285      6B4C 6967 
 4285      6874 00
 4286               	.LASF76:
 4287 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4287      432B 2B20 
 4287      342E 382E 
 4287      3120 2D6D 
 4287      6D63 753D 
 4288               	.LASF1:
 4289 0295 756E 7369 		.string	"unsigned char"
 4289      676E 6564 
 4289      2063 6861 
 4289      7200 
 4290               	.LASF49:
 4291 02a3 5F63 6F6C 		.string	"_cols"
 4291      7300 
 4292               	.LASF78:
 4293 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4293      2F62 7569 
 4293      6C64 3132 
 4293      3336 3837 
 4293      3935 3737 
 4294               	.LASF24:
 4295 02cb 6269 7452 		.string	"bitRate"
 4295      6174 6500 
 4296               	.LASF54:
 4297 02d3 7477 6953 		.string	"twiState"
 4297      7461 7465 
 4297      00
 4298               	.LASF77:
 4299 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4299      2F62 7569 
 4299      6C64 3132 
 4299      3336 3837 
 4299      3935 3737 
 4300               	.LASF6:
 4301 030c 7569 6E74 		.string	"uint32_t"
 4301      3332 5F74 
 4301      00
 4302               	.LASF75:
 4303 0315 6C63 6442 		.string	"lcdBuffer"
 4303      7566 6665 
 4303      7200 
 4304               	.LASF22:
 4305 031f 6E6F 736C 		.string	"noslarw"
 4305      6172 7700 
 4306               	.LASF36:
GAS LISTING /tmp/ccB4vTv5.s 			page 87


 4307 0327 6C65 6E67 		.string	"length"
 4307      7468 00
 4308               	.LASF11:
 4309 032e 6368 6172 		.string	"char"
 4309      00
 4310               	.LASF41:
 4311 0333 646C 656E 		.string	"dlength"
 4311      6774 6800 
 4312               	.LASF29:
 4313 033b 6D6F 6465 		.string	"mode"
 4313      00
 4314               	.LASF72:
 4315 0340 6C63 6443 		.string	"lcdCols"
 4315      6F6C 7300 
 4316               	.LASF21:
 4317 0348 6C6F 7374 		.string	"losts"
 4317      7300 
 4318               	.LASF82:
 4319 034e 7469 6D65 		.string	"time"
 4319      00
 4320               	.LASF26:
 4321 0353 7477 6953 		.string	"twiSpeed"
 4321      7065 6564 
 4321      00
 4322               	.LASF16:
 4323 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4323      5345 4E44 
 4323      5F53 544F 
 4323      5000 
 4324               	.LASF70:
 4325 036a 6C63 6442 		.string	"lcdBackLight"
 4325      6163 6B4C 
 4325      6967 6874 
 4325      00
 4326               	.LASF2:
 4327 0377 7569 6E74 		.string	"uint8_t"
 4327      385F 7400 
 4328               	.LASF80:
 4329 037f 3854 5749 		.string	"8TWI_Stat"
 4329      5F53 7461 
 4329      7400 
 4330               	.LASF74:
 4331 0389 7369 7A65 		.string	"sizetype"
 4331      7479 7065 
 4331      00
 4332               	.LASF46:
 4333 0392 6C63 6449 		.string	"lcdInit"
 4333      6E69 7400 
 4334               	.LASF64:
 4335 039a 7477 6953 		.string	"twiSlaveReader"
 4335      6C61 7665 
 4335      5265 6164 
 4335      6572 00
 4336               	.LASF62:
 4337 03a9 7477 6948 		.string	"twiHookRestart"
 4337      6F6F 6B52 
 4337      6573 7461 
GAS LISTING /tmp/ccB4vTv5.s 			page 88


 4337      7274 00
 4338               	.LASF61:
 4339 03b8 7477 6953 		.string	"twiST_Ptr"
 4339      545F 5074 
 4339      7200 
 4340               	.LASF33:
 4341 03c2 5F74 7769 		.string	"_twiStartRe"
 4341      5374 6172 
 4341      7452 6500 
 4342               	.LASF34:
 4343 03ce 7477 6957 		.string	"twiWrite"
 4343      7269 7465 
 4343      00
 4344               	.LASF67:
 4345 03d7 6C63 644D 		.string	"lcdModes"
 4345      6F64 6573 
 4345      00
 4346               	.LASF44:
 4347 03e0 6E69 6262 		.string	"nibble"
 4347      6C65 00
 4348               	.LASF60:
 4349 03e7 7477 6953 		.string	"twiST_Count"
 4349      545F 436F 
 4349      756E 7400 
 4350               	.LASF15:
 4351 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4351      4953 5F53 
 4351      4C41 5645 
 4351      00
 4352               		.ident	"GCC: (GNU) 4.8.1"
 4353               	.global __do_copy_data
 4354               	.global __do_clear_bss
GAS LISTING /tmp/ccB4vTv5.s 			page 89


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccB4vTv5.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccB4vTv5.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccB4vTv5.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccB4vTv5.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccB4vTv5.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccB4vTv5.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccB4vTv5.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccB4vTv5.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccB4vTv5.s:1153   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccB4vTv5.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccB4vTv5.s:1099   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccB4vTv5.s:1141   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccB4vTv5.s:226    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccB4vTv5.s:1147   .bss.twiState:0000000000000000 twiState
     /tmp/ccB4vTv5.s:1135   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccB4vTv5.s:1129   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccB4vTv5.s:399    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccB4vTv5.s:434    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccB4vTv5.s:469    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccB4vTv5.s:502    .text.twiRead:0000000000000000 twiRead
     /tmp/ccB4vTv5.s:1117   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccB4vTv5.s:1123   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccB4vTv5.s:536    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccB4vTv5.s:600    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccB4vTv5.s:1052   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccB4vTv5.s:1028   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccB4vTv5.s:663    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccB4vTv5.s:1046   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccB4vTv5.s:734    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccB4vTv5.s:1070   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccB4vTv5.s:1058   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccB4vTv5.s:1064   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccB4vTv5.s:827    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccB4vTv5.s:1040   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccB4vTv5.s:1034   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccB4vTv5.s:983    .text.setup:0000000000000000 setup
     /tmp/ccB4vTv5.s:1012   .text.loop:0000000000000000 loop
     /tmp/ccB4vTv5.s:1075   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccB4vTv5.s:1081   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccB4vTv5.s:1087   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccB4vTv5.s:1093   .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccB4vTv5.s:1105   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccB4vTv5.s:1111   .bss.twiST_Count:0000000000000000 twiST_Count

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
