GAS LISTING /tmp/ccFZTQVh.s 			page 1


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
GAS LISTING /tmp/ccFZTQVh.s 			page 2


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
GAS LISTING /tmp/ccFZTQVh.s 			page 3


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
GAS LISTING /tmp/ccFZTQVh.s 			page 4


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
GAS LISTING /tmp/ccFZTQVh.s 			page 5


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
GAS LISTING /tmp/ccFZTQVh.s 			page 6


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
GAS LISTING /tmp/ccFZTQVh.s 			page 7


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
GAS LISTING /tmp/ccFZTQVh.s 			page 8


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
GAS LISTING /tmp/ccFZTQVh.s 			page 9


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
 237 000a 0BB6      		in r0,__RAMPZ__
 238 000c 0F92      		push r0
 239 000e 2F93      		push r18
 240               	.LCFI7:
 241               		.cfi_def_cfa_offset 6
 242               		.cfi_offset 18, -5
 243 0010 3F93      		push r19
 244               	.LCFI8:
 245               		.cfi_def_cfa_offset 7
 246               		.cfi_offset 19, -6
 247 0012 4F93      		push r20
 248               	.LCFI9:
 249               		.cfi_def_cfa_offset 8
 250               		.cfi_offset 20, -7
 251 0014 5F93      		push r21
 252               	.LCFI10:
GAS LISTING /tmp/ccFZTQVh.s 			page 10


 253               		.cfi_def_cfa_offset 9
 254               		.cfi_offset 21, -8
 255 0016 6F93      		push r22
 256               	.LCFI11:
 257               		.cfi_def_cfa_offset 10
 258               		.cfi_offset 22, -9
 259 0018 7F93      		push r23
 260               	.LCFI12:
 261               		.cfi_def_cfa_offset 11
 262               		.cfi_offset 23, -10
 263 001a 8F93      		push r24
 264               	.LCFI13:
 265               		.cfi_def_cfa_offset 12
 266               		.cfi_offset 24, -11
 267 001c 9F93      		push r25
 268               	.LCFI14:
 269               		.cfi_def_cfa_offset 13
 270               		.cfi_offset 25, -12
 271 001e AF93      		push r26
 272               	.LCFI15:
 273               		.cfi_def_cfa_offset 14
 274               		.cfi_offset 26, -13
 275 0020 BF93      		push r27
 276               	.LCFI16:
 277               		.cfi_def_cfa_offset 15
 278               		.cfi_offset 27, -14
 279 0022 EF93      		push r30
 280               	.LCFI17:
 281               		.cfi_def_cfa_offset 16
 282               		.cfi_offset 30, -15
 283 0024 FF93      		push r31
 284               	.LCFI18:
 285               		.cfi_def_cfa_offset 17
 286               		.cfi_offset 31, -16
 287               	/* prologue: Signal */
 288               	/* frame size = 0 */
 289               	/* stack size = 16 */
 290               	.L__stack_usage = 16
 291               	.LBB3:
 262:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _cr;
 263:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _md = twiMode;
 292               		.loc 1 263 0
 293 0026 3091 0000 		lds r19,twiMode
 294               	.LVL19:
 264:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _st = twiState=TWI_STATUS;
 295               		.loc 1 264 0
 296 002a 2091 B900 		lds r18,185
 297 002e 822F      		mov r24,r18
 298 0030 887F      		andi r24,lo8(-8)
 299 0032 8093 0000 		sts twiState,r24
 300               	.LVL20:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 267:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( _st >= TWI_SR_SLA_ACK )
 301               		.loc 1 267 0
 302 0036 8036      		cpi r24,lo8(96)
 303 0038 00F0      		brlo .L22
GAS LISTING /tmp/ccFZTQVh.s 			page 11


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
 304               		.loc 1 288 0 discriminator 1
 305 003a 922F      		mov r25,r18
 306 003c 987E      		andi r25,lo8(-24)
 307 003e 9838      		cpi r25,lo8(-120)
 308 0040 01F0      		breq .L23
 309 0042 803A      		cpi r24,lo8(-96)
 310 0044 01F4      		brne .L32
 311 0046 00C0      		rjmp .L24
 312               	.L23:
 289:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 290:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_NACK) || (_st == TWI_SR_DATA_NACK) )
 291:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 292:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. GCall - туда же.
 293:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: УПС. Получен байт, мастеру уже был отп
 294:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *twiRX_Ptr = TWDR;
 313               		.loc 1 294 0
 314 0048 E091 0000 		lds r30,twiRX_Ptr
 315 004c F091 0000 		lds r31,twiRX_Ptr+1
 316 0050 8091 BB00 		lds r24,187
 317               	.LVL21:
 318 0054 8083      		st Z,r24
 319               	.LVL22:
 320               	.L24:
 295:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 296:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // SR: Обнаружен stop или restart в процессе приема 
 297:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSlaveReader();                           // Хук обязателен! э�
 321               		.loc 1 297 0
 322 0056 E091 0000 		lds r30,twiSlaveReader
 323 005a F091 0000 		lds r31,twiSlaveReader+1
 324 005e 1995      		eicall
 325               	.LVL23:
 298:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md=twiMode;                                // возможно изменен�
 326               		.loc 1 298 0
 327 0060 8091 0000 		lds r24,twiMode
 328               	.LVL24:
 299:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     twiSendStop(_md); return;
GAS LISTING /tmp/ccFZTQVh.s 			page 12


 329               		.loc 1 299 0
 330 0064 0E94 0000 		call twiSendStop
 331               	.LVL25:
 332 0068 00C0      		rjmp .L21
 333               	.LVL26:
 334               	.L32:
 300:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 301:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_SR_GCALL_DATA_ACK) || (_st == TWI_SR_DATA_ACK) )
 335               		.loc 1 301 0 discriminator 1
 336 006a 9038      		cpi r25,lo8(-128)
 337 006c 01F4      		brne .L27
 302:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 303:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт всем - аналогично
 304:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // SR: пришел байт, можно ещё принять
 305:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         *(twiRX_Ptr++) = TWDR;
 338               		.loc 1 305 0
 339 006e E091 0000 		lds r30,twiRX_Ptr
 340 0072 F091 0000 		lds r31,twiRX_Ptr+1
 341 0076 CF01      		movw r24,r30
 342               	.LVL27:
 343 0078 0196      		adiw r24,1
 344 007a 9093 0000 		sts twiRX_Ptr+1,r25
 345 007e 8093 0000 		sts twiRX_Ptr,r24
 346 0082 8091 BB00 		lds r24,187
 347 0086 8083      		st Z,r24
 348               	.LVL28:
 349               	.L27:
 306:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }
 307:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_SLA_ACK   SR: Мастер потерял шину: нет �
 308:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_ARB_LOST_GCALL_ACK SR: Вызов всем потерял шину (�
 309:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_SLA_ACK            SR: Адрес принят, ещё только �
 310:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // TWI_SR_GCALL_ACK          SR: Вызов всем принят оно же
 311:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReply(--twiRX_Count);              // .. приняли байт и о
 350               		.loc 1 311 0
 351 0088 8091 0000 		lds r24,twiRX_Count
 352 008c 8150      		subi r24,lo8(-(-1))
 353 008e 8093 0000 		sts twiRX_Count,r24
 354 0092 8823      		tst r24
 355 0094 01F0      		breq .L28
 356 0096 95EC      		ldi r25,lo8(-59)
 357 0098 00C0      		rjmp .L22
 358               	.L28:
 359 009a 95E8      		ldi r25,lo8(-123)
 360               	.L22:
 361               	.LVL29:
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
GAS LISTING /tmp/ccFZTQVh.s 			page 13


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
 340:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 if( twiMT_Count-- ){
 341:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     TWDR = *twiMT_Ptr++;
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
GAS LISTING /tmp/ccFZTQVh.s 			page 14


 381:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         }
 382:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_ON::TWI_MASTER_TX
 383:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 384:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     }
 385:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #endif // TWI_SLAVE_ON
 386:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode = _md;
 362               		.loc 1 386 0
 363 009c 3093 0000 		sts twiMode,r19
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 364               		.loc 1 387 0
 365 00a0 9093 BC00 		sts 188,r25
 366               	.LVL30:
 367               	.L21:
 368               	/* epilogue start */
 369               	.LBE3:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 370               		.loc 1 388 0
 371 00a4 FF91      		pop r31
 372 00a6 EF91      		pop r30
 373 00a8 BF91      		pop r27
 374 00aa AF91      		pop r26
 375 00ac 9F91      		pop r25
 376 00ae 8F91      		pop r24
 377 00b0 7F91      		pop r23
 378 00b2 6F91      		pop r22
 379 00b4 5F91      		pop r21
 380 00b6 4F91      		pop r20
 381 00b8 3F91      		pop r19
 382 00ba 2F91      		pop r18
 383 00bc 0F90      		pop r0
 384 00be 0BBE      		out __RAMPZ__,r0
 385 00c0 0F90      		pop r0
 386 00c2 0FBE      		out __SREG__,r0
 387 00c4 0F90      		pop r0
 388 00c6 1F90      		pop r1
 389 00c8 1895      		reti
 390               		.cfi_endproc
 391               	.LFE105:
 392               		.size	__vector_39, .-__vector_39
 393               		.section	.text._twiStartTo,"ax",@progbits
 394               	.global	_twiStartTo
 395               		.type	_twiStartTo, @function
 396               	_twiStartTo:
 397               	.LFB106:
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
 398               		.loc 1 400 0
GAS LISTING /tmp/ccFZTQVh.s 			page 15


 399               		.cfi_startproc
 400               	.LVL31:
 401               	/* prologue: function */
 402               	/* frame size = 0 */
 403               	/* stack size = 0 */
 404               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 405               		.loc 1 401 0
 406 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 407               		.loc 1 402 0
 408 0004 8091 0000 		lds r24,twiMode
 409               	.LVL32:
 410 0008 8260      		ori r24,lo8(2)
 411 000a 8093 0000 		sts twiMode,r24
 412               	.LVL33:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 413               		.loc 1 403 0
 414 000e 8091 0000 		lds r24,twiMode
 415 0012 80FF      		sbrs r24,0
 416 0014 00C0      		rjmp .L35
 417 0016 85EE      		ldi r24,lo8(-27)
 418 0018 00C0      		rjmp .L34
 419               	.L35:
 420 001a 85EA      		ldi r24,lo8(-91)
 421               	.L34:
 422               		.loc 1 403 0 is_stmt 0 discriminator 3
 423 001c 8093 BC00 		sts 188,r24
 424 0020 0895      		ret
 425               		.cfi_endproc
 426               	.LFE106:
 427               		.size	_twiStartTo, .-_twiStartTo
 428               		.section	.text._twiStartRe,"ax",@progbits
 429               	.global	_twiStartRe
 430               		.type	_twiStartRe, @function
 431               	_twiStartRe:
 432               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 433               		.loc 1 412 0 is_stmt 1
 434               		.cfi_startproc
 435               	.LVL34:
 436               	/* prologue: function */
 437               	/* frame size = 0 */
 438               	/* stack size = 0 */
 439               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 440               		.loc 1 413 0
 441 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
GAS LISTING /tmp/ccFZTQVh.s 			page 16


 442               		.loc 1 414 0
 443 0004 8091 0000 		lds r24,twiMode
 444               	.LVL35:
 445 0008 8D7F      		andi r24,lo8(-3)
 446 000a 8093 0000 		sts twiMode,r24
 447               	.LVL36:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 448               		.loc 1 415 0
 449 000e 8091 0000 		lds r24,twiMode
 450 0012 80FF      		sbrs r24,0
 451 0014 00C0      		rjmp .L38
 452 0016 85EE      		ldi r24,lo8(-27)
 453 0018 00C0      		rjmp .L37
 454               	.L38:
 455 001a 85EA      		ldi r24,lo8(-91)
 456               	.L37:
 457               		.loc 1 415 0 is_stmt 0 discriminator 3
 458 001c 8093 BC00 		sts 188,r24
 459 0020 0895      		ret
 460               		.cfi_endproc
 461               	.LFE107:
 462               		.size	_twiStartRe, .-_twiStartRe
 463               		.section	.text.twiWrite,"ax",@progbits
 464               	.global	twiWrite
 465               		.type	twiWrite, @function
 466               	twiWrite:
 467               	.LFB108:
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
 468               		.loc 1 430 0 is_stmt 1
 469               		.cfi_startproc
 470               	/* prologue: function */
 471               	/* frame size = 0 */
 472               	/* stack size = 0 */
 473               	.L__stack_usage = 0
 474               	.LVL37:
 475               	.L41:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 476               		.loc 1 431 0 discriminator 1
 477 0000 9091 0000 		lds r25,twiMode
 478 0004 92FF      		sbrs r25,2
 479 0006 00C0      		rjmp .L41
 480               		.loc 1 431 0 is_stmt 0 discriminator 2
 481 0008 9091 0000 		lds r25,twiMode
GAS LISTING /tmp/ccFZTQVh.s 			page 17


 482 000c 9B7F      		andi r25,lo8(-5)
 483 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 484               		.loc 1 432 0 is_stmt 1 discriminator 2
 485 0012 7093 0000 		sts twiMT_Ptr+1,r23
 486 0016 6093 0000 		sts twiMT_Ptr,r22
 487 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 488               		.loc 1 433 0 discriminator 2
 489 001e 880F      		lsl r24
 490               	.LVL38:
 491 0020 0C94 0000 		jmp _twiStartTo
 492               	.LVL39:
 493               		.cfi_endproc
 494               	.LFE108:
 495               		.size	twiWrite, .-twiWrite
 496               		.section	.text.twiRead,"ax",@progbits
 497               	.global	twiRead
 498               		.type	twiRead, @function
 499               	twiRead:
 500               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 501               		.loc 1 440 0
 502               		.cfi_startproc
 503               	/* prologue: function */
 504               	/* frame size = 0 */
 505               	/* stack size = 0 */
 506               	.L__stack_usage = 0
 507               	.LVL40:
 508               	.L44:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 509               		.loc 1 441 0 discriminator 1
 510 0000 9091 0000 		lds r25,twiMode
 511 0004 92FF      		sbrs r25,2
 512 0006 00C0      		rjmp .L44
 513               		.loc 1 441 0 is_stmt 0 discriminator 2
 514 0008 9091 0000 		lds r25,twiMode
 515 000c 9B7F      		andi r25,lo8(-5)
 516 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 517               		.loc 1 442 0 is_stmt 1 discriminator 2
 518 0012 7093 0000 		sts twiRX_Ptr+1,r23
 519 0016 6093 0000 		sts twiRX_Ptr,r22
 520 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 521               		.loc 1 443 0 discriminator 2
 522 001e 880F      		lsl r24
 523               	.LVL41:
 524 0020 8160      		ori r24,lo8(1)
 525 0022 0C94 0000 		jmp _twiStartTo
 526               	.LVL42:
GAS LISTING /tmp/ccFZTQVh.s 			page 18


 527               		.cfi_endproc
 528               	.LFE109:
 529               		.size	twiRead, .-twiRead
 530               		.section	.text.twiRAW,"ax",@progbits
 531               	.global	twiRAW
 532               		.type	twiRAW, @function
 533               	twiRAW:
 534               	.LFB110:
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
 535               		.loc 1 453 0
 536               		.cfi_startproc
 537               	.LVL43:
 538 0000 0F93      		push r16
 539               	.LCFI19:
 540               		.cfi_def_cfa_offset 4
 541               		.cfi_offset 16, -3
 542               	/* prologue: function */
 543               	/* frame size = 0 */
 544               	/* stack size = 1 */
 545               	.L__stack_usage = 1
 546               	.L47:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 547               		.loc 1 454 0 discriminator 1
 548 0002 9091 0000 		lds r25,twiMode
 549 0006 92FF      		sbrs r25,2
 550 0008 00C0      		rjmp .L47
 551               		.loc 1 454 0 is_stmt 0 discriminator 2
 552 000a 9091 0000 		lds r25,twiMode
 553 000e 9B7F      		andi r25,lo8(-5)
 554 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 555               		.loc 1 455 0 is_stmt 1 discriminator 2
 556 0014 7093 0000 		sts twiMT_Ptr+1,r23
 557 0018 6093 0000 		sts twiMT_Ptr,r22
 558 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 559               		.loc 1 456 0 discriminator 2
 560 0020 3093 0000 		sts twiRX_Ptr+1,r19
 561 0024 2093 0000 		sts twiRX_Ptr,r18
 562 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 563               		.loc 1 458 0 discriminator 2
 564 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 565 0030 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 566               		.loc 1 459 0 discriminator 2
 567 0034 9091 0000 		lds r25,twiMode
GAS LISTING /tmp/ccFZTQVh.s 			page 19


 568 0038 9D7F      		andi r25,lo8(-3)
 569 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 570               		.loc 1 460 0 discriminator 2
 571 003e 880F      		lsl r24
 572               	.LVL44:
 573 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 574               		.loc 1 461 0 discriminator 2
 575 0044 8091 0000 		lds r24,twiMode
 576 0048 80FF      		sbrs r24,0
 577 004a 00C0      		rjmp .L49
 578               		.loc 1 461 0 is_stmt 0
 579 004c 85EE      		ldi r24,lo8(-27)
 580 004e 00C0      		rjmp .L48
 581               	.L49:
 582 0050 85EA      		ldi r24,lo8(-91)
 583               	.L48:
 584               		.loc 1 461 0 discriminator 3
 585 0052 8093 BC00 		sts 188,r24
 586               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 587               		.loc 1 462 0 is_stmt 1 discriminator 3
 588 0056 0F91      		pop r16
 589               	.LVL45:
 590 0058 0895      		ret
 591               		.cfi_endproc
 592               	.LFE110:
 593               		.size	twiRAW, .-twiRAW
 594               		.section	.text.lcdPrepare,"ax",@progbits
 595               	.global	lcdPrepare
 596               		.type	lcdPrepare, @function
 597               	lcdPrepare:
 598               	.LFB111:
 599               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 600               		.loc 2 490 0
 601               		.cfi_startproc
 602               	.LVL46:
 603               	/* prologue: function */
 604               	/* frame size = 0 */
 605               	/* stack size = 0 */
 606               	.L__stack_usage = 0
 607               	.LBB4:
 608               		.loc 2 491 0
 609 0000 2091 0000 		lds r18,lcdBackLight
 610 0004 982F      		mov r25,r24
 611 0006 907F      		andi r25,lo8(-16)
 612 0008 922B      		or r25,r18
 613               	.LVL47:
 614               		.loc 2 493 0
 615 000a 6111      		cpse r22,__zero_reg__
 616               		.loc 2 493 0 is_stmt 0 discriminator 1
 617 000c 9160      		ori r25,lo8(1)
 618               	.LVL48:
 619               	.L51:
 620               		.loc 2 494 0 is_stmt 1
GAS LISTING /tmp/ccFZTQVh.s 			page 20


 621 000e 9093 0000 		sts lcdBuffer,r25
 622 0012 9093 0000 		sts lcdBuffer+2,r25
 623               	.LVL49:
 624               		.loc 2 495 0
 625 0016 9460      		ori r25,lo8(4)
 626               	.LVL50:
 627               		.loc 2 496 0
 628 0018 9093 0000 		sts lcdBuffer+1,r25
 629               		.loc 2 498 0
 630 001c 30E1      		ldi r19,lo8(16)
 631 001e 839F      		mul r24,r19
 632 0020 C001      		movw r24,r0
 633 0022 1124      		clr __zero_reg__
 634               	.LVL51:
 635 0024 822B      		or r24,r18
 636               	.LVL52:
 637               		.loc 2 500 0
 638 0026 6111      		cpse r22,__zero_reg__
 639               		.loc 2 500 0 is_stmt 0 discriminator 1
 640 0028 8160      		ori r24,lo8(1)
 641               	.LVL53:
 642               	.L52:
 643               		.loc 2 501 0 is_stmt 1
 644 002a 8093 0000 		sts lcdBuffer+3,r24
 645 002e 8093 0000 		sts lcdBuffer+5,r24
 646               	.LVL54:
 647               		.loc 2 502 0
 648 0032 8460      		ori r24,lo8(4)
 649               	.LVL55:
 650               		.loc 2 503 0
 651 0034 8093 0000 		sts lcdBuffer+4,r24
 652 0038 0895      		ret
 653               	.LBE4:
 654               		.cfi_endproc
 655               	.LFE111:
 656               		.size	lcdPrepare, .-lcdPrepare
 657               		.section	.text.lcdWrite,"ax",@progbits
 658               	.global	lcdWrite
 659               		.type	lcdWrite, @function
 660               	lcdWrite:
 661               	.LFB112:
 662               		.loc 2 511 0
 663               		.cfi_startproc
 664               	.LVL56:
 665 0000 1F93      		push r17
 666               	.LCFI20:
 667               		.cfi_def_cfa_offset 4
 668               		.cfi_offset 17, -3
 669 0002 CF93      		push r28
 670               	.LCFI21:
 671               		.cfi_def_cfa_offset 5
 672               		.cfi_offset 28, -4
 673 0004 DF93      		push r29
 674               	.LCFI22:
 675               		.cfi_def_cfa_offset 6
 676               		.cfi_offset 29, -5
 677               	/* prologue: function */
GAS LISTING /tmp/ccFZTQVh.s 			page 21


 678               	/* frame size = 0 */
 679               	/* stack size = 3 */
 680               	.L__stack_usage = 3
 681 0006 162F      		mov r17,r22
 682               	.LVL57:
 683               	.LBB5:
 684               		.loc 2 515 0
 685 0008 2091 0000 		lds r18,twiMode
 686 000c 2260      		ori r18,lo8(2)
 687 000e 2093 0000 		sts twiMode,r18
 688               		.loc 2 516 0
 689 0012 C82F      		mov r28,r24
 690 0014 D92F      		mov r29,r25
 691 0016 180F      		add r17,r24
 692               	.LVL58:
 693               	.L60:
 694               		.loc 2 516 0 is_stmt 0 discriminator 1
 695 0018 1C17      		cp r17,r28
 696 001a 01F0      		breq .L62
 697               	.LVL59:
 698               		.loc 2 517 0 is_stmt 1
 699 001c 61E0      		ldi r22,lo8(1)
 700 001e 8991      		ld r24,Y+
 701               	.LVL60:
 702 0020 0E94 0000 		call lcdPrepare
 703               	.LVL61:
 704 0024 46E0      		ldi r20,lo8(6)
 705 0026 60E0      		ldi r22,lo8(lcdBuffer)
 706 0028 70E0      		ldi r23,hi8(lcdBuffer)
 707 002a 8091 0000 		lds r24,lcdAddress
 708 002e 0E94 0000 		call twiWrite
 709               	.LVL62:
 710 0032 85E0      		ldi r24,lo8(5)
 711 0034 90E0      		ldi r25,0
 712 0036 0E94 0000 		call time_delay16
 713               	.LVL63:
 714 003a 00C0      		rjmp .L60
 715               	.LVL64:
 716               	.L62:
 717               	/* epilogue start */
 718               	.LBE5:
 719               		.loc 2 518 0
 720 003c DF91      		pop r29
 721 003e CF91      		pop r28
 722               	.LVL65:
 723 0040 1F91      		pop r17
 724 0042 0895      		ret
 725               		.cfi_endproc
 726               	.LFE112:
 727               		.size	lcdWrite, .-lcdWrite
 728               		.section	.text.lcdInit,"ax",@progbits
 729               	.global	lcdInit
 730               		.type	lcdInit, @function
 731               	lcdInit:
 732               	.LFB113:
 733               		.loc 2 524 0
 734               		.cfi_startproc
GAS LISTING /tmp/ccFZTQVh.s 			page 22


 735               	/* prologue: function */
 736               	/* frame size = 0 */
 737               	/* stack size = 0 */
 738               	.L__stack_usage = 0
 739               		.loc 2 525 0
 740 0000 60E0      		ldi r22,0
 741 0002 8091 0000 		lds r24,lcdModes
 742 0006 0E94 0000 		call lcdPrepare
 743               	.LVL66:
 744 000a 46E0      		ldi r20,lo8(6)
 745 000c 60E0      		ldi r22,lo8(lcdBuffer)
 746 000e 70E0      		ldi r23,hi8(lcdBuffer)
 747 0010 8091 0000 		lds r24,lcdAddress
 748 0014 0E94 0000 		call twiWrite
 749               	.LVL67:
 750 0018 85E0      		ldi r24,lo8(5)
 751 001a 90E0      		ldi r25,0
 752 001c 0E94 0000 		call time_delay16
 753               	.LVL68:
 754               		.loc 2 526 0
 755 0020 60E0      		ldi r22,0
 756 0022 8091 0000 		lds r24,lcdShows
 757 0026 0E94 0000 		call lcdPrepare
 758               	.LVL69:
 759 002a 46E0      		ldi r20,lo8(6)
 760 002c 60E0      		ldi r22,lo8(lcdBuffer)
 761 002e 70E0      		ldi r23,hi8(lcdBuffer)
 762 0030 8091 0000 		lds r24,lcdAddress
 763 0034 0E94 0000 		call twiWrite
 764               	.LVL70:
 765 0038 85E0      		ldi r24,lo8(5)
 766 003a 90E0      		ldi r25,0
 767 003c 0E94 0000 		call time_delay16
 768               	.LVL71:
 769               		.loc 2 527 0
 770 0040 60E0      		ldi r22,0
 771 0042 8091 0000 		lds r24,lcdShifts
 772 0046 0E94 0000 		call lcdPrepare
 773               	.LVL72:
 774 004a 46E0      		ldi r20,lo8(6)
 775 004c 60E0      		ldi r22,lo8(lcdBuffer)
 776 004e 70E0      		ldi r23,hi8(lcdBuffer)
 777 0050 8091 0000 		lds r24,lcdAddress
 778 0054 0E94 0000 		call twiWrite
 779               	.LVL73:
 780 0058 85E0      		ldi r24,lo8(5)
 781 005a 90E0      		ldi r25,0
 782 005c 0E94 0000 		call time_delay16
 783               	.LVL74:
 784               		.loc 2 528 0
 785 0060 60E0      		ldi r22,0
 786 0062 81E0      		ldi r24,lo8(1)
 787 0064 0E94 0000 		call lcdPrepare
 788               	.LVL75:
 789 0068 46E0      		ldi r20,lo8(6)
 790 006a 60E0      		ldi r22,lo8(lcdBuffer)
 791 006c 70E0      		ldi r23,hi8(lcdBuffer)
GAS LISTING /tmp/ccFZTQVh.s 			page 23


 792 006e 8091 0000 		lds r24,lcdAddress
 793 0072 0E94 0000 		call twiWrite
 794               	.LVL76:
 795 0076 85E0      		ldi r24,lo8(5)
 796 0078 90E0      		ldi r25,0
 797 007a 0E94 0000 		call time_delay16
 798               	.LVL77:
 799 007e 80E1      		ldi r24,lo8(16)
 800 0080 90E0      		ldi r25,0
 801 0082 0E94 0000 		call time_delay16
 802               	.LVL78:
 803               		.loc 2 529 0
 804 0086 60E0      		ldi r22,0
 805 0088 82E0      		ldi r24,lo8(2)
 806 008a 0E94 0000 		call lcdPrepare
 807               	.LVL79:
 808 008e 46E0      		ldi r20,lo8(6)
 809 0090 60E0      		ldi r22,lo8(lcdBuffer)
 810 0092 70E0      		ldi r23,hi8(lcdBuffer)
 811 0094 8091 0000 		lds r24,lcdAddress
 812 0098 0E94 0000 		call twiWrite
 813               	.LVL80:
 814 009c 85E0      		ldi r24,lo8(5)
 815 009e 90E0      		ldi r25,0
 816 00a0 0C94 0000 		jmp time_delay16
 817               	.LVL81:
 818               		.cfi_endproc
 819               	.LFE113:
 820               		.size	lcdInit, .-lcdInit
 821               		.section	.text.lcdSetup,"ax",@progbits
 822               	.global	lcdSetup
 823               		.type	lcdSetup, @function
 824               	lcdSetup:
 825               	.LFB114:
 826               		.loc 2 536 0
 827               		.cfi_startproc
 828               	.LVL82:
 829 0000 CF93      		push r28
 830               	.LCFI23:
 831               		.cfi_def_cfa_offset 4
 832               		.cfi_offset 28, -3
 833               	/* prologue: function */
 834               	/* frame size = 0 */
 835               	/* stack size = 1 */
 836               	.L__stack_usage = 1
 837 0002 C42F      		mov r28,r20
 838               		.loc 2 537 0
 839 0004 8093 0000 		sts lcdAddress,r24
 840               		.loc 2 538 0
 841 0008 6093 0000 		sts lcdCols,r22
 842               		.loc 2 539 0
 843 000c 4093 0000 		sts lcdRows,r20
 844               		.loc 2 540 0
 845 0010 2223      		tst r18
 846 0012 01F0      		breq .L67
 847 0014 88E0      		ldi r24,lo8(8)
 848               	.LVL83:
GAS LISTING /tmp/ccFZTQVh.s 			page 24


 849 0016 00C0      		rjmp .L65
 850               	.LVL84:
 851               	.L67:
 852 0018 80E0      		ldi r24,0
 853               	.LVL85:
 854               	.L65:
 855               		.loc 2 540 0 is_stmt 0 discriminator 3
 856 001a 8093 0000 		sts lcdBackLight,r24
 857               		.loc 2 541 0 is_stmt 1 discriminator 3
 858 001e 80E2      		ldi r24,lo8(32)
 859 0020 8093 0000 		sts lcdModes,r24
 860               		.loc 2 542 0 discriminator 3
 861 0024 86E0      		ldi r24,lo8(6)
 862 0026 8093 0000 		sts lcdShifts,r24
 863               		.loc 2 543 0 discriminator 3
 864 002a 8CE0      		ldi r24,lo8(12)
 865 002c 8093 0000 		sts lcdShows,r24
 866               		.loc 2 547 0 discriminator 3
 867 0030 46E0      		ldi r20,lo8(6)
 868               	.LVL86:
 869 0032 60EA      		ldi r22,lo8(-96)
 870 0034 76E8      		ldi r23,lo8(-122)
 871 0036 81E0      		ldi r24,lo8(1)
 872 0038 90E0      		ldi r25,0
 873               	.LVL87:
 874 003a 0E94 0000 		call twiSetup
 875               	.LVL88:
 876               		.loc 2 551 0 discriminator 3
 877 003e C230      		cpi r28,lo8(2)
 878 0040 00F0      		brlo .L66
 879               		.loc 2 551 0 is_stmt 0 discriminator 1
 880 0042 8091 0000 		lds r24,lcdModes
 881 0046 8860      		ori r24,lo8(8)
 882 0048 8093 0000 		sts lcdModes,r24
 883               	.L66:
 884               		.loc 2 555 0 is_stmt 1
 885 004c 60E0      		ldi r22,0
 886 004e 80E3      		ldi r24,lo8(48)
 887 0050 0E94 0000 		call lcdPrepare
 888               	.LVL89:
 889               		.loc 2 557 0
 890 0054 8FE0      		ldi r24,lo8(15)
 891 0056 90E0      		ldi r25,0
 892 0058 0E94 0000 		call time_delay16
 893               	.LVL90:
 894               		.loc 2 558 0
 895 005c 43E0      		ldi r20,lo8(3)
 896 005e 60E0      		ldi r22,lo8(lcdBuffer)
 897 0060 70E0      		ldi r23,hi8(lcdBuffer)
 898 0062 8091 0000 		lds r24,lcdAddress
 899 0066 0E94 0000 		call twiWrite
 900               	.LVL91:
 901 006a 85E0      		ldi r24,lo8(5)
 902 006c 90E0      		ldi r25,0
 903 006e 0E94 0000 		call time_delay16
 904               	.LVL92:
 905               		.loc 2 559 0
GAS LISTING /tmp/ccFZTQVh.s 			page 25


 906 0072 85E0      		ldi r24,lo8(5)
 907 0074 90E0      		ldi r25,0
 908 0076 0E94 0000 		call time_delay16
 909               	.LVL93:
 910               		.loc 2 560 0
 911 007a 43E0      		ldi r20,lo8(3)
 912 007c 60E0      		ldi r22,lo8(lcdBuffer)
 913 007e 70E0      		ldi r23,hi8(lcdBuffer)
 914 0080 8091 0000 		lds r24,lcdAddress
 915 0084 0E94 0000 		call twiWrite
 916               	.LVL94:
 917 0088 85E0      		ldi r24,lo8(5)
 918 008a 90E0      		ldi r25,0
 919 008c 0E94 0000 		call time_delay16
 920               	.LVL95:
 921               		.loc 2 561 0
 922 0090 80E9      		ldi r24,lo8(-112)
 923 0092 91E0      		ldi r25,lo8(1)
 924               	/* #APP */
 925               	 ;  561 "LCD1602ex.ino" 1
 926 0094 0197      		1: sbiw r24,1 
 927 0096 01F4      		brne 1b
 928               		
 929               	 ;  0 "" 2
 930               		.loc 2 562 0
 931               	/* #NOAPP */
 932 0098 43E0      		ldi r20,lo8(3)
 933 009a 60E0      		ldi r22,lo8(lcdBuffer)
 934 009c 70E0      		ldi r23,hi8(lcdBuffer)
 935 009e 8091 0000 		lds r24,lcdAddress
 936 00a2 0E94 0000 		call twiWrite
 937               	.LVL96:
 938 00a6 85E0      		ldi r24,lo8(5)
 939 00a8 90E0      		ldi r25,0
 940 00aa 0E94 0000 		call time_delay16
 941               	.LVL97:
 942               		.loc 2 564 0
 943 00ae 60E0      		ldi r22,0
 944 00b0 80E2      		ldi r24,lo8(32)
 945 00b2 0E94 0000 		call lcdPrepare
 946               	.LVL98:
 947               		.loc 2 565 0
 948 00b6 43E0      		ldi r20,lo8(3)
 949 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 950 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 951 00bc 8091 0000 		lds r24,lcdAddress
 952 00c0 0E94 0000 		call twiWrite
 953               	.LVL99:
 954 00c4 85E0      		ldi r24,lo8(5)
 955 00c6 90E0      		ldi r25,0
 956 00c8 0E94 0000 		call time_delay16
 957               	.LVL100:
 958               		.loc 2 567 0
 959 00cc 0E94 0000 		call lcdInit
 960               	.LVL101:
 961               		.loc 2 568 0
 962 00d0 84EF      		ldi r24,lo8(-12)
GAS LISTING /tmp/ccFZTQVh.s 			page 26


 963 00d2 91E0      		ldi r25,lo8(1)
 964               	/* epilogue start */
 965               		.loc 2 569 0
 966 00d4 CF91      		pop r28
 967               	.LVL102:
 968               		.loc 2 568 0
 969 00d6 0C94 0000 		jmp time_delay16
 970               	.LVL103:
 971               		.cfi_endproc
 972               	.LFE114:
 973               		.size	lcdSetup, .-lcdSetup
 974               		.section	.rodata.str1.1,"aMS",@progbits,1
 975               	.LC0:
 976 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 976      6F2C 2041 
 976      4141 4141 
 976      4100 
 977               		.section	.text.setup,"ax",@progbits
 978               	.global	setup
 979               		.type	setup, @function
 980               	setup:
 981               	.LFB115:
 982               		.loc 2 577 0
 983               		.cfi_startproc
 984               	/* prologue: function */
 985               	/* frame size = 0 */
 986               	/* stack size = 0 */
 987               	.L__stack_usage = 0
 988               	.LBB6:
 989               		.loc 2 581 0
 990 0000 21E0      		ldi r18,lo8(1)
 991 0002 42E0      		ldi r20,lo8(2)
 992 0004 60E1      		ldi r22,lo8(16)
 993 0006 87E2      		ldi r24,lo8(39)
 994 0008 0E94 0000 		call lcdSetup
 995               	.LVL104:
 996               		.loc 2 582 0
 997 000c 6DE0      		ldi r22,lo8(13)
 998 000e 80E0      		ldi r24,lo8(.LC0)
 999 0010 90E0      		ldi r25,hi8(.LC0)
 1000 0012 0C94 0000 		jmp lcdWrite
 1001               	.LVL105:
 1002               	.LBE6:
 1003               		.cfi_endproc
 1004               	.LFE115:
 1005               		.size	setup, .-setup
 1006               		.section	.text.loop,"ax",@progbits
 1007               	.global	loop
 1008               		.type	loop, @function
 1009               	loop:
 1010               	.LFB116:
 1011               		.loc 2 588 0
 1012               		.cfi_startproc
 1013               	/* prologue: function */
 1014               	/* frame size = 0 */
 1015               	/* stack size = 0 */
 1016               	.L__stack_usage = 0
GAS LISTING /tmp/ccFZTQVh.s 			page 27


 1017 0000 0895      		ret
 1018               		.cfi_endproc
 1019               	.LFE116:
 1020               		.size	loop, .-loop
 1021               	.global	lcdBuffer
 1022               		.section	.bss.lcdBuffer,"aw",@nobits
 1023               		.type	lcdBuffer, @object
 1024               		.size	lcdBuffer, 6
 1025               	lcdBuffer:
 1026 0000 0000 0000 		.zero	6
 1026      0000 
 1027               	.global	lcdRows
 1028               		.section	.data.lcdRows,"aw",@progbits
 1029               		.type	lcdRows, @object
 1030               		.size	lcdRows, 1
 1031               	lcdRows:
 1032 0000 02        		.byte	2
 1033               	.global	lcdCols
 1034               		.section	.data.lcdCols,"aw",@progbits
 1035               		.type	lcdCols, @object
 1036               		.size	lcdCols, 1
 1037               	lcdCols:
 1038 0000 10        		.byte	16
 1039               	.global	lcdAddress
 1040               		.section	.data.lcdAddress,"aw",@progbits
 1041               		.type	lcdAddress, @object
 1042               		.size	lcdAddress, 1
 1043               	lcdAddress:
 1044 0000 27        		.byte	39
 1045               	.global	lcdBackLight
 1046               		.section	.data.lcdBackLight,"aw",@progbits
 1047               		.type	lcdBackLight, @object
 1048               		.size	lcdBackLight, 1
 1049               	lcdBackLight:
 1050 0000 08        		.byte	8
 1051               	.global	lcdShows
 1052               		.section	.data.lcdShows,"aw",@progbits
 1053               		.type	lcdShows, @object
 1054               		.size	lcdShows, 1
 1055               	lcdShows:
 1056 0000 08        		.byte	8
 1057               	.global	lcdShifts
 1058               		.section	.data.lcdShifts,"aw",@progbits
 1059               		.type	lcdShifts, @object
 1060               		.size	lcdShifts, 1
 1061               	lcdShifts:
 1062 0000 06        		.byte	6
 1063               	.global	lcdModes
 1064               		.section	.data.lcdModes,"aw",@progbits
 1065               		.type	lcdModes, @object
 1066               		.size	lcdModes, 1
 1067               	lcdModes:
 1068 0000 30        		.byte	48
 1069               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 1070               		.type	_ZL12twiStatistic, @object
 1071               		.size	_ZL12twiStatistic, 20
 1072               	_ZL12twiStatistic:
GAS LISTING /tmp/ccFZTQVh.s 			page 28


 1073 0000 0000 0000 		.zero	20
 1073      0000 0000 
 1073      0000 0000 
 1073      0000 0000 
 1073      0000 0000 
 1074               	.global	twiSlaveWriter
 1075               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1076               		.type	twiSlaveWriter, @object
 1077               		.size	twiSlaveWriter, 2
 1078               	twiSlaveWriter:
 1079 0000 0000      		.zero	2
 1080               	.global	twiSlaveReader
 1081               		.section	.bss.twiSlaveReader,"aw",@nobits
 1082               		.type	twiSlaveReader, @object
 1083               		.size	twiSlaveReader, 2
 1084               	twiSlaveReader:
 1085 0000 0000      		.zero	2
 1086               	.global	twiMasterReader
 1087               		.section	.bss.twiMasterReader,"aw",@nobits
 1088               		.type	twiMasterReader, @object
 1089               		.size	twiMasterReader, 2
 1090               	twiMasterReader:
 1091 0000 0000      		.zero	2
 1092               	.global	twiHookRestart
 1093               		.section	.bss.twiHookRestart,"aw",@nobits
 1094               		.type	twiHookRestart, @object
 1095               		.size	twiHookRestart, 2
 1096               	twiHookRestart:
 1097 0000 0000      		.zero	2
 1098               	.global	twiST_Ptr
 1099               		.section	.bss.twiST_Ptr,"aw",@nobits
 1100               		.type	twiST_Ptr, @object
 1101               		.size	twiST_Ptr, 2
 1102               	twiST_Ptr:
 1103 0000 0000      		.zero	2
 1104               	.global	twiST_Count
 1105               		.section	.bss.twiST_Count,"aw",@nobits
 1106               		.type	twiST_Count, @object
 1107               		.size	twiST_Count, 1
 1108               	twiST_Count:
 1109 0000 00        		.zero	1
 1110               	.global	twiRX_Ptr
 1111               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1112               		.type	twiRX_Ptr, @object
 1113               		.size	twiRX_Ptr, 2
 1114               	twiRX_Ptr:
 1115 0000 0000      		.zero	2
 1116               	.global	twiRX_Count
 1117               		.section	.bss.twiRX_Count,"aw",@nobits
 1118               		.type	twiRX_Count, @object
 1119               		.size	twiRX_Count, 1
 1120               	twiRX_Count:
 1121 0000 00        		.zero	1
 1122               	.global	twiMT_Ptr
 1123               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1124               		.type	twiMT_Ptr, @object
 1125               		.size	twiMT_Ptr, 2
GAS LISTING /tmp/ccFZTQVh.s 			page 29


 1126               	twiMT_Ptr:
 1127 0000 0000      		.zero	2
 1128               	.global	twiMT_Count
 1129               		.section	.bss.twiMT_Count,"aw",@nobits
 1130               		.type	twiMT_Count, @object
 1131               		.size	twiMT_Count, 1
 1132               	twiMT_Count:
 1133 0000 00        		.zero	1
 1134               	.global	twiSLARW
 1135               		.section	.bss.twiSLARW,"aw",@nobits
 1136               		.type	twiSLARW, @object
 1137               		.size	twiSLARW, 1
 1138               	twiSLARW:
 1139 0000 00        		.zero	1
 1140               	.global	twiState
 1141               		.section	.bss.twiState,"aw",@nobits
 1142               		.type	twiState, @object
 1143               		.size	twiState, 1
 1144               	twiState:
 1145 0000 00        		.zero	1
 1146               	.global	twiMode
 1147               		.section	.bss.twiMode,"aw",@nobits
 1148               		.type	twiMode, @object
 1149               		.size	twiMode, 1
 1150               	twiMode:
 1151 0000 00        		.zero	1
 1152               		.text
 1153               	.Letext0:
 1154               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1155               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1156               		.section	.debug_info,"",@progbits
 1157               	.Ldebug_info0:
 1158 0000 260B 0000 		.long	0xb26
 1159 0004 0200      		.word	0x2
 1160 0006 0000 0000 		.long	.Ldebug_abbrev0
 1161 000a 04        		.byte	0x4
 1162 000b 01        		.uleb128 0x1
 1163 000c 0000 0000 		.long	.LASF77
 1164 0010 04        		.byte	0x4
 1165 0011 0000 0000 		.long	.LASF78
 1166 0015 0000 0000 		.long	.LASF79
 1167 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1168 001d 0000 0000 		.long	0
 1169 0021 0000 0000 		.long	0
 1170 0025 0000 0000 		.long	.Ldebug_line0
 1171 0029 02        		.uleb128 0x2
 1172 002a 01        		.byte	0x1
 1173 002b 06        		.byte	0x6
 1174 002c 0000 0000 		.long	.LASF0
 1175 0030 03        		.uleb128 0x3
 1176 0031 0000 0000 		.long	.LASF2
 1177 0035 03        		.byte	0x3
 1178 0036 7A        		.byte	0x7a
 1179 0037 3B00 0000 		.long	0x3b
 1180 003b 02        		.uleb128 0x2
 1181 003c 01        		.byte	0x1
 1182 003d 08        		.byte	0x8
GAS LISTING /tmp/ccFZTQVh.s 			page 30


 1183 003e 0000 0000 		.long	.LASF1
 1184 0042 04        		.uleb128 0x4
 1185 0043 02        		.byte	0x2
 1186 0044 05        		.byte	0x5
 1187 0045 696E 7400 		.string	"int"
 1188 0049 03        		.uleb128 0x3
 1189 004a 0000 0000 		.long	.LASF3
 1190 004e 03        		.byte	0x3
 1191 004f 7C        		.byte	0x7c
 1192 0050 5400 0000 		.long	0x54
 1193 0054 02        		.uleb128 0x2
 1194 0055 02        		.byte	0x2
 1195 0056 07        		.byte	0x7
 1196 0057 0000 0000 		.long	.LASF4
 1197 005b 02        		.uleb128 0x2
 1198 005c 04        		.byte	0x4
 1199 005d 05        		.byte	0x5
 1200 005e 0000 0000 		.long	.LASF5
 1201 0062 03        		.uleb128 0x3
 1202 0063 0000 0000 		.long	.LASF6
 1203 0067 03        		.byte	0x3
 1204 0068 7E        		.byte	0x7e
 1205 0069 6D00 0000 		.long	0x6d
 1206 006d 02        		.uleb128 0x2
 1207 006e 04        		.byte	0x4
 1208 006f 07        		.byte	0x7
 1209 0070 0000 0000 		.long	.LASF7
 1210 0074 02        		.uleb128 0x2
 1211 0075 08        		.byte	0x8
 1212 0076 05        		.byte	0x5
 1213 0077 0000 0000 		.long	.LASF8
 1214 007b 02        		.uleb128 0x2
 1215 007c 08        		.byte	0x8
 1216 007d 07        		.byte	0x7
 1217 007e 0000 0000 		.long	.LASF9
 1218 0082 02        		.uleb128 0x2
 1219 0083 01        		.byte	0x1
 1220 0084 02        		.byte	0x2
 1221 0085 0000 0000 		.long	.LASF10
 1222 0089 05        		.uleb128 0x5
 1223 008a 02        		.byte	0x2
 1224 008b 8F00 0000 		.long	0x8f
 1225 008f 06        		.uleb128 0x6
 1226 0090 02        		.uleb128 0x2
 1227 0091 01        		.byte	0x1
 1228 0092 06        		.byte	0x6
 1229 0093 0000 0000 		.long	.LASF11
 1230 0097 02        		.uleb128 0x2
 1231 0098 04        		.byte	0x4
 1232 0099 04        		.byte	0x4
 1233 009a 0000 0000 		.long	.LASF12
 1234 009e 02        		.uleb128 0x2
 1235 009f 04        		.byte	0x4
 1236 00a0 04        		.byte	0x4
 1237 00a1 0000 0000 		.long	.LASF13
 1238 00a5 02        		.uleb128 0x2
 1239 00a6 02        		.byte	0x2
GAS LISTING /tmp/ccFZTQVh.s 			page 31


 1240 00a7 07        		.byte	0x7
 1241 00a8 0000 0000 		.long	.LASF14
 1242 00ac 07        		.uleb128 0x7
 1243 00ad 0000 0000 		.long	.LASF80
 1244 00b1 02        		.byte	0x2
 1245 00b2 01        		.byte	0x1
 1246 00b3 8C        		.byte	0x8c
 1247 00b4 CB00 0000 		.long	0xcb
 1248 00b8 08        		.uleb128 0x8
 1249 00b9 0000 0000 		.long	.LASF15
 1250 00bd 01        		.sleb128 1
 1251 00be 08        		.uleb128 0x8
 1252 00bf 0000 0000 		.long	.LASF16
 1253 00c3 02        		.sleb128 2
 1254 00c4 08        		.uleb128 0x8
 1255 00c5 0000 0000 		.long	.LASF17
 1256 00c9 04        		.sleb128 4
 1257 00ca 00        		.byte	0
 1258 00cb 09        		.uleb128 0x9
 1259 00cc 14        		.byte	0x14
 1260 00cd 01        		.byte	0x1
 1261 00ce A6        		.byte	0xa6
 1262 00cf 0000 0000 		.long	.LASF81
 1263 00d3 6401 0000 		.long	0x164
 1264 00d7 0A        		.uleb128 0xa
 1265 00d8 0000 0000 		.long	.LASF18
 1266 00dc 01        		.byte	0x1
 1267 00dd A7        		.byte	0xa7
 1268 00de 4900 0000 		.long	0x49
 1269 00e2 02        		.byte	0x2
 1270 00e3 23        		.byte	0x23
 1271 00e4 00        		.uleb128 0
 1272 00e5 0A        		.uleb128 0xa
 1273 00e6 0000 0000 		.long	.LASF19
 1274 00ea 01        		.byte	0x1
 1275 00eb A7        		.byte	0xa7
 1276 00ec 4900 0000 		.long	0x49
 1277 00f0 02        		.byte	0x2
 1278 00f1 23        		.byte	0x23
 1279 00f2 02        		.uleb128 0x2
 1280 00f3 0A        		.uleb128 0xa
 1281 00f4 0000 0000 		.long	.LASF20
 1282 00f8 01        		.byte	0x1
 1283 00f9 A7        		.byte	0xa7
 1284 00fa 4900 0000 		.long	0x49
 1285 00fe 02        		.byte	0x2
 1286 00ff 23        		.byte	0x23
 1287 0100 04        		.uleb128 0x4
 1288 0101 0A        		.uleb128 0xa
 1289 0102 0000 0000 		.long	.LASF21
 1290 0106 01        		.byte	0x1
 1291 0107 A7        		.byte	0xa7
 1292 0108 4900 0000 		.long	0x49
 1293 010c 02        		.byte	0x2
 1294 010d 23        		.byte	0x23
 1295 010e 06        		.uleb128 0x6
 1296 010f 0A        		.uleb128 0xa
GAS LISTING /tmp/ccFZTQVh.s 			page 32


 1297 0110 0000 0000 		.long	.LASF22
 1298 0114 01        		.byte	0x1
 1299 0115 A7        		.byte	0xa7
 1300 0116 4900 0000 		.long	0x49
 1301 011a 02        		.byte	0x2
 1302 011b 23        		.byte	0x23
 1303 011c 08        		.uleb128 0x8
 1304 011d 0B        		.uleb128 0xb
 1305 011e 6D74 7800 		.string	"mtx"
 1306 0122 01        		.byte	0x1
 1307 0123 A7        		.byte	0xa7
 1308 0124 4900 0000 		.long	0x49
 1309 0128 02        		.byte	0x2
 1310 0129 23        		.byte	0x23
 1311 012a 0A        		.uleb128 0xa
 1312 012b 0B        		.uleb128 0xb
 1313 012c 6D72 7800 		.string	"mrx"
 1314 0130 01        		.byte	0x1
 1315 0131 A7        		.byte	0xa7
 1316 0132 4900 0000 		.long	0x49
 1317 0136 02        		.byte	0x2
 1318 0137 23        		.byte	0x23
 1319 0138 0C        		.uleb128 0xc
 1320 0139 0B        		.uleb128 0xb
 1321 013a 7372 7800 		.string	"srx"
 1322 013e 01        		.byte	0x1
 1323 013f A7        		.byte	0xa7
 1324 0140 4900 0000 		.long	0x49
 1325 0144 02        		.byte	0x2
 1326 0145 23        		.byte	0x23
 1327 0146 0E        		.uleb128 0xe
 1328 0147 0B        		.uleb128 0xb
 1329 0148 6772 7800 		.string	"grx"
 1330 014c 01        		.byte	0x1
 1331 014d A7        		.byte	0xa7
 1332 014e 4900 0000 		.long	0x49
 1333 0152 02        		.byte	0x2
 1334 0153 23        		.byte	0x23
 1335 0154 10        		.uleb128 0x10
 1336 0155 0B        		.uleb128 0xb
 1337 0156 7374 7800 		.string	"stx"
 1338 015a 01        		.byte	0x1
 1339 015b A7        		.byte	0xa7
 1340 015c 4900 0000 		.long	0x49
 1341 0160 02        		.byte	0x2
 1342 0161 23        		.byte	0x23
 1343 0162 12        		.uleb128 0x12
 1344 0163 00        		.byte	0
 1345 0164 03        		.uleb128 0x3
 1346 0165 0000 0000 		.long	.LASF23
 1347 0169 01        		.byte	0x1
 1348 016a A8        		.byte	0xa8
 1349 016b CB00 0000 		.long	0xcb
 1350 016f 05        		.uleb128 0x5
 1351 0170 02        		.byte	0x2
 1352 0171 3000 0000 		.long	0x30
 1353 0175 0C        		.uleb128 0xc
GAS LISTING /tmp/ccFZTQVh.s 			page 33


 1354 0176 01        		.byte	0x1
 1355 0177 0000 0000 		.long	.LASF26
 1356 017b 01        		.byte	0x1
 1357 017c B7        		.byte	0xb7
 1358 017d 0000 0000 		.long	.LFB102
 1359 0181 0000 0000 		.long	.LFE102
 1360 0185 03        		.byte	0x3
 1361 0186 92        		.byte	0x92
 1362 0187 20        		.uleb128 0x20
 1363 0188 03        		.sleb128 3
 1364 0189 01        		.byte	0x1
 1365 018a C901 0000 		.long	0x1c9
 1366 018e 0D        		.uleb128 0xd
 1367 018f 0000 0000 		.long	.LASF28
 1368 0193 01        		.byte	0x1
 1369 0194 B7        		.byte	0xb7
 1370 0195 6200 0000 		.long	0x62
 1371 0199 0000 0000 		.long	.LLST0
 1372 019d 0E        		.uleb128 0xe
 1373 019e 0000 0000 		.long	.LBB2
 1374 01a2 0000 0000 		.long	.LBE2
 1375 01a6 0F        		.uleb128 0xf
 1376 01a7 0000 0000 		.long	.LASF24
 1377 01ab 01        		.byte	0x1
 1378 01ac B9        		.byte	0xb9
 1379 01ad 4900 0000 		.long	0x49
 1380 01b1 06        		.byte	0x6
 1381 01b2 62        		.byte	0x62
 1382 01b3 93        		.byte	0x93
 1383 01b4 01        		.uleb128 0x1
 1384 01b5 63        		.byte	0x63
 1385 01b6 93        		.byte	0x93
 1386 01b7 01        		.uleb128 0x1
 1387 01b8 10        		.uleb128 0x10
 1388 01b9 0000 0000 		.long	.LASF25
 1389 01bd 01        		.byte	0x1
 1390 01be BA        		.byte	0xba
 1391 01bf 3000 0000 		.long	0x30
 1392 01c3 0000 0000 		.long	.LLST1
 1393 01c7 00        		.byte	0
 1394 01c8 00        		.byte	0
 1395 01c9 11        		.uleb128 0x11
 1396 01ca 01        		.byte	0x1
 1397 01cb 0000 0000 		.long	.LASF27
 1398 01cf 01        		.byte	0x1
 1399 01d0 C8        		.byte	0xc8
 1400 01d1 0000 0000 		.long	.LFB103
 1401 01d5 0000 0000 		.long	.LFE103
 1402 01d9 0000 0000 		.long	.LLST2
 1403 01dd 01        		.byte	0x1
 1404 01de 1D02 0000 		.long	0x21d
 1405 01e2 0D        		.uleb128 0xd
 1406 01e3 0000 0000 		.long	.LASF28
 1407 01e7 01        		.byte	0x1
 1408 01e8 C8        		.byte	0xc8
 1409 01e9 6200 0000 		.long	0x62
 1410 01ed 0000 0000 		.long	.LLST3
GAS LISTING /tmp/ccFZTQVh.s 			page 34


 1411 01f1 0D        		.uleb128 0xd
 1412 01f2 0000 0000 		.long	.LASF29
 1413 01f6 01        		.byte	0x1
 1414 01f7 C8        		.byte	0xc8
 1415 01f8 3000 0000 		.long	0x30
 1416 01fc 0000 0000 		.long	.LLST4
 1417 0200 12        		.uleb128 0x12
 1418 0201 0000 0000 		.long	.LVL10
 1419 0205 7501 0000 		.long	0x175
 1420 0209 13        		.uleb128 0x13
 1421 020a 0C        		.byte	0xc
 1422 020b 66        		.byte	0x66
 1423 020c 93        		.byte	0x93
 1424 020d 01        		.uleb128 0x1
 1425 020e 67        		.byte	0x67
 1426 020f 93        		.byte	0x93
 1427 0210 01        		.uleb128 0x1
 1428 0211 68        		.byte	0x68
 1429 0212 93        		.byte	0x93
 1430 0213 01        		.uleb128 0x1
 1431 0214 69        		.byte	0x69
 1432 0215 93        		.byte	0x93
 1433 0216 01        		.uleb128 0x1
 1434 0217 03        		.byte	0x3
 1435 0218 F3        		.byte	0xf3
 1436 0219 01        		.uleb128 0x1
 1437 021a 66        		.byte	0x66
 1438 021b 00        		.byte	0
 1439 021c 00        		.byte	0
 1440 021d 14        		.uleb128 0x14
 1441 021e 01        		.byte	0x1
 1442 021f 0000 0000 		.long	.LASF30
 1443 0223 01        		.byte	0x1
 1444 0224 EF        		.byte	0xef
 1445 0225 0000 0000 		.long	.LFB104
 1446 0229 0000 0000 		.long	.LFE104
 1447 022d 0000 0000 		.long	.LLST5
 1448 0231 01        		.byte	0x1
 1449 0232 4602 0000 		.long	0x246
 1450 0236 15        		.uleb128 0x15
 1451 0237 5F6D 6400 		.string	"_md"
 1452 023b 01        		.byte	0x1
 1453 023c EF        		.byte	0xef
 1454 023d 3000 0000 		.long	0x30
 1455 0241 0000 0000 		.long	.LLST6
 1456 0245 00        		.byte	0
 1457 0246 16        		.uleb128 0x16
 1458 0247 01        		.byte	0x1
 1459 0248 0000 0000 		.long	.LASF31
 1460 024c 01        		.byte	0x1
 1461 024d 0401      		.word	0x104
 1462 024f 0000 0000 		.long	.LFB105
 1463 0253 0000 0000 		.long	.LFE105
 1464 0257 0000 0000 		.long	.LLST7
 1465 025b 01        		.byte	0x1
 1466 025c A402 0000 		.long	0x2a4
 1467 0260 0E        		.uleb128 0xe
GAS LISTING /tmp/ccFZTQVh.s 			page 35


 1468 0261 0000 0000 		.long	.LBB3
 1469 0265 0000 0000 		.long	.LBE3
 1470 0269 17        		.uleb128 0x17
 1471 026a 5F63 7200 		.string	"_cr"
 1472 026e 01        		.byte	0x1
 1473 026f 0601      		.word	0x106
 1474 0271 3000 0000 		.long	0x30
 1475 0275 0000 0000 		.long	.LLST8
 1476 0279 17        		.uleb128 0x17
 1477 027a 5F6D 6400 		.string	"_md"
 1478 027e 01        		.byte	0x1
 1479 027f 0701      		.word	0x107
 1480 0281 3000 0000 		.long	0x30
 1481 0285 0000 0000 		.long	.LLST9
 1482 0289 17        		.uleb128 0x17
 1483 028a 5F73 7400 		.string	"_st"
 1484 028e 01        		.byte	0x1
 1485 028f 0801      		.word	0x108
 1486 0291 3000 0000 		.long	0x30
 1487 0295 0000 0000 		.long	.LLST10
 1488 0299 18        		.uleb128 0x18
 1489 029a 0000 0000 		.long	.LVL25
 1490 029e 1D02 0000 		.long	0x21d
 1491 02a2 00        		.byte	0
 1492 02a3 00        		.byte	0
 1493 02a4 19        		.uleb128 0x19
 1494 02a5 01        		.byte	0x1
 1495 02a6 0000 0000 		.long	.LASF32
 1496 02aa 01        		.byte	0x1
 1497 02ab 8F01      		.word	0x18f
 1498 02ad 0000 0000 		.long	.LFB106
 1499 02b1 0000 0000 		.long	.LFE106
 1500 02b5 03        		.byte	0x3
 1501 02b6 92        		.byte	0x92
 1502 02b7 20        		.uleb128 0x20
 1503 02b8 03        		.sleb128 3
 1504 02b9 01        		.byte	0x1
 1505 02ba CF02 0000 		.long	0x2cf
 1506 02be 1A        		.uleb128 0x1a
 1507 02bf 0000 0000 		.long	.LASF33
 1508 02c3 01        		.byte	0x1
 1509 02c4 8F01      		.word	0x18f
 1510 02c6 3000 0000 		.long	0x30
 1511 02ca 0000 0000 		.long	.LLST11
 1512 02ce 00        		.byte	0
 1513 02cf 19        		.uleb128 0x19
 1514 02d0 01        		.byte	0x1
 1515 02d1 0000 0000 		.long	.LASF34
 1516 02d5 01        		.byte	0x1
 1517 02d6 9B01      		.word	0x19b
 1518 02d8 0000 0000 		.long	.LFB107
 1519 02dc 0000 0000 		.long	.LFE107
 1520 02e0 03        		.byte	0x3
 1521 02e1 92        		.byte	0x92
 1522 02e2 20        		.uleb128 0x20
 1523 02e3 03        		.sleb128 3
 1524 02e4 01        		.byte	0x1
GAS LISTING /tmp/ccFZTQVh.s 			page 36


 1525 02e5 FA02 0000 		.long	0x2fa
 1526 02e9 1A        		.uleb128 0x1a
 1527 02ea 0000 0000 		.long	.LASF33
 1528 02ee 01        		.byte	0x1
 1529 02ef 9B01      		.word	0x19b
 1530 02f1 3000 0000 		.long	0x30
 1531 02f5 0000 0000 		.long	.LLST12
 1532 02f9 00        		.byte	0
 1533 02fa 19        		.uleb128 0x19
 1534 02fb 01        		.byte	0x1
 1535 02fc 0000 0000 		.long	.LASF35
 1536 0300 01        		.byte	0x1
 1537 0301 AD01      		.word	0x1ad
 1538 0303 0000 0000 		.long	.LFB108
 1539 0307 0000 0000 		.long	.LFE108
 1540 030b 03        		.byte	0x3
 1541 030c 92        		.byte	0x92
 1542 030d 20        		.uleb128 0x20
 1543 030e 03        		.sleb128 3
 1544 030f 01        		.byte	0x1
 1545 0310 5903 0000 		.long	0x359
 1546 0314 1A        		.uleb128 0x1a
 1547 0315 0000 0000 		.long	.LASF33
 1548 0319 01        		.byte	0x1
 1549 031a AD01      		.word	0x1ad
 1550 031c 3000 0000 		.long	0x30
 1551 0320 0000 0000 		.long	.LLST13
 1552 0324 1A        		.uleb128 0x1a
 1553 0325 0000 0000 		.long	.LASF36
 1554 0329 01        		.byte	0x1
 1555 032a AD01      		.word	0x1ad
 1556 032c 5903 0000 		.long	0x359
 1557 0330 0000 0000 		.long	.LLST14
 1558 0334 1A        		.uleb128 0x1a
 1559 0335 0000 0000 		.long	.LASF37
 1560 0339 01        		.byte	0x1
 1561 033a AD01      		.word	0x1ad
 1562 033c 3000 0000 		.long	0x30
 1563 0340 0000 0000 		.long	.LLST15
 1564 0344 1B        		.uleb128 0x1b
 1565 0345 0000 0000 		.long	.LVL39
 1566 0349 01        		.byte	0x1
 1567 034a A402 0000 		.long	0x2a4
 1568 034e 13        		.uleb128 0x13
 1569 034f 01        		.byte	0x1
 1570 0350 68        		.byte	0x68
 1571 0351 05        		.byte	0x5
 1572 0352 F3        		.byte	0xf3
 1573 0353 01        		.uleb128 0x1
 1574 0354 68        		.byte	0x68
 1575 0355 31        		.byte	0x31
 1576 0356 24        		.byte	0x24
 1577 0357 00        		.byte	0
 1578 0358 00        		.byte	0
 1579 0359 05        		.uleb128 0x5
 1580 035a 02        		.byte	0x2
 1581 035b 5F03 0000 		.long	0x35f
GAS LISTING /tmp/ccFZTQVh.s 			page 37


 1582 035f 1C        		.uleb128 0x1c
 1583 0360 3000 0000 		.long	0x30
 1584 0364 19        		.uleb128 0x19
 1585 0365 01        		.byte	0x1
 1586 0366 0000 0000 		.long	.LASF38
 1587 036a 01        		.byte	0x1
 1588 036b B701      		.word	0x1b7
 1589 036d 0000 0000 		.long	.LFB109
 1590 0371 0000 0000 		.long	.LFE109
 1591 0375 03        		.byte	0x3
 1592 0376 92        		.byte	0x92
 1593 0377 20        		.uleb128 0x20
 1594 0378 03        		.sleb128 3
 1595 0379 01        		.byte	0x1
 1596 037a C503 0000 		.long	0x3c5
 1597 037e 1A        		.uleb128 0x1a
 1598 037f 0000 0000 		.long	.LASF33
 1599 0383 01        		.byte	0x1
 1600 0384 B701      		.word	0x1b7
 1601 0386 3000 0000 		.long	0x30
 1602 038a 0000 0000 		.long	.LLST16
 1603 038e 1A        		.uleb128 0x1a
 1604 038f 0000 0000 		.long	.LASF36
 1605 0393 01        		.byte	0x1
 1606 0394 B701      		.word	0x1b7
 1607 0396 6F01 0000 		.long	0x16f
 1608 039a 0000 0000 		.long	.LLST17
 1609 039e 1A        		.uleb128 0x1a
 1610 039f 0000 0000 		.long	.LASF37
 1611 03a3 01        		.byte	0x1
 1612 03a4 B701      		.word	0x1b7
 1613 03a6 3000 0000 		.long	0x30
 1614 03aa 0000 0000 		.long	.LLST18
 1615 03ae 1B        		.uleb128 0x1b
 1616 03af 0000 0000 		.long	.LVL42
 1617 03b3 01        		.byte	0x1
 1618 03b4 A402 0000 		.long	0x2a4
 1619 03b8 13        		.uleb128 0x13
 1620 03b9 01        		.byte	0x1
 1621 03ba 68        		.byte	0x68
 1622 03bb 07        		.byte	0x7
 1623 03bc F3        		.byte	0xf3
 1624 03bd 01        		.uleb128 0x1
 1625 03be 68        		.byte	0x68
 1626 03bf 31        		.byte	0x31
 1627 03c0 24        		.byte	0x24
 1628 03c1 31        		.byte	0x31
 1629 03c2 21        		.byte	0x21
 1630 03c3 00        		.byte	0
 1631 03c4 00        		.byte	0
 1632 03c5 1D        		.uleb128 0x1d
 1633 03c6 01        		.byte	0x1
 1634 03c7 0000 0000 		.long	.LASF39
 1635 03cb 01        		.byte	0x1
 1636 03cc C201      		.word	0x1c2
 1637 03ce 0000 0000 		.long	.LFB110
 1638 03d2 0000 0000 		.long	.LFE110
GAS LISTING /tmp/ccFZTQVh.s 			page 38


 1639 03d6 0000 0000 		.long	.LLST19
 1640 03da 01        		.byte	0x1
 1641 03db 3404 0000 		.long	0x434
 1642 03df 1A        		.uleb128 0x1a
 1643 03e0 0000 0000 		.long	.LASF33
 1644 03e4 01        		.byte	0x1
 1645 03e5 C201      		.word	0x1c2
 1646 03e7 3000 0000 		.long	0x30
 1647 03eb 0000 0000 		.long	.LLST20
 1648 03ef 1E        		.uleb128 0x1e
 1649 03f0 0000 0000 		.long	.LASF40
 1650 03f4 01        		.byte	0x1
 1651 03f5 C301      		.word	0x1c3
 1652 03f7 6F01 0000 		.long	0x16f
 1653 03fb 06        		.byte	0x6
 1654 03fc 66        		.byte	0x66
 1655 03fd 93        		.byte	0x93
 1656 03fe 01        		.uleb128 0x1
 1657 03ff 67        		.byte	0x67
 1658 0400 93        		.byte	0x93
 1659 0401 01        		.uleb128 0x1
 1660 0402 1E        		.uleb128 0x1e
 1661 0403 0000 0000 		.long	.LASF41
 1662 0407 01        		.byte	0x1
 1663 0408 C301      		.word	0x1c3
 1664 040a 3000 0000 		.long	0x30
 1665 040e 01        		.byte	0x1
 1666 040f 64        		.byte	0x64
 1667 0410 1E        		.uleb128 0x1e
 1668 0411 0000 0000 		.long	.LASF36
 1669 0415 01        		.byte	0x1
 1670 0416 C401      		.word	0x1c4
 1671 0418 6F01 0000 		.long	0x16f
 1672 041c 06        		.byte	0x6
 1673 041d 62        		.byte	0x62
 1674 041e 93        		.byte	0x93
 1675 041f 01        		.uleb128 0x1
 1676 0420 63        		.byte	0x63
 1677 0421 93        		.byte	0x93
 1678 0422 01        		.uleb128 0x1
 1679 0423 1A        		.uleb128 0x1a
 1680 0424 0000 0000 		.long	.LASF42
 1681 0428 01        		.byte	0x1
 1682 0429 C401      		.word	0x1c4
 1683 042b 3000 0000 		.long	0x30
 1684 042f 0000 0000 		.long	.LLST21
 1685 0433 00        		.byte	0
 1686 0434 19        		.uleb128 0x19
 1687 0435 01        		.byte	0x1
 1688 0436 0000 0000 		.long	.LASF43
 1689 043a 02        		.byte	0x2
 1690 043b E901      		.word	0x1e9
 1691 043d 0000 0000 		.long	.LFB111
 1692 0441 0000 0000 		.long	.LFE111
 1693 0445 03        		.byte	0x3
 1694 0446 92        		.byte	0x92
 1695 0447 20        		.uleb128 0x20
GAS LISTING /tmp/ccFZTQVh.s 			page 39


 1696 0448 03        		.sleb128 3
 1697 0449 01        		.byte	0x1
 1698 044a 8704 0000 		.long	0x487
 1699 044e 1A        		.uleb128 0x1a
 1700 044f 0000 0000 		.long	.LASF44
 1701 0453 02        		.byte	0x2
 1702 0454 E901      		.word	0x1e9
 1703 0456 3000 0000 		.long	0x30
 1704 045a 0000 0000 		.long	.LLST22
 1705 045e 1F        		.uleb128 0x1f
 1706 045f 5F72 7300 		.string	"_rs"
 1707 0463 02        		.byte	0x2
 1708 0464 E901      		.word	0x1e9
 1709 0466 3000 0000 		.long	0x30
 1710 046a 01        		.byte	0x1
 1711 046b 66        		.byte	0x66
 1712 046c 0E        		.uleb128 0xe
 1713 046d 0000 0000 		.long	.LBB4
 1714 0471 0000 0000 		.long	.LBE4
 1715 0475 20        		.uleb128 0x20
 1716 0476 0000 0000 		.long	.LASF45
 1717 047a 02        		.byte	0x2
 1718 047b EB01      		.word	0x1eb
 1719 047d 3000 0000 		.long	0x30
 1720 0481 0000 0000 		.long	.LLST23
 1721 0485 00        		.byte	0
 1722 0486 00        		.byte	0
 1723 0487 1D        		.uleb128 0x1d
 1724 0488 01        		.byte	0x1
 1725 0489 0000 0000 		.long	.LASF46
 1726 048d 02        		.byte	0x2
 1727 048e FE01      		.word	0x1fe
 1728 0490 0000 0000 		.long	.LFB112
 1729 0494 0000 0000 		.long	.LFE112
 1730 0498 0000 0000 		.long	.LLST24
 1731 049c 01        		.byte	0x1
 1732 049d 3205 0000 		.long	0x532
 1733 04a1 21        		.uleb128 0x21
 1734 04a2 6275 6600 		.string	"buf"
 1735 04a6 02        		.byte	0x2
 1736 04a7 FE01      		.word	0x1fe
 1737 04a9 8900 0000 		.long	0x89
 1738 04ad 0000 0000 		.long	.LLST25
 1739 04b1 21        		.uleb128 0x21
 1740 04b2 6C65 6E00 		.string	"len"
 1741 04b6 02        		.byte	0x2
 1742 04b7 FE01      		.word	0x1fe
 1743 04b9 3000 0000 		.long	0x30
 1744 04bd 0000 0000 		.long	.LLST26
 1745 04c1 0E        		.uleb128 0xe
 1746 04c2 0000 0000 		.long	.LBB5
 1747 04c6 0000 0000 		.long	.LBE5
 1748 04ca 17        		.uleb128 0x17
 1749 04cb 5F62 00   		.string	"_b"
 1750 04ce 02        		.byte	0x2
 1751 04cf 0002      		.word	0x200
 1752 04d1 6F01 0000 		.long	0x16f
GAS LISTING /tmp/ccFZTQVh.s 			page 40


 1753 04d5 0000 0000 		.long	.LLST27
 1754 04d9 17        		.uleb128 0x17
 1755 04da 5F6C 00   		.string	"_l"
 1756 04dd 02        		.byte	0x2
 1757 04de 0102      		.word	0x201
 1758 04e0 3000 0000 		.long	0x30
 1759 04e4 0000 0000 		.long	.LLST28
 1760 04e8 22        		.uleb128 0x22
 1761 04e9 0000 0000 		.long	.LVL61
 1762 04ed 3404 0000 		.long	0x434
 1763 04f1 FB04 0000 		.long	0x4fb
 1764 04f5 13        		.uleb128 0x13
 1765 04f6 01        		.byte	0x1
 1766 04f7 66        		.byte	0x66
 1767 04f8 01        		.byte	0x1
 1768 04f9 31        		.byte	0x31
 1769 04fa 00        		.byte	0
 1770 04fb 22        		.uleb128 0x22
 1771 04fc 0000 0000 		.long	.LVL62
 1772 0500 FA02 0000 		.long	0x2fa
 1773 0504 1C05 0000 		.long	0x51c
 1774 0508 13        		.uleb128 0x13
 1775 0509 06        		.byte	0x6
 1776 050a 66        		.byte	0x66
 1777 050b 93        		.byte	0x93
 1778 050c 01        		.uleb128 0x1
 1779 050d 67        		.byte	0x67
 1780 050e 93        		.byte	0x93
 1781 050f 01        		.uleb128 0x1
 1782 0510 05        		.byte	0x5
 1783 0511 03        		.byte	0x3
 1784 0512 0000 0000 		.long	lcdBuffer
 1785 0516 13        		.uleb128 0x13
 1786 0517 01        		.byte	0x1
 1787 0518 64        		.byte	0x64
 1788 0519 01        		.byte	0x1
 1789 051a 36        		.byte	0x36
 1790 051b 00        		.byte	0
 1791 051c 12        		.uleb128 0x12
 1792 051d 0000 0000 		.long	.LVL63
 1793 0521 190B 0000 		.long	0xb19
 1794 0525 13        		.uleb128 0x13
 1795 0526 06        		.byte	0x6
 1796 0527 68        		.byte	0x68
 1797 0528 93        		.byte	0x93
 1798 0529 01        		.uleb128 0x1
 1799 052a 69        		.byte	0x69
 1800 052b 93        		.byte	0x93
 1801 052c 01        		.uleb128 0x1
 1802 052d 01        		.byte	0x1
 1803 052e 35        		.byte	0x35
 1804 052f 00        		.byte	0
 1805 0530 00        		.byte	0
 1806 0531 00        		.byte	0
 1807 0532 19        		.uleb128 0x19
 1808 0533 01        		.byte	0x1
 1809 0534 0000 0000 		.long	.LASF47
GAS LISTING /tmp/ccFZTQVh.s 			page 41


 1810 0538 02        		.byte	0x2
 1811 0539 0B02      		.word	0x20b
 1812 053b 0000 0000 		.long	.LFB113
 1813 053f 0000 0000 		.long	.LFE113
 1814 0543 03        		.byte	0x3
 1815 0544 92        		.byte	0x92
 1816 0545 20        		.uleb128 0x20
 1817 0546 03        		.sleb128 3
 1818 0547 01        		.byte	0x1
 1819 0548 E806 0000 		.long	0x6e8
 1820 054c 22        		.uleb128 0x22
 1821 054d 0000 0000 		.long	.LVL66
 1822 0551 3404 0000 		.long	0x434
 1823 0555 5F05 0000 		.long	0x55f
 1824 0559 13        		.uleb128 0x13
 1825 055a 01        		.byte	0x1
 1826 055b 66        		.byte	0x66
 1827 055c 01        		.byte	0x1
 1828 055d 30        		.byte	0x30
 1829 055e 00        		.byte	0
 1830 055f 22        		.uleb128 0x22
 1831 0560 0000 0000 		.long	.LVL67
 1832 0564 FA02 0000 		.long	0x2fa
 1833 0568 8005 0000 		.long	0x580
 1834 056c 13        		.uleb128 0x13
 1835 056d 06        		.byte	0x6
 1836 056e 66        		.byte	0x66
 1837 056f 93        		.byte	0x93
 1838 0570 01        		.uleb128 0x1
 1839 0571 67        		.byte	0x67
 1840 0572 93        		.byte	0x93
 1841 0573 01        		.uleb128 0x1
 1842 0574 05        		.byte	0x5
 1843 0575 03        		.byte	0x3
 1844 0576 0000 0000 		.long	lcdBuffer
 1845 057a 13        		.uleb128 0x13
 1846 057b 01        		.byte	0x1
 1847 057c 64        		.byte	0x64
 1848 057d 01        		.byte	0x1
 1849 057e 36        		.byte	0x36
 1850 057f 00        		.byte	0
 1851 0580 22        		.uleb128 0x22
 1852 0581 0000 0000 		.long	.LVL68
 1853 0585 190B 0000 		.long	0xb19
 1854 0589 9805 0000 		.long	0x598
 1855 058d 13        		.uleb128 0x13
 1856 058e 06        		.byte	0x6
 1857 058f 68        		.byte	0x68
 1858 0590 93        		.byte	0x93
 1859 0591 01        		.uleb128 0x1
 1860 0592 69        		.byte	0x69
 1861 0593 93        		.byte	0x93
 1862 0594 01        		.uleb128 0x1
 1863 0595 01        		.byte	0x1
 1864 0596 35        		.byte	0x35
 1865 0597 00        		.byte	0
 1866 0598 22        		.uleb128 0x22
GAS LISTING /tmp/ccFZTQVh.s 			page 42


 1867 0599 0000 0000 		.long	.LVL69
 1868 059d 3404 0000 		.long	0x434
 1869 05a1 AB05 0000 		.long	0x5ab
 1870 05a5 13        		.uleb128 0x13
 1871 05a6 01        		.byte	0x1
 1872 05a7 66        		.byte	0x66
 1873 05a8 01        		.byte	0x1
 1874 05a9 30        		.byte	0x30
 1875 05aa 00        		.byte	0
 1876 05ab 22        		.uleb128 0x22
 1877 05ac 0000 0000 		.long	.LVL70
 1878 05b0 FA02 0000 		.long	0x2fa
 1879 05b4 CC05 0000 		.long	0x5cc
 1880 05b8 13        		.uleb128 0x13
 1881 05b9 06        		.byte	0x6
 1882 05ba 66        		.byte	0x66
 1883 05bb 93        		.byte	0x93
 1884 05bc 01        		.uleb128 0x1
 1885 05bd 67        		.byte	0x67
 1886 05be 93        		.byte	0x93
 1887 05bf 01        		.uleb128 0x1
 1888 05c0 05        		.byte	0x5
 1889 05c1 03        		.byte	0x3
 1890 05c2 0000 0000 		.long	lcdBuffer
 1891 05c6 13        		.uleb128 0x13
 1892 05c7 01        		.byte	0x1
 1893 05c8 64        		.byte	0x64
 1894 05c9 01        		.byte	0x1
 1895 05ca 36        		.byte	0x36
 1896 05cb 00        		.byte	0
 1897 05cc 22        		.uleb128 0x22
 1898 05cd 0000 0000 		.long	.LVL71
 1899 05d1 190B 0000 		.long	0xb19
 1900 05d5 E405 0000 		.long	0x5e4
 1901 05d9 13        		.uleb128 0x13
 1902 05da 06        		.byte	0x6
 1903 05db 68        		.byte	0x68
 1904 05dc 93        		.byte	0x93
 1905 05dd 01        		.uleb128 0x1
 1906 05de 69        		.byte	0x69
 1907 05df 93        		.byte	0x93
 1908 05e0 01        		.uleb128 0x1
 1909 05e1 01        		.byte	0x1
 1910 05e2 35        		.byte	0x35
 1911 05e3 00        		.byte	0
 1912 05e4 22        		.uleb128 0x22
 1913 05e5 0000 0000 		.long	.LVL72
 1914 05e9 3404 0000 		.long	0x434
 1915 05ed F705 0000 		.long	0x5f7
 1916 05f1 13        		.uleb128 0x13
 1917 05f2 01        		.byte	0x1
 1918 05f3 66        		.byte	0x66
 1919 05f4 01        		.byte	0x1
 1920 05f5 30        		.byte	0x30
 1921 05f6 00        		.byte	0
 1922 05f7 22        		.uleb128 0x22
 1923 05f8 0000 0000 		.long	.LVL73
GAS LISTING /tmp/ccFZTQVh.s 			page 43


 1924 05fc FA02 0000 		.long	0x2fa
 1925 0600 1806 0000 		.long	0x618
 1926 0604 13        		.uleb128 0x13
 1927 0605 06        		.byte	0x6
 1928 0606 66        		.byte	0x66
 1929 0607 93        		.byte	0x93
 1930 0608 01        		.uleb128 0x1
 1931 0609 67        		.byte	0x67
 1932 060a 93        		.byte	0x93
 1933 060b 01        		.uleb128 0x1
 1934 060c 05        		.byte	0x5
 1935 060d 03        		.byte	0x3
 1936 060e 0000 0000 		.long	lcdBuffer
 1937 0612 13        		.uleb128 0x13
 1938 0613 01        		.byte	0x1
 1939 0614 64        		.byte	0x64
 1940 0615 01        		.byte	0x1
 1941 0616 36        		.byte	0x36
 1942 0617 00        		.byte	0
 1943 0618 22        		.uleb128 0x22
 1944 0619 0000 0000 		.long	.LVL74
 1945 061d 190B 0000 		.long	0xb19
 1946 0621 3006 0000 		.long	0x630
 1947 0625 13        		.uleb128 0x13
 1948 0626 06        		.byte	0x6
 1949 0627 68        		.byte	0x68
 1950 0628 93        		.byte	0x93
 1951 0629 01        		.uleb128 0x1
 1952 062a 69        		.byte	0x69
 1953 062b 93        		.byte	0x93
 1954 062c 01        		.uleb128 0x1
 1955 062d 01        		.byte	0x1
 1956 062e 35        		.byte	0x35
 1957 062f 00        		.byte	0
 1958 0630 22        		.uleb128 0x22
 1959 0631 0000 0000 		.long	.LVL75
 1960 0635 3404 0000 		.long	0x434
 1961 0639 4806 0000 		.long	0x648
 1962 063d 13        		.uleb128 0x13
 1963 063e 01        		.byte	0x1
 1964 063f 68        		.byte	0x68
 1965 0640 01        		.byte	0x1
 1966 0641 31        		.byte	0x31
 1967 0642 13        		.uleb128 0x13
 1968 0643 01        		.byte	0x1
 1969 0644 66        		.byte	0x66
 1970 0645 01        		.byte	0x1
 1971 0646 30        		.byte	0x30
 1972 0647 00        		.byte	0
 1973 0648 22        		.uleb128 0x22
 1974 0649 0000 0000 		.long	.LVL76
 1975 064d FA02 0000 		.long	0x2fa
 1976 0651 6906 0000 		.long	0x669
 1977 0655 13        		.uleb128 0x13
 1978 0656 06        		.byte	0x6
 1979 0657 66        		.byte	0x66
 1980 0658 93        		.byte	0x93
GAS LISTING /tmp/ccFZTQVh.s 			page 44


 1981 0659 01        		.uleb128 0x1
 1982 065a 67        		.byte	0x67
 1983 065b 93        		.byte	0x93
 1984 065c 01        		.uleb128 0x1
 1985 065d 05        		.byte	0x5
 1986 065e 03        		.byte	0x3
 1987 065f 0000 0000 		.long	lcdBuffer
 1988 0663 13        		.uleb128 0x13
 1989 0664 01        		.byte	0x1
 1990 0665 64        		.byte	0x64
 1991 0666 01        		.byte	0x1
 1992 0667 36        		.byte	0x36
 1993 0668 00        		.byte	0
 1994 0669 22        		.uleb128 0x22
 1995 066a 0000 0000 		.long	.LVL77
 1996 066e 190B 0000 		.long	0xb19
 1997 0672 8106 0000 		.long	0x681
 1998 0676 13        		.uleb128 0x13
 1999 0677 06        		.byte	0x6
 2000 0678 68        		.byte	0x68
 2001 0679 93        		.byte	0x93
 2002 067a 01        		.uleb128 0x1
 2003 067b 69        		.byte	0x69
 2004 067c 93        		.byte	0x93
 2005 067d 01        		.uleb128 0x1
 2006 067e 01        		.byte	0x1
 2007 067f 35        		.byte	0x35
 2008 0680 00        		.byte	0
 2009 0681 22        		.uleb128 0x22
 2010 0682 0000 0000 		.long	.LVL78
 2011 0686 190B 0000 		.long	0xb19
 2012 068a 9906 0000 		.long	0x699
 2013 068e 13        		.uleb128 0x13
 2014 068f 06        		.byte	0x6
 2015 0690 68        		.byte	0x68
 2016 0691 93        		.byte	0x93
 2017 0692 01        		.uleb128 0x1
 2018 0693 69        		.byte	0x69
 2019 0694 93        		.byte	0x93
 2020 0695 01        		.uleb128 0x1
 2021 0696 01        		.byte	0x1
 2022 0697 40        		.byte	0x40
 2023 0698 00        		.byte	0
 2024 0699 22        		.uleb128 0x22
 2025 069a 0000 0000 		.long	.LVL79
 2026 069e 3404 0000 		.long	0x434
 2027 06a2 B106 0000 		.long	0x6b1
 2028 06a6 13        		.uleb128 0x13
 2029 06a7 01        		.byte	0x1
 2030 06a8 68        		.byte	0x68
 2031 06a9 01        		.byte	0x1
 2032 06aa 32        		.byte	0x32
 2033 06ab 13        		.uleb128 0x13
 2034 06ac 01        		.byte	0x1
 2035 06ad 66        		.byte	0x66
 2036 06ae 01        		.byte	0x1
 2037 06af 30        		.byte	0x30
GAS LISTING /tmp/ccFZTQVh.s 			page 45


 2038 06b0 00        		.byte	0
 2039 06b1 22        		.uleb128 0x22
 2040 06b2 0000 0000 		.long	.LVL80
 2041 06b6 FA02 0000 		.long	0x2fa
 2042 06ba D206 0000 		.long	0x6d2
 2043 06be 13        		.uleb128 0x13
 2044 06bf 06        		.byte	0x6
 2045 06c0 66        		.byte	0x66
 2046 06c1 93        		.byte	0x93
 2047 06c2 01        		.uleb128 0x1
 2048 06c3 67        		.byte	0x67
 2049 06c4 93        		.byte	0x93
 2050 06c5 01        		.uleb128 0x1
 2051 06c6 05        		.byte	0x5
 2052 06c7 03        		.byte	0x3
 2053 06c8 0000 0000 		.long	lcdBuffer
 2054 06cc 13        		.uleb128 0x13
 2055 06cd 01        		.byte	0x1
 2056 06ce 64        		.byte	0x64
 2057 06cf 01        		.byte	0x1
 2058 06d0 36        		.byte	0x36
 2059 06d1 00        		.byte	0
 2060 06d2 1B        		.uleb128 0x1b
 2061 06d3 0000 0000 		.long	.LVL81
 2062 06d7 01        		.byte	0x1
 2063 06d8 190B 0000 		.long	0xb19
 2064 06dc 13        		.uleb128 0x13
 2065 06dd 06        		.byte	0x6
 2066 06de 68        		.byte	0x68
 2067 06df 93        		.byte	0x93
 2068 06e0 01        		.uleb128 0x1
 2069 06e1 69        		.byte	0x69
 2070 06e2 93        		.byte	0x93
 2071 06e3 01        		.uleb128 0x1
 2072 06e4 01        		.byte	0x1
 2073 06e5 35        		.byte	0x35
 2074 06e6 00        		.byte	0
 2075 06e7 00        		.byte	0
 2076 06e8 1D        		.uleb128 0x1d
 2077 06e9 01        		.byte	0x1
 2078 06ea 0000 0000 		.long	.LASF48
 2079 06ee 02        		.byte	0x2
 2080 06ef 1702      		.word	0x217
 2081 06f1 0000 0000 		.long	.LFB114
 2082 06f5 0000 0000 		.long	.LFE114
 2083 06f9 0000 0000 		.long	.LLST29
 2084 06fd 01        		.byte	0x1
 2085 06fe D008 0000 		.long	0x8d0
 2086 0702 1A        		.uleb128 0x1a
 2087 0703 0000 0000 		.long	.LASF49
 2088 0707 02        		.byte	0x2
 2089 0708 1702      		.word	0x217
 2090 070a 3000 0000 		.long	0x30
 2091 070e 0000 0000 		.long	.LLST30
 2092 0712 1A        		.uleb128 0x1a
 2093 0713 0000 0000 		.long	.LASF50
 2094 0717 02        		.byte	0x2
GAS LISTING /tmp/ccFZTQVh.s 			page 46


 2095 0718 1702      		.word	0x217
 2096 071a 3000 0000 		.long	0x30
 2097 071e 0000 0000 		.long	.LLST31
 2098 0722 1A        		.uleb128 0x1a
 2099 0723 0000 0000 		.long	.LASF51
 2100 0727 02        		.byte	0x2
 2101 0728 1702      		.word	0x217
 2102 072a 3000 0000 		.long	0x30
 2103 072e 0000 0000 		.long	.LLST32
 2104 0732 1A        		.uleb128 0x1a
 2105 0733 0000 0000 		.long	.LASF52
 2106 0737 02        		.byte	0x2
 2107 0738 1702      		.word	0x217
 2108 073a 3000 0000 		.long	0x30
 2109 073e 0000 0000 		.long	.LLST33
 2110 0742 22        		.uleb128 0x22
 2111 0743 0000 0000 		.long	.LVL88
 2112 0747 C901 0000 		.long	0x1c9
 2113 074b 6907 0000 		.long	0x769
 2114 074f 13        		.uleb128 0x13
 2115 0750 0C        		.byte	0xc
 2116 0751 66        		.byte	0x66
 2117 0752 93        		.byte	0x93
 2118 0753 01        		.uleb128 0x1
 2119 0754 67        		.byte	0x67
 2120 0755 93        		.byte	0x93
 2121 0756 01        		.uleb128 0x1
 2122 0757 68        		.byte	0x68
 2123 0758 93        		.byte	0x93
 2124 0759 01        		.uleb128 0x1
 2125 075a 69        		.byte	0x69
 2126 075b 93        		.byte	0x93
 2127 075c 01        		.uleb128 0x1
 2128 075d 05        		.byte	0x5
 2129 075e 0C        		.byte	0xc
 2130 075f A086 0100 		.long	0x186a0
 2131 0763 13        		.uleb128 0x13
 2132 0764 01        		.byte	0x1
 2133 0765 64        		.byte	0x64
 2134 0766 01        		.byte	0x1
 2135 0767 36        		.byte	0x36
 2136 0768 00        		.byte	0
 2137 0769 22        		.uleb128 0x22
 2138 076a 0000 0000 		.long	.LVL89
 2139 076e 3404 0000 		.long	0x434
 2140 0772 8207 0000 		.long	0x782
 2141 0776 13        		.uleb128 0x13
 2142 0777 01        		.byte	0x1
 2143 0778 68        		.byte	0x68
 2144 0779 02        		.byte	0x2
 2145 077a 08        		.byte	0x8
 2146 077b 30        		.byte	0x30
 2147 077c 13        		.uleb128 0x13
 2148 077d 01        		.byte	0x1
 2149 077e 66        		.byte	0x66
 2150 077f 01        		.byte	0x1
 2151 0780 30        		.byte	0x30
GAS LISTING /tmp/ccFZTQVh.s 			page 47


 2152 0781 00        		.byte	0
 2153 0782 22        		.uleb128 0x22
 2154 0783 0000 0000 		.long	.LVL90
 2155 0787 190B 0000 		.long	0xb19
 2156 078b 9A07 0000 		.long	0x79a
 2157 078f 13        		.uleb128 0x13
 2158 0790 06        		.byte	0x6
 2159 0791 68        		.byte	0x68
 2160 0792 93        		.byte	0x93
 2161 0793 01        		.uleb128 0x1
 2162 0794 69        		.byte	0x69
 2163 0795 93        		.byte	0x93
 2164 0796 01        		.uleb128 0x1
 2165 0797 01        		.byte	0x1
 2166 0798 3F        		.byte	0x3f
 2167 0799 00        		.byte	0
 2168 079a 22        		.uleb128 0x22
 2169 079b 0000 0000 		.long	.LVL91
 2170 079f FA02 0000 		.long	0x2fa
 2171 07a3 BB07 0000 		.long	0x7bb
 2172 07a7 13        		.uleb128 0x13
 2173 07a8 06        		.byte	0x6
 2174 07a9 66        		.byte	0x66
 2175 07aa 93        		.byte	0x93
 2176 07ab 01        		.uleb128 0x1
 2177 07ac 67        		.byte	0x67
 2178 07ad 93        		.byte	0x93
 2179 07ae 01        		.uleb128 0x1
 2180 07af 05        		.byte	0x5
 2181 07b0 03        		.byte	0x3
 2182 07b1 0000 0000 		.long	lcdBuffer
 2183 07b5 13        		.uleb128 0x13
 2184 07b6 01        		.byte	0x1
 2185 07b7 64        		.byte	0x64
 2186 07b8 01        		.byte	0x1
 2187 07b9 33        		.byte	0x33
 2188 07ba 00        		.byte	0
 2189 07bb 22        		.uleb128 0x22
 2190 07bc 0000 0000 		.long	.LVL92
 2191 07c0 190B 0000 		.long	0xb19
 2192 07c4 D307 0000 		.long	0x7d3
 2193 07c8 13        		.uleb128 0x13
 2194 07c9 06        		.byte	0x6
 2195 07ca 68        		.byte	0x68
 2196 07cb 93        		.byte	0x93
 2197 07cc 01        		.uleb128 0x1
 2198 07cd 69        		.byte	0x69
 2199 07ce 93        		.byte	0x93
 2200 07cf 01        		.uleb128 0x1
 2201 07d0 01        		.byte	0x1
 2202 07d1 35        		.byte	0x35
 2203 07d2 00        		.byte	0
 2204 07d3 22        		.uleb128 0x22
 2205 07d4 0000 0000 		.long	.LVL93
 2206 07d8 190B 0000 		.long	0xb19
 2207 07dc EB07 0000 		.long	0x7eb
 2208 07e0 13        		.uleb128 0x13
GAS LISTING /tmp/ccFZTQVh.s 			page 48


 2209 07e1 06        		.byte	0x6
 2210 07e2 68        		.byte	0x68
 2211 07e3 93        		.byte	0x93
 2212 07e4 01        		.uleb128 0x1
 2213 07e5 69        		.byte	0x69
 2214 07e6 93        		.byte	0x93
 2215 07e7 01        		.uleb128 0x1
 2216 07e8 01        		.byte	0x1
 2217 07e9 35        		.byte	0x35
 2218 07ea 00        		.byte	0
 2219 07eb 22        		.uleb128 0x22
 2220 07ec 0000 0000 		.long	.LVL94
 2221 07f0 FA02 0000 		.long	0x2fa
 2222 07f4 0C08 0000 		.long	0x80c
 2223 07f8 13        		.uleb128 0x13
 2224 07f9 06        		.byte	0x6
 2225 07fa 66        		.byte	0x66
 2226 07fb 93        		.byte	0x93
 2227 07fc 01        		.uleb128 0x1
 2228 07fd 67        		.byte	0x67
 2229 07fe 93        		.byte	0x93
 2230 07ff 01        		.uleb128 0x1
 2231 0800 05        		.byte	0x5
 2232 0801 03        		.byte	0x3
 2233 0802 0000 0000 		.long	lcdBuffer
 2234 0806 13        		.uleb128 0x13
 2235 0807 01        		.byte	0x1
 2236 0808 64        		.byte	0x64
 2237 0809 01        		.byte	0x1
 2238 080a 33        		.byte	0x33
 2239 080b 00        		.byte	0
 2240 080c 22        		.uleb128 0x22
 2241 080d 0000 0000 		.long	.LVL95
 2242 0811 190B 0000 		.long	0xb19
 2243 0815 2408 0000 		.long	0x824
 2244 0819 13        		.uleb128 0x13
 2245 081a 06        		.byte	0x6
 2246 081b 68        		.byte	0x68
 2247 081c 93        		.byte	0x93
 2248 081d 01        		.uleb128 0x1
 2249 081e 69        		.byte	0x69
 2250 081f 93        		.byte	0x93
 2251 0820 01        		.uleb128 0x1
 2252 0821 01        		.byte	0x1
 2253 0822 35        		.byte	0x35
 2254 0823 00        		.byte	0
 2255 0824 22        		.uleb128 0x22
 2256 0825 0000 0000 		.long	.LVL96
 2257 0829 FA02 0000 		.long	0x2fa
 2258 082d 4508 0000 		.long	0x845
 2259 0831 13        		.uleb128 0x13
 2260 0832 06        		.byte	0x6
 2261 0833 66        		.byte	0x66
 2262 0834 93        		.byte	0x93
 2263 0835 01        		.uleb128 0x1
 2264 0836 67        		.byte	0x67
 2265 0837 93        		.byte	0x93
GAS LISTING /tmp/ccFZTQVh.s 			page 49


 2266 0838 01        		.uleb128 0x1
 2267 0839 05        		.byte	0x5
 2268 083a 03        		.byte	0x3
 2269 083b 0000 0000 		.long	lcdBuffer
 2270 083f 13        		.uleb128 0x13
 2271 0840 01        		.byte	0x1
 2272 0841 64        		.byte	0x64
 2273 0842 01        		.byte	0x1
 2274 0843 33        		.byte	0x33
 2275 0844 00        		.byte	0
 2276 0845 22        		.uleb128 0x22
 2277 0846 0000 0000 		.long	.LVL97
 2278 084a 190B 0000 		.long	0xb19
 2279 084e 5D08 0000 		.long	0x85d
 2280 0852 13        		.uleb128 0x13
 2281 0853 06        		.byte	0x6
 2282 0854 68        		.byte	0x68
 2283 0855 93        		.byte	0x93
 2284 0856 01        		.uleb128 0x1
 2285 0857 69        		.byte	0x69
 2286 0858 93        		.byte	0x93
 2287 0859 01        		.uleb128 0x1
 2288 085a 01        		.byte	0x1
 2289 085b 35        		.byte	0x35
 2290 085c 00        		.byte	0
 2291 085d 22        		.uleb128 0x22
 2292 085e 0000 0000 		.long	.LVL98
 2293 0862 3404 0000 		.long	0x434
 2294 0866 7608 0000 		.long	0x876
 2295 086a 13        		.uleb128 0x13
 2296 086b 01        		.byte	0x1
 2297 086c 68        		.byte	0x68
 2298 086d 02        		.byte	0x2
 2299 086e 08        		.byte	0x8
 2300 086f 20        		.byte	0x20
 2301 0870 13        		.uleb128 0x13
 2302 0871 01        		.byte	0x1
 2303 0872 66        		.byte	0x66
 2304 0873 01        		.byte	0x1
 2305 0874 30        		.byte	0x30
 2306 0875 00        		.byte	0
 2307 0876 22        		.uleb128 0x22
 2308 0877 0000 0000 		.long	.LVL99
 2309 087b FA02 0000 		.long	0x2fa
 2310 087f 9708 0000 		.long	0x897
 2311 0883 13        		.uleb128 0x13
 2312 0884 06        		.byte	0x6
 2313 0885 66        		.byte	0x66
 2314 0886 93        		.byte	0x93
 2315 0887 01        		.uleb128 0x1
 2316 0888 67        		.byte	0x67
 2317 0889 93        		.byte	0x93
 2318 088a 01        		.uleb128 0x1
 2319 088b 05        		.byte	0x5
 2320 088c 03        		.byte	0x3
 2321 088d 0000 0000 		.long	lcdBuffer
 2322 0891 13        		.uleb128 0x13
GAS LISTING /tmp/ccFZTQVh.s 			page 50


 2323 0892 01        		.byte	0x1
 2324 0893 64        		.byte	0x64
 2325 0894 01        		.byte	0x1
 2326 0895 33        		.byte	0x33
 2327 0896 00        		.byte	0
 2328 0897 22        		.uleb128 0x22
 2329 0898 0000 0000 		.long	.LVL100
 2330 089c 190B 0000 		.long	0xb19
 2331 08a0 AF08 0000 		.long	0x8af
 2332 08a4 13        		.uleb128 0x13
 2333 08a5 06        		.byte	0x6
 2334 08a6 68        		.byte	0x68
 2335 08a7 93        		.byte	0x93
 2336 08a8 01        		.uleb128 0x1
 2337 08a9 69        		.byte	0x69
 2338 08aa 93        		.byte	0x93
 2339 08ab 01        		.uleb128 0x1
 2340 08ac 01        		.byte	0x1
 2341 08ad 35        		.byte	0x35
 2342 08ae 00        		.byte	0
 2343 08af 18        		.uleb128 0x18
 2344 08b0 0000 0000 		.long	.LVL101
 2345 08b4 3205 0000 		.long	0x532
 2346 08b8 1B        		.uleb128 0x1b
 2347 08b9 0000 0000 		.long	.LVL103
 2348 08bd 01        		.byte	0x1
 2349 08be 190B 0000 		.long	0xb19
 2350 08c2 13        		.uleb128 0x13
 2351 08c3 06        		.byte	0x6
 2352 08c4 68        		.byte	0x68
 2353 08c5 93        		.byte	0x93
 2354 08c6 01        		.uleb128 0x1
 2355 08c7 69        		.byte	0x69
 2356 08c8 93        		.byte	0x93
 2357 08c9 01        		.uleb128 0x1
 2358 08ca 03        		.byte	0x3
 2359 08cb 0A        		.byte	0xa
 2360 08cc F401      		.word	0x1f4
 2361 08ce 00        		.byte	0
 2362 08cf 00        		.byte	0
 2363 08d0 19        		.uleb128 0x19
 2364 08d1 01        		.byte	0x1
 2365 08d2 0000 0000 		.long	.LASF53
 2366 08d6 02        		.byte	0x2
 2367 08d7 4102      		.word	0x241
 2368 08d9 0000 0000 		.long	.LFB115
 2369 08dd 0000 0000 		.long	.LFE115
 2370 08e1 03        		.byte	0x3
 2371 08e2 92        		.byte	0x92
 2372 08e3 20        		.uleb128 0x20
 2373 08e4 03        		.sleb128 3
 2374 08e5 01        		.byte	0x1
 2375 08e6 4209 0000 		.long	0x942
 2376 08ea 0E        		.uleb128 0xe
 2377 08eb 0000 0000 		.long	.LBB6
 2378 08ef 0000 0000 		.long	.LBE6
 2379 08f3 23        		.uleb128 0x23
GAS LISTING /tmp/ccFZTQVh.s 			page 51


 2380 08f4 0000 0000 		.long	.LASF82
 2381 08f8 02        		.byte	0x2
 2382 08f9 4202      		.word	0x242
 2383 08fb 4900 0000 		.long	0x49
 2384 08ff 22        		.uleb128 0x22
 2385 0900 0000 0000 		.long	.LVL104
 2386 0904 E806 0000 		.long	0x6e8
 2387 0908 2209 0000 		.long	0x922
 2388 090c 13        		.uleb128 0x13
 2389 090d 01        		.byte	0x1
 2390 090e 68        		.byte	0x68
 2391 090f 02        		.byte	0x2
 2392 0910 08        		.byte	0x8
 2393 0911 27        		.byte	0x27
 2394 0912 13        		.uleb128 0x13
 2395 0913 01        		.byte	0x1
 2396 0914 66        		.byte	0x66
 2397 0915 01        		.byte	0x1
 2398 0916 40        		.byte	0x40
 2399 0917 13        		.uleb128 0x13
 2400 0918 01        		.byte	0x1
 2401 0919 64        		.byte	0x64
 2402 091a 01        		.byte	0x1
 2403 091b 32        		.byte	0x32
 2404 091c 13        		.uleb128 0x13
 2405 091d 01        		.byte	0x1
 2406 091e 62        		.byte	0x62
 2407 091f 01        		.byte	0x1
 2408 0920 31        		.byte	0x31
 2409 0921 00        		.byte	0
 2410 0922 1B        		.uleb128 0x1b
 2411 0923 0000 0000 		.long	.LVL105
 2412 0927 01        		.byte	0x1
 2413 0928 8704 0000 		.long	0x487
 2414 092c 13        		.uleb128 0x13
 2415 092d 06        		.byte	0x6
 2416 092e 68        		.byte	0x68
 2417 092f 93        		.byte	0x93
 2418 0930 01        		.uleb128 0x1
 2419 0931 69        		.byte	0x69
 2420 0932 93        		.byte	0x93
 2421 0933 01        		.uleb128 0x1
 2422 0934 05        		.byte	0x5
 2423 0935 03        		.byte	0x3
 2424 0936 0000 0000 		.long	.LC0
 2425 093a 13        		.uleb128 0x13
 2426 093b 01        		.byte	0x1
 2427 093c 66        		.byte	0x66
 2428 093d 01        		.byte	0x1
 2429 093e 3D        		.byte	0x3d
 2430 093f 00        		.byte	0
 2431 0940 00        		.byte	0
 2432 0941 00        		.byte	0
 2433 0942 24        		.uleb128 0x24
 2434 0943 01        		.byte	0x1
 2435 0944 0000 0000 		.long	.LASF83
 2436 0948 02        		.byte	0x2
GAS LISTING /tmp/ccFZTQVh.s 			page 52


 2437 0949 4C02      		.word	0x24c
 2438 094b 0000 0000 		.long	.LFB116
 2439 094f 0000 0000 		.long	.LFE116
 2440 0953 03        		.byte	0x3
 2441 0954 92        		.byte	0x92
 2442 0955 20        		.uleb128 0x20
 2443 0956 03        		.sleb128 3
 2444 0957 01        		.byte	0x1
 2445 0958 25        		.uleb128 0x25
 2446 0959 0000 0000 		.long	.LASF54
 2447 095d 01        		.byte	0x1
 2448 095e 92        		.byte	0x92
 2449 095f 6A09 0000 		.long	0x96a
 2450 0963 01        		.byte	0x1
 2451 0964 05        		.byte	0x5
 2452 0965 03        		.byte	0x3
 2453 0966 0000 0000 		.long	twiMode
 2454 096a 26        		.uleb128 0x26
 2455 096b 3000 0000 		.long	0x30
 2456 096f 25        		.uleb128 0x25
 2457 0970 0000 0000 		.long	.LASF55
 2458 0974 01        		.byte	0x1
 2459 0975 93        		.byte	0x93
 2460 0976 6A09 0000 		.long	0x96a
 2461 097a 01        		.byte	0x1
 2462 097b 05        		.byte	0x5
 2463 097c 03        		.byte	0x3
 2464 097d 0000 0000 		.long	twiState
 2465 0981 25        		.uleb128 0x25
 2466 0982 0000 0000 		.long	.LASF56
 2467 0986 01        		.byte	0x1
 2468 0987 94        		.byte	0x94
 2469 0988 6A09 0000 		.long	0x96a
 2470 098c 01        		.byte	0x1
 2471 098d 05        		.byte	0x5
 2472 098e 03        		.byte	0x3
 2473 098f 0000 0000 		.long	twiSLARW
 2474 0993 25        		.uleb128 0x25
 2475 0994 0000 0000 		.long	.LASF57
 2476 0998 01        		.byte	0x1
 2477 0999 96        		.byte	0x96
 2478 099a 6A09 0000 		.long	0x96a
 2479 099e 01        		.byte	0x1
 2480 099f 05        		.byte	0x5
 2481 09a0 03        		.byte	0x3
 2482 09a1 0000 0000 		.long	twiMT_Count
 2483 09a5 25        		.uleb128 0x25
 2484 09a6 0000 0000 		.long	.LASF58
 2485 09aa 01        		.byte	0x1
 2486 09ab 97        		.byte	0x97
 2487 09ac B709 0000 		.long	0x9b7
 2488 09b0 01        		.byte	0x1
 2489 09b1 05        		.byte	0x5
 2490 09b2 03        		.byte	0x3
 2491 09b3 0000 0000 		.long	twiMT_Ptr
 2492 09b7 05        		.uleb128 0x5
 2493 09b8 02        		.byte	0x2
GAS LISTING /tmp/ccFZTQVh.s 			page 53


 2494 09b9 6A09 0000 		.long	0x96a
 2495 09bd 25        		.uleb128 0x25
 2496 09be 0000 0000 		.long	.LASF59
 2497 09c2 01        		.byte	0x1
 2498 09c3 99        		.byte	0x99
 2499 09c4 6A09 0000 		.long	0x96a
 2500 09c8 01        		.byte	0x1
 2501 09c9 05        		.byte	0x5
 2502 09ca 03        		.byte	0x3
 2503 09cb 0000 0000 		.long	twiRX_Count
 2504 09cf 25        		.uleb128 0x25
 2505 09d0 0000 0000 		.long	.LASF60
 2506 09d4 01        		.byte	0x1
 2507 09d5 9A        		.byte	0x9a
 2508 09d6 B709 0000 		.long	0x9b7
 2509 09da 01        		.byte	0x1
 2510 09db 05        		.byte	0x5
 2511 09dc 03        		.byte	0x3
 2512 09dd 0000 0000 		.long	twiRX_Ptr
 2513 09e1 25        		.uleb128 0x25
 2514 09e2 0000 0000 		.long	.LASF61
 2515 09e6 01        		.byte	0x1
 2516 09e7 9C        		.byte	0x9c
 2517 09e8 6A09 0000 		.long	0x96a
 2518 09ec 01        		.byte	0x1
 2519 09ed 05        		.byte	0x5
 2520 09ee 03        		.byte	0x3
 2521 09ef 0000 0000 		.long	twiST_Count
 2522 09f3 25        		.uleb128 0x25
 2523 09f4 0000 0000 		.long	.LASF62
 2524 09f8 01        		.byte	0x1
 2525 09f9 9D        		.byte	0x9d
 2526 09fa B709 0000 		.long	0x9b7
 2527 09fe 01        		.byte	0x1
 2528 09ff 05        		.byte	0x5
 2529 0a00 03        		.byte	0x3
 2530 0a01 0000 0000 		.long	twiST_Ptr
 2531 0a05 27        		.uleb128 0x27
 2532 0a06 25        		.uleb128 0x25
 2533 0a07 0000 0000 		.long	.LASF63
 2534 0a0b 01        		.byte	0x1
 2535 0a0c 9F        		.byte	0x9f
 2536 0a0d 180A 0000 		.long	0xa18
 2537 0a11 01        		.byte	0x1
 2538 0a12 05        		.byte	0x5
 2539 0a13 03        		.byte	0x3
 2540 0a14 0000 0000 		.long	twiHookRestart
 2541 0a18 05        		.uleb128 0x5
 2542 0a19 02        		.byte	0x2
 2543 0a1a 050A 0000 		.long	0xa05
 2544 0a1e 25        		.uleb128 0x25
 2545 0a1f 0000 0000 		.long	.LASF64
 2546 0a23 01        		.byte	0x1
 2547 0a24 A0        		.byte	0xa0
 2548 0a25 180A 0000 		.long	0xa18
 2549 0a29 01        		.byte	0x1
 2550 0a2a 05        		.byte	0x5
GAS LISTING /tmp/ccFZTQVh.s 			page 54


 2551 0a2b 03        		.byte	0x3
 2552 0a2c 0000 0000 		.long	twiMasterReader
 2553 0a30 25        		.uleb128 0x25
 2554 0a31 0000 0000 		.long	.LASF65
 2555 0a35 01        		.byte	0x1
 2556 0a36 A1        		.byte	0xa1
 2557 0a37 180A 0000 		.long	0xa18
 2558 0a3b 01        		.byte	0x1
 2559 0a3c 05        		.byte	0x5
 2560 0a3d 03        		.byte	0x3
 2561 0a3e 0000 0000 		.long	twiSlaveReader
 2562 0a42 25        		.uleb128 0x25
 2563 0a43 0000 0000 		.long	.LASF66
 2564 0a47 01        		.byte	0x1
 2565 0a48 A2        		.byte	0xa2
 2566 0a49 180A 0000 		.long	0xa18
 2567 0a4d 01        		.byte	0x1
 2568 0a4e 05        		.byte	0x5
 2569 0a4f 03        		.byte	0x3
 2570 0a50 0000 0000 		.long	twiSlaveWriter
 2571 0a54 0F        		.uleb128 0xf
 2572 0a55 0000 0000 		.long	.LASF67
 2573 0a59 01        		.byte	0x1
 2574 0a5a AA        		.byte	0xaa
 2575 0a5b 650A 0000 		.long	0xa65
 2576 0a5f 05        		.byte	0x5
 2577 0a60 03        		.byte	0x3
 2578 0a61 0000 0000 		.long	_ZL12twiStatistic
 2579 0a65 26        		.uleb128 0x26
 2580 0a66 6401 0000 		.long	0x164
 2581 0a6a 28        		.uleb128 0x28
 2582 0a6b 0000 0000 		.long	.LASF68
 2583 0a6f 02        		.byte	0x2
 2584 0a70 DB01      		.word	0x1db
 2585 0a72 3000 0000 		.long	0x30
 2586 0a76 01        		.byte	0x1
 2587 0a77 05        		.byte	0x5
 2588 0a78 03        		.byte	0x3
 2589 0a79 0000 0000 		.long	lcdModes
 2590 0a7d 28        		.uleb128 0x28
 2591 0a7e 0000 0000 		.long	.LASF69
 2592 0a82 02        		.byte	0x2
 2593 0a83 DC01      		.word	0x1dc
 2594 0a85 3000 0000 		.long	0x30
 2595 0a89 01        		.byte	0x1
 2596 0a8a 05        		.byte	0x5
 2597 0a8b 03        		.byte	0x3
 2598 0a8c 0000 0000 		.long	lcdShifts
 2599 0a90 28        		.uleb128 0x28
 2600 0a91 0000 0000 		.long	.LASF70
 2601 0a95 02        		.byte	0x2
 2602 0a96 DD01      		.word	0x1dd
 2603 0a98 3000 0000 		.long	0x30
 2604 0a9c 01        		.byte	0x1
 2605 0a9d 05        		.byte	0x5
 2606 0a9e 03        		.byte	0x3
 2607 0a9f 0000 0000 		.long	lcdShows
GAS LISTING /tmp/ccFZTQVh.s 			page 55


 2608 0aa3 28        		.uleb128 0x28
 2609 0aa4 0000 0000 		.long	.LASF71
 2610 0aa8 02        		.byte	0x2
 2611 0aa9 DE01      		.word	0x1de
 2612 0aab 3000 0000 		.long	0x30
 2613 0aaf 01        		.byte	0x1
 2614 0ab0 05        		.byte	0x5
 2615 0ab1 03        		.byte	0x3
 2616 0ab2 0000 0000 		.long	lcdBackLight
 2617 0ab6 28        		.uleb128 0x28
 2618 0ab7 0000 0000 		.long	.LASF72
 2619 0abb 02        		.byte	0x2
 2620 0abc E001      		.word	0x1e0
 2621 0abe 3000 0000 		.long	0x30
 2622 0ac2 01        		.byte	0x1
 2623 0ac3 05        		.byte	0x5
 2624 0ac4 03        		.byte	0x3
 2625 0ac5 0000 0000 		.long	lcdAddress
 2626 0ac9 28        		.uleb128 0x28
 2627 0aca 0000 0000 		.long	.LASF73
 2628 0ace 02        		.byte	0x2
 2629 0acf E101      		.word	0x1e1
 2630 0ad1 3000 0000 		.long	0x30
 2631 0ad5 01        		.byte	0x1
 2632 0ad6 05        		.byte	0x5
 2633 0ad7 03        		.byte	0x3
 2634 0ad8 0000 0000 		.long	lcdCols
 2635 0adc 28        		.uleb128 0x28
 2636 0add 0000 0000 		.long	.LASF74
 2637 0ae1 02        		.byte	0x2
 2638 0ae2 E201      		.word	0x1e2
 2639 0ae4 3000 0000 		.long	0x30
 2640 0ae8 01        		.byte	0x1
 2641 0ae9 05        		.byte	0x5
 2642 0aea 03        		.byte	0x3
 2643 0aeb 0000 0000 		.long	lcdRows
 2644 0aef 29        		.uleb128 0x29
 2645 0af0 3B00 0000 		.long	0x3b
 2646 0af4 FF0A 0000 		.long	0xaff
 2647 0af8 2A        		.uleb128 0x2a
 2648 0af9 FF0A 0000 		.long	0xaff
 2649 0afd 05        		.byte	0x5
 2650 0afe 00        		.byte	0
 2651 0aff 02        		.uleb128 0x2
 2652 0b00 02        		.byte	0x2
 2653 0b01 07        		.byte	0x7
 2654 0b02 0000 0000 		.long	.LASF75
 2655 0b06 28        		.uleb128 0x28
 2656 0b07 0000 0000 		.long	.LASF76
 2657 0b0b 02        		.byte	0x2
 2658 0b0c E301      		.word	0x1e3
 2659 0b0e EF0A 0000 		.long	0xaef
 2660 0b12 01        		.byte	0x1
 2661 0b13 05        		.byte	0x5
 2662 0b14 03        		.byte	0x3
 2663 0b15 0000 0000 		.long	lcdBuffer
 2664 0b19 2B        		.uleb128 0x2b
GAS LISTING /tmp/ccFZTQVh.s 			page 56


 2665 0b1a 01        		.byte	0x1
 2666 0b1b 0000 0000 		.long	.LASF84
 2667 0b1f 04        		.byte	0x4
 2668 0b20 E101      		.word	0x1e1
 2669 0b22 01        		.byte	0x1
 2670 0b23 2C        		.uleb128 0x2c
 2671 0b24 4900 0000 		.long	0x49
 2672 0b28 00        		.byte	0
 2673 0b29 00        		.byte	0
 2674               		.section	.debug_abbrev,"",@progbits
 2675               	.Ldebug_abbrev0:
 2676 0000 01        		.uleb128 0x1
 2677 0001 11        		.uleb128 0x11
 2678 0002 01        		.byte	0x1
 2679 0003 25        		.uleb128 0x25
 2680 0004 0E        		.uleb128 0xe
 2681 0005 13        		.uleb128 0x13
 2682 0006 0B        		.uleb128 0xb
 2683 0007 03        		.uleb128 0x3
 2684 0008 0E        		.uleb128 0xe
 2685 0009 1B        		.uleb128 0x1b
 2686 000a 0E        		.uleb128 0xe
 2687 000b 55        		.uleb128 0x55
 2688 000c 06        		.uleb128 0x6
 2689 000d 11        		.uleb128 0x11
 2690 000e 01        		.uleb128 0x1
 2691 000f 52        		.uleb128 0x52
 2692 0010 01        		.uleb128 0x1
 2693 0011 10        		.uleb128 0x10
 2694 0012 06        		.uleb128 0x6
 2695 0013 00        		.byte	0
 2696 0014 00        		.byte	0
 2697 0015 02        		.uleb128 0x2
 2698 0016 24        		.uleb128 0x24
 2699 0017 00        		.byte	0
 2700 0018 0B        		.uleb128 0xb
 2701 0019 0B        		.uleb128 0xb
 2702 001a 3E        		.uleb128 0x3e
 2703 001b 0B        		.uleb128 0xb
 2704 001c 03        		.uleb128 0x3
 2705 001d 0E        		.uleb128 0xe
 2706 001e 00        		.byte	0
 2707 001f 00        		.byte	0
 2708 0020 03        		.uleb128 0x3
 2709 0021 16        		.uleb128 0x16
 2710 0022 00        		.byte	0
 2711 0023 03        		.uleb128 0x3
 2712 0024 0E        		.uleb128 0xe
 2713 0025 3A        		.uleb128 0x3a
 2714 0026 0B        		.uleb128 0xb
 2715 0027 3B        		.uleb128 0x3b
 2716 0028 0B        		.uleb128 0xb
 2717 0029 49        		.uleb128 0x49
 2718 002a 13        		.uleb128 0x13
 2719 002b 00        		.byte	0
 2720 002c 00        		.byte	0
 2721 002d 04        		.uleb128 0x4
GAS LISTING /tmp/ccFZTQVh.s 			page 57


 2722 002e 24        		.uleb128 0x24
 2723 002f 00        		.byte	0
 2724 0030 0B        		.uleb128 0xb
 2725 0031 0B        		.uleb128 0xb
 2726 0032 3E        		.uleb128 0x3e
 2727 0033 0B        		.uleb128 0xb
 2728 0034 03        		.uleb128 0x3
 2729 0035 08        		.uleb128 0x8
 2730 0036 00        		.byte	0
 2731 0037 00        		.byte	0
 2732 0038 05        		.uleb128 0x5
 2733 0039 0F        		.uleb128 0xf
 2734 003a 00        		.byte	0
 2735 003b 0B        		.uleb128 0xb
 2736 003c 0B        		.uleb128 0xb
 2737 003d 49        		.uleb128 0x49
 2738 003e 13        		.uleb128 0x13
 2739 003f 00        		.byte	0
 2740 0040 00        		.byte	0
 2741 0041 06        		.uleb128 0x6
 2742 0042 26        		.uleb128 0x26
 2743 0043 00        		.byte	0
 2744 0044 00        		.byte	0
 2745 0045 00        		.byte	0
 2746 0046 07        		.uleb128 0x7
 2747 0047 04        		.uleb128 0x4
 2748 0048 01        		.byte	0x1
 2749 0049 03        		.uleb128 0x3
 2750 004a 0E        		.uleb128 0xe
 2751 004b 0B        		.uleb128 0xb
 2752 004c 0B        		.uleb128 0xb
 2753 004d 3A        		.uleb128 0x3a
 2754 004e 0B        		.uleb128 0xb
 2755 004f 3B        		.uleb128 0x3b
 2756 0050 0B        		.uleb128 0xb
 2757 0051 01        		.uleb128 0x1
 2758 0052 13        		.uleb128 0x13
 2759 0053 00        		.byte	0
 2760 0054 00        		.byte	0
 2761 0055 08        		.uleb128 0x8
 2762 0056 28        		.uleb128 0x28
 2763 0057 00        		.byte	0
 2764 0058 03        		.uleb128 0x3
 2765 0059 0E        		.uleb128 0xe
 2766 005a 1C        		.uleb128 0x1c
 2767 005b 0D        		.uleb128 0xd
 2768 005c 00        		.byte	0
 2769 005d 00        		.byte	0
 2770 005e 09        		.uleb128 0x9
 2771 005f 13        		.uleb128 0x13
 2772 0060 01        		.byte	0x1
 2773 0061 0B        		.uleb128 0xb
 2774 0062 0B        		.uleb128 0xb
 2775 0063 3A        		.uleb128 0x3a
 2776 0064 0B        		.uleb128 0xb
 2777 0065 3B        		.uleb128 0x3b
 2778 0066 0B        		.uleb128 0xb
GAS LISTING /tmp/ccFZTQVh.s 			page 58


 2779 0067 8740      		.uleb128 0x2007
 2780 0069 0E        		.uleb128 0xe
 2781 006a 01        		.uleb128 0x1
 2782 006b 13        		.uleb128 0x13
 2783 006c 00        		.byte	0
 2784 006d 00        		.byte	0
 2785 006e 0A        		.uleb128 0xa
 2786 006f 0D        		.uleb128 0xd
 2787 0070 00        		.byte	0
 2788 0071 03        		.uleb128 0x3
 2789 0072 0E        		.uleb128 0xe
 2790 0073 3A        		.uleb128 0x3a
 2791 0074 0B        		.uleb128 0xb
 2792 0075 3B        		.uleb128 0x3b
 2793 0076 0B        		.uleb128 0xb
 2794 0077 49        		.uleb128 0x49
 2795 0078 13        		.uleb128 0x13
 2796 0079 38        		.uleb128 0x38
 2797 007a 0A        		.uleb128 0xa
 2798 007b 00        		.byte	0
 2799 007c 00        		.byte	0
 2800 007d 0B        		.uleb128 0xb
 2801 007e 0D        		.uleb128 0xd
 2802 007f 00        		.byte	0
 2803 0080 03        		.uleb128 0x3
 2804 0081 08        		.uleb128 0x8
 2805 0082 3A        		.uleb128 0x3a
 2806 0083 0B        		.uleb128 0xb
 2807 0084 3B        		.uleb128 0x3b
 2808 0085 0B        		.uleb128 0xb
 2809 0086 49        		.uleb128 0x49
 2810 0087 13        		.uleb128 0x13
 2811 0088 38        		.uleb128 0x38
 2812 0089 0A        		.uleb128 0xa
 2813 008a 00        		.byte	0
 2814 008b 00        		.byte	0
 2815 008c 0C        		.uleb128 0xc
 2816 008d 2E        		.uleb128 0x2e
 2817 008e 01        		.byte	0x1
 2818 008f 3F        		.uleb128 0x3f
 2819 0090 0C        		.uleb128 0xc
 2820 0091 03        		.uleb128 0x3
 2821 0092 0E        		.uleb128 0xe
 2822 0093 3A        		.uleb128 0x3a
 2823 0094 0B        		.uleb128 0xb
 2824 0095 3B        		.uleb128 0x3b
 2825 0096 0B        		.uleb128 0xb
 2826 0097 11        		.uleb128 0x11
 2827 0098 01        		.uleb128 0x1
 2828 0099 12        		.uleb128 0x12
 2829 009a 01        		.uleb128 0x1
 2830 009b 40        		.uleb128 0x40
 2831 009c 0A        		.uleb128 0xa
 2832 009d 9742      		.uleb128 0x2117
 2833 009f 0C        		.uleb128 0xc
 2834 00a0 01        		.uleb128 0x1
 2835 00a1 13        		.uleb128 0x13
GAS LISTING /tmp/ccFZTQVh.s 			page 59


 2836 00a2 00        		.byte	0
 2837 00a3 00        		.byte	0
 2838 00a4 0D        		.uleb128 0xd
 2839 00a5 05        		.uleb128 0x5
 2840 00a6 00        		.byte	0
 2841 00a7 03        		.uleb128 0x3
 2842 00a8 0E        		.uleb128 0xe
 2843 00a9 3A        		.uleb128 0x3a
 2844 00aa 0B        		.uleb128 0xb
 2845 00ab 3B        		.uleb128 0x3b
 2846 00ac 0B        		.uleb128 0xb
 2847 00ad 49        		.uleb128 0x49
 2848 00ae 13        		.uleb128 0x13
 2849 00af 02        		.uleb128 0x2
 2850 00b0 06        		.uleb128 0x6
 2851 00b1 00        		.byte	0
 2852 00b2 00        		.byte	0
 2853 00b3 0E        		.uleb128 0xe
 2854 00b4 0B        		.uleb128 0xb
 2855 00b5 01        		.byte	0x1
 2856 00b6 11        		.uleb128 0x11
 2857 00b7 01        		.uleb128 0x1
 2858 00b8 12        		.uleb128 0x12
 2859 00b9 01        		.uleb128 0x1
 2860 00ba 00        		.byte	0
 2861 00bb 00        		.byte	0
 2862 00bc 0F        		.uleb128 0xf
 2863 00bd 34        		.uleb128 0x34
 2864 00be 00        		.byte	0
 2865 00bf 03        		.uleb128 0x3
 2866 00c0 0E        		.uleb128 0xe
 2867 00c1 3A        		.uleb128 0x3a
 2868 00c2 0B        		.uleb128 0xb
 2869 00c3 3B        		.uleb128 0x3b
 2870 00c4 0B        		.uleb128 0xb
 2871 00c5 49        		.uleb128 0x49
 2872 00c6 13        		.uleb128 0x13
 2873 00c7 02        		.uleb128 0x2
 2874 00c8 0A        		.uleb128 0xa
 2875 00c9 00        		.byte	0
 2876 00ca 00        		.byte	0
 2877 00cb 10        		.uleb128 0x10
 2878 00cc 34        		.uleb128 0x34
 2879 00cd 00        		.byte	0
 2880 00ce 03        		.uleb128 0x3
 2881 00cf 0E        		.uleb128 0xe
 2882 00d0 3A        		.uleb128 0x3a
 2883 00d1 0B        		.uleb128 0xb
 2884 00d2 3B        		.uleb128 0x3b
 2885 00d3 0B        		.uleb128 0xb
 2886 00d4 49        		.uleb128 0x49
 2887 00d5 13        		.uleb128 0x13
 2888 00d6 02        		.uleb128 0x2
 2889 00d7 06        		.uleb128 0x6
 2890 00d8 00        		.byte	0
 2891 00d9 00        		.byte	0
 2892 00da 11        		.uleb128 0x11
GAS LISTING /tmp/ccFZTQVh.s 			page 60


 2893 00db 2E        		.uleb128 0x2e
 2894 00dc 01        		.byte	0x1
 2895 00dd 3F        		.uleb128 0x3f
 2896 00de 0C        		.uleb128 0xc
 2897 00df 03        		.uleb128 0x3
 2898 00e0 0E        		.uleb128 0xe
 2899 00e1 3A        		.uleb128 0x3a
 2900 00e2 0B        		.uleb128 0xb
 2901 00e3 3B        		.uleb128 0x3b
 2902 00e4 0B        		.uleb128 0xb
 2903 00e5 11        		.uleb128 0x11
 2904 00e6 01        		.uleb128 0x1
 2905 00e7 12        		.uleb128 0x12
 2906 00e8 01        		.uleb128 0x1
 2907 00e9 40        		.uleb128 0x40
 2908 00ea 06        		.uleb128 0x6
 2909 00eb 9742      		.uleb128 0x2117
 2910 00ed 0C        		.uleb128 0xc
 2911 00ee 01        		.uleb128 0x1
 2912 00ef 13        		.uleb128 0x13
 2913 00f0 00        		.byte	0
 2914 00f1 00        		.byte	0
 2915 00f2 12        		.uleb128 0x12
 2916 00f3 8982 01   		.uleb128 0x4109
 2917 00f6 01        		.byte	0x1
 2918 00f7 11        		.uleb128 0x11
 2919 00f8 01        		.uleb128 0x1
 2920 00f9 31        		.uleb128 0x31
 2921 00fa 13        		.uleb128 0x13
 2922 00fb 00        		.byte	0
 2923 00fc 00        		.byte	0
 2924 00fd 13        		.uleb128 0x13
 2925 00fe 8A82 01   		.uleb128 0x410a
 2926 0101 00        		.byte	0
 2927 0102 02        		.uleb128 0x2
 2928 0103 0A        		.uleb128 0xa
 2929 0104 9142      		.uleb128 0x2111
 2930 0106 0A        		.uleb128 0xa
 2931 0107 00        		.byte	0
 2932 0108 00        		.byte	0
 2933 0109 14        		.uleb128 0x14
 2934 010a 2E        		.uleb128 0x2e
 2935 010b 01        		.byte	0x1
 2936 010c 3F        		.uleb128 0x3f
 2937 010d 0C        		.uleb128 0xc
 2938 010e 03        		.uleb128 0x3
 2939 010f 0E        		.uleb128 0xe
 2940 0110 3A        		.uleb128 0x3a
 2941 0111 0B        		.uleb128 0xb
 2942 0112 3B        		.uleb128 0x3b
 2943 0113 0B        		.uleb128 0xb
 2944 0114 11        		.uleb128 0x11
 2945 0115 01        		.uleb128 0x1
 2946 0116 12        		.uleb128 0x12
 2947 0117 01        		.uleb128 0x1
 2948 0118 40        		.uleb128 0x40
 2949 0119 06        		.uleb128 0x6
GAS LISTING /tmp/ccFZTQVh.s 			page 61


 2950 011a 9642      		.uleb128 0x2116
 2951 011c 0C        		.uleb128 0xc
 2952 011d 01        		.uleb128 0x1
 2953 011e 13        		.uleb128 0x13
 2954 011f 00        		.byte	0
 2955 0120 00        		.byte	0
 2956 0121 15        		.uleb128 0x15
 2957 0122 05        		.uleb128 0x5
 2958 0123 00        		.byte	0
 2959 0124 03        		.uleb128 0x3
 2960 0125 08        		.uleb128 0x8
 2961 0126 3A        		.uleb128 0x3a
 2962 0127 0B        		.uleb128 0xb
 2963 0128 3B        		.uleb128 0x3b
 2964 0129 0B        		.uleb128 0xb
 2965 012a 49        		.uleb128 0x49
 2966 012b 13        		.uleb128 0x13
 2967 012c 02        		.uleb128 0x2
 2968 012d 06        		.uleb128 0x6
 2969 012e 00        		.byte	0
 2970 012f 00        		.byte	0
 2971 0130 16        		.uleb128 0x16
 2972 0131 2E        		.uleb128 0x2e
 2973 0132 01        		.byte	0x1
 2974 0133 3F        		.uleb128 0x3f
 2975 0134 0C        		.uleb128 0xc
 2976 0135 03        		.uleb128 0x3
 2977 0136 0E        		.uleb128 0xe
 2978 0137 3A        		.uleb128 0x3a
 2979 0138 0B        		.uleb128 0xb
 2980 0139 3B        		.uleb128 0x3b
 2981 013a 05        		.uleb128 0x5
 2982 013b 11        		.uleb128 0x11
 2983 013c 01        		.uleb128 0x1
 2984 013d 12        		.uleb128 0x12
 2985 013e 01        		.uleb128 0x1
 2986 013f 40        		.uleb128 0x40
 2987 0140 06        		.uleb128 0x6
 2988 0141 9642      		.uleb128 0x2116
 2989 0143 0C        		.uleb128 0xc
 2990 0144 01        		.uleb128 0x1
 2991 0145 13        		.uleb128 0x13
 2992 0146 00        		.byte	0
 2993 0147 00        		.byte	0
 2994 0148 17        		.uleb128 0x17
 2995 0149 34        		.uleb128 0x34
 2996 014a 00        		.byte	0
 2997 014b 03        		.uleb128 0x3
 2998 014c 08        		.uleb128 0x8
 2999 014d 3A        		.uleb128 0x3a
 3000 014e 0B        		.uleb128 0xb
 3001 014f 3B        		.uleb128 0x3b
 3002 0150 05        		.uleb128 0x5
 3003 0151 49        		.uleb128 0x49
 3004 0152 13        		.uleb128 0x13
 3005 0153 02        		.uleb128 0x2
 3006 0154 06        		.uleb128 0x6
GAS LISTING /tmp/ccFZTQVh.s 			page 62


 3007 0155 00        		.byte	0
 3008 0156 00        		.byte	0
 3009 0157 18        		.uleb128 0x18
 3010 0158 8982 01   		.uleb128 0x4109
 3011 015b 00        		.byte	0
 3012 015c 11        		.uleb128 0x11
 3013 015d 01        		.uleb128 0x1
 3014 015e 31        		.uleb128 0x31
 3015 015f 13        		.uleb128 0x13
 3016 0160 00        		.byte	0
 3017 0161 00        		.byte	0
 3018 0162 19        		.uleb128 0x19
 3019 0163 2E        		.uleb128 0x2e
 3020 0164 01        		.byte	0x1
 3021 0165 3F        		.uleb128 0x3f
 3022 0166 0C        		.uleb128 0xc
 3023 0167 03        		.uleb128 0x3
 3024 0168 0E        		.uleb128 0xe
 3025 0169 3A        		.uleb128 0x3a
 3026 016a 0B        		.uleb128 0xb
 3027 016b 3B        		.uleb128 0x3b
 3028 016c 05        		.uleb128 0x5
 3029 016d 11        		.uleb128 0x11
 3030 016e 01        		.uleb128 0x1
 3031 016f 12        		.uleb128 0x12
 3032 0170 01        		.uleb128 0x1
 3033 0171 40        		.uleb128 0x40
 3034 0172 0A        		.uleb128 0xa
 3035 0173 9742      		.uleb128 0x2117
 3036 0175 0C        		.uleb128 0xc
 3037 0176 01        		.uleb128 0x1
 3038 0177 13        		.uleb128 0x13
 3039 0178 00        		.byte	0
 3040 0179 00        		.byte	0
 3041 017a 1A        		.uleb128 0x1a
 3042 017b 05        		.uleb128 0x5
 3043 017c 00        		.byte	0
 3044 017d 03        		.uleb128 0x3
 3045 017e 0E        		.uleb128 0xe
 3046 017f 3A        		.uleb128 0x3a
 3047 0180 0B        		.uleb128 0xb
 3048 0181 3B        		.uleb128 0x3b
 3049 0182 05        		.uleb128 0x5
 3050 0183 49        		.uleb128 0x49
 3051 0184 13        		.uleb128 0x13
 3052 0185 02        		.uleb128 0x2
 3053 0186 06        		.uleb128 0x6
 3054 0187 00        		.byte	0
 3055 0188 00        		.byte	0
 3056 0189 1B        		.uleb128 0x1b
 3057 018a 8982 01   		.uleb128 0x4109
 3058 018d 01        		.byte	0x1
 3059 018e 11        		.uleb128 0x11
 3060 018f 01        		.uleb128 0x1
 3061 0190 9542      		.uleb128 0x2115
 3062 0192 0C        		.uleb128 0xc
 3063 0193 31        		.uleb128 0x31
GAS LISTING /tmp/ccFZTQVh.s 			page 63


 3064 0194 13        		.uleb128 0x13
 3065 0195 00        		.byte	0
 3066 0196 00        		.byte	0
 3067 0197 1C        		.uleb128 0x1c
 3068 0198 26        		.uleb128 0x26
 3069 0199 00        		.byte	0
 3070 019a 49        		.uleb128 0x49
 3071 019b 13        		.uleb128 0x13
 3072 019c 00        		.byte	0
 3073 019d 00        		.byte	0
 3074 019e 1D        		.uleb128 0x1d
 3075 019f 2E        		.uleb128 0x2e
 3076 01a0 01        		.byte	0x1
 3077 01a1 3F        		.uleb128 0x3f
 3078 01a2 0C        		.uleb128 0xc
 3079 01a3 03        		.uleb128 0x3
 3080 01a4 0E        		.uleb128 0xe
 3081 01a5 3A        		.uleb128 0x3a
 3082 01a6 0B        		.uleb128 0xb
 3083 01a7 3B        		.uleb128 0x3b
 3084 01a8 05        		.uleb128 0x5
 3085 01a9 11        		.uleb128 0x11
 3086 01aa 01        		.uleb128 0x1
 3087 01ab 12        		.uleb128 0x12
 3088 01ac 01        		.uleb128 0x1
 3089 01ad 40        		.uleb128 0x40
 3090 01ae 06        		.uleb128 0x6
 3091 01af 9742      		.uleb128 0x2117
 3092 01b1 0C        		.uleb128 0xc
 3093 01b2 01        		.uleb128 0x1
 3094 01b3 13        		.uleb128 0x13
 3095 01b4 00        		.byte	0
 3096 01b5 00        		.byte	0
 3097 01b6 1E        		.uleb128 0x1e
 3098 01b7 05        		.uleb128 0x5
 3099 01b8 00        		.byte	0
 3100 01b9 03        		.uleb128 0x3
 3101 01ba 0E        		.uleb128 0xe
 3102 01bb 3A        		.uleb128 0x3a
 3103 01bc 0B        		.uleb128 0xb
 3104 01bd 3B        		.uleb128 0x3b
 3105 01be 05        		.uleb128 0x5
 3106 01bf 49        		.uleb128 0x49
 3107 01c0 13        		.uleb128 0x13
 3108 01c1 02        		.uleb128 0x2
 3109 01c2 0A        		.uleb128 0xa
 3110 01c3 00        		.byte	0
 3111 01c4 00        		.byte	0
 3112 01c5 1F        		.uleb128 0x1f
 3113 01c6 05        		.uleb128 0x5
 3114 01c7 00        		.byte	0
 3115 01c8 03        		.uleb128 0x3
 3116 01c9 08        		.uleb128 0x8
 3117 01ca 3A        		.uleb128 0x3a
 3118 01cb 0B        		.uleb128 0xb
 3119 01cc 3B        		.uleb128 0x3b
 3120 01cd 05        		.uleb128 0x5
GAS LISTING /tmp/ccFZTQVh.s 			page 64


 3121 01ce 49        		.uleb128 0x49
 3122 01cf 13        		.uleb128 0x13
 3123 01d0 02        		.uleb128 0x2
 3124 01d1 0A        		.uleb128 0xa
 3125 01d2 00        		.byte	0
 3126 01d3 00        		.byte	0
 3127 01d4 20        		.uleb128 0x20
 3128 01d5 34        		.uleb128 0x34
 3129 01d6 00        		.byte	0
 3130 01d7 03        		.uleb128 0x3
 3131 01d8 0E        		.uleb128 0xe
 3132 01d9 3A        		.uleb128 0x3a
 3133 01da 0B        		.uleb128 0xb
 3134 01db 3B        		.uleb128 0x3b
 3135 01dc 05        		.uleb128 0x5
 3136 01dd 49        		.uleb128 0x49
 3137 01de 13        		.uleb128 0x13
 3138 01df 02        		.uleb128 0x2
 3139 01e0 06        		.uleb128 0x6
 3140 01e1 00        		.byte	0
 3141 01e2 00        		.byte	0
 3142 01e3 21        		.uleb128 0x21
 3143 01e4 05        		.uleb128 0x5
 3144 01e5 00        		.byte	0
 3145 01e6 03        		.uleb128 0x3
 3146 01e7 08        		.uleb128 0x8
 3147 01e8 3A        		.uleb128 0x3a
 3148 01e9 0B        		.uleb128 0xb
 3149 01ea 3B        		.uleb128 0x3b
 3150 01eb 05        		.uleb128 0x5
 3151 01ec 49        		.uleb128 0x49
 3152 01ed 13        		.uleb128 0x13
 3153 01ee 02        		.uleb128 0x2
 3154 01ef 06        		.uleb128 0x6
 3155 01f0 00        		.byte	0
 3156 01f1 00        		.byte	0
 3157 01f2 22        		.uleb128 0x22
 3158 01f3 8982 01   		.uleb128 0x4109
 3159 01f6 01        		.byte	0x1
 3160 01f7 11        		.uleb128 0x11
 3161 01f8 01        		.uleb128 0x1
 3162 01f9 31        		.uleb128 0x31
 3163 01fa 13        		.uleb128 0x13
 3164 01fb 01        		.uleb128 0x1
 3165 01fc 13        		.uleb128 0x13
 3166 01fd 00        		.byte	0
 3167 01fe 00        		.byte	0
 3168 01ff 23        		.uleb128 0x23
 3169 0200 34        		.uleb128 0x34
 3170 0201 00        		.byte	0
 3171 0202 03        		.uleb128 0x3
 3172 0203 0E        		.uleb128 0xe
 3173 0204 3A        		.uleb128 0x3a
 3174 0205 0B        		.uleb128 0xb
 3175 0206 3B        		.uleb128 0x3b
 3176 0207 05        		.uleb128 0x5
 3177 0208 49        		.uleb128 0x49
GAS LISTING /tmp/ccFZTQVh.s 			page 65


 3178 0209 13        		.uleb128 0x13
 3179 020a 00        		.byte	0
 3180 020b 00        		.byte	0
 3181 020c 24        		.uleb128 0x24
 3182 020d 2E        		.uleb128 0x2e
 3183 020e 00        		.byte	0
 3184 020f 3F        		.uleb128 0x3f
 3185 0210 0C        		.uleb128 0xc
 3186 0211 03        		.uleb128 0x3
 3187 0212 0E        		.uleb128 0xe
 3188 0213 3A        		.uleb128 0x3a
 3189 0214 0B        		.uleb128 0xb
 3190 0215 3B        		.uleb128 0x3b
 3191 0216 05        		.uleb128 0x5
 3192 0217 11        		.uleb128 0x11
 3193 0218 01        		.uleb128 0x1
 3194 0219 12        		.uleb128 0x12
 3195 021a 01        		.uleb128 0x1
 3196 021b 40        		.uleb128 0x40
 3197 021c 0A        		.uleb128 0xa
 3198 021d 9742      		.uleb128 0x2117
 3199 021f 0C        		.uleb128 0xc
 3200 0220 00        		.byte	0
 3201 0221 00        		.byte	0
 3202 0222 25        		.uleb128 0x25
 3203 0223 34        		.uleb128 0x34
 3204 0224 00        		.byte	0
 3205 0225 03        		.uleb128 0x3
 3206 0226 0E        		.uleb128 0xe
 3207 0227 3A        		.uleb128 0x3a
 3208 0228 0B        		.uleb128 0xb
 3209 0229 3B        		.uleb128 0x3b
 3210 022a 0B        		.uleb128 0xb
 3211 022b 49        		.uleb128 0x49
 3212 022c 13        		.uleb128 0x13
 3213 022d 3F        		.uleb128 0x3f
 3214 022e 0C        		.uleb128 0xc
 3215 022f 02        		.uleb128 0x2
 3216 0230 0A        		.uleb128 0xa
 3217 0231 00        		.byte	0
 3218 0232 00        		.byte	0
 3219 0233 26        		.uleb128 0x26
 3220 0234 35        		.uleb128 0x35
 3221 0235 00        		.byte	0
 3222 0236 49        		.uleb128 0x49
 3223 0237 13        		.uleb128 0x13
 3224 0238 00        		.byte	0
 3225 0239 00        		.byte	0
 3226 023a 27        		.uleb128 0x27
 3227 023b 15        		.uleb128 0x15
 3228 023c 00        		.byte	0
 3229 023d 00        		.byte	0
 3230 023e 00        		.byte	0
 3231 023f 28        		.uleb128 0x28
 3232 0240 34        		.uleb128 0x34
 3233 0241 00        		.byte	0
 3234 0242 03        		.uleb128 0x3
GAS LISTING /tmp/ccFZTQVh.s 			page 66


 3235 0243 0E        		.uleb128 0xe
 3236 0244 3A        		.uleb128 0x3a
 3237 0245 0B        		.uleb128 0xb
 3238 0246 3B        		.uleb128 0x3b
 3239 0247 05        		.uleb128 0x5
 3240 0248 49        		.uleb128 0x49
 3241 0249 13        		.uleb128 0x13
 3242 024a 3F        		.uleb128 0x3f
 3243 024b 0C        		.uleb128 0xc
 3244 024c 02        		.uleb128 0x2
 3245 024d 0A        		.uleb128 0xa
 3246 024e 00        		.byte	0
 3247 024f 00        		.byte	0
 3248 0250 29        		.uleb128 0x29
 3249 0251 01        		.uleb128 0x1
 3250 0252 01        		.byte	0x1
 3251 0253 49        		.uleb128 0x49
 3252 0254 13        		.uleb128 0x13
 3253 0255 01        		.uleb128 0x1
 3254 0256 13        		.uleb128 0x13
 3255 0257 00        		.byte	0
 3256 0258 00        		.byte	0
 3257 0259 2A        		.uleb128 0x2a
 3258 025a 21        		.uleb128 0x21
 3259 025b 00        		.byte	0
 3260 025c 49        		.uleb128 0x49
 3261 025d 13        		.uleb128 0x13
 3262 025e 2F        		.uleb128 0x2f
 3263 025f 0B        		.uleb128 0xb
 3264 0260 00        		.byte	0
 3265 0261 00        		.byte	0
 3266 0262 2B        		.uleb128 0x2b
 3267 0263 2E        		.uleb128 0x2e
 3268 0264 01        		.byte	0x1
 3269 0265 3F        		.uleb128 0x3f
 3270 0266 0C        		.uleb128 0xc
 3271 0267 03        		.uleb128 0x3
 3272 0268 0E        		.uleb128 0xe
 3273 0269 3A        		.uleb128 0x3a
 3274 026a 0B        		.uleb128 0xb
 3275 026b 3B        		.uleb128 0x3b
 3276 026c 05        		.uleb128 0x5
 3277 026d 3C        		.uleb128 0x3c
 3278 026e 0C        		.uleb128 0xc
 3279 026f 00        		.byte	0
 3280 0270 00        		.byte	0
 3281 0271 2C        		.uleb128 0x2c
 3282 0272 05        		.uleb128 0x5
 3283 0273 00        		.byte	0
 3284 0274 49        		.uleb128 0x49
 3285 0275 13        		.uleb128 0x13
 3286 0276 00        		.byte	0
 3287 0277 00        		.byte	0
 3288 0278 00        		.byte	0
 3289               		.section	.debug_loc,"",@progbits
 3290               	.Ldebug_loc0:
 3291               	.LLST0:
GAS LISTING /tmp/ccFZTQVh.s 			page 67


 3292 0000 0000 0000 		.long	.LVL0
 3293 0004 0000 0000 		.long	.LVL1
 3294 0008 0C00      		.word	0xc
 3295 000a 66        		.byte	0x66
 3296 000b 93        		.byte	0x93
 3297 000c 01        		.uleb128 0x1
 3298 000d 67        		.byte	0x67
 3299 000e 93        		.byte	0x93
 3300 000f 01        		.uleb128 0x1
 3301 0010 68        		.byte	0x68
 3302 0011 93        		.byte	0x93
 3303 0012 01        		.uleb128 0x1
 3304 0013 69        		.byte	0x69
 3305 0014 93        		.byte	0x93
 3306 0015 01        		.uleb128 0x1
 3307 0016 0000 0000 		.long	.LVL1
 3308 001a 0000 0000 		.long	.LVL2
 3309 001e 0C00      		.word	0xc
 3310 0020 62        		.byte	0x62
 3311 0021 93        		.byte	0x93
 3312 0022 01        		.uleb128 0x1
 3313 0023 63        		.byte	0x63
 3314 0024 93        		.byte	0x93
 3315 0025 01        		.uleb128 0x1
 3316 0026 64        		.byte	0x64
 3317 0027 93        		.byte	0x93
 3318 0028 01        		.uleb128 0x1
 3319 0029 65        		.byte	0x65
 3320 002a 93        		.byte	0x93
 3321 002b 01        		.uleb128 0x1
 3322 002c 0000 0000 		.long	.LVL2
 3323 0030 0000 0000 		.long	.LFE102
 3324 0034 0400      		.word	0x4
 3325 0036 F3        		.byte	0xf3
 3326 0037 01        		.uleb128 0x1
 3327 0038 66        		.byte	0x66
 3328 0039 9F        		.byte	0x9f
 3329 003a 0000 0000 		.long	0
 3330 003e 0000 0000 		.long	0
 3331               	.LLST1:
 3332 0042 0000 0000 		.long	.LVL3
 3333 0046 0000 0000 		.long	.LVL4
 3334 004a 0200      		.word	0x2
 3335 004c 30        		.byte	0x30
 3336 004d 9F        		.byte	0x9f
 3337 004e 0000 0000 		.long	.LVL4
 3338 0052 0000 0000 		.long	.LFE102
 3339 0056 0100      		.word	0x1
 3340 0058 68        		.byte	0x68
 3341 0059 0000 0000 		.long	0
 3342 005d 0000 0000 		.long	0
 3343               	.LLST2:
 3344 0061 0000 0000 		.long	.LFB103
 3345 0065 0000 0000 		.long	.LCFI0
 3346 0069 0300      		.word	0x3
 3347 006b 92        		.byte	0x92
 3348 006c 20        		.uleb128 0x20
GAS LISTING /tmp/ccFZTQVh.s 			page 68


 3349 006d 03        		.sleb128 3
 3350 006e 0000 0000 		.long	.LCFI0
 3351 0072 0000 0000 		.long	.LCFI1
 3352 0076 0300      		.word	0x3
 3353 0078 92        		.byte	0x92
 3354 0079 20        		.uleb128 0x20
 3355 007a 04        		.sleb128 4
 3356 007b 0000 0000 		.long	.LCFI1
 3357 007f 0000 0000 		.long	.LCFI2
 3358 0083 0300      		.word	0x3
 3359 0085 92        		.byte	0x92
 3360 0086 20        		.uleb128 0x20
 3361 0087 05        		.sleb128 5
 3362 0088 0000 0000 		.long	.LCFI2
 3363 008c 0000 0000 		.long	.LCFI3
 3364 0090 0300      		.word	0x3
 3365 0092 92        		.byte	0x92
 3366 0093 20        		.uleb128 0x20
 3367 0094 06        		.sleb128 6
 3368 0095 0000 0000 		.long	.LCFI3
 3369 0099 0000 0000 		.long	.LFE103
 3370 009d 0200      		.word	0x2
 3371 009f 8C        		.byte	0x8c
 3372 00a0 06        		.sleb128 6
 3373 00a1 0000 0000 		.long	0
 3374 00a5 0000 0000 		.long	0
 3375               	.LLST3:
 3376 00a9 0000 0000 		.long	.LVL9
 3377 00ad 0000 0000 		.long	.LVL10-1
 3378 00b1 0C00      		.word	0xc
 3379 00b3 66        		.byte	0x66
 3380 00b4 93        		.byte	0x93
 3381 00b5 01        		.uleb128 0x1
 3382 00b6 67        		.byte	0x67
 3383 00b7 93        		.byte	0x93
 3384 00b8 01        		.uleb128 0x1
 3385 00b9 68        		.byte	0x68
 3386 00ba 93        		.byte	0x93
 3387 00bb 01        		.uleb128 0x1
 3388 00bc 69        		.byte	0x69
 3389 00bd 93        		.byte	0x93
 3390 00be 01        		.uleb128 0x1
 3391 00bf 0000 0000 		.long	.LVL10-1
 3392 00c3 0000 0000 		.long	.LFE103
 3393 00c7 0400      		.word	0x4
 3394 00c9 F3        		.byte	0xf3
 3395 00ca 01        		.uleb128 0x1
 3396 00cb 66        		.byte	0x66
 3397 00cc 9F        		.byte	0x9f
 3398 00cd 0000 0000 		.long	0
 3399 00d1 0000 0000 		.long	0
 3400               	.LLST4:
 3401 00d5 0000 0000 		.long	.LVL9
 3402 00d9 0000 0000 		.long	.LVL10-1
 3403 00dd 0100      		.word	0x1
 3404 00df 64        		.byte	0x64
 3405 00e0 0000 0000 		.long	.LVL10-1
GAS LISTING /tmp/ccFZTQVh.s 			page 69


 3406 00e4 0000 0000 		.long	.LFE103
 3407 00e8 0400      		.word	0x4
 3408 00ea F3        		.byte	0xf3
 3409 00eb 01        		.uleb128 0x1
 3410 00ec 64        		.byte	0x64
 3411 00ed 9F        		.byte	0x9f
 3412 00ee 0000 0000 		.long	0
 3413 00f2 0000 0000 		.long	0
 3414               	.LLST5:
 3415 00f6 0000 0000 		.long	.LFB104
 3416 00fa 0000 0000 		.long	.LCFI4
 3417 00fe 0300      		.word	0x3
 3418 0100 92        		.byte	0x92
 3419 0101 20        		.uleb128 0x20
 3420 0102 03        		.sleb128 3
 3421 0103 0000 0000 		.long	.LCFI4
 3422 0107 0000 0000 		.long	.LFE104
 3423 010b 0300      		.word	0x3
 3424 010d 92        		.byte	0x92
 3425 010e 20        		.uleb128 0x20
 3426 010f 04        		.sleb128 4
 3427 0110 0000 0000 		.long	0
 3428 0114 0000 0000 		.long	0
 3429               	.LLST6:
 3430 0118 0000 0000 		.long	.LVL11
 3431 011c 0000 0000 		.long	.LVL12
 3432 0120 0100      		.word	0x1
 3433 0122 68        		.byte	0x68
 3434 0123 0000 0000 		.long	.LVL12
 3435 0127 0000 0000 		.long	.LVL13
 3436 012b 0400      		.word	0x4
 3437 012d F3        		.byte	0xf3
 3438 012e 01        		.uleb128 0x1
 3439 012f 68        		.byte	0x68
 3440 0130 9F        		.byte	0x9f
 3441 0131 0000 0000 		.long	.LVL13
 3442 0135 0000 0000 		.long	.LVL14
 3443 0139 0100      		.word	0x1
 3444 013b 68        		.byte	0x68
 3445 013c 0000 0000 		.long	.LVL14
 3446 0140 0000 0000 		.long	.LVL15
 3447 0144 0400      		.word	0x4
 3448 0146 F3        		.byte	0xf3
 3449 0147 01        		.uleb128 0x1
 3450 0148 68        		.byte	0x68
 3451 0149 9F        		.byte	0x9f
 3452 014a 0000 0000 		.long	.LVL15
 3453 014e 0000 0000 		.long	.LVL16-1
 3454 0152 0100      		.word	0x1
 3455 0154 68        		.byte	0x68
 3456 0155 0000 0000 		.long	.LVL16-1
 3457 0159 0000 0000 		.long	.LVL17
 3458 015d 0400      		.word	0x4
 3459 015f F3        		.byte	0xf3
 3460 0160 01        		.uleb128 0x1
 3461 0161 68        		.byte	0x68
 3462 0162 9F        		.byte	0x9f
GAS LISTING /tmp/ccFZTQVh.s 			page 70


 3463 0163 0000 0000 		.long	.LVL17
 3464 0167 0000 0000 		.long	.LVL18
 3465 016b 0100      		.word	0x1
 3466 016d 68        		.byte	0x68
 3467 016e 0000 0000 		.long	.LVL18
 3468 0172 0000 0000 		.long	.LFE104
 3469 0176 0400      		.word	0x4
 3470 0178 F3        		.byte	0xf3
 3471 0179 01        		.uleb128 0x1
 3472 017a 68        		.byte	0x68
 3473 017b 9F        		.byte	0x9f
 3474 017c 0000 0000 		.long	0
 3475 0180 0000 0000 		.long	0
 3476               	.LLST7:
 3477 0184 0000 0000 		.long	.LFB105
 3478 0188 0000 0000 		.long	.LCFI5
 3479 018c 0300      		.word	0x3
 3480 018e 92        		.byte	0x92
 3481 018f 20        		.uleb128 0x20
 3482 0190 03        		.sleb128 3
 3483 0191 0000 0000 		.long	.LCFI5
 3484 0195 0000 0000 		.long	.LCFI6
 3485 0199 0300      		.word	0x3
 3486 019b 92        		.byte	0x92
 3487 019c 20        		.uleb128 0x20
 3488 019d 04        		.sleb128 4
 3489 019e 0000 0000 		.long	.LCFI6
 3490 01a2 0000 0000 		.long	.LCFI7
 3491 01a6 0300      		.word	0x3
 3492 01a8 92        		.byte	0x92
 3493 01a9 20        		.uleb128 0x20
 3494 01aa 05        		.sleb128 5
 3495 01ab 0000 0000 		.long	.LCFI7
 3496 01af 0000 0000 		.long	.LCFI8
 3497 01b3 0300      		.word	0x3
 3498 01b5 92        		.byte	0x92
 3499 01b6 20        		.uleb128 0x20
 3500 01b7 06        		.sleb128 6
 3501 01b8 0000 0000 		.long	.LCFI8
 3502 01bc 0000 0000 		.long	.LCFI9
 3503 01c0 0300      		.word	0x3
 3504 01c2 92        		.byte	0x92
 3505 01c3 20        		.uleb128 0x20
 3506 01c4 07        		.sleb128 7
 3507 01c5 0000 0000 		.long	.LCFI9
 3508 01c9 0000 0000 		.long	.LCFI10
 3509 01cd 0300      		.word	0x3
 3510 01cf 92        		.byte	0x92
 3511 01d0 20        		.uleb128 0x20
 3512 01d1 08        		.sleb128 8
 3513 01d2 0000 0000 		.long	.LCFI10
 3514 01d6 0000 0000 		.long	.LCFI11
 3515 01da 0300      		.word	0x3
 3516 01dc 92        		.byte	0x92
 3517 01dd 20        		.uleb128 0x20
 3518 01de 09        		.sleb128 9
 3519 01df 0000 0000 		.long	.LCFI11
GAS LISTING /tmp/ccFZTQVh.s 			page 71


 3520 01e3 0000 0000 		.long	.LCFI12
 3521 01e7 0300      		.word	0x3
 3522 01e9 92        		.byte	0x92
 3523 01ea 20        		.uleb128 0x20
 3524 01eb 0A        		.sleb128 10
 3525 01ec 0000 0000 		.long	.LCFI12
 3526 01f0 0000 0000 		.long	.LCFI13
 3527 01f4 0300      		.word	0x3
 3528 01f6 92        		.byte	0x92
 3529 01f7 20        		.uleb128 0x20
 3530 01f8 0B        		.sleb128 11
 3531 01f9 0000 0000 		.long	.LCFI13
 3532 01fd 0000 0000 		.long	.LCFI14
 3533 0201 0300      		.word	0x3
 3534 0203 92        		.byte	0x92
 3535 0204 20        		.uleb128 0x20
 3536 0205 0C        		.sleb128 12
 3537 0206 0000 0000 		.long	.LCFI14
 3538 020a 0000 0000 		.long	.LCFI15
 3539 020e 0300      		.word	0x3
 3540 0210 92        		.byte	0x92
 3541 0211 20        		.uleb128 0x20
 3542 0212 0D        		.sleb128 13
 3543 0213 0000 0000 		.long	.LCFI15
 3544 0217 0000 0000 		.long	.LCFI16
 3545 021b 0300      		.word	0x3
 3546 021d 92        		.byte	0x92
 3547 021e 20        		.uleb128 0x20
 3548 021f 0E        		.sleb128 14
 3549 0220 0000 0000 		.long	.LCFI16
 3550 0224 0000 0000 		.long	.LCFI17
 3551 0228 0300      		.word	0x3
 3552 022a 92        		.byte	0x92
 3553 022b 20        		.uleb128 0x20
 3554 022c 0F        		.sleb128 15
 3555 022d 0000 0000 		.long	.LCFI17
 3556 0231 0000 0000 		.long	.LCFI18
 3557 0235 0300      		.word	0x3
 3558 0237 92        		.byte	0x92
 3559 0238 20        		.uleb128 0x20
 3560 0239 10        		.sleb128 16
 3561 023a 0000 0000 		.long	.LCFI18
 3562 023e 0000 0000 		.long	.LFE105
 3563 0242 0300      		.word	0x3
 3564 0244 92        		.byte	0x92
 3565 0245 20        		.uleb128 0x20
 3566 0246 11        		.sleb128 17
 3567 0247 0000 0000 		.long	0
 3568 024b 0000 0000 		.long	0
 3569               	.LLST8:
 3570 024f 0000 0000 		.long	.LVL29
 3571 0253 0000 0000 		.long	.LVL30
 3572 0257 0100      		.word	0x1
 3573 0259 69        		.byte	0x69
 3574 025a 0000 0000 		.long	0
 3575 025e 0000 0000 		.long	0
 3576               	.LLST9:
GAS LISTING /tmp/ccFZTQVh.s 			page 72


 3577 0262 0000 0000 		.long	.LVL19
 3578 0266 0000 0000 		.long	.LVL23-1
 3579 026a 0100      		.word	0x1
 3580 026c 63        		.byte	0x63
 3581 026d 0000 0000 		.long	.LVL24
 3582 0271 0000 0000 		.long	.LVL25-1
 3583 0275 0100      		.word	0x1
 3584 0277 68        		.byte	0x68
 3585 0278 0000 0000 		.long	.LVL26
 3586 027c 0000 0000 		.long	.LVL30
 3587 0280 0100      		.word	0x1
 3588 0282 63        		.byte	0x63
 3589 0283 0000 0000 		.long	0
 3590 0287 0000 0000 		.long	0
 3591               	.LLST10:
 3592 028b 0000 0000 		.long	.LVL20
 3593 028f 0000 0000 		.long	.LVL21
 3594 0293 0100      		.word	0x1
 3595 0295 68        		.byte	0x68
 3596 0296 0000 0000 		.long	.LVL21
 3597 029a 0000 0000 		.long	.LVL22
 3598 029e 0500      		.word	0x5
 3599 02a0 03        		.byte	0x3
 3600 02a1 0000 0000 		.long	twiState
 3601 02a5 0000 0000 		.long	.LVL22
 3602 02a9 0000 0000 		.long	.LVL23-1
 3603 02ad 0600      		.word	0x6
 3604 02af 82        		.byte	0x82
 3605 02b0 00        		.sleb128 0
 3606 02b1 09        		.byte	0x9
 3607 02b2 F8        		.byte	0xf8
 3608 02b3 1A        		.byte	0x1a
 3609 02b4 9F        		.byte	0x9f
 3610 02b5 0000 0000 		.long	.LVL26
 3611 02b9 0000 0000 		.long	.LVL27
 3612 02bd 0100      		.word	0x1
 3613 02bf 68        		.byte	0x68
 3614 02c0 0000 0000 		.long	.LVL27
 3615 02c4 0000 0000 		.long	.LVL28
 3616 02c8 0500      		.word	0x5
 3617 02ca 03        		.byte	0x3
 3618 02cb 0000 0000 		.long	twiState
 3619 02cf 0000 0000 		.long	.LVL28
 3620 02d3 0000 0000 		.long	.LVL30
 3621 02d7 0600      		.word	0x6
 3622 02d9 82        		.byte	0x82
 3623 02da 00        		.sleb128 0
 3624 02db 09        		.byte	0x9
 3625 02dc F8        		.byte	0xf8
 3626 02dd 1A        		.byte	0x1a
 3627 02de 9F        		.byte	0x9f
 3628 02df 0000 0000 		.long	0
 3629 02e3 0000 0000 		.long	0
 3630               	.LLST11:
 3631 02e7 0000 0000 		.long	.LVL31
 3632 02eb 0000 0000 		.long	.LVL32
 3633 02ef 0100      		.word	0x1
GAS LISTING /tmp/ccFZTQVh.s 			page 73


 3634 02f1 68        		.byte	0x68
 3635 02f2 0000 0000 		.long	.LVL32
 3636 02f6 0000 0000 		.long	.LVL33
 3637 02fa 0500      		.word	0x5
 3638 02fc 03        		.byte	0x3
 3639 02fd 0000 0000 		.long	twiSLARW
 3640 0301 0000 0000 		.long	.LVL33
 3641 0305 0000 0000 		.long	.LFE106
 3642 0309 0400      		.word	0x4
 3643 030b F3        		.byte	0xf3
 3644 030c 01        		.uleb128 0x1
 3645 030d 68        		.byte	0x68
 3646 030e 9F        		.byte	0x9f
 3647 030f 0000 0000 		.long	0
 3648 0313 0000 0000 		.long	0
 3649               	.LLST12:
 3650 0317 0000 0000 		.long	.LVL34
 3651 031b 0000 0000 		.long	.LVL35
 3652 031f 0100      		.word	0x1
 3653 0321 68        		.byte	0x68
 3654 0322 0000 0000 		.long	.LVL35
 3655 0326 0000 0000 		.long	.LVL36
 3656 032a 0500      		.word	0x5
 3657 032c 03        		.byte	0x3
 3658 032d 0000 0000 		.long	twiSLARW
 3659 0331 0000 0000 		.long	.LVL36
 3660 0335 0000 0000 		.long	.LFE107
 3661 0339 0400      		.word	0x4
 3662 033b F3        		.byte	0xf3
 3663 033c 01        		.uleb128 0x1
 3664 033d 68        		.byte	0x68
 3665 033e 9F        		.byte	0x9f
 3666 033f 0000 0000 		.long	0
 3667 0343 0000 0000 		.long	0
 3668               	.LLST13:
 3669 0347 0000 0000 		.long	.LVL37
 3670 034b 0000 0000 		.long	.LVL38
 3671 034f 0100      		.word	0x1
 3672 0351 68        		.byte	0x68
 3673 0352 0000 0000 		.long	.LVL38
 3674 0356 0000 0000 		.long	.LFE108
 3675 035a 0400      		.word	0x4
 3676 035c F3        		.byte	0xf3
 3677 035d 01        		.uleb128 0x1
 3678 035e 68        		.byte	0x68
 3679 035f 9F        		.byte	0x9f
 3680 0360 0000 0000 		.long	0
 3681 0364 0000 0000 		.long	0
 3682               	.LLST14:
 3683 0368 0000 0000 		.long	.LVL37
 3684 036c 0000 0000 		.long	.LVL39-1
 3685 0370 0600      		.word	0x6
 3686 0372 66        		.byte	0x66
 3687 0373 93        		.byte	0x93
 3688 0374 01        		.uleb128 0x1
 3689 0375 67        		.byte	0x67
 3690 0376 93        		.byte	0x93
GAS LISTING /tmp/ccFZTQVh.s 			page 74


 3691 0377 01        		.uleb128 0x1
 3692 0378 0000 0000 		.long	.LVL39-1
 3693 037c 0000 0000 		.long	.LFE108
 3694 0380 0400      		.word	0x4
 3695 0382 F3        		.byte	0xf3
 3696 0383 01        		.uleb128 0x1
 3697 0384 66        		.byte	0x66
 3698 0385 9F        		.byte	0x9f
 3699 0386 0000 0000 		.long	0
 3700 038a 0000 0000 		.long	0
 3701               	.LLST15:
 3702 038e 0000 0000 		.long	.LVL37
 3703 0392 0000 0000 		.long	.LVL39-1
 3704 0396 0100      		.word	0x1
 3705 0398 64        		.byte	0x64
 3706 0399 0000 0000 		.long	.LVL39-1
 3707 039d 0000 0000 		.long	.LFE108
 3708 03a1 0400      		.word	0x4
 3709 03a3 F3        		.byte	0xf3
 3710 03a4 01        		.uleb128 0x1
 3711 03a5 64        		.byte	0x64
 3712 03a6 9F        		.byte	0x9f
 3713 03a7 0000 0000 		.long	0
 3714 03ab 0000 0000 		.long	0
 3715               	.LLST16:
 3716 03af 0000 0000 		.long	.LVL40
 3717 03b3 0000 0000 		.long	.LVL41
 3718 03b7 0100      		.word	0x1
 3719 03b9 68        		.byte	0x68
 3720 03ba 0000 0000 		.long	.LVL41
 3721 03be 0000 0000 		.long	.LFE109
 3722 03c2 0400      		.word	0x4
 3723 03c4 F3        		.byte	0xf3
 3724 03c5 01        		.uleb128 0x1
 3725 03c6 68        		.byte	0x68
 3726 03c7 9F        		.byte	0x9f
 3727 03c8 0000 0000 		.long	0
 3728 03cc 0000 0000 		.long	0
 3729               	.LLST17:
 3730 03d0 0000 0000 		.long	.LVL40
 3731 03d4 0000 0000 		.long	.LVL42-1
 3732 03d8 0600      		.word	0x6
 3733 03da 66        		.byte	0x66
 3734 03db 93        		.byte	0x93
 3735 03dc 01        		.uleb128 0x1
 3736 03dd 67        		.byte	0x67
 3737 03de 93        		.byte	0x93
 3738 03df 01        		.uleb128 0x1
 3739 03e0 0000 0000 		.long	.LVL42-1
 3740 03e4 0000 0000 		.long	.LFE109
 3741 03e8 0400      		.word	0x4
 3742 03ea F3        		.byte	0xf3
 3743 03eb 01        		.uleb128 0x1
 3744 03ec 66        		.byte	0x66
 3745 03ed 9F        		.byte	0x9f
 3746 03ee 0000 0000 		.long	0
 3747 03f2 0000 0000 		.long	0
GAS LISTING /tmp/ccFZTQVh.s 			page 75


 3748               	.LLST18:
 3749 03f6 0000 0000 		.long	.LVL40
 3750 03fa 0000 0000 		.long	.LVL42-1
 3751 03fe 0100      		.word	0x1
 3752 0400 64        		.byte	0x64
 3753 0401 0000 0000 		.long	.LVL42-1
 3754 0405 0000 0000 		.long	.LFE109
 3755 0409 0400      		.word	0x4
 3756 040b F3        		.byte	0xf3
 3757 040c 01        		.uleb128 0x1
 3758 040d 64        		.byte	0x64
 3759 040e 9F        		.byte	0x9f
 3760 040f 0000 0000 		.long	0
 3761 0413 0000 0000 		.long	0
 3762               	.LLST19:
 3763 0417 0000 0000 		.long	.LFB110
 3764 041b 0000 0000 		.long	.LCFI19
 3765 041f 0300      		.word	0x3
 3766 0421 92        		.byte	0x92
 3767 0422 20        		.uleb128 0x20
 3768 0423 03        		.sleb128 3
 3769 0424 0000 0000 		.long	.LCFI19
 3770 0428 0000 0000 		.long	.LFE110
 3771 042c 0300      		.word	0x3
 3772 042e 92        		.byte	0x92
 3773 042f 20        		.uleb128 0x20
 3774 0430 04        		.sleb128 4
 3775 0431 0000 0000 		.long	0
 3776 0435 0000 0000 		.long	0
 3777               	.LLST20:
 3778 0439 0000 0000 		.long	.LVL43
 3779 043d 0000 0000 		.long	.LVL44
 3780 0441 0100      		.word	0x1
 3781 0443 68        		.byte	0x68
 3782 0444 0000 0000 		.long	.LVL44
 3783 0448 0000 0000 		.long	.LFE110
 3784 044c 0400      		.word	0x4
 3785 044e F3        		.byte	0xf3
 3786 044f 01        		.uleb128 0x1
 3787 0450 68        		.byte	0x68
 3788 0451 9F        		.byte	0x9f
 3789 0452 0000 0000 		.long	0
 3790 0456 0000 0000 		.long	0
 3791               	.LLST21:
 3792 045a 0000 0000 		.long	.LVL43
 3793 045e 0000 0000 		.long	.LVL45
 3794 0462 0100      		.word	0x1
 3795 0464 60        		.byte	0x60
 3796 0465 0000 0000 		.long	.LVL45
 3797 0469 0000 0000 		.long	.LFE110
 3798 046d 0400      		.word	0x4
 3799 046f F3        		.byte	0xf3
 3800 0470 01        		.uleb128 0x1
 3801 0471 60        		.byte	0x60
 3802 0472 9F        		.byte	0x9f
 3803 0473 0000 0000 		.long	0
 3804 0477 0000 0000 		.long	0
GAS LISTING /tmp/ccFZTQVh.s 			page 76


 3805               	.LLST22:
 3806 047b 0000 0000 		.long	.LVL46
 3807 047f 0000 0000 		.long	.LVL51
 3808 0483 0100      		.word	0x1
 3809 0485 68        		.byte	0x68
 3810 0486 0000 0000 		.long	.LVL51
 3811 048a 0000 0000 		.long	.LFE111
 3812 048e 0400      		.word	0x4
 3813 0490 F3        		.byte	0xf3
 3814 0491 01        		.uleb128 0x1
 3815 0492 68        		.byte	0x68
 3816 0493 9F        		.byte	0x9f
 3817 0494 0000 0000 		.long	0
 3818 0498 0000 0000 		.long	0
 3819               	.LLST23:
 3820 049c 0000 0000 		.long	.LVL47
 3821 04a0 0000 0000 		.long	.LVL49
 3822 04a4 0100      		.word	0x1
 3823 04a6 69        		.byte	0x69
 3824 04a7 0000 0000 		.long	.LVL49
 3825 04ab 0000 0000 		.long	.LVL50
 3826 04af 0500      		.word	0x5
 3827 04b1 89        		.byte	0x89
 3828 04b2 00        		.sleb128 0
 3829 04b3 34        		.byte	0x34
 3830 04b4 21        		.byte	0x21
 3831 04b5 9F        		.byte	0x9f
 3832 04b6 0000 0000 		.long	.LVL50
 3833 04ba 0000 0000 		.long	.LVL52
 3834 04be 0100      		.word	0x1
 3835 04c0 69        		.byte	0x69
 3836 04c1 0000 0000 		.long	.LVL52
 3837 04c5 0000 0000 		.long	.LVL54
 3838 04c9 0100      		.word	0x1
 3839 04cb 68        		.byte	0x68
 3840 04cc 0000 0000 		.long	.LVL54
 3841 04d0 0000 0000 		.long	.LVL55
 3842 04d4 0500      		.word	0x5
 3843 04d6 88        		.byte	0x88
 3844 04d7 00        		.sleb128 0
 3845 04d8 34        		.byte	0x34
 3846 04d9 21        		.byte	0x21
 3847 04da 9F        		.byte	0x9f
 3848 04db 0000 0000 		.long	.LVL55
 3849 04df 0000 0000 		.long	.LFE111
 3850 04e3 0100      		.word	0x1
 3851 04e5 68        		.byte	0x68
 3852 04e6 0000 0000 		.long	0
 3853 04ea 0000 0000 		.long	0
 3854               	.LLST24:
 3855 04ee 0000 0000 		.long	.LFB112
 3856 04f2 0000 0000 		.long	.LCFI20
 3857 04f6 0300      		.word	0x3
 3858 04f8 92        		.byte	0x92
 3859 04f9 20        		.uleb128 0x20
 3860 04fa 03        		.sleb128 3
 3861 04fb 0000 0000 		.long	.LCFI20
GAS LISTING /tmp/ccFZTQVh.s 			page 77


 3862 04ff 0000 0000 		.long	.LCFI21
 3863 0503 0300      		.word	0x3
 3864 0505 92        		.byte	0x92
 3865 0506 20        		.uleb128 0x20
 3866 0507 04        		.sleb128 4
 3867 0508 0000 0000 		.long	.LCFI21
 3868 050c 0000 0000 		.long	.LCFI22
 3869 0510 0300      		.word	0x3
 3870 0512 92        		.byte	0x92
 3871 0513 20        		.uleb128 0x20
 3872 0514 05        		.sleb128 5
 3873 0515 0000 0000 		.long	.LCFI22
 3874 0519 0000 0000 		.long	.LFE112
 3875 051d 0300      		.word	0x3
 3876 051f 92        		.byte	0x92
 3877 0520 20        		.uleb128 0x20
 3878 0521 06        		.sleb128 6
 3879 0522 0000 0000 		.long	0
 3880 0526 0000 0000 		.long	0
 3881               	.LLST25:
 3882 052a 0000 0000 		.long	.LVL56
 3883 052e 0000 0000 		.long	.LVL58
 3884 0532 0600      		.word	0x6
 3885 0534 68        		.byte	0x68
 3886 0535 93        		.byte	0x93
 3887 0536 01        		.uleb128 0x1
 3888 0537 69        		.byte	0x69
 3889 0538 93        		.byte	0x93
 3890 0539 01        		.uleb128 0x1
 3891 053a 0000 0000 		.long	.LVL58
 3892 053e 0000 0000 		.long	.LFE112
 3893 0542 0400      		.word	0x4
 3894 0544 F3        		.byte	0xf3
 3895 0545 01        		.uleb128 0x1
 3896 0546 68        		.byte	0x68
 3897 0547 9F        		.byte	0x9f
 3898 0548 0000 0000 		.long	0
 3899 054c 0000 0000 		.long	0
 3900               	.LLST26:
 3901 0550 0000 0000 		.long	.LVL56
 3902 0554 0000 0000 		.long	.LVL58
 3903 0558 0100      		.word	0x1
 3904 055a 66        		.byte	0x66
 3905 055b 0000 0000 		.long	.LVL58
 3906 055f 0000 0000 		.long	.LFE112
 3907 0563 0400      		.word	0x4
 3908 0565 F3        		.byte	0xf3
 3909 0566 01        		.uleb128 0x1
 3910 0567 66        		.byte	0x66
 3911 0568 9F        		.byte	0x9f
 3912 0569 0000 0000 		.long	0
 3913 056d 0000 0000 		.long	0
 3914               	.LLST27:
 3915 0571 0000 0000 		.long	.LVL57
 3916 0575 0000 0000 		.long	.LVL58
 3917 0579 0600      		.word	0x6
 3918 057b 68        		.byte	0x68
GAS LISTING /tmp/ccFZTQVh.s 			page 78


 3919 057c 93        		.byte	0x93
 3920 057d 01        		.uleb128 0x1
 3921 057e 69        		.byte	0x69
 3922 057f 93        		.byte	0x93
 3923 0580 01        		.uleb128 0x1
 3924 0581 0000 0000 		.long	.LVL58
 3925 0585 0000 0000 		.long	.LVL59
 3926 0589 0600      		.word	0x6
 3927 058b 6C        		.byte	0x6c
 3928 058c 93        		.byte	0x93
 3929 058d 01        		.uleb128 0x1
 3930 058e 6D        		.byte	0x6d
 3931 058f 93        		.byte	0x93
 3932 0590 01        		.uleb128 0x1
 3933 0591 0000 0000 		.long	.LVL59
 3934 0595 0000 0000 		.long	.LVL60
 3935 0599 0300      		.word	0x3
 3936 059b 8C        		.byte	0x8c
 3937 059c 01        		.sleb128 1
 3938 059d 9F        		.byte	0x9f
 3939 059e 0000 0000 		.long	.LVL60
 3940 05a2 0000 0000 		.long	.LVL65
 3941 05a6 0600      		.word	0x6
 3942 05a8 6C        		.byte	0x6c
 3943 05a9 93        		.byte	0x93
 3944 05aa 01        		.uleb128 0x1
 3945 05ab 6D        		.byte	0x6d
 3946 05ac 93        		.byte	0x93
 3947 05ad 01        		.uleb128 0x1
 3948 05ae 0000 0000 		.long	0
 3949 05b2 0000 0000 		.long	0
 3950               	.LLST28:
 3951 05b6 0000 0000 		.long	.LVL57
 3952 05ba 0000 0000 		.long	.LVL58
 3953 05be 0100      		.word	0x1
 3954 05c0 66        		.byte	0x66
 3955 05c1 0000 0000 		.long	.LVL58
 3956 05c5 0000 0000 		.long	.LVL60
 3957 05c9 0C00      		.word	0xc
 3958 05cb 8C        		.byte	0x8c
 3959 05cc 00        		.sleb128 0
 3960 05cd 20        		.byte	0x20
 3961 05ce F3        		.byte	0xf3
 3962 05cf 01        		.uleb128 0x1
 3963 05d0 66        		.byte	0x66
 3964 05d1 22        		.byte	0x22
 3965 05d2 F3        		.byte	0xf3
 3966 05d3 01        		.uleb128 0x1
 3967 05d4 68        		.byte	0x68
 3968 05d5 22        		.byte	0x22
 3969 05d6 9F        		.byte	0x9f
 3970 05d7 0000 0000 		.long	.LVL60
 3971 05db 0000 0000 		.long	.LVL64
 3972 05df 0B00      		.word	0xb
 3973 05e1 F3        		.byte	0xf3
 3974 05e2 01        		.uleb128 0x1
 3975 05e3 66        		.byte	0x66
GAS LISTING /tmp/ccFZTQVh.s 			page 79


 3976 05e4 8C        		.byte	0x8c
 3977 05e5 00        		.sleb128 0
 3978 05e6 1C        		.byte	0x1c
 3979 05e7 F3        		.byte	0xf3
 3980 05e8 01        		.uleb128 0x1
 3981 05e9 68        		.byte	0x68
 3982 05ea 22        		.byte	0x22
 3983 05eb 9F        		.byte	0x9f
 3984 05ec 0000 0000 		.long	.LVL64
 3985 05f0 0000 0000 		.long	.LVL65
 3986 05f4 0C00      		.word	0xc
 3987 05f6 8C        		.byte	0x8c
 3988 05f7 00        		.sleb128 0
 3989 05f8 20        		.byte	0x20
 3990 05f9 F3        		.byte	0xf3
 3991 05fa 01        		.uleb128 0x1
 3992 05fb 66        		.byte	0x66
 3993 05fc 22        		.byte	0x22
 3994 05fd F3        		.byte	0xf3
 3995 05fe 01        		.uleb128 0x1
 3996 05ff 68        		.byte	0x68
 3997 0600 22        		.byte	0x22
 3998 0601 9F        		.byte	0x9f
 3999 0602 0000 0000 		.long	0
 4000 0606 0000 0000 		.long	0
 4001               	.LLST29:
 4002 060a 0000 0000 		.long	.LFB114
 4003 060e 0000 0000 		.long	.LCFI23
 4004 0612 0300      		.word	0x3
 4005 0614 92        		.byte	0x92
 4006 0615 20        		.uleb128 0x20
 4007 0616 03        		.sleb128 3
 4008 0617 0000 0000 		.long	.LCFI23
 4009 061b 0000 0000 		.long	.LFE114
 4010 061f 0300      		.word	0x3
 4011 0621 92        		.byte	0x92
 4012 0622 20        		.uleb128 0x20
 4013 0623 04        		.sleb128 4
 4014 0624 0000 0000 		.long	0
 4015 0628 0000 0000 		.long	0
 4016               	.LLST30:
 4017 062c 0000 0000 		.long	.LVL82
 4018 0630 0000 0000 		.long	.LVL83
 4019 0634 0100      		.word	0x1
 4020 0636 68        		.byte	0x68
 4021 0637 0000 0000 		.long	.LVL83
 4022 063b 0000 0000 		.long	.LVL84
 4023 063f 0500      		.word	0x5
 4024 0641 03        		.byte	0x3
 4025 0642 0000 0000 		.long	lcdAddress
 4026 0646 0000 0000 		.long	.LVL84
 4027 064a 0000 0000 		.long	.LVL85
 4028 064e 0100      		.word	0x1
 4029 0650 68        		.byte	0x68
 4030 0651 0000 0000 		.long	.LVL85
 4031 0655 0000 0000 		.long	.LVL88-1
 4032 0659 0500      		.word	0x5
GAS LISTING /tmp/ccFZTQVh.s 			page 80


 4033 065b 03        		.byte	0x3
 4034 065c 0000 0000 		.long	lcdAddress
 4035 0660 0000 0000 		.long	.LVL88-1
 4036 0664 0000 0000 		.long	.LFE114
 4037 0668 0400      		.word	0x4
 4038 066a F3        		.byte	0xf3
 4039 066b 01        		.uleb128 0x1
 4040 066c 68        		.byte	0x68
 4041 066d 9F        		.byte	0x9f
 4042 066e 0000 0000 		.long	0
 4043 0672 0000 0000 		.long	0
 4044               	.LLST31:
 4045 0676 0000 0000 		.long	.LVL82
 4046 067a 0000 0000 		.long	.LVL87
 4047 067e 0100      		.word	0x1
 4048 0680 66        		.byte	0x66
 4049 0681 0000 0000 		.long	.LVL87
 4050 0685 0000 0000 		.long	.LVL88-1
 4051 0689 0500      		.word	0x5
 4052 068b 03        		.byte	0x3
 4053 068c 0000 0000 		.long	lcdCols
 4054 0690 0000 0000 		.long	.LVL88-1
 4055 0694 0000 0000 		.long	.LFE114
 4056 0698 0400      		.word	0x4
 4057 069a F3        		.byte	0xf3
 4058 069b 01        		.uleb128 0x1
 4059 069c 66        		.byte	0x66
 4060 069d 9F        		.byte	0x9f
 4061 069e 0000 0000 		.long	0
 4062 06a2 0000 0000 		.long	0
 4063               	.LLST32:
 4064 06a6 0000 0000 		.long	.LVL82
 4065 06aa 0000 0000 		.long	.LVL86
 4066 06ae 0100      		.word	0x1
 4067 06b0 64        		.byte	0x64
 4068 06b1 0000 0000 		.long	.LVL86
 4069 06b5 0000 0000 		.long	.LVL102
 4070 06b9 0100      		.word	0x1
 4071 06bb 6C        		.byte	0x6c
 4072 06bc 0000 0000 		.long	.LVL102
 4073 06c0 0000 0000 		.long	.LFE114
 4074 06c4 0400      		.word	0x4
 4075 06c6 F3        		.byte	0xf3
 4076 06c7 01        		.uleb128 0x1
 4077 06c8 64        		.byte	0x64
 4078 06c9 9F        		.byte	0x9f
 4079 06ca 0000 0000 		.long	0
 4080 06ce 0000 0000 		.long	0
 4081               	.LLST33:
 4082 06d2 0000 0000 		.long	.LVL82
 4083 06d6 0000 0000 		.long	.LVL88-1
 4084 06da 0100      		.word	0x1
 4085 06dc 62        		.byte	0x62
 4086 06dd 0000 0000 		.long	.LVL88-1
 4087 06e1 0000 0000 		.long	.LFE114
 4088 06e5 0400      		.word	0x4
 4089 06e7 F3        		.byte	0xf3
GAS LISTING /tmp/ccFZTQVh.s 			page 81


 4090 06e8 01        		.uleb128 0x1
 4091 06e9 62        		.byte	0x62
 4092 06ea 9F        		.byte	0x9f
 4093 06eb 0000 0000 		.long	0
 4094 06ef 0000 0000 		.long	0
 4095               		.section	.debug_aranges,"",@progbits
 4096 0000 8C00 0000 		.long	0x8c
 4097 0004 0200      		.word	0x2
 4098 0006 0000 0000 		.long	.Ldebug_info0
 4099 000a 04        		.byte	0x4
 4100 000b 00        		.byte	0
 4101 000c 0000      		.word	0
 4102 000e 0000      		.word	0
 4103 0010 0000 0000 		.long	.LFB102
 4104 0014 4800 0000 		.long	.LFE102-.LFB102
 4105 0018 0000 0000 		.long	.LFB103
 4106 001c 3000 0000 		.long	.LFE103-.LFB103
 4107 0020 0000 0000 		.long	.LFB104
 4108 0024 5800 0000 		.long	.LFE104-.LFB104
 4109 0028 0000 0000 		.long	.LFB105
 4110 002c CA00 0000 		.long	.LFE105-.LFB105
 4111 0030 0000 0000 		.long	.LFB106
 4112 0034 2200 0000 		.long	.LFE106-.LFB106
 4113 0038 0000 0000 		.long	.LFB107
 4114 003c 2200 0000 		.long	.LFE107-.LFB107
 4115 0040 0000 0000 		.long	.LFB108
 4116 0044 2400 0000 		.long	.LFE108-.LFB108
 4117 0048 0000 0000 		.long	.LFB109
 4118 004c 2600 0000 		.long	.LFE109-.LFB109
 4119 0050 0000 0000 		.long	.LFB110
 4120 0054 5A00 0000 		.long	.LFE110-.LFB110
 4121 0058 0000 0000 		.long	.LFB111
 4122 005c 3A00 0000 		.long	.LFE111-.LFB111
 4123 0060 0000 0000 		.long	.LFB112
 4124 0064 4400 0000 		.long	.LFE112-.LFB112
 4125 0068 0000 0000 		.long	.LFB113
 4126 006c A400 0000 		.long	.LFE113-.LFB113
 4127 0070 0000 0000 		.long	.LFB114
 4128 0074 DA00 0000 		.long	.LFE114-.LFB114
 4129 0078 0000 0000 		.long	.LFB115
 4130 007c 1600 0000 		.long	.LFE115-.LFB115
 4131 0080 0000 0000 		.long	.LFB116
 4132 0084 0200 0000 		.long	.LFE116-.LFB116
 4133 0088 0000 0000 		.long	0
 4134 008c 0000 0000 		.long	0
 4135               		.section	.debug_ranges,"",@progbits
 4136               	.Ldebug_ranges0:
 4137 0000 0000 0000 		.long	.LFB102
 4138 0004 0000 0000 		.long	.LFE102
 4139 0008 0000 0000 		.long	.LFB103
 4140 000c 0000 0000 		.long	.LFE103
 4141 0010 0000 0000 		.long	.LFB104
 4142 0014 0000 0000 		.long	.LFE104
 4143 0018 0000 0000 		.long	.LFB105
 4144 001c 0000 0000 		.long	.LFE105
 4145 0020 0000 0000 		.long	.LFB106
 4146 0024 0000 0000 		.long	.LFE106
GAS LISTING /tmp/ccFZTQVh.s 			page 82


 4147 0028 0000 0000 		.long	.LFB107
 4148 002c 0000 0000 		.long	.LFE107
 4149 0030 0000 0000 		.long	.LFB108
 4150 0034 0000 0000 		.long	.LFE108
 4151 0038 0000 0000 		.long	.LFB109
 4152 003c 0000 0000 		.long	.LFE109
 4153 0040 0000 0000 		.long	.LFB110
 4154 0044 0000 0000 		.long	.LFE110
 4155 0048 0000 0000 		.long	.LFB111
 4156 004c 0000 0000 		.long	.LFE111
 4157 0050 0000 0000 		.long	.LFB112
 4158 0054 0000 0000 		.long	.LFE112
 4159 0058 0000 0000 		.long	.LFB113
 4160 005c 0000 0000 		.long	.LFE113
 4161 0060 0000 0000 		.long	.LFB114
 4162 0064 0000 0000 		.long	.LFE114
 4163 0068 0000 0000 		.long	.LFB115
 4164 006c 0000 0000 		.long	.LFE115
 4165 0070 0000 0000 		.long	.LFB116
 4166 0074 0000 0000 		.long	.LFE116
 4167 0078 0000 0000 		.long	0
 4168 007c 0000 0000 		.long	0
 4169               		.section	.debug_line,"",@progbits
 4170               	.Ldebug_line0:
 4171 0000 E802 0000 		.section	.debug_str,"MS",@progbits,1
 4171      0200 B400 
 4171      0000 0201 
 4171      FB0E 0D00 
 4171      0101 0101 
 4172               	.LASF27:
 4173 0000 7477 6953 		.string	"twiSetup"
 4173      6574 7570 
 4173      00
 4174               	.LASF44:
 4175 0009 5F64 6174 		.string	"_data"
 4175      6100 
 4176               	.LASF9:
 4177 000f 6C6F 6E67 		.string	"long long unsigned int"
 4177      206C 6F6E 
 4177      6720 756E 
 4177      7369 676E 
 4177      6564 2069 
 4178               	.LASF18:
 4179 0026 7374 6172 		.string	"starts"
 4179      7473 00
 4180               	.LASF69:
 4181 002d 6C63 6453 		.string	"lcdShifts"
 4181      6869 6674 
 4181      7300 
 4182               	.LASF59:
 4183 0037 7477 6952 		.string	"twiRX_Count"
 4183      585F 436F 
 4183      756E 7400 
 4184               	.LASF8:
 4185 0043 6C6F 6E67 		.string	"long long int"
 4185      206C 6F6E 
 4185      6720 696E 
GAS LISTING /tmp/ccFZTQVh.s 			page 83


 4185      7400 
 4186               	.LASF0:
 4187 0051 7369 676E 		.string	"signed char"
 4187      6564 2063 
 4187      6861 7200 
 4188               	.LASF28:
 4189 005d 6672 6571 		.string	"freq"
 4189      00
 4190               	.LASF20:
 4191 0062 7374 6F70 		.string	"stops"
 4191      7300 
 4192               	.LASF17:
 4193 0068 5457 495F 		.string	"TWI_READY"
 4193      5245 4144 
 4193      5900 
 4194               	.LASF70:
 4195 0072 6C63 6453 		.string	"lcdShows"
 4195      686F 7773 
 4195      00
 4196               	.LASF5:
 4197 007b 6C6F 6E67 		.string	"long int"
 4197      2069 6E74 
 4197      00
 4198               	.LASF31:
 4199 0084 5F5F 7665 		.string	"__vector_39"
 4199      6374 6F72 
 4199      5F33 3900 
 4200               	.LASF67:
 4201 0090 7477 6953 		.string	"twiStatistic"
 4201      7461 7469 
 4201      7374 6963 
 4201      00
 4202               	.LASF3:
 4203 009d 7569 6E74 		.string	"uint16_t"
 4203      3136 5F74 
 4203      00
 4204               	.LASF13:
 4205 00a6 646F 7562 		.string	"double"
 4205      6C65 00
 4206               	.LASF41:
 4207 00ad 636C 656E 		.string	"clength"
 4207      6774 6800 
 4208               	.LASF66:
 4209 00b5 7477 6953 		.string	"twiSlaveWriter"
 4209      6C61 7665 
 4209      5772 6974 
 4209      6572 00
 4210               	.LASF39:
 4211 00c4 7477 6952 		.string	"twiRAW"
 4211      4157 00
 4212               	.LASF46:
 4213 00cb 6C63 6457 		.string	"lcdWrite"
 4213      7269 7465 
 4213      00
 4214               	.LASF38:
 4215 00d4 7477 6952 		.string	"twiRead"
 4215      6561 6400 
GAS LISTING /tmp/ccFZTQVh.s 			page 84


 4216               	.LASF25:
 4217 00dc 6269 744D 		.string	"bitMul"
 4217      756C 00
 4218               	.LASF4:
 4219 00e3 756E 7369 		.string	"unsigned int"
 4219      676E 6564 
 4219      2069 6E74 
 4219      00
 4220               	.LASF72:
 4221 00f0 6C63 6441 		.string	"lcdAddress"
 4221      6464 7265 
 4221      7373 00
 4222               	.LASF60:
 4223 00fb 7477 6952 		.string	"twiRX_Ptr"
 4223      585F 5074 
 4223      7200 
 4224               	.LASF40:
 4225 0105 636F 6D6D 		.string	"command"
 4225      616E 6400 
 4226               	.LASF83:
 4227 010d 6C6F 6F70 		.string	"loop"
 4227      00
 4228               	.LASF48:
 4229 0112 6C63 6453 		.string	"lcdSetup"
 4229      6574 7570 
 4229      00
 4230               	.LASF7:
 4231 011b 6C6F 6E67 		.string	"long unsigned int"
 4231      2075 6E73 
 4231      6967 6E65 
 4231      6420 696E 
 4231      7400 
 4232               	.LASF56:
 4233 012d 7477 6953 		.string	"twiSLARW"
 4233      4C41 5257 
 4233      00
 4234               	.LASF49:
 4235 0136 5F61 6464 		.string	"_address"
 4235      7265 7373 
 4235      00
 4236               	.LASF36:
 4237 013f 6461 7461 		.string	"data"
 4237      00
 4238               	.LASF14:
 4239 0144 7368 6F72 		.string	"short unsigned int"
 4239      7420 756E 
 4239      7369 676E 
 4239      6564 2069 
 4239      6E74 00
 4240               	.LASF23:
 4241 0157 5457 495F 		.string	"TWI_Stat"
 4241      5374 6174 
 4241      00
 4242               	.LASF51:
 4243 0160 5F72 6F77 		.string	"_rows"
 4243      7300 
 4244               	.LASF10:
GAS LISTING /tmp/ccFZTQVh.s 			page 85


 4245 0166 626F 6F6C 		.string	"bool"
 4245      00
 4246               	.LASF54:
 4247 016b 7477 694D 		.string	"twiMode"
 4247      6F64 6500 
 4248               	.LASF64:
 4249 0173 7477 694D 		.string	"twiMasterReader"
 4249      6173 7465 
 4249      7252 6561 
 4249      6465 7200 
 4250               	.LASF80:
 4251 0183 5457 495F 		.string	"TWI_Modes"
 4251      4D6F 6465 
 4251      7300 
 4252               	.LASF57:
 4253 018d 7477 694D 		.string	"twiMT_Count"
 4253      545F 436F 
 4253      756E 7400 
 4254               	.LASF30:
 4255 0199 7477 6953 		.string	"twiSendStop"
 4255      656E 6453 
 4255      746F 7000 
 4256               	.LASF33:
 4257 01a5 6164 6472 		.string	"address"
 4257      6573 7300 
 4258               	.LASF32:
 4259 01ad 5F74 7769 		.string	"_twiStartTo"
 4259      5374 6172 
 4259      7454 6F00 
 4260               	.LASF53:
 4261 01b9 7365 7475 		.string	"setup"
 4261      7000 
 4262               	.LASF12:
 4263 01bf 666C 6F61 		.string	"float"
 4263      7400 
 4264               	.LASF74:
 4265 01c5 6C63 6452 		.string	"lcdRows"
 4265      6F77 7300 
 4266               	.LASF84:
 4267 01cd 7469 6D65 		.string	"time_delay16"
 4267      5F64 656C 
 4267      6179 3136 
 4267      00
 4268               	.LASF58:
 4269 01da 7477 694D 		.string	"twiMT_Ptr"
 4269      545F 5074 
 4269      7200 
 4270               	.LASF43:
 4271 01e4 6C63 6450 		.string	"lcdPrepare"
 4271      7265 7061 
 4271      7265 00
 4272               	.LASF19:
 4273 01ef 7265 7374 		.string	"restarts"
 4273      6172 7473 
 4273      00
 4274               	.LASF52:
 4275 01f8 5F62 6163 		.string	"_backLight"
GAS LISTING /tmp/ccFZTQVh.s 			page 86


 4275      6B4C 6967 
 4275      6874 00
 4276               	.LASF77:
 4277 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4277      432B 2B20 
 4277      342E 382E 
 4277      3120 2D6D 
 4277      6D63 753D 
 4278               	.LASF1:
 4279 0295 756E 7369 		.string	"unsigned char"
 4279      676E 6564 
 4279      2063 6861 
 4279      7200 
 4280               	.LASF50:
 4281 02a3 5F63 6F6C 		.string	"_cols"
 4281      7300 
 4282               	.LASF79:
 4283 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4283      2F62 7569 
 4283      6C64 3132 
 4283      3336 3837 
 4283      3935 3737 
 4284               	.LASF24:
 4285 02cb 6269 7452 		.string	"bitRate"
 4285      6174 6500 
 4286               	.LASF55:
 4287 02d3 7477 6953 		.string	"twiState"
 4287      7461 7465 
 4287      00
 4288               	.LASF78:
 4289 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4289      2F62 7569 
 4289      6C64 3132 
 4289      3336 3837 
 4289      3935 3737 
 4290               	.LASF6:
 4291 030c 7569 6E74 		.string	"uint32_t"
 4291      3332 5F74 
 4291      00
 4292               	.LASF76:
 4293 0315 6C63 6442 		.string	"lcdBuffer"
 4293      7566 6665 
 4293      7200 
 4294               	.LASF22:
 4295 031f 6E6F 736C 		.string	"noslarw"
 4295      6172 7700 
 4296               	.LASF37:
 4297 0327 6C65 6E67 		.string	"length"
 4297      7468 00
 4298               	.LASF11:
 4299 032e 6368 6172 		.string	"char"
 4299      00
 4300               	.LASF42:
 4301 0333 646C 656E 		.string	"dlength"
 4301      6774 6800 
 4302               	.LASF29:
 4303 033b 6D6F 6465 		.string	"mode"
GAS LISTING /tmp/ccFZTQVh.s 			page 87


 4303      00
 4304               	.LASF73:
 4305 0340 6C63 6443 		.string	"lcdCols"
 4305      6F6C 7300 
 4306               	.LASF21:
 4307 0348 6C6F 7374 		.string	"losts"
 4307      7300 
 4308               	.LASF82:
 4309 034e 7469 6D65 		.string	"time"
 4309      00
 4310               	.LASF26:
 4311 0353 7477 6953 		.string	"twiSpeed"
 4311      7065 6564 
 4311      00
 4312               	.LASF16:
 4313 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4313      5345 4E44 
 4313      5F53 544F 
 4313      5000 
 4314               	.LASF71:
 4315 036a 6C63 6442 		.string	"lcdBackLight"
 4315      6163 6B4C 
 4315      6967 6874 
 4315      00
 4316               	.LASF2:
 4317 0377 7569 6E74 		.string	"uint8_t"
 4317      385F 7400 
 4318               	.LASF81:
 4319 037f 3854 5749 		.string	"8TWI_Stat"
 4319      5F53 7461 
 4319      7400 
 4320               	.LASF75:
 4321 0389 7369 7A65 		.string	"sizetype"
 4321      7479 7065 
 4321      00
 4322               	.LASF47:
 4323 0392 6C63 6449 		.string	"lcdInit"
 4323      6E69 7400 
 4324               	.LASF65:
 4325 039a 7477 6953 		.string	"twiSlaveReader"
 4325      6C61 7665 
 4325      5265 6164 
 4325      6572 00
 4326               	.LASF63:
 4327 03a9 7477 6948 		.string	"twiHookRestart"
 4327      6F6F 6B52 
 4327      6573 7461 
 4327      7274 00
 4328               	.LASF62:
 4329 03b8 7477 6953 		.string	"twiST_Ptr"
 4329      545F 5074 
 4329      7200 
 4330               	.LASF34:
 4331 03c2 5F74 7769 		.string	"_twiStartRe"
 4331      5374 6172 
 4331      7452 6500 
 4332               	.LASF35:
GAS LISTING /tmp/ccFZTQVh.s 			page 88


 4333 03ce 7477 6957 		.string	"twiWrite"
 4333      7269 7465 
 4333      00
 4334               	.LASF68:
 4335 03d7 6C63 644D 		.string	"lcdModes"
 4335      6F64 6573 
 4335      00
 4336               	.LASF45:
 4337 03e0 6E69 6262 		.string	"nibble"
 4337      6C65 00
 4338               	.LASF61:
 4339 03e7 7477 6953 		.string	"twiST_Count"
 4339      545F 436F 
 4339      756E 7400 
 4340               	.LASF15:
 4341 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4341      4953 5F53 
 4341      4C41 5645 
 4341      00
 4342               		.ident	"GCC: (GNU) 4.8.1"
 4343               	.global __do_copy_data
 4344               	.global __do_clear_bss
GAS LISTING /tmp/ccFZTQVh.s 			page 89


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccFZTQVh.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccFZTQVh.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccFZTQVh.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccFZTQVh.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccFZTQVh.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccFZTQVh.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccFZTQVh.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccFZTQVh.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccFZTQVh.s:1150   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccFZTQVh.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccFZTQVh.s:1096   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccFZTQVh.s:1138   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccFZTQVh.s:222    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccFZTQVh.s:1144   .bss.twiState:0000000000000000 twiState
     /tmp/ccFZTQVh.s:1114   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccFZTQVh.s:1084   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccFZTQVh.s:1120   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccFZTQVh.s:396    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccFZTQVh.s:431    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccFZTQVh.s:466    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccFZTQVh.s:1126   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccFZTQVh.s:1132   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccFZTQVh.s:499    .text.twiRead:0000000000000000 twiRead
     /tmp/ccFZTQVh.s:533    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccFZTQVh.s:597    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccFZTQVh.s:1049   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccFZTQVh.s:1025   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccFZTQVh.s:660    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccFZTQVh.s:1043   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccFZTQVh.s:731    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccFZTQVh.s:1067   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccFZTQVh.s:1055   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccFZTQVh.s:1061   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccFZTQVh.s:824    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccFZTQVh.s:1037   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccFZTQVh.s:1031   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccFZTQVh.s:980    .text.setup:0000000000000000 setup
     /tmp/ccFZTQVh.s:1009   .text.loop:0000000000000000 loop
     /tmp/ccFZTQVh.s:1072   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccFZTQVh.s:1078   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccFZTQVh.s:1090   .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccFZTQVh.s:1102   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccFZTQVh.s:1108   .bss.twiST_Count:0000000000000000 twiST_Count

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
