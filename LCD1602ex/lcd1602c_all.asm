GAS LISTING /tmp/ccFP0NC0.s 			page 1


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
GAS LISTING /tmp/ccFP0NC0.s 			page 2


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
GAS LISTING /tmp/ccFP0NC0.s 			page 3


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
GAS LISTING /tmp/ccFP0NC0.s 			page 4


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
GAS LISTING /tmp/ccFP0NC0.s 			page 5


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
GAS LISTING /tmp/ccFP0NC0.s 			page 6


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
GAS LISTING /tmp/ccFP0NC0.s 			page 7


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
GAS LISTING /tmp/ccFP0NC0.s 			page 8


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
GAS LISTING /tmp/ccFP0NC0.s 			page 9


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
GAS LISTING /tmp/ccFP0NC0.s 			page 10


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
GAS LISTING /tmp/ccFP0NC0.s 			page 11


 267:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( _st >= TWI_SR_SLA_ACK )
 305               		.loc 1 267 0
 306 0036 9036      		cpi r25,lo8(96)
 307 0038 00F0      		brlo .L22
 268:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 269:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 270:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_ST_DATA_NACK) || (_st == TWI_ST_LAST_DATA) )
 308               		.loc 1 270 0
 309 003a 322F      		mov r19,r18
 310 003c 307F      		andi r19,lo8(-16)
 311 003e 303C      		cpi r19,lo8(-64)
 312 0040 01F4      		brne .L23
 271:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 272:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был последний байт, мастер наелся ..
 273:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // ST: Был наш последний байт: предупреждали масте
 274:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSlaveWriter();                                   // Хук - обязателен!
 313               		.loc 1 274 0
 314 0042 E091 0000 		lds r30,twiSlaveWriter
 315 0046 F091 0000 		lds r31,twiSlaveWriter+1
 316 004a 00C0      		rjmp .L73
 317               	.L23:
 275:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _md=twiMode;                                        // возможно изменен�
 276:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             twiSendStop(_md); return;
 277:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 278:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_ST_ARB_LOST_SLA_ACK) || (_st == TWI_ST_SLA_ACK || _st == TWI_ST_DATA_AC
 318               		.loc 1 278 0
 319 004c 903B      		cpi r25,lo8(-80)
 320 004e 01F0      		breq .L25
 321               		.loc 1 278 0 is_stmt 0 discriminator 1
 322 0050 287E      		andi r18,lo8(-24)
 323 0052 283A      		cpi r18,lo8(-88)
 324 0054 01F4      		brne .L26
 325               	.L25:
 279:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 280:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Моего мастера заткнули и просят данные ..
 281:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Мой адрес, начинаем ..
 282:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // ST: Отправлено успешно, продолжаем ..
 283:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 TWDR = *twiST_Ptr++;
 326               		.loc 1 283 0 is_stmt 1
 327 0056 E091 0000 		lds r30,twiST_Ptr
 328 005a F091 0000 		lds r31,twiST_Ptr+1
 329 005e 9F01      		movw r18,r30
 330 0060 2F5F      		subi r18,-1
 331 0062 3F4F      		sbci r19,-1
 332 0064 3093 0000 		sts twiST_Ptr+1,r19
 333 0068 2093 0000 		sts twiST_Ptr,r18
 334 006c 9081      		ld r25,Z
 335               	.LVL22:
 336 006e 9093 BB00 		sts 187,r25
 337               	.LVL23:
 284:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 _cr = twiReply(--twiST_Count);
 338               		.loc 1 284 0
 339 0072 9091 0000 		lds r25,twiST_Count
 340 0076 9150      		subi r25,lo8(-(-1))
 341 0078 9093 0000 		sts twiST_Count,r25
 342 007c 00C0      		rjmp .L76
 343               	.LVL24:
GAS LISTING /tmp/ccFP0NC0.s 			page 12


 344               	.L26:
 285:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 286:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 287:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_RX)
 288:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) || (_st == TWI_SR_
 345               		.loc 1 288 0 discriminator 1
 346 007e 2838      		cpi r18,lo8(-120)
 347 0080 01F0      		breq .L28
 348 0082 903A      		cpi r25,lo8(-96)
 349 0084 01F4      		brne .L71
 350 0086 00C0      		rjmp .L29
 351               	.L28:
 289:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 290:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) )
 291:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 292:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. GCall - туда же.
 293:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. Получен байт, мастеру уже был отп
 294:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *twiRX_Ptr = TWDR;
 352               		.loc 1 294 0
 353 0088 E091 0000 		lds r30,twiRX_Ptr
 354 008c F091 0000 		lds r31,twiRX_Ptr+1
 355 0090 8091 BB00 		lds r24,187
 356               	.LVL25:
 357 0094 8083      		st Z,r24
 358               	.L29:
 295:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 296:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // SR: Обнаружен stop или restart в процессе приема 
 297:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSlaveReader();                           // Хук обязателен! э�
 359               		.loc 1 297 0
 360 0096 E091 0000 		lds r30,twiSlaveReader
 361 009a F091 0000 		lds r31,twiSlaveReader+1
 362 009e 00C0      		rjmp .L73
 363               	.LVL26:
 364               	.L71:
 298:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md=twiMode;                                // возможно изменен�
 299:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 300:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 301:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_ACK) || (_st == TWI_SR_DATA_ACK) )
 365               		.loc 1 301 0 discriminator 1
 366 00a0 2038      		cpi r18,lo8(-128)
 367 00a2 01F0      		breq .+2
 368 00a4 00C0      		rjmp .L41
 369 00a6 00C0      		rjmp .L40
 370               	.L22:
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
GAS LISTING /tmp/ccFP0NC0.s 			page 13


 315:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 316:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 317:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_IS_SLAVE_TX
 318:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }else{
 319:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 320:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_SLAVE..
 321:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_TX)
 322:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         // Master Transmiter or Reciever modes
 323:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_START) || (_st == TWI_REP_START) )
 371               		.loc 1 323 0
 372 00a8 9830      		cpi r25,lo8(8)
 373 00aa 01F0      		breq .L32
 374               		.loc 1 323 0 is_stmt 0 discriminator 1
 375 00ac 9031      		cpi r25,lo8(16)
 376 00ae 01F4      		brne .L33
 377               	.L32:
 324:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 325:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка стартовой посылки
 326:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка повторного старта
 327:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             TWDR = twiSLARW;
 378               		.loc 1 327 0 is_stmt 1
 379 00b0 9091 0000 		lds r25,twiSLARW
 380               	.LVL27:
 381 00b4 00C0      		rjmp .L74
 382               	.LVL28:
 383               	.L33:
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
 329:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 330:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_NACK) || (_st == TWI_MT_DATA_NACK) )
 384               		.loc 1 330 0
 385 00b6 287E      		andi r18,lo8(-24)
 386 00b8 2032      		cpi r18,lo8(32)
 387 00ba 01F4      		brne .+2
 388 00bc 00C0      		rjmp .L43
 331:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 332:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_DATA_NACK MT:: Упс. data NACK: Получатель не хотит?
 333:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // TWI_MT_SLA_NACK  MT:: Упс. Получатель NACK .. не откликае
 334:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 twiSendStop(_md); return;
 335:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }
 336:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             if( (_st == TWI_MT_SLA_ACK)  || (_st == TWI_MT_DATA_ACK) )
 389               		.loc 1 336 0
 390 00be 9831      		cpi r25,lo8(24)
 391 00c0 01F0      		breq .L36
 392               		.loc 1 336 0 is_stmt 0 discriminator 1
 393 00c2 9832      		cpi r25,lo8(40)
 394 00c4 01F4      		brne .L37
 395               	.L36:
 337:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             {
 338:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Адрес получателя отправлен успешно, начи�
 339:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 // MT: Байт данных отправлен, продолжаем
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( twiMT_Count-- ){
 396               		.loc 1 340 0 is_stmt 1
 397 00c6 9091 0000 		lds r25,twiMT_Count
 398               	.LVL29:
 399 00ca 2FEF      		ldi r18,lo8(-1)
 400 00cc 290F      		add r18,r25
 401 00ce 2093 0000 		sts twiMT_Count,r18
GAS LISTING /tmp/ccFP0NC0.s 			page 14


 402               	.LVL30:
 403 00d2 9923      		tst r25
 404 00d4 01F4      		brne .+2
 405 00d6 00C0      		rjmp .L43
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *twiMT_Ptr++;
 406               		.loc 1 341 0
 407 00d8 E091 0000 		lds r30,twiMT_Ptr
 408 00dc F091 0000 		lds r31,twiMT_Ptr+1
 409 00e0 9F01      		movw r18,r30
 410 00e2 2F5F      		subi r18,-1
 411 00e4 3F4F      		sbci r19,-1
 412 00e6 3093 0000 		sts twiMT_Ptr+1,r19
 413 00ea 2093 0000 		sts twiMT_Ptr,r18
 414 00ee 9081      		ld r25,Z
 415               	.L74:
 416 00f0 9093 BB00 		sts 187,r25
 342:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(_md & TWI_IS_SLAVE);
 417               		.loc 1 342 0
 418 00f4 80FF      		sbrs r24,0
 419 00f6 00C0      		rjmp .L49
 420 00f8 00C0      		rjmp .L34
 421               	.LVL31:
 422               	.L37:
 343:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 344:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
 345:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }
 346:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             }else{
 347:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 348:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && (TWI_ON & TWI_MASTER_RX)
 349:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( _st == TWI_MTR_ARB_LOST )
 423               		.loc 1 349 0
 424 00fa 9833      		cpi r25,lo8(56)
 425 00fc 01F4      		brne .L39
 350:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 351:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // MT,MR: Упс. Мастер потерял шину: освобождаем 
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md |= TWI_READY;
 426               		.loc 1 352 0
 427 00fe 982F      		mov r25,r24
 428               	.LVL32:
 429 0100 9460      		ori r25,lo8(4)
 430               	.LVL33:
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 431               		.loc 1 353 0
 432 0102 80FF      		sbrs r24,0
 433 0104 00C0      		rjmp .L48
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 434               		.loc 1 352 0
 435 0106 892F      		mov r24,r25
 436 0108 00C0      		rjmp .L34
 437               	.LVL34:
 438               	.L39:
 354:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 355:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
 439               		.loc 1 355 0
 440 010a 9035      		cpi r25,lo8(80)
 441 010c 01F0      		breq .L40
 442               		.loc 1 355 0 is_stmt 0 discriminator 1
GAS LISTING /tmp/ccFP0NC0.s 			page 15


 443 010e 9034      		cpi r25,lo8(64)
 444 0110 01F4      		brne .L72
 445 0112 00C0      		rjmp .L41
 446               	.L40:
 356:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 357:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_ACK ){
 358:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: байт принят, ACK отправлен
 359:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *(twiRX_Ptr++) = TWDR;
 447               		.loc 1 359 0 is_stmt 1
 448 0114 E091 0000 		lds r30,twiRX_Ptr
 449 0118 F091 0000 		lds r31,twiRX_Ptr+1
 450 011c 9F01      		movw r18,r30
 451 011e 2F5F      		subi r18,-1
 452 0120 3F4F      		sbci r19,-1
 453 0122 3093 0000 		sts twiRX_Ptr+1,r19
 454 0126 2093 0000 		sts twiRX_Ptr,r18
 455 012a 9091 BB00 		lds r25,187
 456               	.LVL35:
 457 012e 9083      		st Z,r25
 458               	.LVL36:
 459               	.L41:
 360:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 361:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // MR: Отправитель найден, начинаем прием
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         _cr = twiReply( --twiRX_Count );        // .. Можно ещё приня�
 460               		.loc 1 362 0
 461 0130 9091 0000 		lds r25,twiRX_Count
 462 0134 9150      		subi r25,lo8(-(-1))
 463 0136 9093 0000 		sts twiRX_Count,r25
 464               	.L76:
 465 013a 9923      		tst r25
 466 013c 01F0      		breq .L49
 467 013e 00C0      		rjmp .L34
 468               	.LVL37:
 469               	.L72:
 363:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 364:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_ERROR ) return;
 470               		.loc 1 364 0
 471 0140 9923      		tst r25
 472 0142 01F0      		breq .L21
 365:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_NACK )
 473               		.loc 1 365 0
 474 0144 9835      		cpi r25,lo8(88)
 475 0146 01F4      		brne .L43
 366:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         {
 367:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: Упс. Получен последний байт дальше 
 368:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *twiRX_Ptr = TWDR;
 476               		.loc 1 368 0
 477 0148 E091 0000 		lds r30,twiRX_Ptr
 478 014c F091 0000 		lds r31,twiRX_Ptr+1
 479 0150 8091 BB00 		lds r24,187
 480               	.LVL38:
 481 0154 8083      		st Z,r24
 369:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             if( twiMasterReader ) twiMasterReader();
 482               		.loc 1 369 0
 483 0156 E091 0000 		lds r30,twiMasterReader
 484 015a F091 0000 		lds r31,twiMasterReader+1
 485 015e 3097      		sbiw r30,0
GAS LISTING /tmp/ccFP0NC0.s 			page 16


 486 0160 01F0      		breq .L44
 487               	.L73:
 488               		.loc 1 369 0 is_stmt 0 discriminator 1
 489 0162 1995      		eicall
 490               	.LVL39:
 491               	.L44:
 370:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //                            goto TWI_RET_HOOK;
 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
 492               		.loc 1 371 0 is_stmt 1 discriminator 3
 493 0164 8091 0000 		lds r24,twiMode
 494               	.LVL40:
 495               	.L43:
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 496               		.loc 1 375 0
 497 0168 0E94 0000 		call twiSendStop
 498               	.LVL41:
 499 016c 00C0      		rjmp .L21
 500               	.LVL42:
 501               	.L34:
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }else{
 502               		.loc 1 328 0
 503 016e 95EC      		ldi r25,lo8(-59)
 504 0170 00C0      		rjmp .L27
 505               	.LVL43:
 506               	.L48:
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 507               		.loc 1 352 0
 508 0172 892F      		mov r24,r25
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 509               		.loc 1 353 0
 510 0174 94E8      		ldi r25,lo8(-124)
 511               	.LVL44:
 512 0176 00C0      		rjmp .L27
 513               	.LVL45:
 514               	.L49:
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 515               		.loc 1 362 0
 516 0178 95E8      		ldi r25,lo8(-123)
 517               	.L27:
 518               	.LVL46:
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
 519               		.loc 1 386 0
 520 017a 8093 0000 		sts twiMode,r24
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
GAS LISTING /tmp/ccFP0NC0.s 			page 17


 521               		.loc 1 387 0
 522 017e 9093 BC00 		sts 188,r25
 523               	.LVL47:
 524               	.L21:
 525               	/* epilogue start */
 526               	.LBE7:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 527               		.loc 1 388 0
 528 0182 FF91      		pop r31
 529 0184 EF91      		pop r30
 530 0186 BF91      		pop r27
 531 0188 AF91      		pop r26
 532 018a 9F91      		pop r25
 533 018c 8F91      		pop r24
 534 018e 7F91      		pop r23
 535 0190 6F91      		pop r22
 536 0192 5F91      		pop r21
 537 0194 4F91      		pop r20
 538 0196 3F91      		pop r19
 539 0198 2F91      		pop r18
 540 019a 0F90      		pop r0
 541 019c 0BBE      		out __RAMPZ__,r0
 542 019e 0F90      		pop r0
 543 01a0 0FBE      		out __SREG__,r0
 544 01a2 0F90      		pop r0
 545 01a4 1F90      		pop r1
 546 01a6 1895      		reti
 547               		.cfi_endproc
 548               	.LFE105:
 549               		.size	__vector_39, .-__vector_39
 550               		.section	.text._twiStartTo,"ax",@progbits
 551               	.global	_twiStartTo
 552               		.type	_twiStartTo, @function
 553               	_twiStartTo:
 554               	.LFB106:
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
 555               		.loc 1 400 0
 556               		.cfi_startproc
 557               	.LVL48:
 558               	/* prologue: function */
 559               	/* frame size = 0 */
 560               	/* stack size = 0 */
 561               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 562               		.loc 1 401 0
 563 0000 8093 0000 		sts twiSLARW,r24
GAS LISTING /tmp/ccFP0NC0.s 			page 18


 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 564               		.loc 1 402 0
 565 0004 8091 0000 		lds r24,twiMode
 566               	.LVL49:
 567 0008 8260      		ori r24,lo8(2)
 568 000a 8093 0000 		sts twiMode,r24
 569               	.LVL50:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 570               		.loc 1 403 0
 571 000e 8091 0000 		lds r24,twiMode
 572 0012 80FF      		sbrs r24,0
 573 0014 00C0      		rjmp .L80
 574 0016 85EE      		ldi r24,lo8(-27)
 575 0018 00C0      		rjmp .L79
 576               	.L80:
 577 001a 85EA      		ldi r24,lo8(-91)
 578               	.L79:
 579               		.loc 1 403 0 is_stmt 0 discriminator 3
 580 001c 8093 BC00 		sts 188,r24
 581 0020 0895      		ret
 582               		.cfi_endproc
 583               	.LFE106:
 584               		.size	_twiStartTo, .-_twiStartTo
 585               		.section	.text._twiStartRe,"ax",@progbits
 586               	.global	_twiStartRe
 587               		.type	_twiStartRe, @function
 588               	_twiStartRe:
 589               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 590               		.loc 1 412 0 is_stmt 1
 591               		.cfi_startproc
 592               	.LVL51:
 593               	/* prologue: function */
 594               	/* frame size = 0 */
 595               	/* stack size = 0 */
 596               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 597               		.loc 1 413 0
 598 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 599               		.loc 1 414 0
 600 0004 8091 0000 		lds r24,twiMode
 601               	.LVL52:
 602 0008 8D7F      		andi r24,lo8(-3)
 603 000a 8093 0000 		sts twiMode,r24
 604               	.LVL53:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 605               		.loc 1 415 0
 606 000e 8091 0000 		lds r24,twiMode
GAS LISTING /tmp/ccFP0NC0.s 			page 19


 607 0012 80FF      		sbrs r24,0
 608 0014 00C0      		rjmp .L83
 609 0016 85EE      		ldi r24,lo8(-27)
 610 0018 00C0      		rjmp .L82
 611               	.L83:
 612 001a 85EA      		ldi r24,lo8(-91)
 613               	.L82:
 614               		.loc 1 415 0 is_stmt 0 discriminator 3
 615 001c 8093 BC00 		sts 188,r24
 616 0020 0895      		ret
 617               		.cfi_endproc
 618               	.LFE107:
 619               		.size	_twiStartRe, .-_twiStartRe
 620               		.section	.text.twiWrite,"ax",@progbits
 621               	.global	twiWrite
 622               		.type	twiWrite, @function
 623               	twiWrite:
 624               	.LFB108:
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
 625               		.loc 1 430 0 is_stmt 1
 626               		.cfi_startproc
 627               	/* prologue: function */
 628               	/* frame size = 0 */
 629               	/* stack size = 0 */
 630               	.L__stack_usage = 0
 631               	.LVL54:
 632               	.L86:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 633               		.loc 1 431 0 discriminator 1
 634 0000 9091 0000 		lds r25,twiMode
 635 0004 92FF      		sbrs r25,2
 636 0006 00C0      		rjmp .L86
 637               		.loc 1 431 0 is_stmt 0 discriminator 2
 638 0008 9091 0000 		lds r25,twiMode
 639 000c 9B7F      		andi r25,lo8(-5)
 640 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 641               		.loc 1 432 0 is_stmt 1 discriminator 2
 642 0012 7093 0000 		sts twiMT_Ptr+1,r23
 643 0016 6093 0000 		sts twiMT_Ptr,r22
 644 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 645               		.loc 1 433 0 discriminator 2
GAS LISTING /tmp/ccFP0NC0.s 			page 20


 646 001e 880F      		lsl r24
 647               	.LVL55:
 648 0020 0C94 0000 		jmp _twiStartTo
 649               	.LVL56:
 650               		.cfi_endproc
 651               	.LFE108:
 652               		.size	twiWrite, .-twiWrite
 653               		.section	.text.twiRead,"ax",@progbits
 654               	.global	twiRead
 655               		.type	twiRead, @function
 656               	twiRead:
 657               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 658               		.loc 1 440 0
 659               		.cfi_startproc
 660               	/* prologue: function */
 661               	/* frame size = 0 */
 662               	/* stack size = 0 */
 663               	.L__stack_usage = 0
 664               	.LVL57:
 665               	.L89:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 666               		.loc 1 441 0 discriminator 1
 667 0000 9091 0000 		lds r25,twiMode
 668 0004 92FF      		sbrs r25,2
 669 0006 00C0      		rjmp .L89
 670               		.loc 1 441 0 is_stmt 0 discriminator 2
 671 0008 9091 0000 		lds r25,twiMode
 672 000c 9B7F      		andi r25,lo8(-5)
 673 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 674               		.loc 1 442 0 is_stmt 1 discriminator 2
 675 0012 7093 0000 		sts twiRX_Ptr+1,r23
 676 0016 6093 0000 		sts twiRX_Ptr,r22
 677 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 678               		.loc 1 443 0 discriminator 2
 679 001e 880F      		lsl r24
 680               	.LVL58:
 681 0020 8160      		ori r24,lo8(1)
 682 0022 0C94 0000 		jmp _twiStartTo
 683               	.LVL59:
 684               		.cfi_endproc
 685               	.LFE109:
 686               		.size	twiRead, .-twiRead
 687               		.section	.text.twiRAW,"ax",@progbits
 688               	.global	twiRAW
 689               		.type	twiRAW, @function
 690               	twiRAW:
 691               	.LFB110:
 444:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
GAS LISTING /tmp/ccFP0NC0.s 			page 21


 445:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 446:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 447:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * Master Read-after-Write:: Чтение данных после отправки команды. 
 448:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * !!! Не совместимо с Slave Receive Mode - буфер приема общий !!!
 449:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 450:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRAW(uint8_t address                             // адрес устройства
 451:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* command, uint8_t clength                     // команда и её длина
 452:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** , uint8_t* data, uint8_t dlength                        // буфер приема данных и 
 453:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** ){
 692               		.loc 1 453 0
 693               		.cfi_startproc
 694               	.LVL60:
 695 0000 0F93      		push r16
 696               	.LCFI19:
 697               		.cfi_def_cfa_offset 4
 698               		.cfi_offset 16, -3
 699               	/* prologue: function */
 700               	/* frame size = 0 */
 701               	/* stack size = 1 */
 702               	.L__stack_usage = 1
 703               	.L92:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 704               		.loc 1 454 0 discriminator 1
 705 0002 9091 0000 		lds r25,twiMode
 706 0006 92FF      		sbrs r25,2
 707 0008 00C0      		rjmp .L92
 708               		.loc 1 454 0 is_stmt 0 discriminator 2
 709 000a 9091 0000 		lds r25,twiMode
 710 000e 9B7F      		andi r25,lo8(-5)
 711 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 712               		.loc 1 455 0 is_stmt 1 discriminator 2
 713 0014 7093 0000 		sts twiMT_Ptr+1,r23
 714 0018 6093 0000 		sts twiMT_Ptr,r22
 715 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 716               		.loc 1 456 0 discriminator 2
 717 0020 3093 0000 		sts twiRX_Ptr+1,r19
 718 0024 2093 0000 		sts twiRX_Ptr,r18
 719 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 720               		.loc 1 458 0 discriminator 2
 721 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 722 0030 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 723               		.loc 1 459 0 discriminator 2
 724 0034 9091 0000 		lds r25,twiMode
 725 0038 9D7F      		andi r25,lo8(-3)
 726 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 727               		.loc 1 460 0 discriminator 2
 728 003e 880F      		lsl r24
 729               	.LVL61:
 730 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 731               		.loc 1 461 0 discriminator 2
GAS LISTING /tmp/ccFP0NC0.s 			page 22


 732 0044 8091 0000 		lds r24,twiMode
 733 0048 80FF      		sbrs r24,0
 734 004a 00C0      		rjmp .L94
 735               		.loc 1 461 0 is_stmt 0
 736 004c 85EE      		ldi r24,lo8(-27)
 737 004e 00C0      		rjmp .L93
 738               	.L94:
 739 0050 85EA      		ldi r24,lo8(-91)
 740               	.L93:
 741               		.loc 1 461 0 discriminator 3
 742 0052 8093 BC00 		sts 188,r24
 743               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 744               		.loc 1 462 0 is_stmt 1 discriminator 3
 745 0056 0F91      		pop r16
 746               	.LVL62:
 747 0058 0895      		ret
 748               		.cfi_endproc
 749               	.LFE110:
 750               		.size	twiRAW, .-twiRAW
 751               		.section	.text.lcdPrepare,"ax",@progbits
 752               	.global	lcdPrepare
 753               		.type	lcdPrepare, @function
 754               	lcdPrepare:
 755               	.LFB111:
 756               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 757               		.loc 2 490 0
 758               		.cfi_startproc
 759               	.LVL63:
 760               	/* prologue: function */
 761               	/* frame size = 0 */
 762               	/* stack size = 0 */
 763               	.L__stack_usage = 0
 764               	.LBB8:
 765               		.loc 2 491 0
 766 0000 2091 0000 		lds r18,lcdBackLight
 767 0004 982F      		mov r25,r24
 768 0006 907F      		andi r25,lo8(-16)
 769 0008 922B      		or r25,r18
 770               	.LVL64:
 771               		.loc 2 493 0
 772 000a 6111      		cpse r22,__zero_reg__
 773               		.loc 2 493 0 is_stmt 0 discriminator 1
 774 000c 9160      		ori r25,lo8(1)
 775               	.LVL65:
 776               	.L96:
 777               		.loc 2 494 0 is_stmt 1
 778 000e 9093 0000 		sts lcdBuffer,r25
 779 0012 9093 0000 		sts lcdBuffer+2,r25
 780               	.LVL66:
 781               		.loc 2 495 0
 782 0016 9460      		ori r25,lo8(4)
 783               	.LVL67:
 784               		.loc 2 496 0
 785 0018 9093 0000 		sts lcdBuffer+1,r25
 786               		.loc 2 498 0
GAS LISTING /tmp/ccFP0NC0.s 			page 23


 787 001c 30E1      		ldi r19,lo8(16)
 788 001e 839F      		mul r24,r19
 789 0020 C001      		movw r24,r0
 790 0022 1124      		clr __zero_reg__
 791               	.LVL68:
 792 0024 822B      		or r24,r18
 793               	.LVL69:
 794               		.loc 2 500 0
 795 0026 6111      		cpse r22,__zero_reg__
 796               		.loc 2 500 0 is_stmt 0 discriminator 1
 797 0028 8160      		ori r24,lo8(1)
 798               	.LVL70:
 799               	.L97:
 800               		.loc 2 501 0 is_stmt 1
 801 002a 8093 0000 		sts lcdBuffer+3,r24
 802 002e 8093 0000 		sts lcdBuffer+5,r24
 803               	.LVL71:
 804               		.loc 2 502 0
 805 0032 8460      		ori r24,lo8(4)
 806               	.LVL72:
 807               		.loc 2 503 0
 808 0034 8093 0000 		sts lcdBuffer+4,r24
 809 0038 0895      		ret
 810               	.LBE8:
 811               		.cfi_endproc
 812               	.LFE111:
 813               		.size	lcdPrepare, .-lcdPrepare
 814               		.section	.text.lcdWrite,"ax",@progbits
 815               	.global	lcdWrite
 816               		.type	lcdWrite, @function
 817               	lcdWrite:
 818               	.LFB112:
 819               		.loc 2 511 0
 820               		.cfi_startproc
 821               	.LVL73:
 822 0000 1F93      		push r17
 823               	.LCFI20:
 824               		.cfi_def_cfa_offset 4
 825               		.cfi_offset 17, -3
 826 0002 CF93      		push r28
 827               	.LCFI21:
 828               		.cfi_def_cfa_offset 5
 829               		.cfi_offset 28, -4
 830 0004 DF93      		push r29
 831               	.LCFI22:
 832               		.cfi_def_cfa_offset 6
 833               		.cfi_offset 29, -5
 834               	/* prologue: function */
 835               	/* frame size = 0 */
 836               	/* stack size = 3 */
 837               	.L__stack_usage = 3
 838 0006 162F      		mov r17,r22
 839               	.LVL74:
 840               	.LBB9:
 841               		.loc 2 515 0
 842 0008 2091 0000 		lds r18,twiMode
 843 000c 2260      		ori r18,lo8(2)
GAS LISTING /tmp/ccFP0NC0.s 			page 24


 844 000e 2093 0000 		sts twiMode,r18
 845               		.loc 2 516 0
 846 0012 C82F      		mov r28,r24
 847 0014 D92F      		mov r29,r25
 848 0016 180F      		add r17,r24
 849               	.LVL75:
 850               	.L105:
 851               		.loc 2 516 0 is_stmt 0 discriminator 1
 852 0018 1C17      		cp r17,r28
 853 001a 01F0      		breq .L107
 854               	.LVL76:
 855               		.loc 2 517 0 is_stmt 1
 856 001c 61E0      		ldi r22,lo8(1)
 857 001e 8991      		ld r24,Y+
 858               	.LVL77:
 859 0020 0E94 0000 		call lcdPrepare
 860               	.LVL78:
 861 0024 46E0      		ldi r20,lo8(6)
 862 0026 60E0      		ldi r22,lo8(lcdBuffer)
 863 0028 70E0      		ldi r23,hi8(lcdBuffer)
 864 002a 8091 0000 		lds r24,lcdAddress
 865 002e 0E94 0000 		call twiWrite
 866               	.LVL79:
 867 0032 85E0      		ldi r24,lo8(5)
 868 0034 90E0      		ldi r25,0
 869 0036 0E94 0000 		call time_delay16
 870               	.LVL80:
 871 003a 00C0      		rjmp .L105
 872               	.LVL81:
 873               	.L107:
 874               	/* epilogue start */
 875               	.LBE9:
 876               		.loc 2 518 0
 877 003c DF91      		pop r29
 878 003e CF91      		pop r28
 879               	.LVL82:
 880 0040 1F91      		pop r17
 881 0042 0895      		ret
 882               		.cfi_endproc
 883               	.LFE112:
 884               		.size	lcdWrite, .-lcdWrite
 885               		.section	.text.lcdInit,"ax",@progbits
 886               	.global	lcdInit
 887               		.type	lcdInit, @function
 888               	lcdInit:
 889               	.LFB113:
 890               		.loc 2 524 0
 891               		.cfi_startproc
 892               	/* prologue: function */
 893               	/* frame size = 0 */
 894               	/* stack size = 0 */
 895               	.L__stack_usage = 0
 896               		.loc 2 525 0
 897 0000 60E0      		ldi r22,0
 898 0002 8091 0000 		lds r24,lcdModes
 899 0006 0E94 0000 		call lcdPrepare
 900               	.LVL83:
GAS LISTING /tmp/ccFP0NC0.s 			page 25


 901 000a 46E0      		ldi r20,lo8(6)
 902 000c 60E0      		ldi r22,lo8(lcdBuffer)
 903 000e 70E0      		ldi r23,hi8(lcdBuffer)
 904 0010 8091 0000 		lds r24,lcdAddress
 905 0014 0E94 0000 		call twiWrite
 906               	.LVL84:
 907 0018 85E0      		ldi r24,lo8(5)
 908 001a 90E0      		ldi r25,0
 909 001c 0E94 0000 		call time_delay16
 910               	.LVL85:
 911               		.loc 2 526 0
 912 0020 60E0      		ldi r22,0
 913 0022 8091 0000 		lds r24,lcdShows
 914 0026 0E94 0000 		call lcdPrepare
 915               	.LVL86:
 916 002a 46E0      		ldi r20,lo8(6)
 917 002c 60E0      		ldi r22,lo8(lcdBuffer)
 918 002e 70E0      		ldi r23,hi8(lcdBuffer)
 919 0030 8091 0000 		lds r24,lcdAddress
 920 0034 0E94 0000 		call twiWrite
 921               	.LVL87:
 922 0038 85E0      		ldi r24,lo8(5)
 923 003a 90E0      		ldi r25,0
 924 003c 0E94 0000 		call time_delay16
 925               	.LVL88:
 926               		.loc 2 527 0
 927 0040 60E0      		ldi r22,0
 928 0042 8091 0000 		lds r24,lcdShifts
 929 0046 0E94 0000 		call lcdPrepare
 930               	.LVL89:
 931 004a 46E0      		ldi r20,lo8(6)
 932 004c 60E0      		ldi r22,lo8(lcdBuffer)
 933 004e 70E0      		ldi r23,hi8(lcdBuffer)
 934 0050 8091 0000 		lds r24,lcdAddress
 935 0054 0E94 0000 		call twiWrite
 936               	.LVL90:
 937 0058 85E0      		ldi r24,lo8(5)
 938 005a 90E0      		ldi r25,0
 939 005c 0E94 0000 		call time_delay16
 940               	.LVL91:
 941               		.loc 2 528 0
 942 0060 60E0      		ldi r22,0
 943 0062 81E0      		ldi r24,lo8(1)
 944 0064 0E94 0000 		call lcdPrepare
 945               	.LVL92:
 946 0068 46E0      		ldi r20,lo8(6)
 947 006a 60E0      		ldi r22,lo8(lcdBuffer)
 948 006c 70E0      		ldi r23,hi8(lcdBuffer)
 949 006e 8091 0000 		lds r24,lcdAddress
 950 0072 0E94 0000 		call twiWrite
 951               	.LVL93:
 952 0076 85E0      		ldi r24,lo8(5)
 953 0078 90E0      		ldi r25,0
 954 007a 0E94 0000 		call time_delay16
 955               	.LVL94:
 956 007e 80E1      		ldi r24,lo8(16)
 957 0080 90E0      		ldi r25,0
GAS LISTING /tmp/ccFP0NC0.s 			page 26


 958 0082 0E94 0000 		call time_delay16
 959               	.LVL95:
 960               		.loc 2 529 0
 961 0086 60E0      		ldi r22,0
 962 0088 82E0      		ldi r24,lo8(2)
 963 008a 0E94 0000 		call lcdPrepare
 964               	.LVL96:
 965 008e 46E0      		ldi r20,lo8(6)
 966 0090 60E0      		ldi r22,lo8(lcdBuffer)
 967 0092 70E0      		ldi r23,hi8(lcdBuffer)
 968 0094 8091 0000 		lds r24,lcdAddress
 969 0098 0E94 0000 		call twiWrite
 970               	.LVL97:
 971 009c 85E0      		ldi r24,lo8(5)
 972 009e 90E0      		ldi r25,0
 973 00a0 0C94 0000 		jmp time_delay16
 974               	.LVL98:
 975               		.cfi_endproc
 976               	.LFE113:
 977               		.size	lcdInit, .-lcdInit
 978               		.section	.text.lcdSetup,"ax",@progbits
 979               	.global	lcdSetup
 980               		.type	lcdSetup, @function
 981               	lcdSetup:
 982               	.LFB114:
 983               		.loc 2 536 0
 984               		.cfi_startproc
 985               	.LVL99:
 986 0000 CF93      		push r28
 987               	.LCFI23:
 988               		.cfi_def_cfa_offset 4
 989               		.cfi_offset 28, -3
 990               	/* prologue: function */
 991               	/* frame size = 0 */
 992               	/* stack size = 1 */
 993               	.L__stack_usage = 1
 994 0002 C42F      		mov r28,r20
 995               		.loc 2 537 0
 996 0004 8093 0000 		sts lcdAddress,r24
 997               		.loc 2 538 0
 998 0008 6093 0000 		sts lcdCols,r22
 999               		.loc 2 539 0
 1000 000c 4093 0000 		sts lcdRows,r20
 1001               		.loc 2 540 0
 1002 0010 2223      		tst r18
 1003 0012 01F0      		breq .L112
 1004 0014 88E0      		ldi r24,lo8(8)
 1005               	.LVL100:
 1006 0016 00C0      		rjmp .L110
 1007               	.LVL101:
 1008               	.L112:
 1009 0018 80E0      		ldi r24,0
 1010               	.LVL102:
 1011               	.L110:
 1012               		.loc 2 540 0 is_stmt 0 discriminator 3
 1013 001a 8093 0000 		sts lcdBackLight,r24
 1014               		.loc 2 541 0 is_stmt 1 discriminator 3
GAS LISTING /tmp/ccFP0NC0.s 			page 27


 1015 001e 80E2      		ldi r24,lo8(32)
 1016 0020 8093 0000 		sts lcdModes,r24
 1017               		.loc 2 542 0 discriminator 3
 1018 0024 86E0      		ldi r24,lo8(6)
 1019 0026 8093 0000 		sts lcdShifts,r24
 1020               		.loc 2 543 0 discriminator 3
 1021 002a 8CE0      		ldi r24,lo8(12)
 1022 002c 8093 0000 		sts lcdShows,r24
 1023               		.loc 2 547 0 discriminator 3
 1024 0030 46E0      		ldi r20,lo8(6)
 1025               	.LVL103:
 1026 0032 60EA      		ldi r22,lo8(-96)
 1027 0034 76E8      		ldi r23,lo8(-122)
 1028 0036 81E0      		ldi r24,lo8(1)
 1029 0038 90E0      		ldi r25,0
 1030               	.LVL104:
 1031 003a 0E94 0000 		call twiSetup
 1032               	.LVL105:
 1033               		.loc 2 551 0 discriminator 3
 1034 003e C230      		cpi r28,lo8(2)
 1035 0040 00F0      		brlo .L111
 1036               		.loc 2 551 0 is_stmt 0 discriminator 1
 1037 0042 8091 0000 		lds r24,lcdModes
 1038 0046 8860      		ori r24,lo8(8)
 1039 0048 8093 0000 		sts lcdModes,r24
 1040               	.L111:
 1041               		.loc 2 555 0 is_stmt 1
 1042 004c 60E0      		ldi r22,0
 1043 004e 80E3      		ldi r24,lo8(48)
 1044 0050 0E94 0000 		call lcdPrepare
 1045               	.LVL106:
 1046               		.loc 2 557 0
 1047 0054 8FE0      		ldi r24,lo8(15)
 1048 0056 90E0      		ldi r25,0
 1049 0058 0E94 0000 		call time_delay16
 1050               	.LVL107:
 1051               		.loc 2 558 0
 1052 005c 43E0      		ldi r20,lo8(3)
 1053 005e 60E0      		ldi r22,lo8(lcdBuffer)
 1054 0060 70E0      		ldi r23,hi8(lcdBuffer)
 1055 0062 8091 0000 		lds r24,lcdAddress
 1056 0066 0E94 0000 		call twiWrite
 1057               	.LVL108:
 1058 006a 85E0      		ldi r24,lo8(5)
 1059 006c 90E0      		ldi r25,0
 1060 006e 0E94 0000 		call time_delay16
 1061               	.LVL109:
 1062               		.loc 2 559 0
 1063 0072 85E0      		ldi r24,lo8(5)
 1064 0074 90E0      		ldi r25,0
 1065 0076 0E94 0000 		call time_delay16
 1066               	.LVL110:
 1067               		.loc 2 560 0
 1068 007a 43E0      		ldi r20,lo8(3)
 1069 007c 60E0      		ldi r22,lo8(lcdBuffer)
 1070 007e 70E0      		ldi r23,hi8(lcdBuffer)
 1071 0080 8091 0000 		lds r24,lcdAddress
GAS LISTING /tmp/ccFP0NC0.s 			page 28


 1072 0084 0E94 0000 		call twiWrite
 1073               	.LVL111:
 1074 0088 85E0      		ldi r24,lo8(5)
 1075 008a 90E0      		ldi r25,0
 1076 008c 0E94 0000 		call time_delay16
 1077               	.LVL112:
 1078               		.loc 2 561 0
 1079 0090 80E9      		ldi r24,lo8(-112)
 1080 0092 91E0      		ldi r25,lo8(1)
 1081               	/* #APP */
 1082               	 ;  561 "LCD1602ex.ino" 1
 1083 0094 0197      		1: sbiw r24,1 
 1084 0096 01F4      		brne 1b
 1085               		
 1086               	 ;  0 "" 2
 1087               		.loc 2 562 0
 1088               	/* #NOAPP */
 1089 0098 43E0      		ldi r20,lo8(3)
 1090 009a 60E0      		ldi r22,lo8(lcdBuffer)
 1091 009c 70E0      		ldi r23,hi8(lcdBuffer)
 1092 009e 8091 0000 		lds r24,lcdAddress
 1093 00a2 0E94 0000 		call twiWrite
 1094               	.LVL113:
 1095 00a6 85E0      		ldi r24,lo8(5)
 1096 00a8 90E0      		ldi r25,0
 1097 00aa 0E94 0000 		call time_delay16
 1098               	.LVL114:
 1099               		.loc 2 564 0
 1100 00ae 60E0      		ldi r22,0
 1101 00b0 80E2      		ldi r24,lo8(32)
 1102 00b2 0E94 0000 		call lcdPrepare
 1103               	.LVL115:
 1104               		.loc 2 565 0
 1105 00b6 43E0      		ldi r20,lo8(3)
 1106 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 1107 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 1108 00bc 8091 0000 		lds r24,lcdAddress
 1109 00c0 0E94 0000 		call twiWrite
 1110               	.LVL116:
 1111 00c4 85E0      		ldi r24,lo8(5)
 1112 00c6 90E0      		ldi r25,0
 1113 00c8 0E94 0000 		call time_delay16
 1114               	.LVL117:
 1115               		.loc 2 567 0
 1116 00cc 0E94 0000 		call lcdInit
 1117               	.LVL118:
 1118               		.loc 2 568 0
 1119 00d0 84EF      		ldi r24,lo8(-12)
 1120 00d2 91E0      		ldi r25,lo8(1)
 1121               	/* epilogue start */
 1122               		.loc 2 569 0
 1123 00d4 CF91      		pop r28
 1124               	.LVL119:
 1125               		.loc 2 568 0
 1126 00d6 0C94 0000 		jmp time_delay16
 1127               	.LVL120:
 1128               		.cfi_endproc
GAS LISTING /tmp/ccFP0NC0.s 			page 29


 1129               	.LFE114:
 1130               		.size	lcdSetup, .-lcdSetup
 1131               		.section	.rodata.str1.1,"aMS",@progbits,1
 1132               	.LC0:
 1133 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 1133      6F2C 2041 
 1133      4141 4141 
 1133      4100 
 1134               		.section	.text.setup,"ax",@progbits
 1135               	.global	setup
 1136               		.type	setup, @function
 1137               	setup:
 1138               	.LFB115:
 1139               		.loc 2 577 0
 1140               		.cfi_startproc
 1141               	/* prologue: function */
 1142               	/* frame size = 0 */
 1143               	/* stack size = 0 */
 1144               	.L__stack_usage = 0
 1145               	.LBB10:
 1146               		.loc 2 581 0
 1147 0000 21E0      		ldi r18,lo8(1)
 1148 0002 42E0      		ldi r20,lo8(2)
 1149 0004 60E1      		ldi r22,lo8(16)
 1150 0006 87E2      		ldi r24,lo8(39)
 1151 0008 0E94 0000 		call lcdSetup
 1152               	.LVL121:
 1153               		.loc 2 582 0
 1154 000c 6DE0      		ldi r22,lo8(13)
 1155 000e 80E0      		ldi r24,lo8(.LC0)
 1156 0010 90E0      		ldi r25,hi8(.LC0)
 1157 0012 0C94 0000 		jmp lcdWrite
 1158               	.LVL122:
 1159               	.LBE10:
 1160               		.cfi_endproc
 1161               	.LFE115:
 1162               		.size	setup, .-setup
 1163               		.section	.text.loop,"ax",@progbits
 1164               	.global	loop
 1165               		.type	loop, @function
 1166               	loop:
 1167               	.LFB116:
 1168               		.loc 2 588 0
 1169               		.cfi_startproc
 1170               	/* prologue: function */
 1171               	/* frame size = 0 */
 1172               	/* stack size = 0 */
 1173               	.L__stack_usage = 0
 1174 0000 0895      		ret
 1175               		.cfi_endproc
 1176               	.LFE116:
 1177               		.size	loop, .-loop
 1178               	.global	lcdBuffer
 1179               		.section	.bss.lcdBuffer,"aw",@nobits
 1180               		.type	lcdBuffer, @object
 1181               		.size	lcdBuffer, 6
 1182               	lcdBuffer:
GAS LISTING /tmp/ccFP0NC0.s 			page 30


 1183 0000 0000 0000 		.zero	6
 1183      0000 
 1184               	.global	lcdRows
 1185               		.section	.data.lcdRows,"aw",@progbits
 1186               		.type	lcdRows, @object
 1187               		.size	lcdRows, 1
 1188               	lcdRows:
 1189 0000 02        		.byte	2
 1190               	.global	lcdCols
 1191               		.section	.data.lcdCols,"aw",@progbits
 1192               		.type	lcdCols, @object
 1193               		.size	lcdCols, 1
 1194               	lcdCols:
 1195 0000 10        		.byte	16
 1196               	.global	lcdAddress
 1197               		.section	.data.lcdAddress,"aw",@progbits
 1198               		.type	lcdAddress, @object
 1199               		.size	lcdAddress, 1
 1200               	lcdAddress:
 1201 0000 27        		.byte	39
 1202               	.global	lcdBackLight
 1203               		.section	.data.lcdBackLight,"aw",@progbits
 1204               		.type	lcdBackLight, @object
 1205               		.size	lcdBackLight, 1
 1206               	lcdBackLight:
 1207 0000 08        		.byte	8
 1208               	.global	lcdShows
 1209               		.section	.data.lcdShows,"aw",@progbits
 1210               		.type	lcdShows, @object
 1211               		.size	lcdShows, 1
 1212               	lcdShows:
 1213 0000 08        		.byte	8
 1214               	.global	lcdShifts
 1215               		.section	.data.lcdShifts,"aw",@progbits
 1216               		.type	lcdShifts, @object
 1217               		.size	lcdShifts, 1
 1218               	lcdShifts:
 1219 0000 06        		.byte	6
 1220               	.global	lcdModes
 1221               		.section	.data.lcdModes,"aw",@progbits
 1222               		.type	lcdModes, @object
 1223               		.size	lcdModes, 1
 1224               	lcdModes:
 1225 0000 30        		.byte	48
 1226               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 1227               		.type	_ZL12twiStatistic, @object
 1228               		.size	_ZL12twiStatistic, 20
 1229               	_ZL12twiStatistic:
 1230 0000 0000 0000 		.zero	20
 1230      0000 0000 
 1230      0000 0000 
 1230      0000 0000 
 1230      0000 0000 
 1231               	.global	twiSlaveWriter
 1232               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1233               		.type	twiSlaveWriter, @object
 1234               		.size	twiSlaveWriter, 2
GAS LISTING /tmp/ccFP0NC0.s 			page 31


 1235               	twiSlaveWriter:
 1236 0000 0000      		.zero	2
 1237               	.global	twiSlaveReader
 1238               		.section	.bss.twiSlaveReader,"aw",@nobits
 1239               		.type	twiSlaveReader, @object
 1240               		.size	twiSlaveReader, 2
 1241               	twiSlaveReader:
 1242 0000 0000      		.zero	2
 1243               	.global	twiMasterReader
 1244               		.section	.bss.twiMasterReader,"aw",@nobits
 1245               		.type	twiMasterReader, @object
 1246               		.size	twiMasterReader, 2
 1247               	twiMasterReader:
 1248 0000 0000      		.zero	2
 1249               	.global	twiHookRestart
 1250               		.section	.bss.twiHookRestart,"aw",@nobits
 1251               		.type	twiHookRestart, @object
 1252               		.size	twiHookRestart, 2
 1253               	twiHookRestart:
 1254 0000 0000      		.zero	2
 1255               	.global	twiST_Ptr
 1256               		.section	.bss.twiST_Ptr,"aw",@nobits
 1257               		.type	twiST_Ptr, @object
 1258               		.size	twiST_Ptr, 2
 1259               	twiST_Ptr:
 1260 0000 0000      		.zero	2
 1261               	.global	twiST_Count
 1262               		.section	.bss.twiST_Count,"aw",@nobits
 1263               		.type	twiST_Count, @object
 1264               		.size	twiST_Count, 1
 1265               	twiST_Count:
 1266 0000 00        		.zero	1
 1267               	.global	twiRX_Ptr
 1268               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1269               		.type	twiRX_Ptr, @object
 1270               		.size	twiRX_Ptr, 2
 1271               	twiRX_Ptr:
 1272 0000 0000      		.zero	2
 1273               	.global	twiRX_Count
 1274               		.section	.bss.twiRX_Count,"aw",@nobits
 1275               		.type	twiRX_Count, @object
 1276               		.size	twiRX_Count, 1
 1277               	twiRX_Count:
 1278 0000 00        		.zero	1
 1279               	.global	twiMT_Ptr
 1280               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1281               		.type	twiMT_Ptr, @object
 1282               		.size	twiMT_Ptr, 2
 1283               	twiMT_Ptr:
 1284 0000 0000      		.zero	2
 1285               	.global	twiMT_Count
 1286               		.section	.bss.twiMT_Count,"aw",@nobits
 1287               		.type	twiMT_Count, @object
 1288               		.size	twiMT_Count, 1
 1289               	twiMT_Count:
 1290 0000 00        		.zero	1
 1291               	.global	twiSLARW
GAS LISTING /tmp/ccFP0NC0.s 			page 32


 1292               		.section	.bss.twiSLARW,"aw",@nobits
 1293               		.type	twiSLARW, @object
 1294               		.size	twiSLARW, 1
 1295               	twiSLARW:
 1296 0000 00        		.zero	1
 1297               	.global	twiState
 1298               		.section	.bss.twiState,"aw",@nobits
 1299               		.type	twiState, @object
 1300               		.size	twiState, 1
 1301               	twiState:
 1302 0000 00        		.zero	1
 1303               	.global	twiMode
 1304               		.section	.bss.twiMode,"aw",@nobits
 1305               		.type	twiMode, @object
 1306               		.size	twiMode, 1
 1307               	twiMode:
 1308 0000 00        		.zero	1
 1309               		.text
 1310               	.Letext0:
 1311               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1312               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1313               		.section	.debug_info,"",@progbits
 1314               	.Ldebug_info0:
 1315 0000 490B 0000 		.long	0xb49
 1316 0004 0200      		.word	0x2
 1317 0006 0000 0000 		.long	.Ldebug_abbrev0
 1318 000a 04        		.byte	0x4
 1319 000b 01        		.uleb128 0x1
 1320 000c 0000 0000 		.long	.LASF76
 1321 0010 04        		.byte	0x4
 1322 0011 0000 0000 		.long	.LASF77
 1323 0015 0000 0000 		.long	.LASF78
 1324 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1325 001d 0000 0000 		.long	0
 1326 0021 0000 0000 		.long	0
 1327 0025 0000 0000 		.long	.Ldebug_line0
 1328 0029 02        		.uleb128 0x2
 1329 002a 01        		.byte	0x1
 1330 002b 06        		.byte	0x6
 1331 002c 0000 0000 		.long	.LASF0
 1332 0030 03        		.uleb128 0x3
 1333 0031 0000 0000 		.long	.LASF2
 1334 0035 03        		.byte	0x3
 1335 0036 7A        		.byte	0x7a
 1336 0037 3B00 0000 		.long	0x3b
 1337 003b 02        		.uleb128 0x2
 1338 003c 01        		.byte	0x1
 1339 003d 08        		.byte	0x8
 1340 003e 0000 0000 		.long	.LASF1
 1341 0042 04        		.uleb128 0x4
 1342 0043 02        		.byte	0x2
 1343 0044 05        		.byte	0x5
 1344 0045 696E 7400 		.string	"int"
 1345 0049 03        		.uleb128 0x3
 1346 004a 0000 0000 		.long	.LASF3
 1347 004e 03        		.byte	0x3
 1348 004f 7C        		.byte	0x7c
GAS LISTING /tmp/ccFP0NC0.s 			page 33


 1349 0050 5400 0000 		.long	0x54
 1350 0054 02        		.uleb128 0x2
 1351 0055 02        		.byte	0x2
 1352 0056 07        		.byte	0x7
 1353 0057 0000 0000 		.long	.LASF4
 1354 005b 02        		.uleb128 0x2
 1355 005c 04        		.byte	0x4
 1356 005d 05        		.byte	0x5
 1357 005e 0000 0000 		.long	.LASF5
 1358 0062 03        		.uleb128 0x3
 1359 0063 0000 0000 		.long	.LASF6
 1360 0067 03        		.byte	0x3
 1361 0068 7E        		.byte	0x7e
 1362 0069 6D00 0000 		.long	0x6d
 1363 006d 02        		.uleb128 0x2
 1364 006e 04        		.byte	0x4
 1365 006f 07        		.byte	0x7
 1366 0070 0000 0000 		.long	.LASF7
 1367 0074 02        		.uleb128 0x2
 1368 0075 08        		.byte	0x8
 1369 0076 05        		.byte	0x5
 1370 0077 0000 0000 		.long	.LASF8
 1371 007b 02        		.uleb128 0x2
 1372 007c 08        		.byte	0x8
 1373 007d 07        		.byte	0x7
 1374 007e 0000 0000 		.long	.LASF9
 1375 0082 02        		.uleb128 0x2
 1376 0083 01        		.byte	0x1
 1377 0084 02        		.byte	0x2
 1378 0085 0000 0000 		.long	.LASF10
 1379 0089 05        		.uleb128 0x5
 1380 008a 02        		.byte	0x2
 1381 008b 8F00 0000 		.long	0x8f
 1382 008f 06        		.uleb128 0x6
 1383 0090 02        		.uleb128 0x2
 1384 0091 01        		.byte	0x1
 1385 0092 06        		.byte	0x6
 1386 0093 0000 0000 		.long	.LASF11
 1387 0097 02        		.uleb128 0x2
 1388 0098 04        		.byte	0x4
 1389 0099 04        		.byte	0x4
 1390 009a 0000 0000 		.long	.LASF12
 1391 009e 02        		.uleb128 0x2
 1392 009f 04        		.byte	0x4
 1393 00a0 04        		.byte	0x4
 1394 00a1 0000 0000 		.long	.LASF13
 1395 00a5 02        		.uleb128 0x2
 1396 00a6 02        		.byte	0x2
 1397 00a7 07        		.byte	0x7
 1398 00a8 0000 0000 		.long	.LASF14
 1399 00ac 07        		.uleb128 0x7
 1400 00ad 0000 0000 		.long	.LASF79
 1401 00b1 02        		.byte	0x2
 1402 00b2 01        		.byte	0x1
 1403 00b3 8C        		.byte	0x8c
 1404 00b4 CB00 0000 		.long	0xcb
 1405 00b8 08        		.uleb128 0x8
GAS LISTING /tmp/ccFP0NC0.s 			page 34


 1406 00b9 0000 0000 		.long	.LASF15
 1407 00bd 01        		.sleb128 1
 1408 00be 08        		.uleb128 0x8
 1409 00bf 0000 0000 		.long	.LASF16
 1410 00c3 02        		.sleb128 2
 1411 00c4 08        		.uleb128 0x8
 1412 00c5 0000 0000 		.long	.LASF17
 1413 00c9 04        		.sleb128 4
 1414 00ca 00        		.byte	0
 1415 00cb 09        		.uleb128 0x9
 1416 00cc 14        		.byte	0x14
 1417 00cd 01        		.byte	0x1
 1418 00ce A6        		.byte	0xa6
 1419 00cf 0000 0000 		.long	.LASF80
 1420 00d3 6401 0000 		.long	0x164
 1421 00d7 0A        		.uleb128 0xa
 1422 00d8 0000 0000 		.long	.LASF18
 1423 00dc 01        		.byte	0x1
 1424 00dd A7        		.byte	0xa7
 1425 00de 4900 0000 		.long	0x49
 1426 00e2 02        		.byte	0x2
 1427 00e3 23        		.byte	0x23
 1428 00e4 00        		.uleb128 0
 1429 00e5 0A        		.uleb128 0xa
 1430 00e6 0000 0000 		.long	.LASF19
 1431 00ea 01        		.byte	0x1
 1432 00eb A7        		.byte	0xa7
 1433 00ec 4900 0000 		.long	0x49
 1434 00f0 02        		.byte	0x2
 1435 00f1 23        		.byte	0x23
 1436 00f2 02        		.uleb128 0x2
 1437 00f3 0A        		.uleb128 0xa
 1438 00f4 0000 0000 		.long	.LASF20
 1439 00f8 01        		.byte	0x1
 1440 00f9 A7        		.byte	0xa7
 1441 00fa 4900 0000 		.long	0x49
 1442 00fe 02        		.byte	0x2
 1443 00ff 23        		.byte	0x23
 1444 0100 04        		.uleb128 0x4
 1445 0101 0A        		.uleb128 0xa
 1446 0102 0000 0000 		.long	.LASF21
 1447 0106 01        		.byte	0x1
 1448 0107 A7        		.byte	0xa7
 1449 0108 4900 0000 		.long	0x49
 1450 010c 02        		.byte	0x2
 1451 010d 23        		.byte	0x23
 1452 010e 06        		.uleb128 0x6
 1453 010f 0A        		.uleb128 0xa
 1454 0110 0000 0000 		.long	.LASF22
 1455 0114 01        		.byte	0x1
 1456 0115 A7        		.byte	0xa7
 1457 0116 4900 0000 		.long	0x49
 1458 011a 02        		.byte	0x2
 1459 011b 23        		.byte	0x23
 1460 011c 08        		.uleb128 0x8
 1461 011d 0B        		.uleb128 0xb
 1462 011e 6D74 7800 		.string	"mtx"
GAS LISTING /tmp/ccFP0NC0.s 			page 35


 1463 0122 01        		.byte	0x1
 1464 0123 A7        		.byte	0xa7
 1465 0124 4900 0000 		.long	0x49
 1466 0128 02        		.byte	0x2
 1467 0129 23        		.byte	0x23
 1468 012a 0A        		.uleb128 0xa
 1469 012b 0B        		.uleb128 0xb
 1470 012c 6D72 7800 		.string	"mrx"
 1471 0130 01        		.byte	0x1
 1472 0131 A7        		.byte	0xa7
 1473 0132 4900 0000 		.long	0x49
 1474 0136 02        		.byte	0x2
 1475 0137 23        		.byte	0x23
 1476 0138 0C        		.uleb128 0xc
 1477 0139 0B        		.uleb128 0xb
 1478 013a 7372 7800 		.string	"srx"
 1479 013e 01        		.byte	0x1
 1480 013f A7        		.byte	0xa7
 1481 0140 4900 0000 		.long	0x49
 1482 0144 02        		.byte	0x2
 1483 0145 23        		.byte	0x23
 1484 0146 0E        		.uleb128 0xe
 1485 0147 0B        		.uleb128 0xb
 1486 0148 6772 7800 		.string	"grx"
 1487 014c 01        		.byte	0x1
 1488 014d A7        		.byte	0xa7
 1489 014e 4900 0000 		.long	0x49
 1490 0152 02        		.byte	0x2
 1491 0153 23        		.byte	0x23
 1492 0154 10        		.uleb128 0x10
 1493 0155 0B        		.uleb128 0xb
 1494 0156 7374 7800 		.string	"stx"
 1495 015a 01        		.byte	0x1
 1496 015b A7        		.byte	0xa7
 1497 015c 4900 0000 		.long	0x49
 1498 0160 02        		.byte	0x2
 1499 0161 23        		.byte	0x23
 1500 0162 12        		.uleb128 0x12
 1501 0163 00        		.byte	0
 1502 0164 03        		.uleb128 0x3
 1503 0165 0000 0000 		.long	.LASF23
 1504 0169 01        		.byte	0x1
 1505 016a A8        		.byte	0xa8
 1506 016b CB00 0000 		.long	0xcb
 1507 016f 05        		.uleb128 0x5
 1508 0170 02        		.byte	0x2
 1509 0171 3000 0000 		.long	0x30
 1510 0175 0C        		.uleb128 0xc
 1511 0176 01        		.byte	0x1
 1512 0177 0000 0000 		.long	.LASF81
 1513 017b 01        		.byte	0x1
 1514 017c EF        		.byte	0xef
 1515 017d 01        		.byte	0x1
 1516 017e 8E01 0000 		.long	0x18e
 1517 0182 0D        		.uleb128 0xd
 1518 0183 5F6D 6400 		.string	"_md"
 1519 0187 01        		.byte	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 36


 1520 0188 EF        		.byte	0xef
 1521 0189 3000 0000 		.long	0x30
 1522 018d 00        		.byte	0
 1523 018e 0E        		.uleb128 0xe
 1524 018f 01        		.byte	0x1
 1525 0190 0000 0000 		.long	.LASF26
 1526 0194 01        		.byte	0x1
 1527 0195 B7        		.byte	0xb7
 1528 0196 0000 0000 		.long	.LFB102
 1529 019a 0000 0000 		.long	.LFE102
 1530 019e 03        		.byte	0x3
 1531 019f 92        		.byte	0x92
 1532 01a0 20        		.uleb128 0x20
 1533 01a1 03        		.sleb128 3
 1534 01a2 01        		.byte	0x1
 1535 01a3 E201 0000 		.long	0x1e2
 1536 01a7 0F        		.uleb128 0xf
 1537 01a8 0000 0000 		.long	.LASF28
 1538 01ac 01        		.byte	0x1
 1539 01ad B7        		.byte	0xb7
 1540 01ae 6200 0000 		.long	0x62
 1541 01b2 0000 0000 		.long	.LLST0
 1542 01b6 10        		.uleb128 0x10
 1543 01b7 0000 0000 		.long	.LBB2
 1544 01bb 0000 0000 		.long	.LBE2
 1545 01bf 11        		.uleb128 0x11
 1546 01c0 0000 0000 		.long	.LASF24
 1547 01c4 01        		.byte	0x1
 1548 01c5 B9        		.byte	0xb9
 1549 01c6 4900 0000 		.long	0x49
 1550 01ca 06        		.byte	0x6
 1551 01cb 62        		.byte	0x62
 1552 01cc 93        		.byte	0x93
 1553 01cd 01        		.uleb128 0x1
 1554 01ce 63        		.byte	0x63
 1555 01cf 93        		.byte	0x93
 1556 01d0 01        		.uleb128 0x1
 1557 01d1 12        		.uleb128 0x12
 1558 01d2 0000 0000 		.long	.LASF25
 1559 01d6 01        		.byte	0x1
 1560 01d7 BA        		.byte	0xba
 1561 01d8 3000 0000 		.long	0x30
 1562 01dc 0000 0000 		.long	.LLST1
 1563 01e0 00        		.byte	0
 1564 01e1 00        		.byte	0
 1565 01e2 13        		.uleb128 0x13
 1566 01e3 01        		.byte	0x1
 1567 01e4 0000 0000 		.long	.LASF27
 1568 01e8 01        		.byte	0x1
 1569 01e9 C8        		.byte	0xc8
 1570 01ea 0000 0000 		.long	.LFB103
 1571 01ee 0000 0000 		.long	.LFE103
 1572 01f2 0000 0000 		.long	.LLST2
 1573 01f6 01        		.byte	0x1
 1574 01f7 3602 0000 		.long	0x236
 1575 01fb 0F        		.uleb128 0xf
 1576 01fc 0000 0000 		.long	.LASF28
GAS LISTING /tmp/ccFP0NC0.s 			page 37


 1577 0200 01        		.byte	0x1
 1578 0201 C8        		.byte	0xc8
 1579 0202 6200 0000 		.long	0x62
 1580 0206 0000 0000 		.long	.LLST3
 1581 020a 0F        		.uleb128 0xf
 1582 020b 0000 0000 		.long	.LASF29
 1583 020f 01        		.byte	0x1
 1584 0210 C8        		.byte	0xc8
 1585 0211 3000 0000 		.long	0x30
 1586 0215 0000 0000 		.long	.LLST4
 1587 0219 14        		.uleb128 0x14
 1588 021a 0000 0000 		.long	.LVL10
 1589 021e 8E01 0000 		.long	0x18e
 1590 0222 15        		.uleb128 0x15
 1591 0223 0C        		.byte	0xc
 1592 0224 66        		.byte	0x66
 1593 0225 93        		.byte	0x93
 1594 0226 01        		.uleb128 0x1
 1595 0227 67        		.byte	0x67
 1596 0228 93        		.byte	0x93
 1597 0229 01        		.uleb128 0x1
 1598 022a 68        		.byte	0x68
 1599 022b 93        		.byte	0x93
 1600 022c 01        		.uleb128 0x1
 1601 022d 69        		.byte	0x69
 1602 022e 93        		.byte	0x93
 1603 022f 01        		.uleb128 0x1
 1604 0230 03        		.byte	0x3
 1605 0231 F3        		.byte	0xf3
 1606 0232 01        		.uleb128 0x1
 1607 0233 66        		.byte	0x66
 1608 0234 00        		.byte	0
 1609 0235 00        		.byte	0
 1610 0236 16        		.uleb128 0x16
 1611 0237 7501 0000 		.long	0x175
 1612 023b 0000 0000 		.long	.LFB104
 1613 023f 0000 0000 		.long	.LFE104
 1614 0243 0000 0000 		.long	.LLST5
 1615 0247 01        		.byte	0x1
 1616 0248 6902 0000 		.long	0x269
 1617 024c 17        		.uleb128 0x17
 1618 024d 8201 0000 		.long	0x182
 1619 0251 0000 0000 		.long	.LLST6
 1620 0255 10        		.uleb128 0x10
 1621 0256 0000 0000 		.long	.LBB5
 1622 025a 0000 0000 		.long	.LBE5
 1623 025e 17        		.uleb128 0x17
 1624 025f 8201 0000 		.long	0x182
 1625 0263 0000 0000 		.long	.LLST7
 1626 0267 00        		.byte	0
 1627 0268 00        		.byte	0
 1628 0269 18        		.uleb128 0x18
 1629 026a 01        		.byte	0x1
 1630 026b 0000 0000 		.long	.LASF30
 1631 026f 01        		.byte	0x1
 1632 0270 0401      		.word	0x104
 1633 0272 0000 0000 		.long	.LFB105
GAS LISTING /tmp/ccFP0NC0.s 			page 38


 1634 0276 0000 0000 		.long	.LFE105
 1635 027a 0000 0000 		.long	.LLST8
 1636 027e 01        		.byte	0x1
 1637 027f C702 0000 		.long	0x2c7
 1638 0283 10        		.uleb128 0x10
 1639 0284 0000 0000 		.long	.LBB7
 1640 0288 0000 0000 		.long	.LBE7
 1641 028c 19        		.uleb128 0x19
 1642 028d 5F63 7200 		.string	"_cr"
 1643 0291 01        		.byte	0x1
 1644 0292 0601      		.word	0x106
 1645 0294 3000 0000 		.long	0x30
 1646 0298 0000 0000 		.long	.LLST9
 1647 029c 19        		.uleb128 0x19
 1648 029d 5F6D 6400 		.string	"_md"
 1649 02a1 01        		.byte	0x1
 1650 02a2 0701      		.word	0x107
 1651 02a4 3000 0000 		.long	0x30
 1652 02a8 0000 0000 		.long	.LLST10
 1653 02ac 19        		.uleb128 0x19
 1654 02ad 5F73 7400 		.string	"_st"
 1655 02b1 01        		.byte	0x1
 1656 02b2 0801      		.word	0x108
 1657 02b4 3000 0000 		.long	0x30
 1658 02b8 0000 0000 		.long	.LLST11
 1659 02bc 1A        		.uleb128 0x1a
 1660 02bd 0000 0000 		.long	.LVL41
 1661 02c1 7501 0000 		.long	0x175
 1662 02c5 00        		.byte	0
 1663 02c6 00        		.byte	0
 1664 02c7 1B        		.uleb128 0x1b
 1665 02c8 01        		.byte	0x1
 1666 02c9 0000 0000 		.long	.LASF31
 1667 02cd 01        		.byte	0x1
 1668 02ce 8F01      		.word	0x18f
 1669 02d0 0000 0000 		.long	.LFB106
 1670 02d4 0000 0000 		.long	.LFE106
 1671 02d8 03        		.byte	0x3
 1672 02d9 92        		.byte	0x92
 1673 02da 20        		.uleb128 0x20
 1674 02db 03        		.sleb128 3
 1675 02dc 01        		.byte	0x1
 1676 02dd F202 0000 		.long	0x2f2
 1677 02e1 1C        		.uleb128 0x1c
 1678 02e2 0000 0000 		.long	.LASF32
 1679 02e6 01        		.byte	0x1
 1680 02e7 8F01      		.word	0x18f
 1681 02e9 3000 0000 		.long	0x30
 1682 02ed 0000 0000 		.long	.LLST12
 1683 02f1 00        		.byte	0
 1684 02f2 1B        		.uleb128 0x1b
 1685 02f3 01        		.byte	0x1
 1686 02f4 0000 0000 		.long	.LASF33
 1687 02f8 01        		.byte	0x1
 1688 02f9 9B01      		.word	0x19b
 1689 02fb 0000 0000 		.long	.LFB107
 1690 02ff 0000 0000 		.long	.LFE107
GAS LISTING /tmp/ccFP0NC0.s 			page 39


 1691 0303 03        		.byte	0x3
 1692 0304 92        		.byte	0x92
 1693 0305 20        		.uleb128 0x20
 1694 0306 03        		.sleb128 3
 1695 0307 01        		.byte	0x1
 1696 0308 1D03 0000 		.long	0x31d
 1697 030c 1C        		.uleb128 0x1c
 1698 030d 0000 0000 		.long	.LASF32
 1699 0311 01        		.byte	0x1
 1700 0312 9B01      		.word	0x19b
 1701 0314 3000 0000 		.long	0x30
 1702 0318 0000 0000 		.long	.LLST13
 1703 031c 00        		.byte	0
 1704 031d 1B        		.uleb128 0x1b
 1705 031e 01        		.byte	0x1
 1706 031f 0000 0000 		.long	.LASF34
 1707 0323 01        		.byte	0x1
 1708 0324 AD01      		.word	0x1ad
 1709 0326 0000 0000 		.long	.LFB108
 1710 032a 0000 0000 		.long	.LFE108
 1711 032e 03        		.byte	0x3
 1712 032f 92        		.byte	0x92
 1713 0330 20        		.uleb128 0x20
 1714 0331 03        		.sleb128 3
 1715 0332 01        		.byte	0x1
 1716 0333 7C03 0000 		.long	0x37c
 1717 0337 1C        		.uleb128 0x1c
 1718 0338 0000 0000 		.long	.LASF32
 1719 033c 01        		.byte	0x1
 1720 033d AD01      		.word	0x1ad
 1721 033f 3000 0000 		.long	0x30
 1722 0343 0000 0000 		.long	.LLST14
 1723 0347 1C        		.uleb128 0x1c
 1724 0348 0000 0000 		.long	.LASF35
 1725 034c 01        		.byte	0x1
 1726 034d AD01      		.word	0x1ad
 1727 034f 7C03 0000 		.long	0x37c
 1728 0353 0000 0000 		.long	.LLST15
 1729 0357 1C        		.uleb128 0x1c
 1730 0358 0000 0000 		.long	.LASF36
 1731 035c 01        		.byte	0x1
 1732 035d AD01      		.word	0x1ad
 1733 035f 3000 0000 		.long	0x30
 1734 0363 0000 0000 		.long	.LLST16
 1735 0367 1D        		.uleb128 0x1d
 1736 0368 0000 0000 		.long	.LVL56
 1737 036c 01        		.byte	0x1
 1738 036d C702 0000 		.long	0x2c7
 1739 0371 15        		.uleb128 0x15
 1740 0372 01        		.byte	0x1
 1741 0373 68        		.byte	0x68
 1742 0374 05        		.byte	0x5
 1743 0375 F3        		.byte	0xf3
 1744 0376 01        		.uleb128 0x1
 1745 0377 68        		.byte	0x68
 1746 0378 31        		.byte	0x31
 1747 0379 24        		.byte	0x24
GAS LISTING /tmp/ccFP0NC0.s 			page 40


 1748 037a 00        		.byte	0
 1749 037b 00        		.byte	0
 1750 037c 05        		.uleb128 0x5
 1751 037d 02        		.byte	0x2
 1752 037e 8203 0000 		.long	0x382
 1753 0382 1E        		.uleb128 0x1e
 1754 0383 3000 0000 		.long	0x30
 1755 0387 1B        		.uleb128 0x1b
 1756 0388 01        		.byte	0x1
 1757 0389 0000 0000 		.long	.LASF37
 1758 038d 01        		.byte	0x1
 1759 038e B701      		.word	0x1b7
 1760 0390 0000 0000 		.long	.LFB109
 1761 0394 0000 0000 		.long	.LFE109
 1762 0398 03        		.byte	0x3
 1763 0399 92        		.byte	0x92
 1764 039a 20        		.uleb128 0x20
 1765 039b 03        		.sleb128 3
 1766 039c 01        		.byte	0x1
 1767 039d E803 0000 		.long	0x3e8
 1768 03a1 1C        		.uleb128 0x1c
 1769 03a2 0000 0000 		.long	.LASF32
 1770 03a6 01        		.byte	0x1
 1771 03a7 B701      		.word	0x1b7
 1772 03a9 3000 0000 		.long	0x30
 1773 03ad 0000 0000 		.long	.LLST17
 1774 03b1 1C        		.uleb128 0x1c
 1775 03b2 0000 0000 		.long	.LASF35
 1776 03b6 01        		.byte	0x1
 1777 03b7 B701      		.word	0x1b7
 1778 03b9 6F01 0000 		.long	0x16f
 1779 03bd 0000 0000 		.long	.LLST18
 1780 03c1 1C        		.uleb128 0x1c
 1781 03c2 0000 0000 		.long	.LASF36
 1782 03c6 01        		.byte	0x1
 1783 03c7 B701      		.word	0x1b7
 1784 03c9 3000 0000 		.long	0x30
 1785 03cd 0000 0000 		.long	.LLST19
 1786 03d1 1D        		.uleb128 0x1d
 1787 03d2 0000 0000 		.long	.LVL59
 1788 03d6 01        		.byte	0x1
 1789 03d7 C702 0000 		.long	0x2c7
 1790 03db 15        		.uleb128 0x15
 1791 03dc 01        		.byte	0x1
 1792 03dd 68        		.byte	0x68
 1793 03de 07        		.byte	0x7
 1794 03df F3        		.byte	0xf3
 1795 03e0 01        		.uleb128 0x1
 1796 03e1 68        		.byte	0x68
 1797 03e2 31        		.byte	0x31
 1798 03e3 24        		.byte	0x24
 1799 03e4 31        		.byte	0x31
 1800 03e5 21        		.byte	0x21
 1801 03e6 00        		.byte	0
 1802 03e7 00        		.byte	0
 1803 03e8 1F        		.uleb128 0x1f
 1804 03e9 01        		.byte	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 41


 1805 03ea 0000 0000 		.long	.LASF38
 1806 03ee 01        		.byte	0x1
 1807 03ef C201      		.word	0x1c2
 1808 03f1 0000 0000 		.long	.LFB110
 1809 03f5 0000 0000 		.long	.LFE110
 1810 03f9 0000 0000 		.long	.LLST20
 1811 03fd 01        		.byte	0x1
 1812 03fe 5704 0000 		.long	0x457
 1813 0402 1C        		.uleb128 0x1c
 1814 0403 0000 0000 		.long	.LASF32
 1815 0407 01        		.byte	0x1
 1816 0408 C201      		.word	0x1c2
 1817 040a 3000 0000 		.long	0x30
 1818 040e 0000 0000 		.long	.LLST21
 1819 0412 20        		.uleb128 0x20
 1820 0413 0000 0000 		.long	.LASF39
 1821 0417 01        		.byte	0x1
 1822 0418 C301      		.word	0x1c3
 1823 041a 6F01 0000 		.long	0x16f
 1824 041e 06        		.byte	0x6
 1825 041f 66        		.byte	0x66
 1826 0420 93        		.byte	0x93
 1827 0421 01        		.uleb128 0x1
 1828 0422 67        		.byte	0x67
 1829 0423 93        		.byte	0x93
 1830 0424 01        		.uleb128 0x1
 1831 0425 20        		.uleb128 0x20
 1832 0426 0000 0000 		.long	.LASF40
 1833 042a 01        		.byte	0x1
 1834 042b C301      		.word	0x1c3
 1835 042d 3000 0000 		.long	0x30
 1836 0431 01        		.byte	0x1
 1837 0432 64        		.byte	0x64
 1838 0433 20        		.uleb128 0x20
 1839 0434 0000 0000 		.long	.LASF35
 1840 0438 01        		.byte	0x1
 1841 0439 C401      		.word	0x1c4
 1842 043b 6F01 0000 		.long	0x16f
 1843 043f 06        		.byte	0x6
 1844 0440 62        		.byte	0x62
 1845 0441 93        		.byte	0x93
 1846 0442 01        		.uleb128 0x1
 1847 0443 63        		.byte	0x63
 1848 0444 93        		.byte	0x93
 1849 0445 01        		.uleb128 0x1
 1850 0446 1C        		.uleb128 0x1c
 1851 0447 0000 0000 		.long	.LASF41
 1852 044b 01        		.byte	0x1
 1853 044c C401      		.word	0x1c4
 1854 044e 3000 0000 		.long	0x30
 1855 0452 0000 0000 		.long	.LLST22
 1856 0456 00        		.byte	0
 1857 0457 1B        		.uleb128 0x1b
 1858 0458 01        		.byte	0x1
 1859 0459 0000 0000 		.long	.LASF42
 1860 045d 02        		.byte	0x2
 1861 045e E901      		.word	0x1e9
GAS LISTING /tmp/ccFP0NC0.s 			page 42


 1862 0460 0000 0000 		.long	.LFB111
 1863 0464 0000 0000 		.long	.LFE111
 1864 0468 03        		.byte	0x3
 1865 0469 92        		.byte	0x92
 1866 046a 20        		.uleb128 0x20
 1867 046b 03        		.sleb128 3
 1868 046c 01        		.byte	0x1
 1869 046d AA04 0000 		.long	0x4aa
 1870 0471 1C        		.uleb128 0x1c
 1871 0472 0000 0000 		.long	.LASF43
 1872 0476 02        		.byte	0x2
 1873 0477 E901      		.word	0x1e9
 1874 0479 3000 0000 		.long	0x30
 1875 047d 0000 0000 		.long	.LLST23
 1876 0481 21        		.uleb128 0x21
 1877 0482 5F72 7300 		.string	"_rs"
 1878 0486 02        		.byte	0x2
 1879 0487 E901      		.word	0x1e9
 1880 0489 3000 0000 		.long	0x30
 1881 048d 01        		.byte	0x1
 1882 048e 66        		.byte	0x66
 1883 048f 10        		.uleb128 0x10
 1884 0490 0000 0000 		.long	.LBB8
 1885 0494 0000 0000 		.long	.LBE8
 1886 0498 22        		.uleb128 0x22
 1887 0499 0000 0000 		.long	.LASF44
 1888 049d 02        		.byte	0x2
 1889 049e EB01      		.word	0x1eb
 1890 04a0 3000 0000 		.long	0x30
 1891 04a4 0000 0000 		.long	.LLST24
 1892 04a8 00        		.byte	0
 1893 04a9 00        		.byte	0
 1894 04aa 1F        		.uleb128 0x1f
 1895 04ab 01        		.byte	0x1
 1896 04ac 0000 0000 		.long	.LASF45
 1897 04b0 02        		.byte	0x2
 1898 04b1 FE01      		.word	0x1fe
 1899 04b3 0000 0000 		.long	.LFB112
 1900 04b7 0000 0000 		.long	.LFE112
 1901 04bb 0000 0000 		.long	.LLST25
 1902 04bf 01        		.byte	0x1
 1903 04c0 5505 0000 		.long	0x555
 1904 04c4 23        		.uleb128 0x23
 1905 04c5 6275 6600 		.string	"buf"
 1906 04c9 02        		.byte	0x2
 1907 04ca FE01      		.word	0x1fe
 1908 04cc 8900 0000 		.long	0x89
 1909 04d0 0000 0000 		.long	.LLST26
 1910 04d4 23        		.uleb128 0x23
 1911 04d5 6C65 6E00 		.string	"len"
 1912 04d9 02        		.byte	0x2
 1913 04da FE01      		.word	0x1fe
 1914 04dc 3000 0000 		.long	0x30
 1915 04e0 0000 0000 		.long	.LLST27
 1916 04e4 10        		.uleb128 0x10
 1917 04e5 0000 0000 		.long	.LBB9
 1918 04e9 0000 0000 		.long	.LBE9
GAS LISTING /tmp/ccFP0NC0.s 			page 43


 1919 04ed 19        		.uleb128 0x19
 1920 04ee 5F62 00   		.string	"_b"
 1921 04f1 02        		.byte	0x2
 1922 04f2 0002      		.word	0x200
 1923 04f4 6F01 0000 		.long	0x16f
 1924 04f8 0000 0000 		.long	.LLST28
 1925 04fc 19        		.uleb128 0x19
 1926 04fd 5F6C 00   		.string	"_l"
 1927 0500 02        		.byte	0x2
 1928 0501 0102      		.word	0x201
 1929 0503 3000 0000 		.long	0x30
 1930 0507 0000 0000 		.long	.LLST29
 1931 050b 24        		.uleb128 0x24
 1932 050c 0000 0000 		.long	.LVL78
 1933 0510 5704 0000 		.long	0x457
 1934 0514 1E05 0000 		.long	0x51e
 1935 0518 15        		.uleb128 0x15
 1936 0519 01        		.byte	0x1
 1937 051a 66        		.byte	0x66
 1938 051b 01        		.byte	0x1
 1939 051c 31        		.byte	0x31
 1940 051d 00        		.byte	0
 1941 051e 24        		.uleb128 0x24
 1942 051f 0000 0000 		.long	.LVL79
 1943 0523 1D03 0000 		.long	0x31d
 1944 0527 3F05 0000 		.long	0x53f
 1945 052b 15        		.uleb128 0x15
 1946 052c 06        		.byte	0x6
 1947 052d 66        		.byte	0x66
 1948 052e 93        		.byte	0x93
 1949 052f 01        		.uleb128 0x1
 1950 0530 67        		.byte	0x67
 1951 0531 93        		.byte	0x93
 1952 0532 01        		.uleb128 0x1
 1953 0533 05        		.byte	0x5
 1954 0534 03        		.byte	0x3
 1955 0535 0000 0000 		.long	lcdBuffer
 1956 0539 15        		.uleb128 0x15
 1957 053a 01        		.byte	0x1
 1958 053b 64        		.byte	0x64
 1959 053c 01        		.byte	0x1
 1960 053d 36        		.byte	0x36
 1961 053e 00        		.byte	0
 1962 053f 14        		.uleb128 0x14
 1963 0540 0000 0000 		.long	.LVL80
 1964 0544 3C0B 0000 		.long	0xb3c
 1965 0548 15        		.uleb128 0x15
 1966 0549 06        		.byte	0x6
 1967 054a 68        		.byte	0x68
 1968 054b 93        		.byte	0x93
 1969 054c 01        		.uleb128 0x1
 1970 054d 69        		.byte	0x69
 1971 054e 93        		.byte	0x93
 1972 054f 01        		.uleb128 0x1
 1973 0550 01        		.byte	0x1
 1974 0551 35        		.byte	0x35
 1975 0552 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 44


 1976 0553 00        		.byte	0
 1977 0554 00        		.byte	0
 1978 0555 1B        		.uleb128 0x1b
 1979 0556 01        		.byte	0x1
 1980 0557 0000 0000 		.long	.LASF46
 1981 055b 02        		.byte	0x2
 1982 055c 0B02      		.word	0x20b
 1983 055e 0000 0000 		.long	.LFB113
 1984 0562 0000 0000 		.long	.LFE113
 1985 0566 03        		.byte	0x3
 1986 0567 92        		.byte	0x92
 1987 0568 20        		.uleb128 0x20
 1988 0569 03        		.sleb128 3
 1989 056a 01        		.byte	0x1
 1990 056b 0B07 0000 		.long	0x70b
 1991 056f 24        		.uleb128 0x24
 1992 0570 0000 0000 		.long	.LVL83
 1993 0574 5704 0000 		.long	0x457
 1994 0578 8205 0000 		.long	0x582
 1995 057c 15        		.uleb128 0x15
 1996 057d 01        		.byte	0x1
 1997 057e 66        		.byte	0x66
 1998 057f 01        		.byte	0x1
 1999 0580 30        		.byte	0x30
 2000 0581 00        		.byte	0
 2001 0582 24        		.uleb128 0x24
 2002 0583 0000 0000 		.long	.LVL84
 2003 0587 1D03 0000 		.long	0x31d
 2004 058b A305 0000 		.long	0x5a3
 2005 058f 15        		.uleb128 0x15
 2006 0590 06        		.byte	0x6
 2007 0591 66        		.byte	0x66
 2008 0592 93        		.byte	0x93
 2009 0593 01        		.uleb128 0x1
 2010 0594 67        		.byte	0x67
 2011 0595 93        		.byte	0x93
 2012 0596 01        		.uleb128 0x1
 2013 0597 05        		.byte	0x5
 2014 0598 03        		.byte	0x3
 2015 0599 0000 0000 		.long	lcdBuffer
 2016 059d 15        		.uleb128 0x15
 2017 059e 01        		.byte	0x1
 2018 059f 64        		.byte	0x64
 2019 05a0 01        		.byte	0x1
 2020 05a1 36        		.byte	0x36
 2021 05a2 00        		.byte	0
 2022 05a3 24        		.uleb128 0x24
 2023 05a4 0000 0000 		.long	.LVL85
 2024 05a8 3C0B 0000 		.long	0xb3c
 2025 05ac BB05 0000 		.long	0x5bb
 2026 05b0 15        		.uleb128 0x15
 2027 05b1 06        		.byte	0x6
 2028 05b2 68        		.byte	0x68
 2029 05b3 93        		.byte	0x93
 2030 05b4 01        		.uleb128 0x1
 2031 05b5 69        		.byte	0x69
 2032 05b6 93        		.byte	0x93
GAS LISTING /tmp/ccFP0NC0.s 			page 45


 2033 05b7 01        		.uleb128 0x1
 2034 05b8 01        		.byte	0x1
 2035 05b9 35        		.byte	0x35
 2036 05ba 00        		.byte	0
 2037 05bb 24        		.uleb128 0x24
 2038 05bc 0000 0000 		.long	.LVL86
 2039 05c0 5704 0000 		.long	0x457
 2040 05c4 CE05 0000 		.long	0x5ce
 2041 05c8 15        		.uleb128 0x15
 2042 05c9 01        		.byte	0x1
 2043 05ca 66        		.byte	0x66
 2044 05cb 01        		.byte	0x1
 2045 05cc 30        		.byte	0x30
 2046 05cd 00        		.byte	0
 2047 05ce 24        		.uleb128 0x24
 2048 05cf 0000 0000 		.long	.LVL87
 2049 05d3 1D03 0000 		.long	0x31d
 2050 05d7 EF05 0000 		.long	0x5ef
 2051 05db 15        		.uleb128 0x15
 2052 05dc 06        		.byte	0x6
 2053 05dd 66        		.byte	0x66
 2054 05de 93        		.byte	0x93
 2055 05df 01        		.uleb128 0x1
 2056 05e0 67        		.byte	0x67
 2057 05e1 93        		.byte	0x93
 2058 05e2 01        		.uleb128 0x1
 2059 05e3 05        		.byte	0x5
 2060 05e4 03        		.byte	0x3
 2061 05e5 0000 0000 		.long	lcdBuffer
 2062 05e9 15        		.uleb128 0x15
 2063 05ea 01        		.byte	0x1
 2064 05eb 64        		.byte	0x64
 2065 05ec 01        		.byte	0x1
 2066 05ed 36        		.byte	0x36
 2067 05ee 00        		.byte	0
 2068 05ef 24        		.uleb128 0x24
 2069 05f0 0000 0000 		.long	.LVL88
 2070 05f4 3C0B 0000 		.long	0xb3c
 2071 05f8 0706 0000 		.long	0x607
 2072 05fc 15        		.uleb128 0x15
 2073 05fd 06        		.byte	0x6
 2074 05fe 68        		.byte	0x68
 2075 05ff 93        		.byte	0x93
 2076 0600 01        		.uleb128 0x1
 2077 0601 69        		.byte	0x69
 2078 0602 93        		.byte	0x93
 2079 0603 01        		.uleb128 0x1
 2080 0604 01        		.byte	0x1
 2081 0605 35        		.byte	0x35
 2082 0606 00        		.byte	0
 2083 0607 24        		.uleb128 0x24
 2084 0608 0000 0000 		.long	.LVL89
 2085 060c 5704 0000 		.long	0x457
 2086 0610 1A06 0000 		.long	0x61a
 2087 0614 15        		.uleb128 0x15
 2088 0615 01        		.byte	0x1
 2089 0616 66        		.byte	0x66
GAS LISTING /tmp/ccFP0NC0.s 			page 46


 2090 0617 01        		.byte	0x1
 2091 0618 30        		.byte	0x30
 2092 0619 00        		.byte	0
 2093 061a 24        		.uleb128 0x24
 2094 061b 0000 0000 		.long	.LVL90
 2095 061f 1D03 0000 		.long	0x31d
 2096 0623 3B06 0000 		.long	0x63b
 2097 0627 15        		.uleb128 0x15
 2098 0628 06        		.byte	0x6
 2099 0629 66        		.byte	0x66
 2100 062a 93        		.byte	0x93
 2101 062b 01        		.uleb128 0x1
 2102 062c 67        		.byte	0x67
 2103 062d 93        		.byte	0x93
 2104 062e 01        		.uleb128 0x1
 2105 062f 05        		.byte	0x5
 2106 0630 03        		.byte	0x3
 2107 0631 0000 0000 		.long	lcdBuffer
 2108 0635 15        		.uleb128 0x15
 2109 0636 01        		.byte	0x1
 2110 0637 64        		.byte	0x64
 2111 0638 01        		.byte	0x1
 2112 0639 36        		.byte	0x36
 2113 063a 00        		.byte	0
 2114 063b 24        		.uleb128 0x24
 2115 063c 0000 0000 		.long	.LVL91
 2116 0640 3C0B 0000 		.long	0xb3c
 2117 0644 5306 0000 		.long	0x653
 2118 0648 15        		.uleb128 0x15
 2119 0649 06        		.byte	0x6
 2120 064a 68        		.byte	0x68
 2121 064b 93        		.byte	0x93
 2122 064c 01        		.uleb128 0x1
 2123 064d 69        		.byte	0x69
 2124 064e 93        		.byte	0x93
 2125 064f 01        		.uleb128 0x1
 2126 0650 01        		.byte	0x1
 2127 0651 35        		.byte	0x35
 2128 0652 00        		.byte	0
 2129 0653 24        		.uleb128 0x24
 2130 0654 0000 0000 		.long	.LVL92
 2131 0658 5704 0000 		.long	0x457
 2132 065c 6B06 0000 		.long	0x66b
 2133 0660 15        		.uleb128 0x15
 2134 0661 01        		.byte	0x1
 2135 0662 68        		.byte	0x68
 2136 0663 01        		.byte	0x1
 2137 0664 31        		.byte	0x31
 2138 0665 15        		.uleb128 0x15
 2139 0666 01        		.byte	0x1
 2140 0667 66        		.byte	0x66
 2141 0668 01        		.byte	0x1
 2142 0669 30        		.byte	0x30
 2143 066a 00        		.byte	0
 2144 066b 24        		.uleb128 0x24
 2145 066c 0000 0000 		.long	.LVL93
 2146 0670 1D03 0000 		.long	0x31d
GAS LISTING /tmp/ccFP0NC0.s 			page 47


 2147 0674 8C06 0000 		.long	0x68c
 2148 0678 15        		.uleb128 0x15
 2149 0679 06        		.byte	0x6
 2150 067a 66        		.byte	0x66
 2151 067b 93        		.byte	0x93
 2152 067c 01        		.uleb128 0x1
 2153 067d 67        		.byte	0x67
 2154 067e 93        		.byte	0x93
 2155 067f 01        		.uleb128 0x1
 2156 0680 05        		.byte	0x5
 2157 0681 03        		.byte	0x3
 2158 0682 0000 0000 		.long	lcdBuffer
 2159 0686 15        		.uleb128 0x15
 2160 0687 01        		.byte	0x1
 2161 0688 64        		.byte	0x64
 2162 0689 01        		.byte	0x1
 2163 068a 36        		.byte	0x36
 2164 068b 00        		.byte	0
 2165 068c 24        		.uleb128 0x24
 2166 068d 0000 0000 		.long	.LVL94
 2167 0691 3C0B 0000 		.long	0xb3c
 2168 0695 A406 0000 		.long	0x6a4
 2169 0699 15        		.uleb128 0x15
 2170 069a 06        		.byte	0x6
 2171 069b 68        		.byte	0x68
 2172 069c 93        		.byte	0x93
 2173 069d 01        		.uleb128 0x1
 2174 069e 69        		.byte	0x69
 2175 069f 93        		.byte	0x93
 2176 06a0 01        		.uleb128 0x1
 2177 06a1 01        		.byte	0x1
 2178 06a2 35        		.byte	0x35
 2179 06a3 00        		.byte	0
 2180 06a4 24        		.uleb128 0x24
 2181 06a5 0000 0000 		.long	.LVL95
 2182 06a9 3C0B 0000 		.long	0xb3c
 2183 06ad BC06 0000 		.long	0x6bc
 2184 06b1 15        		.uleb128 0x15
 2185 06b2 06        		.byte	0x6
 2186 06b3 68        		.byte	0x68
 2187 06b4 93        		.byte	0x93
 2188 06b5 01        		.uleb128 0x1
 2189 06b6 69        		.byte	0x69
 2190 06b7 93        		.byte	0x93
 2191 06b8 01        		.uleb128 0x1
 2192 06b9 01        		.byte	0x1
 2193 06ba 40        		.byte	0x40
 2194 06bb 00        		.byte	0
 2195 06bc 24        		.uleb128 0x24
 2196 06bd 0000 0000 		.long	.LVL96
 2197 06c1 5704 0000 		.long	0x457
 2198 06c5 D406 0000 		.long	0x6d4
 2199 06c9 15        		.uleb128 0x15
 2200 06ca 01        		.byte	0x1
 2201 06cb 68        		.byte	0x68
 2202 06cc 01        		.byte	0x1
 2203 06cd 32        		.byte	0x32
GAS LISTING /tmp/ccFP0NC0.s 			page 48


 2204 06ce 15        		.uleb128 0x15
 2205 06cf 01        		.byte	0x1
 2206 06d0 66        		.byte	0x66
 2207 06d1 01        		.byte	0x1
 2208 06d2 30        		.byte	0x30
 2209 06d3 00        		.byte	0
 2210 06d4 24        		.uleb128 0x24
 2211 06d5 0000 0000 		.long	.LVL97
 2212 06d9 1D03 0000 		.long	0x31d
 2213 06dd F506 0000 		.long	0x6f5
 2214 06e1 15        		.uleb128 0x15
 2215 06e2 06        		.byte	0x6
 2216 06e3 66        		.byte	0x66
 2217 06e4 93        		.byte	0x93
 2218 06e5 01        		.uleb128 0x1
 2219 06e6 67        		.byte	0x67
 2220 06e7 93        		.byte	0x93
 2221 06e8 01        		.uleb128 0x1
 2222 06e9 05        		.byte	0x5
 2223 06ea 03        		.byte	0x3
 2224 06eb 0000 0000 		.long	lcdBuffer
 2225 06ef 15        		.uleb128 0x15
 2226 06f0 01        		.byte	0x1
 2227 06f1 64        		.byte	0x64
 2228 06f2 01        		.byte	0x1
 2229 06f3 36        		.byte	0x36
 2230 06f4 00        		.byte	0
 2231 06f5 1D        		.uleb128 0x1d
 2232 06f6 0000 0000 		.long	.LVL98
 2233 06fa 01        		.byte	0x1
 2234 06fb 3C0B 0000 		.long	0xb3c
 2235 06ff 15        		.uleb128 0x15
 2236 0700 06        		.byte	0x6
 2237 0701 68        		.byte	0x68
 2238 0702 93        		.byte	0x93
 2239 0703 01        		.uleb128 0x1
 2240 0704 69        		.byte	0x69
 2241 0705 93        		.byte	0x93
 2242 0706 01        		.uleb128 0x1
 2243 0707 01        		.byte	0x1
 2244 0708 35        		.byte	0x35
 2245 0709 00        		.byte	0
 2246 070a 00        		.byte	0
 2247 070b 1F        		.uleb128 0x1f
 2248 070c 01        		.byte	0x1
 2249 070d 0000 0000 		.long	.LASF47
 2250 0711 02        		.byte	0x2
 2251 0712 1702      		.word	0x217
 2252 0714 0000 0000 		.long	.LFB114
 2253 0718 0000 0000 		.long	.LFE114
 2254 071c 0000 0000 		.long	.LLST30
 2255 0720 01        		.byte	0x1
 2256 0721 F308 0000 		.long	0x8f3
 2257 0725 1C        		.uleb128 0x1c
 2258 0726 0000 0000 		.long	.LASF48
 2259 072a 02        		.byte	0x2
 2260 072b 1702      		.word	0x217
GAS LISTING /tmp/ccFP0NC0.s 			page 49


 2261 072d 3000 0000 		.long	0x30
 2262 0731 0000 0000 		.long	.LLST31
 2263 0735 1C        		.uleb128 0x1c
 2264 0736 0000 0000 		.long	.LASF49
 2265 073a 02        		.byte	0x2
 2266 073b 1702      		.word	0x217
 2267 073d 3000 0000 		.long	0x30
 2268 0741 0000 0000 		.long	.LLST32
 2269 0745 1C        		.uleb128 0x1c
 2270 0746 0000 0000 		.long	.LASF50
 2271 074a 02        		.byte	0x2
 2272 074b 1702      		.word	0x217
 2273 074d 3000 0000 		.long	0x30
 2274 0751 0000 0000 		.long	.LLST33
 2275 0755 1C        		.uleb128 0x1c
 2276 0756 0000 0000 		.long	.LASF51
 2277 075a 02        		.byte	0x2
 2278 075b 1702      		.word	0x217
 2279 075d 3000 0000 		.long	0x30
 2280 0761 0000 0000 		.long	.LLST34
 2281 0765 24        		.uleb128 0x24
 2282 0766 0000 0000 		.long	.LVL105
 2283 076a E201 0000 		.long	0x1e2
 2284 076e 8C07 0000 		.long	0x78c
 2285 0772 15        		.uleb128 0x15
 2286 0773 0C        		.byte	0xc
 2287 0774 66        		.byte	0x66
 2288 0775 93        		.byte	0x93
 2289 0776 01        		.uleb128 0x1
 2290 0777 67        		.byte	0x67
 2291 0778 93        		.byte	0x93
 2292 0779 01        		.uleb128 0x1
 2293 077a 68        		.byte	0x68
 2294 077b 93        		.byte	0x93
 2295 077c 01        		.uleb128 0x1
 2296 077d 69        		.byte	0x69
 2297 077e 93        		.byte	0x93
 2298 077f 01        		.uleb128 0x1
 2299 0780 05        		.byte	0x5
 2300 0781 0C        		.byte	0xc
 2301 0782 A086 0100 		.long	0x186a0
 2302 0786 15        		.uleb128 0x15
 2303 0787 01        		.byte	0x1
 2304 0788 64        		.byte	0x64
 2305 0789 01        		.byte	0x1
 2306 078a 36        		.byte	0x36
 2307 078b 00        		.byte	0
 2308 078c 24        		.uleb128 0x24
 2309 078d 0000 0000 		.long	.LVL106
 2310 0791 5704 0000 		.long	0x457
 2311 0795 A507 0000 		.long	0x7a5
 2312 0799 15        		.uleb128 0x15
 2313 079a 01        		.byte	0x1
 2314 079b 68        		.byte	0x68
 2315 079c 02        		.byte	0x2
 2316 079d 08        		.byte	0x8
 2317 079e 30        		.byte	0x30
GAS LISTING /tmp/ccFP0NC0.s 			page 50


 2318 079f 15        		.uleb128 0x15
 2319 07a0 01        		.byte	0x1
 2320 07a1 66        		.byte	0x66
 2321 07a2 01        		.byte	0x1
 2322 07a3 30        		.byte	0x30
 2323 07a4 00        		.byte	0
 2324 07a5 24        		.uleb128 0x24
 2325 07a6 0000 0000 		.long	.LVL107
 2326 07aa 3C0B 0000 		.long	0xb3c
 2327 07ae BD07 0000 		.long	0x7bd
 2328 07b2 15        		.uleb128 0x15
 2329 07b3 06        		.byte	0x6
 2330 07b4 68        		.byte	0x68
 2331 07b5 93        		.byte	0x93
 2332 07b6 01        		.uleb128 0x1
 2333 07b7 69        		.byte	0x69
 2334 07b8 93        		.byte	0x93
 2335 07b9 01        		.uleb128 0x1
 2336 07ba 01        		.byte	0x1
 2337 07bb 3F        		.byte	0x3f
 2338 07bc 00        		.byte	0
 2339 07bd 24        		.uleb128 0x24
 2340 07be 0000 0000 		.long	.LVL108
 2341 07c2 1D03 0000 		.long	0x31d
 2342 07c6 DE07 0000 		.long	0x7de
 2343 07ca 15        		.uleb128 0x15
 2344 07cb 06        		.byte	0x6
 2345 07cc 66        		.byte	0x66
 2346 07cd 93        		.byte	0x93
 2347 07ce 01        		.uleb128 0x1
 2348 07cf 67        		.byte	0x67
 2349 07d0 93        		.byte	0x93
 2350 07d1 01        		.uleb128 0x1
 2351 07d2 05        		.byte	0x5
 2352 07d3 03        		.byte	0x3
 2353 07d4 0000 0000 		.long	lcdBuffer
 2354 07d8 15        		.uleb128 0x15
 2355 07d9 01        		.byte	0x1
 2356 07da 64        		.byte	0x64
 2357 07db 01        		.byte	0x1
 2358 07dc 33        		.byte	0x33
 2359 07dd 00        		.byte	0
 2360 07de 24        		.uleb128 0x24
 2361 07df 0000 0000 		.long	.LVL109
 2362 07e3 3C0B 0000 		.long	0xb3c
 2363 07e7 F607 0000 		.long	0x7f6
 2364 07eb 15        		.uleb128 0x15
 2365 07ec 06        		.byte	0x6
 2366 07ed 68        		.byte	0x68
 2367 07ee 93        		.byte	0x93
 2368 07ef 01        		.uleb128 0x1
 2369 07f0 69        		.byte	0x69
 2370 07f1 93        		.byte	0x93
 2371 07f2 01        		.uleb128 0x1
 2372 07f3 01        		.byte	0x1
 2373 07f4 35        		.byte	0x35
 2374 07f5 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 51


 2375 07f6 24        		.uleb128 0x24
 2376 07f7 0000 0000 		.long	.LVL110
 2377 07fb 3C0B 0000 		.long	0xb3c
 2378 07ff 0E08 0000 		.long	0x80e
 2379 0803 15        		.uleb128 0x15
 2380 0804 06        		.byte	0x6
 2381 0805 68        		.byte	0x68
 2382 0806 93        		.byte	0x93
 2383 0807 01        		.uleb128 0x1
 2384 0808 69        		.byte	0x69
 2385 0809 93        		.byte	0x93
 2386 080a 01        		.uleb128 0x1
 2387 080b 01        		.byte	0x1
 2388 080c 35        		.byte	0x35
 2389 080d 00        		.byte	0
 2390 080e 24        		.uleb128 0x24
 2391 080f 0000 0000 		.long	.LVL111
 2392 0813 1D03 0000 		.long	0x31d
 2393 0817 2F08 0000 		.long	0x82f
 2394 081b 15        		.uleb128 0x15
 2395 081c 06        		.byte	0x6
 2396 081d 66        		.byte	0x66
 2397 081e 93        		.byte	0x93
 2398 081f 01        		.uleb128 0x1
 2399 0820 67        		.byte	0x67
 2400 0821 93        		.byte	0x93
 2401 0822 01        		.uleb128 0x1
 2402 0823 05        		.byte	0x5
 2403 0824 03        		.byte	0x3
 2404 0825 0000 0000 		.long	lcdBuffer
 2405 0829 15        		.uleb128 0x15
 2406 082a 01        		.byte	0x1
 2407 082b 64        		.byte	0x64
 2408 082c 01        		.byte	0x1
 2409 082d 33        		.byte	0x33
 2410 082e 00        		.byte	0
 2411 082f 24        		.uleb128 0x24
 2412 0830 0000 0000 		.long	.LVL112
 2413 0834 3C0B 0000 		.long	0xb3c
 2414 0838 4708 0000 		.long	0x847
 2415 083c 15        		.uleb128 0x15
 2416 083d 06        		.byte	0x6
 2417 083e 68        		.byte	0x68
 2418 083f 93        		.byte	0x93
 2419 0840 01        		.uleb128 0x1
 2420 0841 69        		.byte	0x69
 2421 0842 93        		.byte	0x93
 2422 0843 01        		.uleb128 0x1
 2423 0844 01        		.byte	0x1
 2424 0845 35        		.byte	0x35
 2425 0846 00        		.byte	0
 2426 0847 24        		.uleb128 0x24
 2427 0848 0000 0000 		.long	.LVL113
 2428 084c 1D03 0000 		.long	0x31d
 2429 0850 6808 0000 		.long	0x868
 2430 0854 15        		.uleb128 0x15
 2431 0855 06        		.byte	0x6
GAS LISTING /tmp/ccFP0NC0.s 			page 52


 2432 0856 66        		.byte	0x66
 2433 0857 93        		.byte	0x93
 2434 0858 01        		.uleb128 0x1
 2435 0859 67        		.byte	0x67
 2436 085a 93        		.byte	0x93
 2437 085b 01        		.uleb128 0x1
 2438 085c 05        		.byte	0x5
 2439 085d 03        		.byte	0x3
 2440 085e 0000 0000 		.long	lcdBuffer
 2441 0862 15        		.uleb128 0x15
 2442 0863 01        		.byte	0x1
 2443 0864 64        		.byte	0x64
 2444 0865 01        		.byte	0x1
 2445 0866 33        		.byte	0x33
 2446 0867 00        		.byte	0
 2447 0868 24        		.uleb128 0x24
 2448 0869 0000 0000 		.long	.LVL114
 2449 086d 3C0B 0000 		.long	0xb3c
 2450 0871 8008 0000 		.long	0x880
 2451 0875 15        		.uleb128 0x15
 2452 0876 06        		.byte	0x6
 2453 0877 68        		.byte	0x68
 2454 0878 93        		.byte	0x93
 2455 0879 01        		.uleb128 0x1
 2456 087a 69        		.byte	0x69
 2457 087b 93        		.byte	0x93
 2458 087c 01        		.uleb128 0x1
 2459 087d 01        		.byte	0x1
 2460 087e 35        		.byte	0x35
 2461 087f 00        		.byte	0
 2462 0880 24        		.uleb128 0x24
 2463 0881 0000 0000 		.long	.LVL115
 2464 0885 5704 0000 		.long	0x457
 2465 0889 9908 0000 		.long	0x899
 2466 088d 15        		.uleb128 0x15
 2467 088e 01        		.byte	0x1
 2468 088f 68        		.byte	0x68
 2469 0890 02        		.byte	0x2
 2470 0891 08        		.byte	0x8
 2471 0892 20        		.byte	0x20
 2472 0893 15        		.uleb128 0x15
 2473 0894 01        		.byte	0x1
 2474 0895 66        		.byte	0x66
 2475 0896 01        		.byte	0x1
 2476 0897 30        		.byte	0x30
 2477 0898 00        		.byte	0
 2478 0899 24        		.uleb128 0x24
 2479 089a 0000 0000 		.long	.LVL116
 2480 089e 1D03 0000 		.long	0x31d
 2481 08a2 BA08 0000 		.long	0x8ba
 2482 08a6 15        		.uleb128 0x15
 2483 08a7 06        		.byte	0x6
 2484 08a8 66        		.byte	0x66
 2485 08a9 93        		.byte	0x93
 2486 08aa 01        		.uleb128 0x1
 2487 08ab 67        		.byte	0x67
 2488 08ac 93        		.byte	0x93
GAS LISTING /tmp/ccFP0NC0.s 			page 53


 2489 08ad 01        		.uleb128 0x1
 2490 08ae 05        		.byte	0x5
 2491 08af 03        		.byte	0x3
 2492 08b0 0000 0000 		.long	lcdBuffer
 2493 08b4 15        		.uleb128 0x15
 2494 08b5 01        		.byte	0x1
 2495 08b6 64        		.byte	0x64
 2496 08b7 01        		.byte	0x1
 2497 08b8 33        		.byte	0x33
 2498 08b9 00        		.byte	0
 2499 08ba 24        		.uleb128 0x24
 2500 08bb 0000 0000 		.long	.LVL117
 2501 08bf 3C0B 0000 		.long	0xb3c
 2502 08c3 D208 0000 		.long	0x8d2
 2503 08c7 15        		.uleb128 0x15
 2504 08c8 06        		.byte	0x6
 2505 08c9 68        		.byte	0x68
 2506 08ca 93        		.byte	0x93
 2507 08cb 01        		.uleb128 0x1
 2508 08cc 69        		.byte	0x69
 2509 08cd 93        		.byte	0x93
 2510 08ce 01        		.uleb128 0x1
 2511 08cf 01        		.byte	0x1
 2512 08d0 35        		.byte	0x35
 2513 08d1 00        		.byte	0
 2514 08d2 1A        		.uleb128 0x1a
 2515 08d3 0000 0000 		.long	.LVL118
 2516 08d7 5505 0000 		.long	0x555
 2517 08db 1D        		.uleb128 0x1d
 2518 08dc 0000 0000 		.long	.LVL120
 2519 08e0 01        		.byte	0x1
 2520 08e1 3C0B 0000 		.long	0xb3c
 2521 08e5 15        		.uleb128 0x15
 2522 08e6 06        		.byte	0x6
 2523 08e7 68        		.byte	0x68
 2524 08e8 93        		.byte	0x93
 2525 08e9 01        		.uleb128 0x1
 2526 08ea 69        		.byte	0x69
 2527 08eb 93        		.byte	0x93
 2528 08ec 01        		.uleb128 0x1
 2529 08ed 03        		.byte	0x3
 2530 08ee 0A        		.byte	0xa
 2531 08ef F401      		.word	0x1f4
 2532 08f1 00        		.byte	0
 2533 08f2 00        		.byte	0
 2534 08f3 1B        		.uleb128 0x1b
 2535 08f4 01        		.byte	0x1
 2536 08f5 0000 0000 		.long	.LASF52
 2537 08f9 02        		.byte	0x2
 2538 08fa 4102      		.word	0x241
 2539 08fc 0000 0000 		.long	.LFB115
 2540 0900 0000 0000 		.long	.LFE115
 2541 0904 03        		.byte	0x3
 2542 0905 92        		.byte	0x92
 2543 0906 20        		.uleb128 0x20
 2544 0907 03        		.sleb128 3
 2545 0908 01        		.byte	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 54


 2546 0909 6509 0000 		.long	0x965
 2547 090d 10        		.uleb128 0x10
 2548 090e 0000 0000 		.long	.LBB10
 2549 0912 0000 0000 		.long	.LBE10
 2550 0916 25        		.uleb128 0x25
 2551 0917 0000 0000 		.long	.LASF82
 2552 091b 02        		.byte	0x2
 2553 091c 4202      		.word	0x242
 2554 091e 4900 0000 		.long	0x49
 2555 0922 24        		.uleb128 0x24
 2556 0923 0000 0000 		.long	.LVL121
 2557 0927 0B07 0000 		.long	0x70b
 2558 092b 4509 0000 		.long	0x945
 2559 092f 15        		.uleb128 0x15
 2560 0930 01        		.byte	0x1
 2561 0931 68        		.byte	0x68
 2562 0932 02        		.byte	0x2
 2563 0933 08        		.byte	0x8
 2564 0934 27        		.byte	0x27
 2565 0935 15        		.uleb128 0x15
 2566 0936 01        		.byte	0x1
 2567 0937 66        		.byte	0x66
 2568 0938 01        		.byte	0x1
 2569 0939 40        		.byte	0x40
 2570 093a 15        		.uleb128 0x15
 2571 093b 01        		.byte	0x1
 2572 093c 64        		.byte	0x64
 2573 093d 01        		.byte	0x1
 2574 093e 32        		.byte	0x32
 2575 093f 15        		.uleb128 0x15
 2576 0940 01        		.byte	0x1
 2577 0941 62        		.byte	0x62
 2578 0942 01        		.byte	0x1
 2579 0943 31        		.byte	0x31
 2580 0944 00        		.byte	0
 2581 0945 1D        		.uleb128 0x1d
 2582 0946 0000 0000 		.long	.LVL122
 2583 094a 01        		.byte	0x1
 2584 094b AA04 0000 		.long	0x4aa
 2585 094f 15        		.uleb128 0x15
 2586 0950 06        		.byte	0x6
 2587 0951 68        		.byte	0x68
 2588 0952 93        		.byte	0x93
 2589 0953 01        		.uleb128 0x1
 2590 0954 69        		.byte	0x69
 2591 0955 93        		.byte	0x93
 2592 0956 01        		.uleb128 0x1
 2593 0957 05        		.byte	0x5
 2594 0958 03        		.byte	0x3
 2595 0959 0000 0000 		.long	.LC0
 2596 095d 15        		.uleb128 0x15
 2597 095e 01        		.byte	0x1
 2598 095f 66        		.byte	0x66
 2599 0960 01        		.byte	0x1
 2600 0961 3D        		.byte	0x3d
 2601 0962 00        		.byte	0
 2602 0963 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 55


 2603 0964 00        		.byte	0
 2604 0965 26        		.uleb128 0x26
 2605 0966 01        		.byte	0x1
 2606 0967 0000 0000 		.long	.LASF83
 2607 096b 02        		.byte	0x2
 2608 096c 4C02      		.word	0x24c
 2609 096e 0000 0000 		.long	.LFB116
 2610 0972 0000 0000 		.long	.LFE116
 2611 0976 03        		.byte	0x3
 2612 0977 92        		.byte	0x92
 2613 0978 20        		.uleb128 0x20
 2614 0979 03        		.sleb128 3
 2615 097a 01        		.byte	0x1
 2616 097b 27        		.uleb128 0x27
 2617 097c 0000 0000 		.long	.LASF53
 2618 0980 01        		.byte	0x1
 2619 0981 92        		.byte	0x92
 2620 0982 8D09 0000 		.long	0x98d
 2621 0986 01        		.byte	0x1
 2622 0987 05        		.byte	0x5
 2623 0988 03        		.byte	0x3
 2624 0989 0000 0000 		.long	twiMode
 2625 098d 28        		.uleb128 0x28
 2626 098e 3000 0000 		.long	0x30
 2627 0992 27        		.uleb128 0x27
 2628 0993 0000 0000 		.long	.LASF54
 2629 0997 01        		.byte	0x1
 2630 0998 93        		.byte	0x93
 2631 0999 8D09 0000 		.long	0x98d
 2632 099d 01        		.byte	0x1
 2633 099e 05        		.byte	0x5
 2634 099f 03        		.byte	0x3
 2635 09a0 0000 0000 		.long	twiState
 2636 09a4 27        		.uleb128 0x27
 2637 09a5 0000 0000 		.long	.LASF55
 2638 09a9 01        		.byte	0x1
 2639 09aa 94        		.byte	0x94
 2640 09ab 8D09 0000 		.long	0x98d
 2641 09af 01        		.byte	0x1
 2642 09b0 05        		.byte	0x5
 2643 09b1 03        		.byte	0x3
 2644 09b2 0000 0000 		.long	twiSLARW
 2645 09b6 27        		.uleb128 0x27
 2646 09b7 0000 0000 		.long	.LASF56
 2647 09bb 01        		.byte	0x1
 2648 09bc 96        		.byte	0x96
 2649 09bd 8D09 0000 		.long	0x98d
 2650 09c1 01        		.byte	0x1
 2651 09c2 05        		.byte	0x5
 2652 09c3 03        		.byte	0x3
 2653 09c4 0000 0000 		.long	twiMT_Count
 2654 09c8 27        		.uleb128 0x27
 2655 09c9 0000 0000 		.long	.LASF57
 2656 09cd 01        		.byte	0x1
 2657 09ce 97        		.byte	0x97
 2658 09cf DA09 0000 		.long	0x9da
 2659 09d3 01        		.byte	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 56


 2660 09d4 05        		.byte	0x5
 2661 09d5 03        		.byte	0x3
 2662 09d6 0000 0000 		.long	twiMT_Ptr
 2663 09da 05        		.uleb128 0x5
 2664 09db 02        		.byte	0x2
 2665 09dc 8D09 0000 		.long	0x98d
 2666 09e0 27        		.uleb128 0x27
 2667 09e1 0000 0000 		.long	.LASF58
 2668 09e5 01        		.byte	0x1
 2669 09e6 99        		.byte	0x99
 2670 09e7 8D09 0000 		.long	0x98d
 2671 09eb 01        		.byte	0x1
 2672 09ec 05        		.byte	0x5
 2673 09ed 03        		.byte	0x3
 2674 09ee 0000 0000 		.long	twiRX_Count
 2675 09f2 27        		.uleb128 0x27
 2676 09f3 0000 0000 		.long	.LASF59
 2677 09f7 01        		.byte	0x1
 2678 09f8 9A        		.byte	0x9a
 2679 09f9 DA09 0000 		.long	0x9da
 2680 09fd 01        		.byte	0x1
 2681 09fe 05        		.byte	0x5
 2682 09ff 03        		.byte	0x3
 2683 0a00 0000 0000 		.long	twiRX_Ptr
 2684 0a04 27        		.uleb128 0x27
 2685 0a05 0000 0000 		.long	.LASF60
 2686 0a09 01        		.byte	0x1
 2687 0a0a 9C        		.byte	0x9c
 2688 0a0b 8D09 0000 		.long	0x98d
 2689 0a0f 01        		.byte	0x1
 2690 0a10 05        		.byte	0x5
 2691 0a11 03        		.byte	0x3
 2692 0a12 0000 0000 		.long	twiST_Count
 2693 0a16 27        		.uleb128 0x27
 2694 0a17 0000 0000 		.long	.LASF61
 2695 0a1b 01        		.byte	0x1
 2696 0a1c 9D        		.byte	0x9d
 2697 0a1d DA09 0000 		.long	0x9da
 2698 0a21 01        		.byte	0x1
 2699 0a22 05        		.byte	0x5
 2700 0a23 03        		.byte	0x3
 2701 0a24 0000 0000 		.long	twiST_Ptr
 2702 0a28 29        		.uleb128 0x29
 2703 0a29 27        		.uleb128 0x27
 2704 0a2a 0000 0000 		.long	.LASF62
 2705 0a2e 01        		.byte	0x1
 2706 0a2f 9F        		.byte	0x9f
 2707 0a30 3B0A 0000 		.long	0xa3b
 2708 0a34 01        		.byte	0x1
 2709 0a35 05        		.byte	0x5
 2710 0a36 03        		.byte	0x3
 2711 0a37 0000 0000 		.long	twiHookRestart
 2712 0a3b 05        		.uleb128 0x5
 2713 0a3c 02        		.byte	0x2
 2714 0a3d 280A 0000 		.long	0xa28
 2715 0a41 27        		.uleb128 0x27
 2716 0a42 0000 0000 		.long	.LASF63
GAS LISTING /tmp/ccFP0NC0.s 			page 57


 2717 0a46 01        		.byte	0x1
 2718 0a47 A0        		.byte	0xa0
 2719 0a48 3B0A 0000 		.long	0xa3b
 2720 0a4c 01        		.byte	0x1
 2721 0a4d 05        		.byte	0x5
 2722 0a4e 03        		.byte	0x3
 2723 0a4f 0000 0000 		.long	twiMasterReader
 2724 0a53 27        		.uleb128 0x27
 2725 0a54 0000 0000 		.long	.LASF64
 2726 0a58 01        		.byte	0x1
 2727 0a59 A1        		.byte	0xa1
 2728 0a5a 3B0A 0000 		.long	0xa3b
 2729 0a5e 01        		.byte	0x1
 2730 0a5f 05        		.byte	0x5
 2731 0a60 03        		.byte	0x3
 2732 0a61 0000 0000 		.long	twiSlaveReader
 2733 0a65 27        		.uleb128 0x27
 2734 0a66 0000 0000 		.long	.LASF65
 2735 0a6a 01        		.byte	0x1
 2736 0a6b A2        		.byte	0xa2
 2737 0a6c 3B0A 0000 		.long	0xa3b
 2738 0a70 01        		.byte	0x1
 2739 0a71 05        		.byte	0x5
 2740 0a72 03        		.byte	0x3
 2741 0a73 0000 0000 		.long	twiSlaveWriter
 2742 0a77 11        		.uleb128 0x11
 2743 0a78 0000 0000 		.long	.LASF66
 2744 0a7c 01        		.byte	0x1
 2745 0a7d AA        		.byte	0xaa
 2746 0a7e 880A 0000 		.long	0xa88
 2747 0a82 05        		.byte	0x5
 2748 0a83 03        		.byte	0x3
 2749 0a84 0000 0000 		.long	_ZL12twiStatistic
 2750 0a88 28        		.uleb128 0x28
 2751 0a89 6401 0000 		.long	0x164
 2752 0a8d 2A        		.uleb128 0x2a
 2753 0a8e 0000 0000 		.long	.LASF67
 2754 0a92 02        		.byte	0x2
 2755 0a93 DB01      		.word	0x1db
 2756 0a95 3000 0000 		.long	0x30
 2757 0a99 01        		.byte	0x1
 2758 0a9a 05        		.byte	0x5
 2759 0a9b 03        		.byte	0x3
 2760 0a9c 0000 0000 		.long	lcdModes
 2761 0aa0 2A        		.uleb128 0x2a
 2762 0aa1 0000 0000 		.long	.LASF68
 2763 0aa5 02        		.byte	0x2
 2764 0aa6 DC01      		.word	0x1dc
 2765 0aa8 3000 0000 		.long	0x30
 2766 0aac 01        		.byte	0x1
 2767 0aad 05        		.byte	0x5
 2768 0aae 03        		.byte	0x3
 2769 0aaf 0000 0000 		.long	lcdShifts
 2770 0ab3 2A        		.uleb128 0x2a
 2771 0ab4 0000 0000 		.long	.LASF69
 2772 0ab8 02        		.byte	0x2
 2773 0ab9 DD01      		.word	0x1dd
GAS LISTING /tmp/ccFP0NC0.s 			page 58


 2774 0abb 3000 0000 		.long	0x30
 2775 0abf 01        		.byte	0x1
 2776 0ac0 05        		.byte	0x5
 2777 0ac1 03        		.byte	0x3
 2778 0ac2 0000 0000 		.long	lcdShows
 2779 0ac6 2A        		.uleb128 0x2a
 2780 0ac7 0000 0000 		.long	.LASF70
 2781 0acb 02        		.byte	0x2
 2782 0acc DE01      		.word	0x1de
 2783 0ace 3000 0000 		.long	0x30
 2784 0ad2 01        		.byte	0x1
 2785 0ad3 05        		.byte	0x5
 2786 0ad4 03        		.byte	0x3
 2787 0ad5 0000 0000 		.long	lcdBackLight
 2788 0ad9 2A        		.uleb128 0x2a
 2789 0ada 0000 0000 		.long	.LASF71
 2790 0ade 02        		.byte	0x2
 2791 0adf E001      		.word	0x1e0
 2792 0ae1 3000 0000 		.long	0x30
 2793 0ae5 01        		.byte	0x1
 2794 0ae6 05        		.byte	0x5
 2795 0ae7 03        		.byte	0x3
 2796 0ae8 0000 0000 		.long	lcdAddress
 2797 0aec 2A        		.uleb128 0x2a
 2798 0aed 0000 0000 		.long	.LASF72
 2799 0af1 02        		.byte	0x2
 2800 0af2 E101      		.word	0x1e1
 2801 0af4 3000 0000 		.long	0x30
 2802 0af8 01        		.byte	0x1
 2803 0af9 05        		.byte	0x5
 2804 0afa 03        		.byte	0x3
 2805 0afb 0000 0000 		.long	lcdCols
 2806 0aff 2A        		.uleb128 0x2a
 2807 0b00 0000 0000 		.long	.LASF73
 2808 0b04 02        		.byte	0x2
 2809 0b05 E201      		.word	0x1e2
 2810 0b07 3000 0000 		.long	0x30
 2811 0b0b 01        		.byte	0x1
 2812 0b0c 05        		.byte	0x5
 2813 0b0d 03        		.byte	0x3
 2814 0b0e 0000 0000 		.long	lcdRows
 2815 0b12 2B        		.uleb128 0x2b
 2816 0b13 3B00 0000 		.long	0x3b
 2817 0b17 220B 0000 		.long	0xb22
 2818 0b1b 2C        		.uleb128 0x2c
 2819 0b1c 220B 0000 		.long	0xb22
 2820 0b20 05        		.byte	0x5
 2821 0b21 00        		.byte	0
 2822 0b22 02        		.uleb128 0x2
 2823 0b23 02        		.byte	0x2
 2824 0b24 07        		.byte	0x7
 2825 0b25 0000 0000 		.long	.LASF74
 2826 0b29 2A        		.uleb128 0x2a
 2827 0b2a 0000 0000 		.long	.LASF75
 2828 0b2e 02        		.byte	0x2
 2829 0b2f E301      		.word	0x1e3
 2830 0b31 120B 0000 		.long	0xb12
GAS LISTING /tmp/ccFP0NC0.s 			page 59


 2831 0b35 01        		.byte	0x1
 2832 0b36 05        		.byte	0x5
 2833 0b37 03        		.byte	0x3
 2834 0b38 0000 0000 		.long	lcdBuffer
 2835 0b3c 2D        		.uleb128 0x2d
 2836 0b3d 01        		.byte	0x1
 2837 0b3e 0000 0000 		.long	.LASF84
 2838 0b42 04        		.byte	0x4
 2839 0b43 E101      		.word	0x1e1
 2840 0b45 01        		.byte	0x1
 2841 0b46 2E        		.uleb128 0x2e
 2842 0b47 4900 0000 		.long	0x49
 2843 0b4b 00        		.byte	0
 2844 0b4c 00        		.byte	0
 2845               		.section	.debug_abbrev,"",@progbits
 2846               	.Ldebug_abbrev0:
 2847 0000 01        		.uleb128 0x1
 2848 0001 11        		.uleb128 0x11
 2849 0002 01        		.byte	0x1
 2850 0003 25        		.uleb128 0x25
 2851 0004 0E        		.uleb128 0xe
 2852 0005 13        		.uleb128 0x13
 2853 0006 0B        		.uleb128 0xb
 2854 0007 03        		.uleb128 0x3
 2855 0008 0E        		.uleb128 0xe
 2856 0009 1B        		.uleb128 0x1b
 2857 000a 0E        		.uleb128 0xe
 2858 000b 55        		.uleb128 0x55
 2859 000c 06        		.uleb128 0x6
 2860 000d 11        		.uleb128 0x11
 2861 000e 01        		.uleb128 0x1
 2862 000f 52        		.uleb128 0x52
 2863 0010 01        		.uleb128 0x1
 2864 0011 10        		.uleb128 0x10
 2865 0012 06        		.uleb128 0x6
 2866 0013 00        		.byte	0
 2867 0014 00        		.byte	0
 2868 0015 02        		.uleb128 0x2
 2869 0016 24        		.uleb128 0x24
 2870 0017 00        		.byte	0
 2871 0018 0B        		.uleb128 0xb
 2872 0019 0B        		.uleb128 0xb
 2873 001a 3E        		.uleb128 0x3e
 2874 001b 0B        		.uleb128 0xb
 2875 001c 03        		.uleb128 0x3
 2876 001d 0E        		.uleb128 0xe
 2877 001e 00        		.byte	0
 2878 001f 00        		.byte	0
 2879 0020 03        		.uleb128 0x3
 2880 0021 16        		.uleb128 0x16
 2881 0022 00        		.byte	0
 2882 0023 03        		.uleb128 0x3
 2883 0024 0E        		.uleb128 0xe
 2884 0025 3A        		.uleb128 0x3a
 2885 0026 0B        		.uleb128 0xb
 2886 0027 3B        		.uleb128 0x3b
 2887 0028 0B        		.uleb128 0xb
GAS LISTING /tmp/ccFP0NC0.s 			page 60


 2888 0029 49        		.uleb128 0x49
 2889 002a 13        		.uleb128 0x13
 2890 002b 00        		.byte	0
 2891 002c 00        		.byte	0
 2892 002d 04        		.uleb128 0x4
 2893 002e 24        		.uleb128 0x24
 2894 002f 00        		.byte	0
 2895 0030 0B        		.uleb128 0xb
 2896 0031 0B        		.uleb128 0xb
 2897 0032 3E        		.uleb128 0x3e
 2898 0033 0B        		.uleb128 0xb
 2899 0034 03        		.uleb128 0x3
 2900 0035 08        		.uleb128 0x8
 2901 0036 00        		.byte	0
 2902 0037 00        		.byte	0
 2903 0038 05        		.uleb128 0x5
 2904 0039 0F        		.uleb128 0xf
 2905 003a 00        		.byte	0
 2906 003b 0B        		.uleb128 0xb
 2907 003c 0B        		.uleb128 0xb
 2908 003d 49        		.uleb128 0x49
 2909 003e 13        		.uleb128 0x13
 2910 003f 00        		.byte	0
 2911 0040 00        		.byte	0
 2912 0041 06        		.uleb128 0x6
 2913 0042 26        		.uleb128 0x26
 2914 0043 00        		.byte	0
 2915 0044 00        		.byte	0
 2916 0045 00        		.byte	0
 2917 0046 07        		.uleb128 0x7
 2918 0047 04        		.uleb128 0x4
 2919 0048 01        		.byte	0x1
 2920 0049 03        		.uleb128 0x3
 2921 004a 0E        		.uleb128 0xe
 2922 004b 0B        		.uleb128 0xb
 2923 004c 0B        		.uleb128 0xb
 2924 004d 3A        		.uleb128 0x3a
 2925 004e 0B        		.uleb128 0xb
 2926 004f 3B        		.uleb128 0x3b
 2927 0050 0B        		.uleb128 0xb
 2928 0051 01        		.uleb128 0x1
 2929 0052 13        		.uleb128 0x13
 2930 0053 00        		.byte	0
 2931 0054 00        		.byte	0
 2932 0055 08        		.uleb128 0x8
 2933 0056 28        		.uleb128 0x28
 2934 0057 00        		.byte	0
 2935 0058 03        		.uleb128 0x3
 2936 0059 0E        		.uleb128 0xe
 2937 005a 1C        		.uleb128 0x1c
 2938 005b 0D        		.uleb128 0xd
 2939 005c 00        		.byte	0
 2940 005d 00        		.byte	0
 2941 005e 09        		.uleb128 0x9
 2942 005f 13        		.uleb128 0x13
 2943 0060 01        		.byte	0x1
 2944 0061 0B        		.uleb128 0xb
GAS LISTING /tmp/ccFP0NC0.s 			page 61


 2945 0062 0B        		.uleb128 0xb
 2946 0063 3A        		.uleb128 0x3a
 2947 0064 0B        		.uleb128 0xb
 2948 0065 3B        		.uleb128 0x3b
 2949 0066 0B        		.uleb128 0xb
 2950 0067 8740      		.uleb128 0x2007
 2951 0069 0E        		.uleb128 0xe
 2952 006a 01        		.uleb128 0x1
 2953 006b 13        		.uleb128 0x13
 2954 006c 00        		.byte	0
 2955 006d 00        		.byte	0
 2956 006e 0A        		.uleb128 0xa
 2957 006f 0D        		.uleb128 0xd
 2958 0070 00        		.byte	0
 2959 0071 03        		.uleb128 0x3
 2960 0072 0E        		.uleb128 0xe
 2961 0073 3A        		.uleb128 0x3a
 2962 0074 0B        		.uleb128 0xb
 2963 0075 3B        		.uleb128 0x3b
 2964 0076 0B        		.uleb128 0xb
 2965 0077 49        		.uleb128 0x49
 2966 0078 13        		.uleb128 0x13
 2967 0079 38        		.uleb128 0x38
 2968 007a 0A        		.uleb128 0xa
 2969 007b 00        		.byte	0
 2970 007c 00        		.byte	0
 2971 007d 0B        		.uleb128 0xb
 2972 007e 0D        		.uleb128 0xd
 2973 007f 00        		.byte	0
 2974 0080 03        		.uleb128 0x3
 2975 0081 08        		.uleb128 0x8
 2976 0082 3A        		.uleb128 0x3a
 2977 0083 0B        		.uleb128 0xb
 2978 0084 3B        		.uleb128 0x3b
 2979 0085 0B        		.uleb128 0xb
 2980 0086 49        		.uleb128 0x49
 2981 0087 13        		.uleb128 0x13
 2982 0088 38        		.uleb128 0x38
 2983 0089 0A        		.uleb128 0xa
 2984 008a 00        		.byte	0
 2985 008b 00        		.byte	0
 2986 008c 0C        		.uleb128 0xc
 2987 008d 2E        		.uleb128 0x2e
 2988 008e 01        		.byte	0x1
 2989 008f 3F        		.uleb128 0x3f
 2990 0090 0C        		.uleb128 0xc
 2991 0091 03        		.uleb128 0x3
 2992 0092 0E        		.uleb128 0xe
 2993 0093 3A        		.uleb128 0x3a
 2994 0094 0B        		.uleb128 0xb
 2995 0095 3B        		.uleb128 0x3b
 2996 0096 0B        		.uleb128 0xb
 2997 0097 20        		.uleb128 0x20
 2998 0098 0B        		.uleb128 0xb
 2999 0099 01        		.uleb128 0x1
 3000 009a 13        		.uleb128 0x13
 3001 009b 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 62


 3002 009c 00        		.byte	0
 3003 009d 0D        		.uleb128 0xd
 3004 009e 05        		.uleb128 0x5
 3005 009f 00        		.byte	0
 3006 00a0 03        		.uleb128 0x3
 3007 00a1 08        		.uleb128 0x8
 3008 00a2 3A        		.uleb128 0x3a
 3009 00a3 0B        		.uleb128 0xb
 3010 00a4 3B        		.uleb128 0x3b
 3011 00a5 0B        		.uleb128 0xb
 3012 00a6 49        		.uleb128 0x49
 3013 00a7 13        		.uleb128 0x13
 3014 00a8 00        		.byte	0
 3015 00a9 00        		.byte	0
 3016 00aa 0E        		.uleb128 0xe
 3017 00ab 2E        		.uleb128 0x2e
 3018 00ac 01        		.byte	0x1
 3019 00ad 3F        		.uleb128 0x3f
 3020 00ae 0C        		.uleb128 0xc
 3021 00af 03        		.uleb128 0x3
 3022 00b0 0E        		.uleb128 0xe
 3023 00b1 3A        		.uleb128 0x3a
 3024 00b2 0B        		.uleb128 0xb
 3025 00b3 3B        		.uleb128 0x3b
 3026 00b4 0B        		.uleb128 0xb
 3027 00b5 11        		.uleb128 0x11
 3028 00b6 01        		.uleb128 0x1
 3029 00b7 12        		.uleb128 0x12
 3030 00b8 01        		.uleb128 0x1
 3031 00b9 40        		.uleb128 0x40
 3032 00ba 0A        		.uleb128 0xa
 3033 00bb 9742      		.uleb128 0x2117
 3034 00bd 0C        		.uleb128 0xc
 3035 00be 01        		.uleb128 0x1
 3036 00bf 13        		.uleb128 0x13
 3037 00c0 00        		.byte	0
 3038 00c1 00        		.byte	0
 3039 00c2 0F        		.uleb128 0xf
 3040 00c3 05        		.uleb128 0x5
 3041 00c4 00        		.byte	0
 3042 00c5 03        		.uleb128 0x3
 3043 00c6 0E        		.uleb128 0xe
 3044 00c7 3A        		.uleb128 0x3a
 3045 00c8 0B        		.uleb128 0xb
 3046 00c9 3B        		.uleb128 0x3b
 3047 00ca 0B        		.uleb128 0xb
 3048 00cb 49        		.uleb128 0x49
 3049 00cc 13        		.uleb128 0x13
 3050 00cd 02        		.uleb128 0x2
 3051 00ce 06        		.uleb128 0x6
 3052 00cf 00        		.byte	0
 3053 00d0 00        		.byte	0
 3054 00d1 10        		.uleb128 0x10
 3055 00d2 0B        		.uleb128 0xb
 3056 00d3 01        		.byte	0x1
 3057 00d4 11        		.uleb128 0x11
 3058 00d5 01        		.uleb128 0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 63


 3059 00d6 12        		.uleb128 0x12
 3060 00d7 01        		.uleb128 0x1
 3061 00d8 00        		.byte	0
 3062 00d9 00        		.byte	0
 3063 00da 11        		.uleb128 0x11
 3064 00db 34        		.uleb128 0x34
 3065 00dc 00        		.byte	0
 3066 00dd 03        		.uleb128 0x3
 3067 00de 0E        		.uleb128 0xe
 3068 00df 3A        		.uleb128 0x3a
 3069 00e0 0B        		.uleb128 0xb
 3070 00e1 3B        		.uleb128 0x3b
 3071 00e2 0B        		.uleb128 0xb
 3072 00e3 49        		.uleb128 0x49
 3073 00e4 13        		.uleb128 0x13
 3074 00e5 02        		.uleb128 0x2
 3075 00e6 0A        		.uleb128 0xa
 3076 00e7 00        		.byte	0
 3077 00e8 00        		.byte	0
 3078 00e9 12        		.uleb128 0x12
 3079 00ea 34        		.uleb128 0x34
 3080 00eb 00        		.byte	0
 3081 00ec 03        		.uleb128 0x3
 3082 00ed 0E        		.uleb128 0xe
 3083 00ee 3A        		.uleb128 0x3a
 3084 00ef 0B        		.uleb128 0xb
 3085 00f0 3B        		.uleb128 0x3b
 3086 00f1 0B        		.uleb128 0xb
 3087 00f2 49        		.uleb128 0x49
 3088 00f3 13        		.uleb128 0x13
 3089 00f4 02        		.uleb128 0x2
 3090 00f5 06        		.uleb128 0x6
 3091 00f6 00        		.byte	0
 3092 00f7 00        		.byte	0
 3093 00f8 13        		.uleb128 0x13
 3094 00f9 2E        		.uleb128 0x2e
 3095 00fa 01        		.byte	0x1
 3096 00fb 3F        		.uleb128 0x3f
 3097 00fc 0C        		.uleb128 0xc
 3098 00fd 03        		.uleb128 0x3
 3099 00fe 0E        		.uleb128 0xe
 3100 00ff 3A        		.uleb128 0x3a
 3101 0100 0B        		.uleb128 0xb
 3102 0101 3B        		.uleb128 0x3b
 3103 0102 0B        		.uleb128 0xb
 3104 0103 11        		.uleb128 0x11
 3105 0104 01        		.uleb128 0x1
 3106 0105 12        		.uleb128 0x12
 3107 0106 01        		.uleb128 0x1
 3108 0107 40        		.uleb128 0x40
 3109 0108 06        		.uleb128 0x6
 3110 0109 9742      		.uleb128 0x2117
 3111 010b 0C        		.uleb128 0xc
 3112 010c 01        		.uleb128 0x1
 3113 010d 13        		.uleb128 0x13
 3114 010e 00        		.byte	0
 3115 010f 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 64


 3116 0110 14        		.uleb128 0x14
 3117 0111 8982 01   		.uleb128 0x4109
 3118 0114 01        		.byte	0x1
 3119 0115 11        		.uleb128 0x11
 3120 0116 01        		.uleb128 0x1
 3121 0117 31        		.uleb128 0x31
 3122 0118 13        		.uleb128 0x13
 3123 0119 00        		.byte	0
 3124 011a 00        		.byte	0
 3125 011b 15        		.uleb128 0x15
 3126 011c 8A82 01   		.uleb128 0x410a
 3127 011f 00        		.byte	0
 3128 0120 02        		.uleb128 0x2
 3129 0121 0A        		.uleb128 0xa
 3130 0122 9142      		.uleb128 0x2111
 3131 0124 0A        		.uleb128 0xa
 3132 0125 00        		.byte	0
 3133 0126 00        		.byte	0
 3134 0127 16        		.uleb128 0x16
 3135 0128 2E        		.uleb128 0x2e
 3136 0129 01        		.byte	0x1
 3137 012a 31        		.uleb128 0x31
 3138 012b 13        		.uleb128 0x13
 3139 012c 11        		.uleb128 0x11
 3140 012d 01        		.uleb128 0x1
 3141 012e 12        		.uleb128 0x12
 3142 012f 01        		.uleb128 0x1
 3143 0130 40        		.uleb128 0x40
 3144 0131 06        		.uleb128 0x6
 3145 0132 9642      		.uleb128 0x2116
 3146 0134 0C        		.uleb128 0xc
 3147 0135 01        		.uleb128 0x1
 3148 0136 13        		.uleb128 0x13
 3149 0137 00        		.byte	0
 3150 0138 00        		.byte	0
 3151 0139 17        		.uleb128 0x17
 3152 013a 05        		.uleb128 0x5
 3153 013b 00        		.byte	0
 3154 013c 31        		.uleb128 0x31
 3155 013d 13        		.uleb128 0x13
 3156 013e 02        		.uleb128 0x2
 3157 013f 06        		.uleb128 0x6
 3158 0140 00        		.byte	0
 3159 0141 00        		.byte	0
 3160 0142 18        		.uleb128 0x18
 3161 0143 2E        		.uleb128 0x2e
 3162 0144 01        		.byte	0x1
 3163 0145 3F        		.uleb128 0x3f
 3164 0146 0C        		.uleb128 0xc
 3165 0147 03        		.uleb128 0x3
 3166 0148 0E        		.uleb128 0xe
 3167 0149 3A        		.uleb128 0x3a
 3168 014a 0B        		.uleb128 0xb
 3169 014b 3B        		.uleb128 0x3b
 3170 014c 05        		.uleb128 0x5
 3171 014d 11        		.uleb128 0x11
 3172 014e 01        		.uleb128 0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 65


 3173 014f 12        		.uleb128 0x12
 3174 0150 01        		.uleb128 0x1
 3175 0151 40        		.uleb128 0x40
 3176 0152 06        		.uleb128 0x6
 3177 0153 9642      		.uleb128 0x2116
 3178 0155 0C        		.uleb128 0xc
 3179 0156 01        		.uleb128 0x1
 3180 0157 13        		.uleb128 0x13
 3181 0158 00        		.byte	0
 3182 0159 00        		.byte	0
 3183 015a 19        		.uleb128 0x19
 3184 015b 34        		.uleb128 0x34
 3185 015c 00        		.byte	0
 3186 015d 03        		.uleb128 0x3
 3187 015e 08        		.uleb128 0x8
 3188 015f 3A        		.uleb128 0x3a
 3189 0160 0B        		.uleb128 0xb
 3190 0161 3B        		.uleb128 0x3b
 3191 0162 05        		.uleb128 0x5
 3192 0163 49        		.uleb128 0x49
 3193 0164 13        		.uleb128 0x13
 3194 0165 02        		.uleb128 0x2
 3195 0166 06        		.uleb128 0x6
 3196 0167 00        		.byte	0
 3197 0168 00        		.byte	0
 3198 0169 1A        		.uleb128 0x1a
 3199 016a 8982 01   		.uleb128 0x4109
 3200 016d 00        		.byte	0
 3201 016e 11        		.uleb128 0x11
 3202 016f 01        		.uleb128 0x1
 3203 0170 31        		.uleb128 0x31
 3204 0171 13        		.uleb128 0x13
 3205 0172 00        		.byte	0
 3206 0173 00        		.byte	0
 3207 0174 1B        		.uleb128 0x1b
 3208 0175 2E        		.uleb128 0x2e
 3209 0176 01        		.byte	0x1
 3210 0177 3F        		.uleb128 0x3f
 3211 0178 0C        		.uleb128 0xc
 3212 0179 03        		.uleb128 0x3
 3213 017a 0E        		.uleb128 0xe
 3214 017b 3A        		.uleb128 0x3a
 3215 017c 0B        		.uleb128 0xb
 3216 017d 3B        		.uleb128 0x3b
 3217 017e 05        		.uleb128 0x5
 3218 017f 11        		.uleb128 0x11
 3219 0180 01        		.uleb128 0x1
 3220 0181 12        		.uleb128 0x12
 3221 0182 01        		.uleb128 0x1
 3222 0183 40        		.uleb128 0x40
 3223 0184 0A        		.uleb128 0xa
 3224 0185 9742      		.uleb128 0x2117
 3225 0187 0C        		.uleb128 0xc
 3226 0188 01        		.uleb128 0x1
 3227 0189 13        		.uleb128 0x13
 3228 018a 00        		.byte	0
 3229 018b 00        		.byte	0
GAS LISTING /tmp/ccFP0NC0.s 			page 66


 3230 018c 1C        		.uleb128 0x1c
 3231 018d 05        		.uleb128 0x5
 3232 018e 00        		.byte	0
 3233 018f 03        		.uleb128 0x3
 3234 0190 0E        		.uleb128 0xe
 3235 0191 3A        		.uleb128 0x3a
 3236 0192 0B        		.uleb128 0xb
 3237 0193 3B        		.uleb128 0x3b
 3238 0194 05        		.uleb128 0x5
 3239 0195 49        		.uleb128 0x49
 3240 0196 13        		.uleb128 0x13
 3241 0197 02        		.uleb128 0x2
 3242 0198 06        		.uleb128 0x6
 3243 0199 00        		.byte	0
 3244 019a 00        		.byte	0
 3245 019b 1D        		.uleb128 0x1d
 3246 019c 8982 01   		.uleb128 0x4109
 3247 019f 01        		.byte	0x1
 3248 01a0 11        		.uleb128 0x11
 3249 01a1 01        		.uleb128 0x1
 3250 01a2 9542      		.uleb128 0x2115
 3251 01a4 0C        		.uleb128 0xc
 3252 01a5 31        		.uleb128 0x31
 3253 01a6 13        		.uleb128 0x13
 3254 01a7 00        		.byte	0
 3255 01a8 00        		.byte	0
 3256 01a9 1E        		.uleb128 0x1e
 3257 01aa 26        		.uleb128 0x26
 3258 01ab 00        		.byte	0
 3259 01ac 49        		.uleb128 0x49
 3260 01ad 13        		.uleb128 0x13
 3261 01ae 00        		.byte	0
 3262 01af 00        		.byte	0
 3263 01b0 1F        		.uleb128 0x1f
 3264 01b1 2E        		.uleb128 0x2e
 3265 01b2 01        		.byte	0x1
 3266 01b3 3F        		.uleb128 0x3f
 3267 01b4 0C        		.uleb128 0xc
 3268 01b5 03        		.uleb128 0x3
 3269 01b6 0E        		.uleb128 0xe
 3270 01b7 3A        		.uleb128 0x3a
 3271 01b8 0B        		.uleb128 0xb
 3272 01b9 3B        		.uleb128 0x3b
 3273 01ba 05        		.uleb128 0x5
 3274 01bb 11        		.uleb128 0x11
 3275 01bc 01        		.uleb128 0x1
 3276 01bd 12        		.uleb128 0x12
 3277 01be 01        		.uleb128 0x1
 3278 01bf 40        		.uleb128 0x40
 3279 01c0 06        		.uleb128 0x6
 3280 01c1 9742      		.uleb128 0x2117
 3281 01c3 0C        		.uleb128 0xc
 3282 01c4 01        		.uleb128 0x1
 3283 01c5 13        		.uleb128 0x13
 3284 01c6 00        		.byte	0
 3285 01c7 00        		.byte	0
 3286 01c8 20        		.uleb128 0x20
GAS LISTING /tmp/ccFP0NC0.s 			page 67


 3287 01c9 05        		.uleb128 0x5
 3288 01ca 00        		.byte	0
 3289 01cb 03        		.uleb128 0x3
 3290 01cc 0E        		.uleb128 0xe
 3291 01cd 3A        		.uleb128 0x3a
 3292 01ce 0B        		.uleb128 0xb
 3293 01cf 3B        		.uleb128 0x3b
 3294 01d0 05        		.uleb128 0x5
 3295 01d1 49        		.uleb128 0x49
 3296 01d2 13        		.uleb128 0x13
 3297 01d3 02        		.uleb128 0x2
 3298 01d4 0A        		.uleb128 0xa
 3299 01d5 00        		.byte	0
 3300 01d6 00        		.byte	0
 3301 01d7 21        		.uleb128 0x21
 3302 01d8 05        		.uleb128 0x5
 3303 01d9 00        		.byte	0
 3304 01da 03        		.uleb128 0x3
 3305 01db 08        		.uleb128 0x8
 3306 01dc 3A        		.uleb128 0x3a
 3307 01dd 0B        		.uleb128 0xb
 3308 01de 3B        		.uleb128 0x3b
 3309 01df 05        		.uleb128 0x5
 3310 01e0 49        		.uleb128 0x49
 3311 01e1 13        		.uleb128 0x13
 3312 01e2 02        		.uleb128 0x2
 3313 01e3 0A        		.uleb128 0xa
 3314 01e4 00        		.byte	0
 3315 01e5 00        		.byte	0
 3316 01e6 22        		.uleb128 0x22
 3317 01e7 34        		.uleb128 0x34
 3318 01e8 00        		.byte	0
 3319 01e9 03        		.uleb128 0x3
 3320 01ea 0E        		.uleb128 0xe
 3321 01eb 3A        		.uleb128 0x3a
 3322 01ec 0B        		.uleb128 0xb
 3323 01ed 3B        		.uleb128 0x3b
 3324 01ee 05        		.uleb128 0x5
 3325 01ef 49        		.uleb128 0x49
 3326 01f0 13        		.uleb128 0x13
 3327 01f1 02        		.uleb128 0x2
 3328 01f2 06        		.uleb128 0x6
 3329 01f3 00        		.byte	0
 3330 01f4 00        		.byte	0
 3331 01f5 23        		.uleb128 0x23
 3332 01f6 05        		.uleb128 0x5
 3333 01f7 00        		.byte	0
 3334 01f8 03        		.uleb128 0x3
 3335 01f9 08        		.uleb128 0x8
 3336 01fa 3A        		.uleb128 0x3a
 3337 01fb 0B        		.uleb128 0xb
 3338 01fc 3B        		.uleb128 0x3b
 3339 01fd 05        		.uleb128 0x5
 3340 01fe 49        		.uleb128 0x49
 3341 01ff 13        		.uleb128 0x13
 3342 0200 02        		.uleb128 0x2
 3343 0201 06        		.uleb128 0x6
GAS LISTING /tmp/ccFP0NC0.s 			page 68


 3344 0202 00        		.byte	0
 3345 0203 00        		.byte	0
 3346 0204 24        		.uleb128 0x24
 3347 0205 8982 01   		.uleb128 0x4109
 3348 0208 01        		.byte	0x1
 3349 0209 11        		.uleb128 0x11
 3350 020a 01        		.uleb128 0x1
 3351 020b 31        		.uleb128 0x31
 3352 020c 13        		.uleb128 0x13
 3353 020d 01        		.uleb128 0x1
 3354 020e 13        		.uleb128 0x13
 3355 020f 00        		.byte	0
 3356 0210 00        		.byte	0
 3357 0211 25        		.uleb128 0x25
 3358 0212 34        		.uleb128 0x34
 3359 0213 00        		.byte	0
 3360 0214 03        		.uleb128 0x3
 3361 0215 0E        		.uleb128 0xe
 3362 0216 3A        		.uleb128 0x3a
 3363 0217 0B        		.uleb128 0xb
 3364 0218 3B        		.uleb128 0x3b
 3365 0219 05        		.uleb128 0x5
 3366 021a 49        		.uleb128 0x49
 3367 021b 13        		.uleb128 0x13
 3368 021c 00        		.byte	0
 3369 021d 00        		.byte	0
 3370 021e 26        		.uleb128 0x26
 3371 021f 2E        		.uleb128 0x2e
 3372 0220 00        		.byte	0
 3373 0221 3F        		.uleb128 0x3f
 3374 0222 0C        		.uleb128 0xc
 3375 0223 03        		.uleb128 0x3
 3376 0224 0E        		.uleb128 0xe
 3377 0225 3A        		.uleb128 0x3a
 3378 0226 0B        		.uleb128 0xb
 3379 0227 3B        		.uleb128 0x3b
 3380 0228 05        		.uleb128 0x5
 3381 0229 11        		.uleb128 0x11
 3382 022a 01        		.uleb128 0x1
 3383 022b 12        		.uleb128 0x12
 3384 022c 01        		.uleb128 0x1
 3385 022d 40        		.uleb128 0x40
 3386 022e 0A        		.uleb128 0xa
 3387 022f 9742      		.uleb128 0x2117
 3388 0231 0C        		.uleb128 0xc
 3389 0232 00        		.byte	0
 3390 0233 00        		.byte	0
 3391 0234 27        		.uleb128 0x27
 3392 0235 34        		.uleb128 0x34
 3393 0236 00        		.byte	0
 3394 0237 03        		.uleb128 0x3
 3395 0238 0E        		.uleb128 0xe
 3396 0239 3A        		.uleb128 0x3a
 3397 023a 0B        		.uleb128 0xb
 3398 023b 3B        		.uleb128 0x3b
 3399 023c 0B        		.uleb128 0xb
 3400 023d 49        		.uleb128 0x49
GAS LISTING /tmp/ccFP0NC0.s 			page 69


 3401 023e 13        		.uleb128 0x13
 3402 023f 3F        		.uleb128 0x3f
 3403 0240 0C        		.uleb128 0xc
 3404 0241 02        		.uleb128 0x2
 3405 0242 0A        		.uleb128 0xa
 3406 0243 00        		.byte	0
 3407 0244 00        		.byte	0
 3408 0245 28        		.uleb128 0x28
 3409 0246 35        		.uleb128 0x35
 3410 0247 00        		.byte	0
 3411 0248 49        		.uleb128 0x49
 3412 0249 13        		.uleb128 0x13
 3413 024a 00        		.byte	0
 3414 024b 00        		.byte	0
 3415 024c 29        		.uleb128 0x29
 3416 024d 15        		.uleb128 0x15
 3417 024e 00        		.byte	0
 3418 024f 00        		.byte	0
 3419 0250 00        		.byte	0
 3420 0251 2A        		.uleb128 0x2a
 3421 0252 34        		.uleb128 0x34
 3422 0253 00        		.byte	0
 3423 0254 03        		.uleb128 0x3
 3424 0255 0E        		.uleb128 0xe
 3425 0256 3A        		.uleb128 0x3a
 3426 0257 0B        		.uleb128 0xb
 3427 0258 3B        		.uleb128 0x3b
 3428 0259 05        		.uleb128 0x5
 3429 025a 49        		.uleb128 0x49
 3430 025b 13        		.uleb128 0x13
 3431 025c 3F        		.uleb128 0x3f
 3432 025d 0C        		.uleb128 0xc
 3433 025e 02        		.uleb128 0x2
 3434 025f 0A        		.uleb128 0xa
 3435 0260 00        		.byte	0
 3436 0261 00        		.byte	0
 3437 0262 2B        		.uleb128 0x2b
 3438 0263 01        		.uleb128 0x1
 3439 0264 01        		.byte	0x1
 3440 0265 49        		.uleb128 0x49
 3441 0266 13        		.uleb128 0x13
 3442 0267 01        		.uleb128 0x1
 3443 0268 13        		.uleb128 0x13
 3444 0269 00        		.byte	0
 3445 026a 00        		.byte	0
 3446 026b 2C        		.uleb128 0x2c
 3447 026c 21        		.uleb128 0x21
 3448 026d 00        		.byte	0
 3449 026e 49        		.uleb128 0x49
 3450 026f 13        		.uleb128 0x13
 3451 0270 2F        		.uleb128 0x2f
 3452 0271 0B        		.uleb128 0xb
 3453 0272 00        		.byte	0
 3454 0273 00        		.byte	0
 3455 0274 2D        		.uleb128 0x2d
 3456 0275 2E        		.uleb128 0x2e
 3457 0276 01        		.byte	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 70


 3458 0277 3F        		.uleb128 0x3f
 3459 0278 0C        		.uleb128 0xc
 3460 0279 03        		.uleb128 0x3
 3461 027a 0E        		.uleb128 0xe
 3462 027b 3A        		.uleb128 0x3a
 3463 027c 0B        		.uleb128 0xb
 3464 027d 3B        		.uleb128 0x3b
 3465 027e 05        		.uleb128 0x5
 3466 027f 3C        		.uleb128 0x3c
 3467 0280 0C        		.uleb128 0xc
 3468 0281 00        		.byte	0
 3469 0282 00        		.byte	0
 3470 0283 2E        		.uleb128 0x2e
 3471 0284 05        		.uleb128 0x5
 3472 0285 00        		.byte	0
 3473 0286 49        		.uleb128 0x49
 3474 0287 13        		.uleb128 0x13
 3475 0288 00        		.byte	0
 3476 0289 00        		.byte	0
 3477 028a 00        		.byte	0
 3478               		.section	.debug_loc,"",@progbits
 3479               	.Ldebug_loc0:
 3480               	.LLST0:
 3481 0000 0000 0000 		.long	.LVL0
 3482 0004 0000 0000 		.long	.LVL1
 3483 0008 0C00      		.word	0xc
 3484 000a 66        		.byte	0x66
 3485 000b 93        		.byte	0x93
 3486 000c 01        		.uleb128 0x1
 3487 000d 67        		.byte	0x67
 3488 000e 93        		.byte	0x93
 3489 000f 01        		.uleb128 0x1
 3490 0010 68        		.byte	0x68
 3491 0011 93        		.byte	0x93
 3492 0012 01        		.uleb128 0x1
 3493 0013 69        		.byte	0x69
 3494 0014 93        		.byte	0x93
 3495 0015 01        		.uleb128 0x1
 3496 0016 0000 0000 		.long	.LVL1
 3497 001a 0000 0000 		.long	.LVL2
 3498 001e 0C00      		.word	0xc
 3499 0020 62        		.byte	0x62
 3500 0021 93        		.byte	0x93
 3501 0022 01        		.uleb128 0x1
 3502 0023 63        		.byte	0x63
 3503 0024 93        		.byte	0x93
 3504 0025 01        		.uleb128 0x1
 3505 0026 64        		.byte	0x64
 3506 0027 93        		.byte	0x93
 3507 0028 01        		.uleb128 0x1
 3508 0029 65        		.byte	0x65
 3509 002a 93        		.byte	0x93
 3510 002b 01        		.uleb128 0x1
 3511 002c 0000 0000 		.long	.LVL2
 3512 0030 0000 0000 		.long	.LFE102
 3513 0034 0400      		.word	0x4
 3514 0036 F3        		.byte	0xf3
GAS LISTING /tmp/ccFP0NC0.s 			page 71


 3515 0037 01        		.uleb128 0x1
 3516 0038 66        		.byte	0x66
 3517 0039 9F        		.byte	0x9f
 3518 003a 0000 0000 		.long	0
 3519 003e 0000 0000 		.long	0
 3520               	.LLST1:
 3521 0042 0000 0000 		.long	.LVL3
 3522 0046 0000 0000 		.long	.LVL4
 3523 004a 0200      		.word	0x2
 3524 004c 30        		.byte	0x30
 3525 004d 9F        		.byte	0x9f
 3526 004e 0000 0000 		.long	.LVL4
 3527 0052 0000 0000 		.long	.LFE102
 3528 0056 0100      		.word	0x1
 3529 0058 68        		.byte	0x68
 3530 0059 0000 0000 		.long	0
 3531 005d 0000 0000 		.long	0
 3532               	.LLST2:
 3533 0061 0000 0000 		.long	.LFB103
 3534 0065 0000 0000 		.long	.LCFI0
 3535 0069 0300      		.word	0x3
 3536 006b 92        		.byte	0x92
 3537 006c 20        		.uleb128 0x20
 3538 006d 03        		.sleb128 3
 3539 006e 0000 0000 		.long	.LCFI0
 3540 0072 0000 0000 		.long	.LCFI1
 3541 0076 0300      		.word	0x3
 3542 0078 92        		.byte	0x92
 3543 0079 20        		.uleb128 0x20
 3544 007a 04        		.sleb128 4
 3545 007b 0000 0000 		.long	.LCFI1
 3546 007f 0000 0000 		.long	.LCFI2
 3547 0083 0300      		.word	0x3
 3548 0085 92        		.byte	0x92
 3549 0086 20        		.uleb128 0x20
 3550 0087 05        		.sleb128 5
 3551 0088 0000 0000 		.long	.LCFI2
 3552 008c 0000 0000 		.long	.LCFI3
 3553 0090 0300      		.word	0x3
 3554 0092 92        		.byte	0x92
 3555 0093 20        		.uleb128 0x20
 3556 0094 06        		.sleb128 6
 3557 0095 0000 0000 		.long	.LCFI3
 3558 0099 0000 0000 		.long	.LFE103
 3559 009d 0200      		.word	0x2
 3560 009f 8C        		.byte	0x8c
 3561 00a0 06        		.sleb128 6
 3562 00a1 0000 0000 		.long	0
 3563 00a5 0000 0000 		.long	0
 3564               	.LLST3:
 3565 00a9 0000 0000 		.long	.LVL9
 3566 00ad 0000 0000 		.long	.LVL10-1
 3567 00b1 0C00      		.word	0xc
 3568 00b3 66        		.byte	0x66
 3569 00b4 93        		.byte	0x93
 3570 00b5 01        		.uleb128 0x1
 3571 00b6 67        		.byte	0x67
GAS LISTING /tmp/ccFP0NC0.s 			page 72


 3572 00b7 93        		.byte	0x93
 3573 00b8 01        		.uleb128 0x1
 3574 00b9 68        		.byte	0x68
 3575 00ba 93        		.byte	0x93
 3576 00bb 01        		.uleb128 0x1
 3577 00bc 69        		.byte	0x69
 3578 00bd 93        		.byte	0x93
 3579 00be 01        		.uleb128 0x1
 3580 00bf 0000 0000 		.long	.LVL10-1
 3581 00c3 0000 0000 		.long	.LFE103
 3582 00c7 0400      		.word	0x4
 3583 00c9 F3        		.byte	0xf3
 3584 00ca 01        		.uleb128 0x1
 3585 00cb 66        		.byte	0x66
 3586 00cc 9F        		.byte	0x9f
 3587 00cd 0000 0000 		.long	0
 3588 00d1 0000 0000 		.long	0
 3589               	.LLST4:
 3590 00d5 0000 0000 		.long	.LVL9
 3591 00d9 0000 0000 		.long	.LVL10-1
 3592 00dd 0100      		.word	0x1
 3593 00df 64        		.byte	0x64
 3594 00e0 0000 0000 		.long	.LVL10-1
 3595 00e4 0000 0000 		.long	.LFE103
 3596 00e8 0400      		.word	0x4
 3597 00ea F3        		.byte	0xf3
 3598 00eb 01        		.uleb128 0x1
 3599 00ec 64        		.byte	0x64
 3600 00ed 9F        		.byte	0x9f
 3601 00ee 0000 0000 		.long	0
 3602 00f2 0000 0000 		.long	0
 3603               	.LLST5:
 3604 00f6 0000 0000 		.long	.LFB104
 3605 00fa 0000 0000 		.long	.LCFI4
 3606 00fe 0300      		.word	0x3
 3607 0100 92        		.byte	0x92
 3608 0101 20        		.uleb128 0x20
 3609 0102 03        		.sleb128 3
 3610 0103 0000 0000 		.long	.LCFI4
 3611 0107 0000 0000 		.long	.LFE104
 3612 010b 0300      		.word	0x3
 3613 010d 92        		.byte	0x92
 3614 010e 20        		.uleb128 0x20
 3615 010f 04        		.sleb128 4
 3616 0110 0000 0000 		.long	0
 3617 0114 0000 0000 		.long	0
 3618               	.LLST6:
 3619 0118 0000 0000 		.long	.LVL11
 3620 011c 0000 0000 		.long	.LVL12
 3621 0120 0100      		.word	0x1
 3622 0122 68        		.byte	0x68
 3623 0123 0000 0000 		.long	.LVL12
 3624 0127 0000 0000 		.long	.LVL13
 3625 012b 0400      		.word	0x4
 3626 012d F3        		.byte	0xf3
 3627 012e 01        		.uleb128 0x1
 3628 012f 68        		.byte	0x68
GAS LISTING /tmp/ccFP0NC0.s 			page 73


 3629 0130 9F        		.byte	0x9f
 3630 0131 0000 0000 		.long	.LVL13
 3631 0135 0000 0000 		.long	.LVL14
 3632 0139 0100      		.word	0x1
 3633 013b 68        		.byte	0x68
 3634 013c 0000 0000 		.long	.LVL14
 3635 0140 0000 0000 		.long	.LVL15
 3636 0144 0400      		.word	0x4
 3637 0146 F3        		.byte	0xf3
 3638 0147 01        		.uleb128 0x1
 3639 0148 68        		.byte	0x68
 3640 0149 9F        		.byte	0x9f
 3641 014a 0000 0000 		.long	.LVL15
 3642 014e 0000 0000 		.long	.LVL16-1
 3643 0152 0100      		.word	0x1
 3644 0154 68        		.byte	0x68
 3645 0155 0000 0000 		.long	.LVL16-1
 3646 0159 0000 0000 		.long	.LVL17
 3647 015d 0400      		.word	0x4
 3648 015f F3        		.byte	0xf3
 3649 0160 01        		.uleb128 0x1
 3650 0161 68        		.byte	0x68
 3651 0162 9F        		.byte	0x9f
 3652 0163 0000 0000 		.long	.LVL17
 3653 0167 0000 0000 		.long	.LVL18
 3654 016b 0100      		.word	0x1
 3655 016d 68        		.byte	0x68
 3656 016e 0000 0000 		.long	.LVL18
 3657 0172 0000 0000 		.long	.LFE104
 3658 0176 0400      		.word	0x4
 3659 0178 F3        		.byte	0xf3
 3660 0179 01        		.uleb128 0x1
 3661 017a 68        		.byte	0x68
 3662 017b 9F        		.byte	0x9f
 3663 017c 0000 0000 		.long	0
 3664 0180 0000 0000 		.long	0
 3665               	.LLST7:
 3666 0184 0000 0000 		.long	.LVL15
 3667 0188 0000 0000 		.long	.LVL16-1
 3668 018c 0100      		.word	0x1
 3669 018e 68        		.byte	0x68
 3670 018f 0000 0000 		.long	.LVL16-1
 3671 0193 0000 0000 		.long	.LVL17
 3672 0197 0400      		.word	0x4
 3673 0199 F3        		.byte	0xf3
 3674 019a 01        		.uleb128 0x1
 3675 019b 68        		.byte	0x68
 3676 019c 9F        		.byte	0x9f
 3677 019d 0000 0000 		.long	.LVL17
 3678 01a1 0000 0000 		.long	.LVL18
 3679 01a5 0100      		.word	0x1
 3680 01a7 68        		.byte	0x68
 3681 01a8 0000 0000 		.long	.LVL18
 3682 01ac 0000 0000 		.long	.LVL19
 3683 01b0 0400      		.word	0x4
 3684 01b2 F3        		.byte	0xf3
 3685 01b3 01        		.uleb128 0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 74


 3686 01b4 68        		.byte	0x68
 3687 01b5 9F        		.byte	0x9f
 3688 01b6 0000 0000 		.long	0
 3689 01ba 0000 0000 		.long	0
 3690               	.LLST8:
 3691 01be 0000 0000 		.long	.LFB105
 3692 01c2 0000 0000 		.long	.LCFI5
 3693 01c6 0300      		.word	0x3
 3694 01c8 92        		.byte	0x92
 3695 01c9 20        		.uleb128 0x20
 3696 01ca 03        		.sleb128 3
 3697 01cb 0000 0000 		.long	.LCFI5
 3698 01cf 0000 0000 		.long	.LCFI6
 3699 01d3 0300      		.word	0x3
 3700 01d5 92        		.byte	0x92
 3701 01d6 20        		.uleb128 0x20
 3702 01d7 04        		.sleb128 4
 3703 01d8 0000 0000 		.long	.LCFI6
 3704 01dc 0000 0000 		.long	.LCFI7
 3705 01e0 0300      		.word	0x3
 3706 01e2 92        		.byte	0x92
 3707 01e3 20        		.uleb128 0x20
 3708 01e4 05        		.sleb128 5
 3709 01e5 0000 0000 		.long	.LCFI7
 3710 01e9 0000 0000 		.long	.LCFI8
 3711 01ed 0300      		.word	0x3
 3712 01ef 92        		.byte	0x92
 3713 01f0 20        		.uleb128 0x20
 3714 01f1 06        		.sleb128 6
 3715 01f2 0000 0000 		.long	.LCFI8
 3716 01f6 0000 0000 		.long	.LCFI9
 3717 01fa 0300      		.word	0x3
 3718 01fc 92        		.byte	0x92
 3719 01fd 20        		.uleb128 0x20
 3720 01fe 07        		.sleb128 7
 3721 01ff 0000 0000 		.long	.LCFI9
 3722 0203 0000 0000 		.long	.LCFI10
 3723 0207 0300      		.word	0x3
 3724 0209 92        		.byte	0x92
 3725 020a 20        		.uleb128 0x20
 3726 020b 08        		.sleb128 8
 3727 020c 0000 0000 		.long	.LCFI10
 3728 0210 0000 0000 		.long	.LCFI11
 3729 0214 0300      		.word	0x3
 3730 0216 92        		.byte	0x92
 3731 0217 20        		.uleb128 0x20
 3732 0218 09        		.sleb128 9
 3733 0219 0000 0000 		.long	.LCFI11
 3734 021d 0000 0000 		.long	.LCFI12
 3735 0221 0300      		.word	0x3
 3736 0223 92        		.byte	0x92
 3737 0224 20        		.uleb128 0x20
 3738 0225 0A        		.sleb128 10
 3739 0226 0000 0000 		.long	.LCFI12
 3740 022a 0000 0000 		.long	.LCFI13
 3741 022e 0300      		.word	0x3
 3742 0230 92        		.byte	0x92
GAS LISTING /tmp/ccFP0NC0.s 			page 75


 3743 0231 20        		.uleb128 0x20
 3744 0232 0B        		.sleb128 11
 3745 0233 0000 0000 		.long	.LCFI13
 3746 0237 0000 0000 		.long	.LCFI14
 3747 023b 0300      		.word	0x3
 3748 023d 92        		.byte	0x92
 3749 023e 20        		.uleb128 0x20
 3750 023f 0C        		.sleb128 12
 3751 0240 0000 0000 		.long	.LCFI14
 3752 0244 0000 0000 		.long	.LCFI15
 3753 0248 0300      		.word	0x3
 3754 024a 92        		.byte	0x92
 3755 024b 20        		.uleb128 0x20
 3756 024c 0D        		.sleb128 13
 3757 024d 0000 0000 		.long	.LCFI15
 3758 0251 0000 0000 		.long	.LCFI16
 3759 0255 0300      		.word	0x3
 3760 0257 92        		.byte	0x92
 3761 0258 20        		.uleb128 0x20
 3762 0259 0E        		.sleb128 14
 3763 025a 0000 0000 		.long	.LCFI16
 3764 025e 0000 0000 		.long	.LCFI17
 3765 0262 0300      		.word	0x3
 3766 0264 92        		.byte	0x92
 3767 0265 20        		.uleb128 0x20
 3768 0266 0F        		.sleb128 15
 3769 0267 0000 0000 		.long	.LCFI17
 3770 026b 0000 0000 		.long	.LCFI18
 3771 026f 0300      		.word	0x3
 3772 0271 92        		.byte	0x92
 3773 0272 20        		.uleb128 0x20
 3774 0273 10        		.sleb128 16
 3775 0274 0000 0000 		.long	.LCFI18
 3776 0278 0000 0000 		.long	.LFE105
 3777 027c 0300      		.word	0x3
 3778 027e 92        		.byte	0x92
 3779 027f 20        		.uleb128 0x20
 3780 0280 11        		.sleb128 17
 3781 0281 0000 0000 		.long	0
 3782 0285 0000 0000 		.long	0
 3783               	.LLST9:
 3784 0289 0000 0000 		.long	.LVL46
 3785 028d 0000 0000 		.long	.LVL47
 3786 0291 0100      		.word	0x1
 3787 0293 69        		.byte	0x69
 3788 0294 0000 0000 		.long	0
 3789 0298 0000 0000 		.long	0
 3790               	.LLST10:
 3791 029c 0000 0000 		.long	.LVL20
 3792 02a0 0000 0000 		.long	.LVL25
 3793 02a4 0100      		.word	0x1
 3794 02a6 68        		.byte	0x68
 3795 02a7 0000 0000 		.long	.LVL26
 3796 02ab 0000 0000 		.long	.LVL33
 3797 02af 0100      		.word	0x1
 3798 02b1 68        		.byte	0x68
 3799 02b2 0000 0000 		.long	.LVL33
GAS LISTING /tmp/ccFP0NC0.s 			page 76


 3800 02b6 0000 0000 		.long	.LVL34
 3801 02ba 0100      		.word	0x1
 3802 02bc 69        		.byte	0x69
 3803 02bd 0000 0000 		.long	.LVL34
 3804 02c1 0000 0000 		.long	.LVL38
 3805 02c5 0100      		.word	0x1
 3806 02c7 68        		.byte	0x68
 3807 02c8 0000 0000 		.long	.LVL40
 3808 02cc 0000 0000 		.long	.LVL41-1
 3809 02d0 0100      		.word	0x1
 3810 02d2 68        		.byte	0x68
 3811 02d3 0000 0000 		.long	.LVL42
 3812 02d7 0000 0000 		.long	.LVL43
 3813 02db 0100      		.word	0x1
 3814 02dd 68        		.byte	0x68
 3815 02de 0000 0000 		.long	.LVL43
 3816 02e2 0000 0000 		.long	.LVL44
 3817 02e6 0100      		.word	0x1
 3818 02e8 69        		.byte	0x69
 3819 02e9 0000 0000 		.long	.LVL44
 3820 02ed 0000 0000 		.long	.LVL47
 3821 02f1 0100      		.word	0x1
 3822 02f3 68        		.byte	0x68
 3823 02f4 0000 0000 		.long	0
 3824 02f8 0000 0000 		.long	0
 3825               	.LLST11:
 3826 02fc 0000 0000 		.long	.LVL21
 3827 0300 0000 0000 		.long	.LVL22
 3828 0304 0100      		.word	0x1
 3829 0306 69        		.byte	0x69
 3830 0307 0000 0000 		.long	.LVL22
 3831 030b 0000 0000 		.long	.LVL23
 3832 030f 0500      		.word	0x5
 3833 0311 03        		.byte	0x3
 3834 0312 0000 0000 		.long	twiState
 3835 0316 0000 0000 		.long	.LVL24
 3836 031a 0000 0000 		.long	.LVL27
 3837 031e 0100      		.word	0x1
 3838 0320 69        		.byte	0x69
 3839 0321 0000 0000 		.long	.LVL27
 3840 0325 0000 0000 		.long	.LVL28
 3841 0329 0500      		.word	0x5
 3842 032b 03        		.byte	0x3
 3843 032c 0000 0000 		.long	twiState
 3844 0330 0000 0000 		.long	.LVL28
 3845 0334 0000 0000 		.long	.LVL29
 3846 0338 0100      		.word	0x1
 3847 033a 69        		.byte	0x69
 3848 033b 0000 0000 		.long	.LVL29
 3849 033f 0000 0000 		.long	.LVL30
 3850 0343 0500      		.word	0x5
 3851 0345 03        		.byte	0x3
 3852 0346 0000 0000 		.long	twiState
 3853 034a 0000 0000 		.long	.LVL31
 3854 034e 0000 0000 		.long	.LVL32
 3855 0352 0100      		.word	0x1
 3856 0354 69        		.byte	0x69
GAS LISTING /tmp/ccFP0NC0.s 			page 77


 3857 0355 0000 0000 		.long	.LVL32
 3858 0359 0000 0000 		.long	.LVL34
 3859 035d 0500      		.word	0x5
 3860 035f 03        		.byte	0x3
 3861 0360 0000 0000 		.long	twiState
 3862 0364 0000 0000 		.long	.LVL34
 3863 0368 0000 0000 		.long	.LVL35
 3864 036c 0100      		.word	0x1
 3865 036e 69        		.byte	0x69
 3866 036f 0000 0000 		.long	.LVL35
 3867 0373 0000 0000 		.long	.LVL36
 3868 0377 0500      		.word	0x5
 3869 0379 03        		.byte	0x3
 3870 037a 0000 0000 		.long	twiState
 3871 037e 0000 0000 		.long	.LVL37
 3872 0382 0000 0000 		.long	.LVL39-1
 3873 0386 0100      		.word	0x1
 3874 0388 69        		.byte	0x69
 3875 0389 0000 0000 		.long	.LVL43
 3876 038d 0000 0000 		.long	.LVL45
 3877 0391 0500      		.word	0x5
 3878 0393 03        		.byte	0x3
 3879 0394 0000 0000 		.long	twiState
 3880 0398 0000 0000 		.long	0
 3881 039c 0000 0000 		.long	0
 3882               	.LLST12:
 3883 03a0 0000 0000 		.long	.LVL48
 3884 03a4 0000 0000 		.long	.LVL49
 3885 03a8 0100      		.word	0x1
 3886 03aa 68        		.byte	0x68
 3887 03ab 0000 0000 		.long	.LVL49
 3888 03af 0000 0000 		.long	.LVL50
 3889 03b3 0500      		.word	0x5
 3890 03b5 03        		.byte	0x3
 3891 03b6 0000 0000 		.long	twiSLARW
 3892 03ba 0000 0000 		.long	.LVL50
 3893 03be 0000 0000 		.long	.LFE106
 3894 03c2 0400      		.word	0x4
 3895 03c4 F3        		.byte	0xf3
 3896 03c5 01        		.uleb128 0x1
 3897 03c6 68        		.byte	0x68
 3898 03c7 9F        		.byte	0x9f
 3899 03c8 0000 0000 		.long	0
 3900 03cc 0000 0000 		.long	0
 3901               	.LLST13:
 3902 03d0 0000 0000 		.long	.LVL51
 3903 03d4 0000 0000 		.long	.LVL52
 3904 03d8 0100      		.word	0x1
 3905 03da 68        		.byte	0x68
 3906 03db 0000 0000 		.long	.LVL52
 3907 03df 0000 0000 		.long	.LVL53
 3908 03e3 0500      		.word	0x5
 3909 03e5 03        		.byte	0x3
 3910 03e6 0000 0000 		.long	twiSLARW
 3911 03ea 0000 0000 		.long	.LVL53
 3912 03ee 0000 0000 		.long	.LFE107
 3913 03f2 0400      		.word	0x4
GAS LISTING /tmp/ccFP0NC0.s 			page 78


 3914 03f4 F3        		.byte	0xf3
 3915 03f5 01        		.uleb128 0x1
 3916 03f6 68        		.byte	0x68
 3917 03f7 9F        		.byte	0x9f
 3918 03f8 0000 0000 		.long	0
 3919 03fc 0000 0000 		.long	0
 3920               	.LLST14:
 3921 0400 0000 0000 		.long	.LVL54
 3922 0404 0000 0000 		.long	.LVL55
 3923 0408 0100      		.word	0x1
 3924 040a 68        		.byte	0x68
 3925 040b 0000 0000 		.long	.LVL55
 3926 040f 0000 0000 		.long	.LFE108
 3927 0413 0400      		.word	0x4
 3928 0415 F3        		.byte	0xf3
 3929 0416 01        		.uleb128 0x1
 3930 0417 68        		.byte	0x68
 3931 0418 9F        		.byte	0x9f
 3932 0419 0000 0000 		.long	0
 3933 041d 0000 0000 		.long	0
 3934               	.LLST15:
 3935 0421 0000 0000 		.long	.LVL54
 3936 0425 0000 0000 		.long	.LVL56-1
 3937 0429 0600      		.word	0x6
 3938 042b 66        		.byte	0x66
 3939 042c 93        		.byte	0x93
 3940 042d 01        		.uleb128 0x1
 3941 042e 67        		.byte	0x67
 3942 042f 93        		.byte	0x93
 3943 0430 01        		.uleb128 0x1
 3944 0431 0000 0000 		.long	.LVL56-1
 3945 0435 0000 0000 		.long	.LFE108
 3946 0439 0400      		.word	0x4
 3947 043b F3        		.byte	0xf3
 3948 043c 01        		.uleb128 0x1
 3949 043d 66        		.byte	0x66
 3950 043e 9F        		.byte	0x9f
 3951 043f 0000 0000 		.long	0
 3952 0443 0000 0000 		.long	0
 3953               	.LLST16:
 3954 0447 0000 0000 		.long	.LVL54
 3955 044b 0000 0000 		.long	.LVL56-1
 3956 044f 0100      		.word	0x1
 3957 0451 64        		.byte	0x64
 3958 0452 0000 0000 		.long	.LVL56-1
 3959 0456 0000 0000 		.long	.LFE108
 3960 045a 0400      		.word	0x4
 3961 045c F3        		.byte	0xf3
 3962 045d 01        		.uleb128 0x1
 3963 045e 64        		.byte	0x64
 3964 045f 9F        		.byte	0x9f
 3965 0460 0000 0000 		.long	0
 3966 0464 0000 0000 		.long	0
 3967               	.LLST17:
 3968 0468 0000 0000 		.long	.LVL57
 3969 046c 0000 0000 		.long	.LVL58
 3970 0470 0100      		.word	0x1
GAS LISTING /tmp/ccFP0NC0.s 			page 79


 3971 0472 68        		.byte	0x68
 3972 0473 0000 0000 		.long	.LVL58
 3973 0477 0000 0000 		.long	.LFE109
 3974 047b 0400      		.word	0x4
 3975 047d F3        		.byte	0xf3
 3976 047e 01        		.uleb128 0x1
 3977 047f 68        		.byte	0x68
 3978 0480 9F        		.byte	0x9f
 3979 0481 0000 0000 		.long	0
 3980 0485 0000 0000 		.long	0
 3981               	.LLST18:
 3982 0489 0000 0000 		.long	.LVL57
 3983 048d 0000 0000 		.long	.LVL59-1
 3984 0491 0600      		.word	0x6
 3985 0493 66        		.byte	0x66
 3986 0494 93        		.byte	0x93
 3987 0495 01        		.uleb128 0x1
 3988 0496 67        		.byte	0x67
 3989 0497 93        		.byte	0x93
 3990 0498 01        		.uleb128 0x1
 3991 0499 0000 0000 		.long	.LVL59-1
 3992 049d 0000 0000 		.long	.LFE109
 3993 04a1 0400      		.word	0x4
 3994 04a3 F3        		.byte	0xf3
 3995 04a4 01        		.uleb128 0x1
 3996 04a5 66        		.byte	0x66
 3997 04a6 9F        		.byte	0x9f
 3998 04a7 0000 0000 		.long	0
 3999 04ab 0000 0000 		.long	0
 4000               	.LLST19:
 4001 04af 0000 0000 		.long	.LVL57
 4002 04b3 0000 0000 		.long	.LVL59-1
 4003 04b7 0100      		.word	0x1
 4004 04b9 64        		.byte	0x64
 4005 04ba 0000 0000 		.long	.LVL59-1
 4006 04be 0000 0000 		.long	.LFE109
 4007 04c2 0400      		.word	0x4
 4008 04c4 F3        		.byte	0xf3
 4009 04c5 01        		.uleb128 0x1
 4010 04c6 64        		.byte	0x64
 4011 04c7 9F        		.byte	0x9f
 4012 04c8 0000 0000 		.long	0
 4013 04cc 0000 0000 		.long	0
 4014               	.LLST20:
 4015 04d0 0000 0000 		.long	.LFB110
 4016 04d4 0000 0000 		.long	.LCFI19
 4017 04d8 0300      		.word	0x3
 4018 04da 92        		.byte	0x92
 4019 04db 20        		.uleb128 0x20
 4020 04dc 03        		.sleb128 3
 4021 04dd 0000 0000 		.long	.LCFI19
 4022 04e1 0000 0000 		.long	.LFE110
 4023 04e5 0300      		.word	0x3
 4024 04e7 92        		.byte	0x92
 4025 04e8 20        		.uleb128 0x20
 4026 04e9 04        		.sleb128 4
 4027 04ea 0000 0000 		.long	0
GAS LISTING /tmp/ccFP0NC0.s 			page 80


 4028 04ee 0000 0000 		.long	0
 4029               	.LLST21:
 4030 04f2 0000 0000 		.long	.LVL60
 4031 04f6 0000 0000 		.long	.LVL61
 4032 04fa 0100      		.word	0x1
 4033 04fc 68        		.byte	0x68
 4034 04fd 0000 0000 		.long	.LVL61
 4035 0501 0000 0000 		.long	.LFE110
 4036 0505 0400      		.word	0x4
 4037 0507 F3        		.byte	0xf3
 4038 0508 01        		.uleb128 0x1
 4039 0509 68        		.byte	0x68
 4040 050a 9F        		.byte	0x9f
 4041 050b 0000 0000 		.long	0
 4042 050f 0000 0000 		.long	0
 4043               	.LLST22:
 4044 0513 0000 0000 		.long	.LVL60
 4045 0517 0000 0000 		.long	.LVL62
 4046 051b 0100      		.word	0x1
 4047 051d 60        		.byte	0x60
 4048 051e 0000 0000 		.long	.LVL62
 4049 0522 0000 0000 		.long	.LFE110
 4050 0526 0400      		.word	0x4
 4051 0528 F3        		.byte	0xf3
 4052 0529 01        		.uleb128 0x1
 4053 052a 60        		.byte	0x60
 4054 052b 9F        		.byte	0x9f
 4055 052c 0000 0000 		.long	0
 4056 0530 0000 0000 		.long	0
 4057               	.LLST23:
 4058 0534 0000 0000 		.long	.LVL63
 4059 0538 0000 0000 		.long	.LVL68
 4060 053c 0100      		.word	0x1
 4061 053e 68        		.byte	0x68
 4062 053f 0000 0000 		.long	.LVL68
 4063 0543 0000 0000 		.long	.LFE111
 4064 0547 0400      		.word	0x4
 4065 0549 F3        		.byte	0xf3
 4066 054a 01        		.uleb128 0x1
 4067 054b 68        		.byte	0x68
 4068 054c 9F        		.byte	0x9f
 4069 054d 0000 0000 		.long	0
 4070 0551 0000 0000 		.long	0
 4071               	.LLST24:
 4072 0555 0000 0000 		.long	.LVL64
 4073 0559 0000 0000 		.long	.LVL66
 4074 055d 0100      		.word	0x1
 4075 055f 69        		.byte	0x69
 4076 0560 0000 0000 		.long	.LVL66
 4077 0564 0000 0000 		.long	.LVL67
 4078 0568 0500      		.word	0x5
 4079 056a 89        		.byte	0x89
 4080 056b 00        		.sleb128 0
 4081 056c 34        		.byte	0x34
 4082 056d 21        		.byte	0x21
 4083 056e 9F        		.byte	0x9f
 4084 056f 0000 0000 		.long	.LVL67
GAS LISTING /tmp/ccFP0NC0.s 			page 81


 4085 0573 0000 0000 		.long	.LVL69
 4086 0577 0100      		.word	0x1
 4087 0579 69        		.byte	0x69
 4088 057a 0000 0000 		.long	.LVL69
 4089 057e 0000 0000 		.long	.LVL71
 4090 0582 0100      		.word	0x1
 4091 0584 68        		.byte	0x68
 4092 0585 0000 0000 		.long	.LVL71
 4093 0589 0000 0000 		.long	.LVL72
 4094 058d 0500      		.word	0x5
 4095 058f 88        		.byte	0x88
 4096 0590 00        		.sleb128 0
 4097 0591 34        		.byte	0x34
 4098 0592 21        		.byte	0x21
 4099 0593 9F        		.byte	0x9f
 4100 0594 0000 0000 		.long	.LVL72
 4101 0598 0000 0000 		.long	.LFE111
 4102 059c 0100      		.word	0x1
 4103 059e 68        		.byte	0x68
 4104 059f 0000 0000 		.long	0
 4105 05a3 0000 0000 		.long	0
 4106               	.LLST25:
 4107 05a7 0000 0000 		.long	.LFB112
 4108 05ab 0000 0000 		.long	.LCFI20
 4109 05af 0300      		.word	0x3
 4110 05b1 92        		.byte	0x92
 4111 05b2 20        		.uleb128 0x20
 4112 05b3 03        		.sleb128 3
 4113 05b4 0000 0000 		.long	.LCFI20
 4114 05b8 0000 0000 		.long	.LCFI21
 4115 05bc 0300      		.word	0x3
 4116 05be 92        		.byte	0x92
 4117 05bf 20        		.uleb128 0x20
 4118 05c0 04        		.sleb128 4
 4119 05c1 0000 0000 		.long	.LCFI21
 4120 05c5 0000 0000 		.long	.LCFI22
 4121 05c9 0300      		.word	0x3
 4122 05cb 92        		.byte	0x92
 4123 05cc 20        		.uleb128 0x20
 4124 05cd 05        		.sleb128 5
 4125 05ce 0000 0000 		.long	.LCFI22
 4126 05d2 0000 0000 		.long	.LFE112
 4127 05d6 0300      		.word	0x3
 4128 05d8 92        		.byte	0x92
 4129 05d9 20        		.uleb128 0x20
 4130 05da 06        		.sleb128 6
 4131 05db 0000 0000 		.long	0
 4132 05df 0000 0000 		.long	0
 4133               	.LLST26:
 4134 05e3 0000 0000 		.long	.LVL73
 4135 05e7 0000 0000 		.long	.LVL75
 4136 05eb 0600      		.word	0x6
 4137 05ed 68        		.byte	0x68
 4138 05ee 93        		.byte	0x93
 4139 05ef 01        		.uleb128 0x1
 4140 05f0 69        		.byte	0x69
 4141 05f1 93        		.byte	0x93
GAS LISTING /tmp/ccFP0NC0.s 			page 82


 4142 05f2 01        		.uleb128 0x1
 4143 05f3 0000 0000 		.long	.LVL75
 4144 05f7 0000 0000 		.long	.LFE112
 4145 05fb 0400      		.word	0x4
 4146 05fd F3        		.byte	0xf3
 4147 05fe 01        		.uleb128 0x1
 4148 05ff 68        		.byte	0x68
 4149 0600 9F        		.byte	0x9f
 4150 0601 0000 0000 		.long	0
 4151 0605 0000 0000 		.long	0
 4152               	.LLST27:
 4153 0609 0000 0000 		.long	.LVL73
 4154 060d 0000 0000 		.long	.LVL75
 4155 0611 0100      		.word	0x1
 4156 0613 66        		.byte	0x66
 4157 0614 0000 0000 		.long	.LVL75
 4158 0618 0000 0000 		.long	.LFE112
 4159 061c 0400      		.word	0x4
 4160 061e F3        		.byte	0xf3
 4161 061f 01        		.uleb128 0x1
 4162 0620 66        		.byte	0x66
 4163 0621 9F        		.byte	0x9f
 4164 0622 0000 0000 		.long	0
 4165 0626 0000 0000 		.long	0
 4166               	.LLST28:
 4167 062a 0000 0000 		.long	.LVL74
 4168 062e 0000 0000 		.long	.LVL75
 4169 0632 0600      		.word	0x6
 4170 0634 68        		.byte	0x68
 4171 0635 93        		.byte	0x93
 4172 0636 01        		.uleb128 0x1
 4173 0637 69        		.byte	0x69
 4174 0638 93        		.byte	0x93
 4175 0639 01        		.uleb128 0x1
 4176 063a 0000 0000 		.long	.LVL75
 4177 063e 0000 0000 		.long	.LVL76
 4178 0642 0600      		.word	0x6
 4179 0644 6C        		.byte	0x6c
 4180 0645 93        		.byte	0x93
 4181 0646 01        		.uleb128 0x1
 4182 0647 6D        		.byte	0x6d
 4183 0648 93        		.byte	0x93
 4184 0649 01        		.uleb128 0x1
 4185 064a 0000 0000 		.long	.LVL76
 4186 064e 0000 0000 		.long	.LVL77
 4187 0652 0300      		.word	0x3
 4188 0654 8C        		.byte	0x8c
 4189 0655 01        		.sleb128 1
 4190 0656 9F        		.byte	0x9f
 4191 0657 0000 0000 		.long	.LVL77
 4192 065b 0000 0000 		.long	.LVL82
 4193 065f 0600      		.word	0x6
 4194 0661 6C        		.byte	0x6c
 4195 0662 93        		.byte	0x93
 4196 0663 01        		.uleb128 0x1
 4197 0664 6D        		.byte	0x6d
 4198 0665 93        		.byte	0x93
GAS LISTING /tmp/ccFP0NC0.s 			page 83


 4199 0666 01        		.uleb128 0x1
 4200 0667 0000 0000 		.long	0
 4201 066b 0000 0000 		.long	0
 4202               	.LLST29:
 4203 066f 0000 0000 		.long	.LVL74
 4204 0673 0000 0000 		.long	.LVL75
 4205 0677 0100      		.word	0x1
 4206 0679 66        		.byte	0x66
 4207 067a 0000 0000 		.long	.LVL75
 4208 067e 0000 0000 		.long	.LVL77
 4209 0682 0C00      		.word	0xc
 4210 0684 8C        		.byte	0x8c
 4211 0685 00        		.sleb128 0
 4212 0686 20        		.byte	0x20
 4213 0687 F3        		.byte	0xf3
 4214 0688 01        		.uleb128 0x1
 4215 0689 66        		.byte	0x66
 4216 068a 22        		.byte	0x22
 4217 068b F3        		.byte	0xf3
 4218 068c 01        		.uleb128 0x1
 4219 068d 68        		.byte	0x68
 4220 068e 22        		.byte	0x22
 4221 068f 9F        		.byte	0x9f
 4222 0690 0000 0000 		.long	.LVL77
 4223 0694 0000 0000 		.long	.LVL81
 4224 0698 0B00      		.word	0xb
 4225 069a F3        		.byte	0xf3
 4226 069b 01        		.uleb128 0x1
 4227 069c 66        		.byte	0x66
 4228 069d 8C        		.byte	0x8c
 4229 069e 00        		.sleb128 0
 4230 069f 1C        		.byte	0x1c
 4231 06a0 F3        		.byte	0xf3
 4232 06a1 01        		.uleb128 0x1
 4233 06a2 68        		.byte	0x68
 4234 06a3 22        		.byte	0x22
 4235 06a4 9F        		.byte	0x9f
 4236 06a5 0000 0000 		.long	.LVL81
 4237 06a9 0000 0000 		.long	.LVL82
 4238 06ad 0C00      		.word	0xc
 4239 06af 8C        		.byte	0x8c
 4240 06b0 00        		.sleb128 0
 4241 06b1 20        		.byte	0x20
 4242 06b2 F3        		.byte	0xf3
 4243 06b3 01        		.uleb128 0x1
 4244 06b4 66        		.byte	0x66
 4245 06b5 22        		.byte	0x22
 4246 06b6 F3        		.byte	0xf3
 4247 06b7 01        		.uleb128 0x1
 4248 06b8 68        		.byte	0x68
 4249 06b9 22        		.byte	0x22
 4250 06ba 9F        		.byte	0x9f
 4251 06bb 0000 0000 		.long	0
 4252 06bf 0000 0000 		.long	0
 4253               	.LLST30:
 4254 06c3 0000 0000 		.long	.LFB114
 4255 06c7 0000 0000 		.long	.LCFI23
GAS LISTING /tmp/ccFP0NC0.s 			page 84


 4256 06cb 0300      		.word	0x3
 4257 06cd 92        		.byte	0x92
 4258 06ce 20        		.uleb128 0x20
 4259 06cf 03        		.sleb128 3
 4260 06d0 0000 0000 		.long	.LCFI23
 4261 06d4 0000 0000 		.long	.LFE114
 4262 06d8 0300      		.word	0x3
 4263 06da 92        		.byte	0x92
 4264 06db 20        		.uleb128 0x20
 4265 06dc 04        		.sleb128 4
 4266 06dd 0000 0000 		.long	0
 4267 06e1 0000 0000 		.long	0
 4268               	.LLST31:
 4269 06e5 0000 0000 		.long	.LVL99
 4270 06e9 0000 0000 		.long	.LVL100
 4271 06ed 0100      		.word	0x1
 4272 06ef 68        		.byte	0x68
 4273 06f0 0000 0000 		.long	.LVL100
 4274 06f4 0000 0000 		.long	.LVL101
 4275 06f8 0500      		.word	0x5
 4276 06fa 03        		.byte	0x3
 4277 06fb 0000 0000 		.long	lcdAddress
 4278 06ff 0000 0000 		.long	.LVL101
 4279 0703 0000 0000 		.long	.LVL102
 4280 0707 0100      		.word	0x1
 4281 0709 68        		.byte	0x68
 4282 070a 0000 0000 		.long	.LVL102
 4283 070e 0000 0000 		.long	.LVL105-1
 4284 0712 0500      		.word	0x5
 4285 0714 03        		.byte	0x3
 4286 0715 0000 0000 		.long	lcdAddress
 4287 0719 0000 0000 		.long	.LVL105-1
 4288 071d 0000 0000 		.long	.LFE114
 4289 0721 0400      		.word	0x4
 4290 0723 F3        		.byte	0xf3
 4291 0724 01        		.uleb128 0x1
 4292 0725 68        		.byte	0x68
 4293 0726 9F        		.byte	0x9f
 4294 0727 0000 0000 		.long	0
 4295 072b 0000 0000 		.long	0
 4296               	.LLST32:
 4297 072f 0000 0000 		.long	.LVL99
 4298 0733 0000 0000 		.long	.LVL104
 4299 0737 0100      		.word	0x1
 4300 0739 66        		.byte	0x66
 4301 073a 0000 0000 		.long	.LVL104
 4302 073e 0000 0000 		.long	.LVL105-1
 4303 0742 0500      		.word	0x5
 4304 0744 03        		.byte	0x3
 4305 0745 0000 0000 		.long	lcdCols
 4306 0749 0000 0000 		.long	.LVL105-1
 4307 074d 0000 0000 		.long	.LFE114
 4308 0751 0400      		.word	0x4
 4309 0753 F3        		.byte	0xf3
 4310 0754 01        		.uleb128 0x1
 4311 0755 66        		.byte	0x66
 4312 0756 9F        		.byte	0x9f
GAS LISTING /tmp/ccFP0NC0.s 			page 85


 4313 0757 0000 0000 		.long	0
 4314 075b 0000 0000 		.long	0
 4315               	.LLST33:
 4316 075f 0000 0000 		.long	.LVL99
 4317 0763 0000 0000 		.long	.LVL103
 4318 0767 0100      		.word	0x1
 4319 0769 64        		.byte	0x64
 4320 076a 0000 0000 		.long	.LVL103
 4321 076e 0000 0000 		.long	.LVL119
 4322 0772 0100      		.word	0x1
 4323 0774 6C        		.byte	0x6c
 4324 0775 0000 0000 		.long	.LVL119
 4325 0779 0000 0000 		.long	.LFE114
 4326 077d 0400      		.word	0x4
 4327 077f F3        		.byte	0xf3
 4328 0780 01        		.uleb128 0x1
 4329 0781 64        		.byte	0x64
 4330 0782 9F        		.byte	0x9f
 4331 0783 0000 0000 		.long	0
 4332 0787 0000 0000 		.long	0
 4333               	.LLST34:
 4334 078b 0000 0000 		.long	.LVL99
 4335 078f 0000 0000 		.long	.LVL105-1
 4336 0793 0100      		.word	0x1
 4337 0795 62        		.byte	0x62
 4338 0796 0000 0000 		.long	.LVL105-1
 4339 079a 0000 0000 		.long	.LFE114
 4340 079e 0400      		.word	0x4
 4341 07a0 F3        		.byte	0xf3
 4342 07a1 01        		.uleb128 0x1
 4343 07a2 62        		.byte	0x62
 4344 07a3 9F        		.byte	0x9f
 4345 07a4 0000 0000 		.long	0
 4346 07a8 0000 0000 		.long	0
 4347               		.section	.debug_aranges,"",@progbits
 4348 0000 8C00 0000 		.long	0x8c
 4349 0004 0200      		.word	0x2
 4350 0006 0000 0000 		.long	.Ldebug_info0
 4351 000a 04        		.byte	0x4
 4352 000b 00        		.byte	0
 4353 000c 0000      		.word	0
 4354 000e 0000      		.word	0
 4355 0010 0000 0000 		.long	.LFB102
 4356 0014 4800 0000 		.long	.LFE102-.LFB102
 4357 0018 0000 0000 		.long	.LFB103
 4358 001c 3000 0000 		.long	.LFE103-.LFB103
 4359 0020 0000 0000 		.long	.LFB104
 4360 0024 5800 0000 		.long	.LFE104-.LFB104
 4361 0028 0000 0000 		.long	.LFB105
 4362 002c A801 0000 		.long	.LFE105-.LFB105
 4363 0030 0000 0000 		.long	.LFB106
 4364 0034 2200 0000 		.long	.LFE106-.LFB106
 4365 0038 0000 0000 		.long	.LFB107
 4366 003c 2200 0000 		.long	.LFE107-.LFB107
 4367 0040 0000 0000 		.long	.LFB108
 4368 0044 2400 0000 		.long	.LFE108-.LFB108
 4369 0048 0000 0000 		.long	.LFB109
GAS LISTING /tmp/ccFP0NC0.s 			page 86


 4370 004c 2600 0000 		.long	.LFE109-.LFB109
 4371 0050 0000 0000 		.long	.LFB110
 4372 0054 5A00 0000 		.long	.LFE110-.LFB110
 4373 0058 0000 0000 		.long	.LFB111
 4374 005c 3A00 0000 		.long	.LFE111-.LFB111
 4375 0060 0000 0000 		.long	.LFB112
 4376 0064 4400 0000 		.long	.LFE112-.LFB112
 4377 0068 0000 0000 		.long	.LFB113
 4378 006c A400 0000 		.long	.LFE113-.LFB113
 4379 0070 0000 0000 		.long	.LFB114
 4380 0074 DA00 0000 		.long	.LFE114-.LFB114
 4381 0078 0000 0000 		.long	.LFB115
 4382 007c 1600 0000 		.long	.LFE115-.LFB115
 4383 0080 0000 0000 		.long	.LFB116
 4384 0084 0200 0000 		.long	.LFE116-.LFB116
 4385 0088 0000 0000 		.long	0
 4386 008c 0000 0000 		.long	0
 4387               		.section	.debug_ranges,"",@progbits
 4388               	.Ldebug_ranges0:
 4389 0000 0000 0000 		.long	.LFB102
 4390 0004 0000 0000 		.long	.LFE102
 4391 0008 0000 0000 		.long	.LFB103
 4392 000c 0000 0000 		.long	.LFE103
 4393 0010 0000 0000 		.long	.LFB104
 4394 0014 0000 0000 		.long	.LFE104
 4395 0018 0000 0000 		.long	.LFB105
 4396 001c 0000 0000 		.long	.LFE105
 4397 0020 0000 0000 		.long	.LFB106
 4398 0024 0000 0000 		.long	.LFE106
 4399 0028 0000 0000 		.long	.LFB107
 4400 002c 0000 0000 		.long	.LFE107
 4401 0030 0000 0000 		.long	.LFB108
 4402 0034 0000 0000 		.long	.LFE108
 4403 0038 0000 0000 		.long	.LFB109
 4404 003c 0000 0000 		.long	.LFE109
 4405 0040 0000 0000 		.long	.LFB110
 4406 0044 0000 0000 		.long	.LFE110
 4407 0048 0000 0000 		.long	.LFB111
 4408 004c 0000 0000 		.long	.LFE111
 4409 0050 0000 0000 		.long	.LFB112
 4410 0054 0000 0000 		.long	.LFE112
 4411 0058 0000 0000 		.long	.LFB113
 4412 005c 0000 0000 		.long	.LFE113
 4413 0060 0000 0000 		.long	.LFB114
 4414 0064 0000 0000 		.long	.LFE114
 4415 0068 0000 0000 		.long	.LFB115
 4416 006c 0000 0000 		.long	.LFE115
 4417 0070 0000 0000 		.long	.LFB116
 4418 0074 0000 0000 		.long	.LFE116
 4419 0078 0000 0000 		.long	0
 4420 007c 0000 0000 		.long	0
 4421               		.section	.debug_line,"",@progbits
 4422               	.Ldebug_line0:
 4423 0000 2603 0000 		.section	.debug_str,"MS",@progbits,1
 4423      0200 B400 
 4423      0000 0201 
 4423      FB0E 0D00 
GAS LISTING /tmp/ccFP0NC0.s 			page 87


 4423      0101 0101 
 4424               	.LASF27:
 4425 0000 7477 6953 		.string	"twiSetup"
 4425      6574 7570 
 4425      00
 4426               	.LASF43:
 4427 0009 5F64 6174 		.string	"_data"
 4427      6100 
 4428               	.LASF9:
 4429 000f 6C6F 6E67 		.string	"long long unsigned int"
 4429      206C 6F6E 
 4429      6720 756E 
 4429      7369 676E 
 4429      6564 2069 
 4430               	.LASF18:
 4431 0026 7374 6172 		.string	"starts"
 4431      7473 00
 4432               	.LASF68:
 4433 002d 6C63 6453 		.string	"lcdShifts"
 4433      6869 6674 
 4433      7300 
 4434               	.LASF58:
 4435 0037 7477 6952 		.string	"twiRX_Count"
 4435      585F 436F 
 4435      756E 7400 
 4436               	.LASF8:
 4437 0043 6C6F 6E67 		.string	"long long int"
 4437      206C 6F6E 
 4437      6720 696E 
 4437      7400 
 4438               	.LASF0:
 4439 0051 7369 676E 		.string	"signed char"
 4439      6564 2063 
 4439      6861 7200 
 4440               	.LASF28:
 4441 005d 6672 6571 		.string	"freq"
 4441      00
 4442               	.LASF20:
 4443 0062 7374 6F70 		.string	"stops"
 4443      7300 
 4444               	.LASF17:
 4445 0068 5457 495F 		.string	"TWI_READY"
 4445      5245 4144 
 4445      5900 
 4446               	.LASF69:
 4447 0072 6C63 6453 		.string	"lcdShows"
 4447      686F 7773 
 4447      00
 4448               	.LASF5:
 4449 007b 6C6F 6E67 		.string	"long int"
 4449      2069 6E74 
 4449      00
 4450               	.LASF30:
 4451 0084 5F5F 7665 		.string	"__vector_39"
 4451      6374 6F72 
 4451      5F33 3900 
 4452               	.LASF66:
GAS LISTING /tmp/ccFP0NC0.s 			page 88


 4453 0090 7477 6953 		.string	"twiStatistic"
 4453      7461 7469 
 4453      7374 6963 
 4453      00
 4454               	.LASF3:
 4455 009d 7569 6E74 		.string	"uint16_t"
 4455      3136 5F74 
 4455      00
 4456               	.LASF13:
 4457 00a6 646F 7562 		.string	"double"
 4457      6C65 00
 4458               	.LASF40:
 4459 00ad 636C 656E 		.string	"clength"
 4459      6774 6800 
 4460               	.LASF65:
 4461 00b5 7477 6953 		.string	"twiSlaveWriter"
 4461      6C61 7665 
 4461      5772 6974 
 4461      6572 00
 4462               	.LASF38:
 4463 00c4 7477 6952 		.string	"twiRAW"
 4463      4157 00
 4464               	.LASF45:
 4465 00cb 6C63 6457 		.string	"lcdWrite"
 4465      7269 7465 
 4465      00
 4466               	.LASF37:
 4467 00d4 7477 6952 		.string	"twiRead"
 4467      6561 6400 
 4468               	.LASF25:
 4469 00dc 6269 744D 		.string	"bitMul"
 4469      756C 00
 4470               	.LASF4:
 4471 00e3 756E 7369 		.string	"unsigned int"
 4471      676E 6564 
 4471      2069 6E74 
 4471      00
 4472               	.LASF71:
 4473 00f0 6C63 6441 		.string	"lcdAddress"
 4473      6464 7265 
 4473      7373 00
 4474               	.LASF59:
 4475 00fb 7477 6952 		.string	"twiRX_Ptr"
 4475      585F 5074 
 4475      7200 
 4476               	.LASF39:
 4477 0105 636F 6D6D 		.string	"command"
 4477      616E 6400 
 4478               	.LASF83:
 4479 010d 6C6F 6F70 		.string	"loop"
 4479      00
 4480               	.LASF47:
 4481 0112 6C63 6453 		.string	"lcdSetup"
 4481      6574 7570 
 4481      00
 4482               	.LASF7:
 4483 011b 6C6F 6E67 		.string	"long unsigned int"
GAS LISTING /tmp/ccFP0NC0.s 			page 89


 4483      2075 6E73 
 4483      6967 6E65 
 4483      6420 696E 
 4483      7400 
 4484               	.LASF55:
 4485 012d 7477 6953 		.string	"twiSLARW"
 4485      4C41 5257 
 4485      00
 4486               	.LASF48:
 4487 0136 5F61 6464 		.string	"_address"
 4487      7265 7373 
 4487      00
 4488               	.LASF35:
 4489 013f 6461 7461 		.string	"data"
 4489      00
 4490               	.LASF14:
 4491 0144 7368 6F72 		.string	"short unsigned int"
 4491      7420 756E 
 4491      7369 676E 
 4491      6564 2069 
 4491      6E74 00
 4492               	.LASF23:
 4493 0157 5457 495F 		.string	"TWI_Stat"
 4493      5374 6174 
 4493      00
 4494               	.LASF50:
 4495 0160 5F72 6F77 		.string	"_rows"
 4495      7300 
 4496               	.LASF10:
 4497 0166 626F 6F6C 		.string	"bool"
 4497      00
 4498               	.LASF53:
 4499 016b 7477 694D 		.string	"twiMode"
 4499      6F64 6500 
 4500               	.LASF63:
 4501 0173 7477 694D 		.string	"twiMasterReader"
 4501      6173 7465 
 4501      7252 6561 
 4501      6465 7200 
 4502               	.LASF79:
 4503 0183 5457 495F 		.string	"TWI_Modes"
 4503      4D6F 6465 
 4503      7300 
 4504               	.LASF56:
 4505 018d 7477 694D 		.string	"twiMT_Count"
 4505      545F 436F 
 4505      756E 7400 
 4506               	.LASF81:
 4507 0199 7477 6953 		.string	"twiSendStop"
 4507      656E 6453 
 4507      746F 7000 
 4508               	.LASF32:
 4509 01a5 6164 6472 		.string	"address"
 4509      6573 7300 
 4510               	.LASF31:
 4511 01ad 5F74 7769 		.string	"_twiStartTo"
 4511      5374 6172 
GAS LISTING /tmp/ccFP0NC0.s 			page 90


 4511      7454 6F00 
 4512               	.LASF52:
 4513 01b9 7365 7475 		.string	"setup"
 4513      7000 
 4514               	.LASF12:
 4515 01bf 666C 6F61 		.string	"float"
 4515      7400 
 4516               	.LASF73:
 4517 01c5 6C63 6452 		.string	"lcdRows"
 4517      6F77 7300 
 4518               	.LASF84:
 4519 01cd 7469 6D65 		.string	"time_delay16"
 4519      5F64 656C 
 4519      6179 3136 
 4519      00
 4520               	.LASF57:
 4521 01da 7477 694D 		.string	"twiMT_Ptr"
 4521      545F 5074 
 4521      7200 
 4522               	.LASF42:
 4523 01e4 6C63 6450 		.string	"lcdPrepare"
 4523      7265 7061 
 4523      7265 00
 4524               	.LASF19:
 4525 01ef 7265 7374 		.string	"restarts"
 4525      6172 7473 
 4525      00
 4526               	.LASF51:
 4527 01f8 5F62 6163 		.string	"_backLight"
 4527      6B4C 6967 
 4527      6874 00
 4528               	.LASF76:
 4529 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4529      432B 2B20 
 4529      342E 382E 
 4529      3120 2D6D 
 4529      6D63 753D 
 4530               	.LASF1:
 4531 0295 756E 7369 		.string	"unsigned char"
 4531      676E 6564 
 4531      2063 6861 
 4531      7200 
 4532               	.LASF49:
 4533 02a3 5F63 6F6C 		.string	"_cols"
 4533      7300 
 4534               	.LASF78:
 4535 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4535      2F62 7569 
 4535      6C64 3132 
 4535      3336 3837 
 4535      3935 3737 
 4536               	.LASF24:
 4537 02cb 6269 7452 		.string	"bitRate"
 4537      6174 6500 
 4538               	.LASF54:
 4539 02d3 7477 6953 		.string	"twiState"
 4539      7461 7465 
GAS LISTING /tmp/ccFP0NC0.s 			page 91


 4539      00
 4540               	.LASF77:
 4541 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4541      2F62 7569 
 4541      6C64 3132 
 4541      3336 3837 
 4541      3935 3737 
 4542               	.LASF6:
 4543 030c 7569 6E74 		.string	"uint32_t"
 4543      3332 5F74 
 4543      00
 4544               	.LASF75:
 4545 0315 6C63 6442 		.string	"lcdBuffer"
 4545      7566 6665 
 4545      7200 
 4546               	.LASF22:
 4547 031f 6E6F 736C 		.string	"noslarw"
 4547      6172 7700 
 4548               	.LASF36:
 4549 0327 6C65 6E67 		.string	"length"
 4549      7468 00
 4550               	.LASF11:
 4551 032e 6368 6172 		.string	"char"
 4551      00
 4552               	.LASF41:
 4553 0333 646C 656E 		.string	"dlength"
 4553      6774 6800 
 4554               	.LASF29:
 4555 033b 6D6F 6465 		.string	"mode"
 4555      00
 4556               	.LASF72:
 4557 0340 6C63 6443 		.string	"lcdCols"
 4557      6F6C 7300 
 4558               	.LASF21:
 4559 0348 6C6F 7374 		.string	"losts"
 4559      7300 
 4560               	.LASF82:
 4561 034e 7469 6D65 		.string	"time"
 4561      00
 4562               	.LASF26:
 4563 0353 7477 6953 		.string	"twiSpeed"
 4563      7065 6564 
 4563      00
 4564               	.LASF16:
 4565 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4565      5345 4E44 
 4565      5F53 544F 
 4565      5000 
 4566               	.LASF70:
 4567 036a 6C63 6442 		.string	"lcdBackLight"
 4567      6163 6B4C 
 4567      6967 6874 
 4567      00
 4568               	.LASF2:
 4569 0377 7569 6E74 		.string	"uint8_t"
 4569      385F 7400 
 4570               	.LASF80:
GAS LISTING /tmp/ccFP0NC0.s 			page 92


 4571 037f 3854 5749 		.string	"8TWI_Stat"
 4571      5F53 7461 
 4571      7400 
 4572               	.LASF74:
 4573 0389 7369 7A65 		.string	"sizetype"
 4573      7479 7065 
 4573      00
 4574               	.LASF46:
 4575 0392 6C63 6449 		.string	"lcdInit"
 4575      6E69 7400 
 4576               	.LASF64:
 4577 039a 7477 6953 		.string	"twiSlaveReader"
 4577      6C61 7665 
 4577      5265 6164 
 4577      6572 00
 4578               	.LASF62:
 4579 03a9 7477 6948 		.string	"twiHookRestart"
 4579      6F6F 6B52 
 4579      6573 7461 
 4579      7274 00
 4580               	.LASF61:
 4581 03b8 7477 6953 		.string	"twiST_Ptr"
 4581      545F 5074 
 4581      7200 
 4582               	.LASF33:
 4583 03c2 5F74 7769 		.string	"_twiStartRe"
 4583      5374 6172 
 4583      7452 6500 
 4584               	.LASF34:
 4585 03ce 7477 6957 		.string	"twiWrite"
 4585      7269 7465 
 4585      00
 4586               	.LASF67:
 4587 03d7 6C63 644D 		.string	"lcdModes"
 4587      6F64 6573 
 4587      00
 4588               	.LASF44:
 4589 03e0 6E69 6262 		.string	"nibble"
 4589      6C65 00
 4590               	.LASF60:
 4591 03e7 7477 6953 		.string	"twiST_Count"
 4591      545F 436F 
 4591      756E 7400 
 4592               	.LASF15:
 4593 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4593      4953 5F53 
 4593      4C41 5645 
 4593      00
 4594               		.ident	"GCC: (GNU) 4.8.1"
 4595               	.global __do_copy_data
 4596               	.global __do_clear_bss
GAS LISTING /tmp/ccFP0NC0.s 			page 93


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccFP0NC0.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccFP0NC0.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccFP0NC0.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccFP0NC0.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccFP0NC0.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccFP0NC0.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccFP0NC0.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccFP0NC0.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccFP0NC0.s:1307   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccFP0NC0.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccFP0NC0.s:1253   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccFP0NC0.s:1295   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccFP0NC0.s:226    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccFP0NC0.s:1301   .bss.twiState:0000000000000000 twiState
     /tmp/ccFP0NC0.s:1235   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccFP0NC0.s:1259   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccFP0NC0.s:1265   .bss.twiST_Count:0000000000000000 twiST_Count
     /tmp/ccFP0NC0.s:1271   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccFP0NC0.s:1241   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccFP0NC0.s:1289   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccFP0NC0.s:1283   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccFP0NC0.s:1277   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccFP0NC0.s:1247   .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccFP0NC0.s:553    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccFP0NC0.s:588    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccFP0NC0.s:623    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccFP0NC0.s:656    .text.twiRead:0000000000000000 twiRead
     /tmp/ccFP0NC0.s:690    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccFP0NC0.s:754    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccFP0NC0.s:1206   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccFP0NC0.s:1182   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccFP0NC0.s:817    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccFP0NC0.s:1200   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccFP0NC0.s:888    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccFP0NC0.s:1224   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccFP0NC0.s:1212   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccFP0NC0.s:1218   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccFP0NC0.s:981    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccFP0NC0.s:1194   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccFP0NC0.s:1188   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccFP0NC0.s:1137   .text.setup:0000000000000000 setup
     /tmp/ccFP0NC0.s:1166   .text.loop:0000000000000000 loop
     /tmp/ccFP0NC0.s:1229   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
