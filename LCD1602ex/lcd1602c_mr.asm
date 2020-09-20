GAS LISTING /tmp/ccjlgSmg.s 			page 1


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
GAS LISTING /tmp/ccjlgSmg.s 			page 2


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
GAS LISTING /tmp/ccjlgSmg.s 			page 3


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
GAS LISTING /tmp/ccjlgSmg.s 			page 4


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
GAS LISTING /tmp/ccjlgSmg.s 			page 5


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
GAS LISTING /tmp/ccjlgSmg.s 			page 6


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
GAS LISTING /tmp/ccjlgSmg.s 			page 7


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
GAS LISTING /tmp/ccjlgSmg.s 			page 8


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
GAS LISTING /tmp/ccjlgSmg.s 			page 9


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
GAS LISTING /tmp/ccjlgSmg.s 			page 10


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
 293 0026 8091 0000 		lds r24,twiMode
 294               	.LVL19:
 264:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     uint8_t _st = twiState=TWI_STATUS;
 295               		.loc 1 264 0
 296 002a 9091 B900 		lds r25,185
 297 002e 987F      		andi r25,lo8(-8)
 298 0030 9093 0000 		sts twiState,r25
 299               	.LVL20:
 265:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 266:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if defined(TWI_ON) && ((TWI_ON & TWI_IS_SLAVE_TX)||(TWI_ON & TWI_IS_SLAVE_RX))
 267:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     if( _st >= TWI_SR_SLA_ACK )
 268:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     {
 269:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** #if (TWI_ON & TWI_IS_SLAVE_TX)
 270:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         if( (_st == TWI_ST_DATA_NACK) || (_st == TWI_ST_LAST_DATA) )
 271:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
GAS LISTING /tmp/ccjlgSmg.s 			page 11


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
 324:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****         {
 325:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка стартовой посылки
 326:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             // MT,MR:: Прошла отправка повторного старта
 327:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             TWDR = twiSLARW;
 328:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****             _cr = twiReply(_md & TWI_IS_SLAVE);
GAS LISTING /tmp/ccjlgSmg.s 			page 12


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
 300               		.loc 1 349 0
 301 0034 9833      		cpi r25,lo8(56)
 302 0036 01F4      		brne .L22
 350:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 {
 351:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     // MT,MR: Упс. Мастер потерял шину: освобождаем 
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _md |= TWI_READY;
 303               		.loc 1 352 0
 304 0038 982F      		mov r25,r24
 305               	.LVL21:
 306 003a 9460      		ori r25,lo8(4)
 307               	.LVL22:
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 308               		.loc 1 353 0
 309 003c 80FD      		sbrc r24,0
 310 003e 00C0      		rjmp .L23
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 311               		.loc 1 352 0
 312 0040 892F      		mov r24,r25
 313               		.loc 1 353 0
 314 0042 94E8      		ldi r25,lo8(-124)
 315               	.LVL23:
 316 0044 00C0      		rjmp .L24
 317               	.LVL24:
 318               	.L22:
 354:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 355:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     if( (_st == TWI_MR_DATA_ACK) || (_st == TWI_MR_SLA_ACK) )
 319               		.loc 1 355 0
 320 0046 9035      		cpi r25,lo8(80)
 321 0048 01F0      		breq .L25
 322               		.loc 1 355 0 is_stmt 0 discriminator 1
 323 004a 9034      		cpi r25,lo8(64)
 324 004c 01F4      		brne .L41
 325 004e 00C0      		rjmp .L26
 326               	.L25:
 356:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     {
 357:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_ACK ){
GAS LISTING /tmp/ccjlgSmg.s 			page 13


 358:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: байт принят, ACK отправлен
 359:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *(twiRX_Ptr++) = TWDR;
 327               		.loc 1 359 0 is_stmt 1
 328 0050 E091 0000 		lds r30,twiRX_Ptr
 329 0054 F091 0000 		lds r31,twiRX_Ptr+1
 330 0058 9F01      		movw r18,r30
 331 005a 2F5F      		subi r18,-1
 332 005c 3F4F      		sbci r19,-1
 333 005e 3093 0000 		sts twiRX_Ptr+1,r19
 334 0062 2093 0000 		sts twiRX_Ptr,r18
 335 0066 9091 BB00 		lds r25,187
 336               	.LVL25:
 337 006a 9083      		st Z,r25
 338               	.LVL26:
 339               	.L26:
 360:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 361:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // MR: Отправитель найден, начинаем прием
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         _cr = twiReply( --twiRX_Count );        // .. Можно ещё приня�
 340               		.loc 1 362 0
 341 006c 9091 0000 		lds r25,twiRX_Count
 342 0070 9150      		subi r25,lo8(-(-1))
 343 0072 9093 0000 		sts twiRX_Count,r25
 344 0076 9923      		tst r25
 345 0078 01F0      		breq .L31
 346 007a 00C0      		rjmp .L42
 347               	.LVL27:
 348               	.L41:
 363:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 364:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_ERROR ) return;
 349               		.loc 1 364 0
 350 007c 9923      		tst r25
 351 007e 01F0      		breq .L21
 365:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         if( _st == TWI_MR_DATA_NACK )
 352               		.loc 1 365 0
 353 0080 9835      		cpi r25,lo8(88)
 354 0082 01F4      		brne .L29
 366:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         {
 367:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             // MR: Упс. Получен последний байт дальше 
 368:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             *twiRX_Ptr = TWDR;
 355               		.loc 1 368 0
 356 0084 E091 0000 		lds r30,twiRX_Ptr
 357 0088 F091 0000 		lds r31,twiRX_Ptr+1
 358 008c 8091 BB00 		lds r24,187
 359               	.LVL28:
 360 0090 8083      		st Z,r24
 369:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             if( twiMasterReader ) twiMasterReader();
 361               		.loc 1 369 0
 362 0092 E091 0000 		lds r30,twiMasterReader
 363 0096 F091 0000 		lds r31,twiMasterReader+1
 364 009a 3097      		sbiw r30,0
 365 009c 01F0      		breq .L30
 366               		.loc 1 369 0 is_stmt 0 discriminator 1
 367 009e 1995      		eicall
 368               	.LVL29:
 369               	.L30:
 370:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** //                            goto TWI_RET_HOOK;
 371:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                             _md=twiMode;                        // возможно изменен�
GAS LISTING /tmp/ccjlgSmg.s 			page 14


 370               		.loc 1 371 0 is_stmt 1 discriminator 2
 371 00a0 8091 0000 		lds r24,twiMode
 372               	.LVL30:
 373               	.L29:
 372:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         }
 373:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // All other Master states: stop/restart if need
 374:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         // TWI_MR_SLA_NACK  MR:: Упс. Отправитель NACK .. не отк
 375:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                         twiSendStop(_md); return;
 374               		.loc 1 375 0
 375 00a4 0E94 0000 		call twiSendStop
 376               	.LVL31:
 377 00a8 00C0      		rjmp .L21
 378               	.LVL32:
 379               	.L23:
 352:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     _cr = twiReleaseBus(_md & TWI_IS_SLAVE);
 380               		.loc 1 352 0
 381 00aa 892F      		mov r24,r25
 382               	.LVL33:
 383               	.L42:
 353:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                 }else{
 384               		.loc 1 353 0
 385 00ac 95EC      		ldi r25,lo8(-59)
 386 00ae 00C0      		rjmp .L24
 387               	.L31:
 362:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****                     }else{
 388               		.loc 1 362 0
 389 00b0 95E8      		ldi r25,lo8(-123)
 390               	.L24:
 391               	.LVL34:
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
 392               		.loc 1 386 0
 393 00b2 8093 0000 		sts twiMode,r24
 387:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = _cr;
 394               		.loc 1 387 0
 395 00b6 9093 BC00 		sts 188,r25
 396               	.LVL35:
 397               	.L21:
 398               	/* epilogue start */
 399               	.LBE3:
 388:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** } //end ISR()
 400               		.loc 1 388 0
 401 00ba FF91      		pop r31
 402 00bc EF91      		pop r30
 403 00be BF91      		pop r27
 404 00c0 AF91      		pop r26
 405 00c2 9F91      		pop r25
 406 00c4 8F91      		pop r24
GAS LISTING /tmp/ccjlgSmg.s 			page 15


 407 00c6 7F91      		pop r23
 408 00c8 6F91      		pop r22
 409 00ca 5F91      		pop r21
 410 00cc 4F91      		pop r20
 411 00ce 3F91      		pop r19
 412 00d0 2F91      		pop r18
 413 00d2 0F90      		pop r0
 414 00d4 0BBE      		out __RAMPZ__,r0
 415 00d6 0F90      		pop r0
 416 00d8 0FBE      		out __SREG__,r0
 417 00da 0F90      		pop r0
 418 00dc 1F90      		pop r1
 419 00de 1895      		reti
 420               		.cfi_endproc
 421               	.LFE105:
 422               		.size	__vector_39, .-__vector_39
 423               		.section	.text._twiStartTo,"ax",@progbits
 424               	.global	_twiStartTo
 425               		.type	_twiStartTo, @function
 426               	_twiStartTo:
 427               	.LFB106:
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
 428               		.loc 1 400 0
 429               		.cfi_startproc
 430               	.LVL36:
 431               	/* prologue: function */
 432               	/* frame size = 0 */
 433               	/* stack size = 0 */
 434               	.L__stack_usage = 0
 401:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 435               		.loc 1 401 0
 436 0000 8093 0000 		sts twiSLARW,r24
 402:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode |= TWI_SEND_STOP;                           // только 1 бит! Могли быт
 437               		.loc 1 402 0
 438 0004 8091 0000 		lds r24,twiMode
 439               	.LVL37:
 440 0008 8260      		ori r24,lo8(2)
 441 000a 8093 0000 		sts twiMode,r24
 442               	.LVL38:
 403:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 443               		.loc 1 403 0
 444 000e 8091 0000 		lds r24,twiMode
 445 0012 80FF      		sbrs r24,0
 446 0014 00C0      		rjmp .L45
 447 0016 85EE      		ldi r24,lo8(-27)
 448 0018 00C0      		rjmp .L44
GAS LISTING /tmp/ccjlgSmg.s 			page 16


 449               	.L45:
 450 001a 85EA      		ldi r24,lo8(-91)
 451               	.L44:
 452               		.loc 1 403 0 is_stmt 0 discriminator 3
 453 001c 8093 BC00 		sts 188,r24
 454 0020 0895      		ret
 455               		.cfi_endproc
 456               	.LFE106:
 457               		.size	_twiStartTo, .-_twiStartTo
 458               		.section	.text._twiStartRe,"ax",@progbits
 459               	.global	_twiStartRe
 460               		.type	_twiStartRe, @function
 461               	_twiStartRe:
 462               	.LFB107:
 404:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 405:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 406:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 407:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * INTERNAL:: Передача с рестартом. Запись адреса собеседни�
 408:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  *
 409:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * @see twiWrite(), twiRead()
 410:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 411:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void _twiStartRe(uint8_t address)
 412:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 463               		.loc 1 412 0 is_stmt 1
 464               		.cfi_startproc
 465               	.LVL39:
 466               	/* prologue: function */
 467               	/* frame size = 0 */
 468               	/* stack size = 0 */
 469               	.L__stack_usage = 0
 413:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = address;                                 // Режим поставляется вм
 470               		.loc 1 413 0
 471 0000 8093 0000 		sts twiSLARW,r24
 414:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // только 1 бит! Могли быт
 472               		.loc 1 414 0
 473 0004 8091 0000 		lds r24,twiMode
 474               	.LVL40:
 475 0008 8D7F      		andi r24,lo8(-3)
 476 000a 8093 0000 		sts twiMode,r24
 477               	.LVL41:
 415:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 478               		.loc 1 415 0
 479 000e 8091 0000 		lds r24,twiMode
 480 0012 80FF      		sbrs r24,0
 481 0014 00C0      		rjmp .L48
 482 0016 85EE      		ldi r24,lo8(-27)
 483 0018 00C0      		rjmp .L47
 484               	.L48:
 485 001a 85EA      		ldi r24,lo8(-91)
 486               	.L47:
 487               		.loc 1 415 0 is_stmt 0 discriminator 3
 488 001c 8093 BC00 		sts 188,r24
 489 0020 0895      		ret
 490               		.cfi_endproc
 491               	.LFE107:
 492               		.size	_twiStartRe, .-_twiStartRe
 493               		.section	.text.twiWrite,"ax",@progbits
GAS LISTING /tmp/ccjlgSmg.s 			page 17


 494               	.global	twiWrite
 495               		.type	twiWrite, @function
 496               	twiWrite:
 497               	.LFB108:
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
 498               		.loc 1 430 0 is_stmt 1
 499               		.cfi_startproc
 500               	/* prologue: function */
 501               	/* frame size = 0 */
 502               	/* stack size = 0 */
 503               	.L__stack_usage = 0
 504               	.LVL42:
 505               	.L51:
 431:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 506               		.loc 1 431 0 discriminator 1
 507 0000 9091 0000 		lds r25,twiMode
 508 0004 92FF      		sbrs r25,2
 509 0006 00C0      		rjmp .L51
 510               		.loc 1 431 0 is_stmt 0 discriminator 2
 511 0008 9091 0000 		lds r25,twiMode
 512 000c 9B7F      		andi r25,lo8(-5)
 513 000e 9093 0000 		sts twiMode,r25
 432:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(data, length);
 514               		.loc 1 432 0 is_stmt 1 discriminator 2
 515 0012 7093 0000 		sts twiMT_Ptr+1,r23
 516 0016 6093 0000 		sts twiMT_Ptr,r22
 517 001a 4093 0000 		sts twiMT_Count,r20
 433:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_WRITE );            // Режим передачи!
 518               		.loc 1 433 0 discriminator 2
 519 001e 880F      		lsl r24
 520               	.LVL43:
 521 0020 0C94 0000 		jmp _twiStartTo
 522               	.LVL44:
 523               		.cfi_endproc
 524               	.LFE108:
 525               		.size	twiWrite, .-twiWrite
 526               		.section	.text.twiRead,"ax",@progbits
 527               	.global	twiRead
 528               		.type	twiRead, @function
 529               	twiRead:
 530               	.LFB109:
 434:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 435:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
GAS LISTING /tmp/ccjlgSmg.s 			page 18


 436:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** /**
 437:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  * MASTER-RX:: Прием length байт из адреса отправителя. Только з
 438:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****  */
 439:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** void twiRead(uint8_t address, uint8_t * data, uint8_t length)
 440:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** {
 531               		.loc 1 440 0
 532               		.cfi_startproc
 533               	/* prologue: function */
 534               	/* frame size = 0 */
 535               	/* stack size = 0 */
 536               	.L__stack_usage = 0
 537               	.LVL45:
 538               	.L54:
 441:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 539               		.loc 1 441 0 discriminator 1
 540 0000 9091 0000 		lds r25,twiMode
 541 0004 92FF      		sbrs r25,2
 542 0006 00C0      		rjmp .L54
 543               		.loc 1 441 0 is_stmt 0 discriminator 2
 544 0008 9091 0000 		lds r25,twiMode
 545 000c 9B7F      		andi r25,lo8(-5)
 546 000e 9093 0000 		sts twiMode,r25
 442:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, length);
 547               		.loc 1 442 0 is_stmt 1 discriminator 2
 548 0012 7093 0000 		sts twiRX_Ptr+1,r23
 549 0016 6093 0000 		sts twiRX_Ptr,r22
 550 001a 4093 0000 		sts twiRX_Count,r20
 443:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiStartTo( (address<<1) | TWI_READ );             // Режим приема данных!
 551               		.loc 1 443 0 discriminator 2
 552 001e 880F      		lsl r24
 553               	.LVL46:
 554 0020 8160      		ori r24,lo8(1)
 555 0022 0C94 0000 		jmp _twiStartTo
 556               	.LVL47:
 557               		.cfi_endproc
 558               	.LFE109:
 559               		.size	twiRead, .-twiRead
 560               		.section	.text.twiRAW,"ax",@progbits
 561               	.global	twiRAW
 562               		.type	twiRAW, @function
 563               	twiRAW:
 564               	.LFB110:
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
 565               		.loc 1 453 0
 566               		.cfi_startproc
 567               	.LVL48:
 568 0000 0F93      		push r16
 569               	.LCFI19:
GAS LISTING /tmp/ccjlgSmg.s 			page 19


 570               		.cfi_def_cfa_offset 4
 571               		.cfi_offset 16, -3
 572               	/* prologue: function */
 573               	/* frame size = 0 */
 574               	/* stack size = 1 */
 575               	.L__stack_usage = 1
 576               	.L57:
 454:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiWaitReady();                                    // Ждем завершения преды
 577               		.loc 1 454 0 discriminator 1
 578 0002 9091 0000 		lds r25,twiMode
 579 0006 92FF      		sbrs r25,2
 580 0008 00C0      		rjmp .L57
 581               		.loc 1 454 0 is_stmt 0 discriminator 2
 582 000a 9091 0000 		lds r25,twiMode
 583 000e 9B7F      		andi r25,lo8(-5)
 584 0010 9093 0000 		sts twiMode,r25
 455:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiMT_Buffer(command, clength);
 585               		.loc 1 455 0 is_stmt 1 discriminator 2
 586 0014 7093 0000 		sts twiMT_Ptr+1,r23
 587 0018 6093 0000 		sts twiMT_Ptr,r22
 588 001c 4093 0000 		sts twiMT_Count,r20
 456:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     _twiRX_Buffer(data, dlength);
 589               		.loc 1 456 0 discriminator 2
 590 0020 3093 0000 		sts twiRX_Ptr+1,r19
 591 0024 2093 0000 		sts twiRX_Ptr,r18
 592 0028 0093 0000 		sts twiRX_Count,r16
 457:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** 
 458:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiHookRestart = 0;                                 // типовой переход на чт�
 593               		.loc 1 458 0 discriminator 2
 594 002c 1092 0000 		sts twiHookRestart+1,__zero_reg__
 595 0030 1092 0000 		sts twiHookRestart,__zero_reg__
 459:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiMode &= ~TWI_SEND_STOP;                          // рестарт после отправк
 596               		.loc 1 459 0 discriminator 2
 597 0034 9091 0000 		lds r25,twiMode
 598 0038 9D7F      		andi r25,lo8(-3)
 599 003a 9093 0000 		sts twiMode,r25
 460:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     twiSLARW = (address<<1 | TWI_WRITE);                // Сначала режим передач
 600               		.loc 1 460 0 discriminator 2
 601 003e 880F      		lsl r24
 602               	.LVL49:
 603 0040 8093 0000 		sts twiSLARW,r24
 461:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h ****     TWCR = twiStart(twiMode & TWI_IS_SLAVE);
 604               		.loc 1 461 0 discriminator 2
 605 0044 8091 0000 		lds r24,twiMode
 606 0048 80FF      		sbrs r24,0
 607 004a 00C0      		rjmp .L59
 608               		.loc 1 461 0 is_stmt 0
 609 004c 85EE      		ldi r24,lo8(-27)
 610 004e 00C0      		rjmp .L58
 611               	.L59:
 612 0050 85EA      		ldi r24,lo8(-91)
 613               	.L58:
 614               		.loc 1 461 0 discriminator 3
 615 0052 8093 BC00 		sts 188,r24
 616               	/* epilogue start */
 462:/home/arhat109/Arduino/libraries/Arhat/arhat_twi2.h **** }
 617               		.loc 1 462 0 is_stmt 1 discriminator 3
GAS LISTING /tmp/ccjlgSmg.s 			page 20


 618 0056 0F91      		pop r16
 619               	.LVL50:
 620 0058 0895      		ret
 621               		.cfi_endproc
 622               	.LFE110:
 623               		.size	twiRAW, .-twiRAW
 624               		.section	.text.lcdPrepare,"ax",@progbits
 625               	.global	lcdPrepare
 626               		.type	lcdPrepare, @function
 627               	lcdPrepare:
 628               	.LFB111:
 629               		.file 2 "LCD1602ex.ino"
   1:LCD1602ex.ino **** 
 630               		.loc 2 490 0
 631               		.cfi_startproc
 632               	.LVL51:
 633               	/* prologue: function */
 634               	/* frame size = 0 */
 635               	/* stack size = 0 */
 636               	.L__stack_usage = 0
 637               	.LBB4:
 638               		.loc 2 491 0
 639 0000 2091 0000 		lds r18,lcdBackLight
 640 0004 982F      		mov r25,r24
 641 0006 907F      		andi r25,lo8(-16)
 642 0008 922B      		or r25,r18
 643               	.LVL52:
 644               		.loc 2 493 0
 645 000a 6111      		cpse r22,__zero_reg__
 646               		.loc 2 493 0 is_stmt 0 discriminator 1
 647 000c 9160      		ori r25,lo8(1)
 648               	.LVL53:
 649               	.L61:
 650               		.loc 2 494 0 is_stmt 1
 651 000e 9093 0000 		sts lcdBuffer,r25
 652 0012 9093 0000 		sts lcdBuffer+2,r25
 653               	.LVL54:
 654               		.loc 2 495 0
 655 0016 9460      		ori r25,lo8(4)
 656               	.LVL55:
 657               		.loc 2 496 0
 658 0018 9093 0000 		sts lcdBuffer+1,r25
 659               		.loc 2 498 0
 660 001c 30E1      		ldi r19,lo8(16)
 661 001e 839F      		mul r24,r19
 662 0020 C001      		movw r24,r0
 663 0022 1124      		clr __zero_reg__
 664               	.LVL56:
 665 0024 822B      		or r24,r18
 666               	.LVL57:
 667               		.loc 2 500 0
 668 0026 6111      		cpse r22,__zero_reg__
 669               		.loc 2 500 0 is_stmt 0 discriminator 1
 670 0028 8160      		ori r24,lo8(1)
 671               	.LVL58:
 672               	.L62:
 673               		.loc 2 501 0 is_stmt 1
GAS LISTING /tmp/ccjlgSmg.s 			page 21


 674 002a 8093 0000 		sts lcdBuffer+3,r24
 675 002e 8093 0000 		sts lcdBuffer+5,r24
 676               	.LVL59:
 677               		.loc 2 502 0
 678 0032 8460      		ori r24,lo8(4)
 679               	.LVL60:
 680               		.loc 2 503 0
 681 0034 8093 0000 		sts lcdBuffer+4,r24
 682 0038 0895      		ret
 683               	.LBE4:
 684               		.cfi_endproc
 685               	.LFE111:
 686               		.size	lcdPrepare, .-lcdPrepare
 687               		.section	.text.lcdWrite,"ax",@progbits
 688               	.global	lcdWrite
 689               		.type	lcdWrite, @function
 690               	lcdWrite:
 691               	.LFB112:
 692               		.loc 2 511 0
 693               		.cfi_startproc
 694               	.LVL61:
 695 0000 1F93      		push r17
 696               	.LCFI20:
 697               		.cfi_def_cfa_offset 4
 698               		.cfi_offset 17, -3
 699 0002 CF93      		push r28
 700               	.LCFI21:
 701               		.cfi_def_cfa_offset 5
 702               		.cfi_offset 28, -4
 703 0004 DF93      		push r29
 704               	.LCFI22:
 705               		.cfi_def_cfa_offset 6
 706               		.cfi_offset 29, -5
 707               	/* prologue: function */
 708               	/* frame size = 0 */
 709               	/* stack size = 3 */
 710               	.L__stack_usage = 3
 711 0006 162F      		mov r17,r22
 712               	.LVL62:
 713               	.LBB5:
 714               		.loc 2 515 0
 715 0008 2091 0000 		lds r18,twiMode
 716 000c 2260      		ori r18,lo8(2)
 717 000e 2093 0000 		sts twiMode,r18
 718               		.loc 2 516 0
 719 0012 C82F      		mov r28,r24
 720 0014 D92F      		mov r29,r25
 721 0016 180F      		add r17,r24
 722               	.LVL63:
 723               	.L70:
 724               		.loc 2 516 0 is_stmt 0 discriminator 1
 725 0018 1C17      		cp r17,r28
 726 001a 01F0      		breq .L72
 727               	.LVL64:
 728               		.loc 2 517 0 is_stmt 1
 729 001c 61E0      		ldi r22,lo8(1)
 730 001e 8991      		ld r24,Y+
GAS LISTING /tmp/ccjlgSmg.s 			page 22


 731               	.LVL65:
 732 0020 0E94 0000 		call lcdPrepare
 733               	.LVL66:
 734 0024 46E0      		ldi r20,lo8(6)
 735 0026 60E0      		ldi r22,lo8(lcdBuffer)
 736 0028 70E0      		ldi r23,hi8(lcdBuffer)
 737 002a 8091 0000 		lds r24,lcdAddress
 738 002e 0E94 0000 		call twiWrite
 739               	.LVL67:
 740 0032 85E0      		ldi r24,lo8(5)
 741 0034 90E0      		ldi r25,0
 742 0036 0E94 0000 		call time_delay16
 743               	.LVL68:
 744 003a 00C0      		rjmp .L70
 745               	.LVL69:
 746               	.L72:
 747               	/* epilogue start */
 748               	.LBE5:
 749               		.loc 2 518 0
 750 003c DF91      		pop r29
 751 003e CF91      		pop r28
 752               	.LVL70:
 753 0040 1F91      		pop r17
 754 0042 0895      		ret
 755               		.cfi_endproc
 756               	.LFE112:
 757               		.size	lcdWrite, .-lcdWrite
 758               		.section	.text.lcdInit,"ax",@progbits
 759               	.global	lcdInit
 760               		.type	lcdInit, @function
 761               	lcdInit:
 762               	.LFB113:
 763               		.loc 2 524 0
 764               		.cfi_startproc
 765               	/* prologue: function */
 766               	/* frame size = 0 */
 767               	/* stack size = 0 */
 768               	.L__stack_usage = 0
 769               		.loc 2 525 0
 770 0000 60E0      		ldi r22,0
 771 0002 8091 0000 		lds r24,lcdModes
 772 0006 0E94 0000 		call lcdPrepare
 773               	.LVL71:
 774 000a 46E0      		ldi r20,lo8(6)
 775 000c 60E0      		ldi r22,lo8(lcdBuffer)
 776 000e 70E0      		ldi r23,hi8(lcdBuffer)
 777 0010 8091 0000 		lds r24,lcdAddress
 778 0014 0E94 0000 		call twiWrite
 779               	.LVL72:
 780 0018 85E0      		ldi r24,lo8(5)
 781 001a 90E0      		ldi r25,0
 782 001c 0E94 0000 		call time_delay16
 783               	.LVL73:
 784               		.loc 2 526 0
 785 0020 60E0      		ldi r22,0
 786 0022 8091 0000 		lds r24,lcdShows
 787 0026 0E94 0000 		call lcdPrepare
GAS LISTING /tmp/ccjlgSmg.s 			page 23


 788               	.LVL74:
 789 002a 46E0      		ldi r20,lo8(6)
 790 002c 60E0      		ldi r22,lo8(lcdBuffer)
 791 002e 70E0      		ldi r23,hi8(lcdBuffer)
 792 0030 8091 0000 		lds r24,lcdAddress
 793 0034 0E94 0000 		call twiWrite
 794               	.LVL75:
 795 0038 85E0      		ldi r24,lo8(5)
 796 003a 90E0      		ldi r25,0
 797 003c 0E94 0000 		call time_delay16
 798               	.LVL76:
 799               		.loc 2 527 0
 800 0040 60E0      		ldi r22,0
 801 0042 8091 0000 		lds r24,lcdShifts
 802 0046 0E94 0000 		call lcdPrepare
 803               	.LVL77:
 804 004a 46E0      		ldi r20,lo8(6)
 805 004c 60E0      		ldi r22,lo8(lcdBuffer)
 806 004e 70E0      		ldi r23,hi8(lcdBuffer)
 807 0050 8091 0000 		lds r24,lcdAddress
 808 0054 0E94 0000 		call twiWrite
 809               	.LVL78:
 810 0058 85E0      		ldi r24,lo8(5)
 811 005a 90E0      		ldi r25,0
 812 005c 0E94 0000 		call time_delay16
 813               	.LVL79:
 814               		.loc 2 528 0
 815 0060 60E0      		ldi r22,0
 816 0062 81E0      		ldi r24,lo8(1)
 817 0064 0E94 0000 		call lcdPrepare
 818               	.LVL80:
 819 0068 46E0      		ldi r20,lo8(6)
 820 006a 60E0      		ldi r22,lo8(lcdBuffer)
 821 006c 70E0      		ldi r23,hi8(lcdBuffer)
 822 006e 8091 0000 		lds r24,lcdAddress
 823 0072 0E94 0000 		call twiWrite
 824               	.LVL81:
 825 0076 85E0      		ldi r24,lo8(5)
 826 0078 90E0      		ldi r25,0
 827 007a 0E94 0000 		call time_delay16
 828               	.LVL82:
 829 007e 80E1      		ldi r24,lo8(16)
 830 0080 90E0      		ldi r25,0
 831 0082 0E94 0000 		call time_delay16
 832               	.LVL83:
 833               		.loc 2 529 0
 834 0086 60E0      		ldi r22,0
 835 0088 82E0      		ldi r24,lo8(2)
 836 008a 0E94 0000 		call lcdPrepare
 837               	.LVL84:
 838 008e 46E0      		ldi r20,lo8(6)
 839 0090 60E0      		ldi r22,lo8(lcdBuffer)
 840 0092 70E0      		ldi r23,hi8(lcdBuffer)
 841 0094 8091 0000 		lds r24,lcdAddress
 842 0098 0E94 0000 		call twiWrite
 843               	.LVL85:
 844 009c 85E0      		ldi r24,lo8(5)
GAS LISTING /tmp/ccjlgSmg.s 			page 24


 845 009e 90E0      		ldi r25,0
 846 00a0 0C94 0000 		jmp time_delay16
 847               	.LVL86:
 848               		.cfi_endproc
 849               	.LFE113:
 850               		.size	lcdInit, .-lcdInit
 851               		.section	.text.lcdSetup,"ax",@progbits
 852               	.global	lcdSetup
 853               		.type	lcdSetup, @function
 854               	lcdSetup:
 855               	.LFB114:
 856               		.loc 2 536 0
 857               		.cfi_startproc
 858               	.LVL87:
 859 0000 CF93      		push r28
 860               	.LCFI23:
 861               		.cfi_def_cfa_offset 4
 862               		.cfi_offset 28, -3
 863               	/* prologue: function */
 864               	/* frame size = 0 */
 865               	/* stack size = 1 */
 866               	.L__stack_usage = 1
 867 0002 C42F      		mov r28,r20
 868               		.loc 2 537 0
 869 0004 8093 0000 		sts lcdAddress,r24
 870               		.loc 2 538 0
 871 0008 6093 0000 		sts lcdCols,r22
 872               		.loc 2 539 0
 873 000c 4093 0000 		sts lcdRows,r20
 874               		.loc 2 540 0
 875 0010 2223      		tst r18
 876 0012 01F0      		breq .L77
 877 0014 88E0      		ldi r24,lo8(8)
 878               	.LVL88:
 879 0016 00C0      		rjmp .L75
 880               	.LVL89:
 881               	.L77:
 882 0018 80E0      		ldi r24,0
 883               	.LVL90:
 884               	.L75:
 885               		.loc 2 540 0 is_stmt 0 discriminator 3
 886 001a 8093 0000 		sts lcdBackLight,r24
 887               		.loc 2 541 0 is_stmt 1 discriminator 3
 888 001e 80E2      		ldi r24,lo8(32)
 889 0020 8093 0000 		sts lcdModes,r24
 890               		.loc 2 542 0 discriminator 3
 891 0024 86E0      		ldi r24,lo8(6)
 892 0026 8093 0000 		sts lcdShifts,r24
 893               		.loc 2 543 0 discriminator 3
 894 002a 8CE0      		ldi r24,lo8(12)
 895 002c 8093 0000 		sts lcdShows,r24
 896               		.loc 2 547 0 discriminator 3
 897 0030 46E0      		ldi r20,lo8(6)
 898               	.LVL91:
 899 0032 60EA      		ldi r22,lo8(-96)
 900 0034 76E8      		ldi r23,lo8(-122)
 901 0036 81E0      		ldi r24,lo8(1)
GAS LISTING /tmp/ccjlgSmg.s 			page 25


 902 0038 90E0      		ldi r25,0
 903               	.LVL92:
 904 003a 0E94 0000 		call twiSetup
 905               	.LVL93:
 906               		.loc 2 551 0 discriminator 3
 907 003e C230      		cpi r28,lo8(2)
 908 0040 00F0      		brlo .L76
 909               		.loc 2 551 0 is_stmt 0 discriminator 1
 910 0042 8091 0000 		lds r24,lcdModes
 911 0046 8860      		ori r24,lo8(8)
 912 0048 8093 0000 		sts lcdModes,r24
 913               	.L76:
 914               		.loc 2 555 0 is_stmt 1
 915 004c 60E0      		ldi r22,0
 916 004e 80E3      		ldi r24,lo8(48)
 917 0050 0E94 0000 		call lcdPrepare
 918               	.LVL94:
 919               		.loc 2 557 0
 920 0054 8FE0      		ldi r24,lo8(15)
 921 0056 90E0      		ldi r25,0
 922 0058 0E94 0000 		call time_delay16
 923               	.LVL95:
 924               		.loc 2 558 0
 925 005c 43E0      		ldi r20,lo8(3)
 926 005e 60E0      		ldi r22,lo8(lcdBuffer)
 927 0060 70E0      		ldi r23,hi8(lcdBuffer)
 928 0062 8091 0000 		lds r24,lcdAddress
 929 0066 0E94 0000 		call twiWrite
 930               	.LVL96:
 931 006a 85E0      		ldi r24,lo8(5)
 932 006c 90E0      		ldi r25,0
 933 006e 0E94 0000 		call time_delay16
 934               	.LVL97:
 935               		.loc 2 559 0
 936 0072 85E0      		ldi r24,lo8(5)
 937 0074 90E0      		ldi r25,0
 938 0076 0E94 0000 		call time_delay16
 939               	.LVL98:
 940               		.loc 2 560 0
 941 007a 43E0      		ldi r20,lo8(3)
 942 007c 60E0      		ldi r22,lo8(lcdBuffer)
 943 007e 70E0      		ldi r23,hi8(lcdBuffer)
 944 0080 8091 0000 		lds r24,lcdAddress
 945 0084 0E94 0000 		call twiWrite
 946               	.LVL99:
 947 0088 85E0      		ldi r24,lo8(5)
 948 008a 90E0      		ldi r25,0
 949 008c 0E94 0000 		call time_delay16
 950               	.LVL100:
 951               		.loc 2 561 0
 952 0090 80E9      		ldi r24,lo8(-112)
 953 0092 91E0      		ldi r25,lo8(1)
 954               	/* #APP */
 955               	 ;  561 "LCD1602ex.ino" 1
 956 0094 0197      		1: sbiw r24,1 
 957 0096 01F4      		brne 1b
 958               		
GAS LISTING /tmp/ccjlgSmg.s 			page 26


 959               	 ;  0 "" 2
 960               		.loc 2 562 0
 961               	/* #NOAPP */
 962 0098 43E0      		ldi r20,lo8(3)
 963 009a 60E0      		ldi r22,lo8(lcdBuffer)
 964 009c 70E0      		ldi r23,hi8(lcdBuffer)
 965 009e 8091 0000 		lds r24,lcdAddress
 966 00a2 0E94 0000 		call twiWrite
 967               	.LVL101:
 968 00a6 85E0      		ldi r24,lo8(5)
 969 00a8 90E0      		ldi r25,0
 970 00aa 0E94 0000 		call time_delay16
 971               	.LVL102:
 972               		.loc 2 564 0
 973 00ae 60E0      		ldi r22,0
 974 00b0 80E2      		ldi r24,lo8(32)
 975 00b2 0E94 0000 		call lcdPrepare
 976               	.LVL103:
 977               		.loc 2 565 0
 978 00b6 43E0      		ldi r20,lo8(3)
 979 00b8 60E0      		ldi r22,lo8(lcdBuffer)
 980 00ba 70E0      		ldi r23,hi8(lcdBuffer)
 981 00bc 8091 0000 		lds r24,lcdAddress
 982 00c0 0E94 0000 		call twiWrite
 983               	.LVL104:
 984 00c4 85E0      		ldi r24,lo8(5)
 985 00c6 90E0      		ldi r25,0
 986 00c8 0E94 0000 		call time_delay16
 987               	.LVL105:
 988               		.loc 2 567 0
 989 00cc 0E94 0000 		call lcdInit
 990               	.LVL106:
 991               		.loc 2 568 0
 992 00d0 84EF      		ldi r24,lo8(-12)
 993 00d2 91E0      		ldi r25,lo8(1)
 994               	/* epilogue start */
 995               		.loc 2 569 0
 996 00d4 CF91      		pop r28
 997               	.LVL107:
 998               		.loc 2 568 0
 999 00d6 0C94 0000 		jmp time_delay16
 1000               	.LVL108:
 1001               		.cfi_endproc
 1002               	.LFE114:
 1003               		.size	lcdSetup, .-lcdSetup
 1004               		.section	.rodata.str1.1,"aMS",@progbits,1
 1005               	.LC0:
 1006 0000 4865 6C6C 		.string	"Hello, AAAAAA"
 1006      6F2C 2041 
 1006      4141 4141 
 1006      4100 
 1007               		.section	.text.setup,"ax",@progbits
 1008               	.global	setup
 1009               		.type	setup, @function
 1010               	setup:
 1011               	.LFB115:
 1012               		.loc 2 577 0
GAS LISTING /tmp/ccjlgSmg.s 			page 27


 1013               		.cfi_startproc
 1014               	/* prologue: function */
 1015               	/* frame size = 0 */
 1016               	/* stack size = 0 */
 1017               	.L__stack_usage = 0
 1018               	.LBB6:
 1019               		.loc 2 581 0
 1020 0000 21E0      		ldi r18,lo8(1)
 1021 0002 42E0      		ldi r20,lo8(2)
 1022 0004 60E1      		ldi r22,lo8(16)
 1023 0006 87E2      		ldi r24,lo8(39)
 1024 0008 0E94 0000 		call lcdSetup
 1025               	.LVL109:
 1026               		.loc 2 582 0
 1027 000c 6DE0      		ldi r22,lo8(13)
 1028 000e 80E0      		ldi r24,lo8(.LC0)
 1029 0010 90E0      		ldi r25,hi8(.LC0)
 1030 0012 0C94 0000 		jmp lcdWrite
 1031               	.LVL110:
 1032               	.LBE6:
 1033               		.cfi_endproc
 1034               	.LFE115:
 1035               		.size	setup, .-setup
 1036               		.section	.text.loop,"ax",@progbits
 1037               	.global	loop
 1038               		.type	loop, @function
 1039               	loop:
 1040               	.LFB116:
 1041               		.loc 2 588 0
 1042               		.cfi_startproc
 1043               	/* prologue: function */
 1044               	/* frame size = 0 */
 1045               	/* stack size = 0 */
 1046               	.L__stack_usage = 0
 1047 0000 0895      		ret
 1048               		.cfi_endproc
 1049               	.LFE116:
 1050               		.size	loop, .-loop
 1051               	.global	lcdBuffer
 1052               		.section	.bss.lcdBuffer,"aw",@nobits
 1053               		.type	lcdBuffer, @object
 1054               		.size	lcdBuffer, 6
 1055               	lcdBuffer:
 1056 0000 0000 0000 		.zero	6
 1056      0000 
 1057               	.global	lcdRows
 1058               		.section	.data.lcdRows,"aw",@progbits
 1059               		.type	lcdRows, @object
 1060               		.size	lcdRows, 1
 1061               	lcdRows:
 1062 0000 02        		.byte	2
 1063               	.global	lcdCols
 1064               		.section	.data.lcdCols,"aw",@progbits
 1065               		.type	lcdCols, @object
 1066               		.size	lcdCols, 1
 1067               	lcdCols:
 1068 0000 10        		.byte	16
GAS LISTING /tmp/ccjlgSmg.s 			page 28


 1069               	.global	lcdAddress
 1070               		.section	.data.lcdAddress,"aw",@progbits
 1071               		.type	lcdAddress, @object
 1072               		.size	lcdAddress, 1
 1073               	lcdAddress:
 1074 0000 27        		.byte	39
 1075               	.global	lcdBackLight
 1076               		.section	.data.lcdBackLight,"aw",@progbits
 1077               		.type	lcdBackLight, @object
 1078               		.size	lcdBackLight, 1
 1079               	lcdBackLight:
 1080 0000 08        		.byte	8
 1081               	.global	lcdShows
 1082               		.section	.data.lcdShows,"aw",@progbits
 1083               		.type	lcdShows, @object
 1084               		.size	lcdShows, 1
 1085               	lcdShows:
 1086 0000 08        		.byte	8
 1087               	.global	lcdShifts
 1088               		.section	.data.lcdShifts,"aw",@progbits
 1089               		.type	lcdShifts, @object
 1090               		.size	lcdShifts, 1
 1091               	lcdShifts:
 1092 0000 06        		.byte	6
 1093               	.global	lcdModes
 1094               		.section	.data.lcdModes,"aw",@progbits
 1095               		.type	lcdModes, @object
 1096               		.size	lcdModes, 1
 1097               	lcdModes:
 1098 0000 30        		.byte	48
 1099               		.section	.bss._ZL12twiStatistic,"aw",@nobits
 1100               		.type	_ZL12twiStatistic, @object
 1101               		.size	_ZL12twiStatistic, 20
 1102               	_ZL12twiStatistic:
 1103 0000 0000 0000 		.zero	20
 1103      0000 0000 
 1103      0000 0000 
 1103      0000 0000 
 1103      0000 0000 
 1104               	.global	twiSlaveWriter
 1105               		.section	.bss.twiSlaveWriter,"aw",@nobits
 1106               		.type	twiSlaveWriter, @object
 1107               		.size	twiSlaveWriter, 2
 1108               	twiSlaveWriter:
 1109 0000 0000      		.zero	2
 1110               	.global	twiSlaveReader
 1111               		.section	.bss.twiSlaveReader,"aw",@nobits
 1112               		.type	twiSlaveReader, @object
 1113               		.size	twiSlaveReader, 2
 1114               	twiSlaveReader:
 1115 0000 0000      		.zero	2
 1116               	.global	twiMasterReader
 1117               		.section	.bss.twiMasterReader,"aw",@nobits
 1118               		.type	twiMasterReader, @object
 1119               		.size	twiMasterReader, 2
 1120               	twiMasterReader:
 1121 0000 0000      		.zero	2
GAS LISTING /tmp/ccjlgSmg.s 			page 29


 1122               	.global	twiHookRestart
 1123               		.section	.bss.twiHookRestart,"aw",@nobits
 1124               		.type	twiHookRestart, @object
 1125               		.size	twiHookRestart, 2
 1126               	twiHookRestart:
 1127 0000 0000      		.zero	2
 1128               	.global	twiST_Ptr
 1129               		.section	.bss.twiST_Ptr,"aw",@nobits
 1130               		.type	twiST_Ptr, @object
 1131               		.size	twiST_Ptr, 2
 1132               	twiST_Ptr:
 1133 0000 0000      		.zero	2
 1134               	.global	twiST_Count
 1135               		.section	.bss.twiST_Count,"aw",@nobits
 1136               		.type	twiST_Count, @object
 1137               		.size	twiST_Count, 1
 1138               	twiST_Count:
 1139 0000 00        		.zero	1
 1140               	.global	twiRX_Ptr
 1141               		.section	.bss.twiRX_Ptr,"aw",@nobits
 1142               		.type	twiRX_Ptr, @object
 1143               		.size	twiRX_Ptr, 2
 1144               	twiRX_Ptr:
 1145 0000 0000      		.zero	2
 1146               	.global	twiRX_Count
 1147               		.section	.bss.twiRX_Count,"aw",@nobits
 1148               		.type	twiRX_Count, @object
 1149               		.size	twiRX_Count, 1
 1150               	twiRX_Count:
 1151 0000 00        		.zero	1
 1152               	.global	twiMT_Ptr
 1153               		.section	.bss.twiMT_Ptr,"aw",@nobits
 1154               		.type	twiMT_Ptr, @object
 1155               		.size	twiMT_Ptr, 2
 1156               	twiMT_Ptr:
 1157 0000 0000      		.zero	2
 1158               	.global	twiMT_Count
 1159               		.section	.bss.twiMT_Count,"aw",@nobits
 1160               		.type	twiMT_Count, @object
 1161               		.size	twiMT_Count, 1
 1162               	twiMT_Count:
 1163 0000 00        		.zero	1
 1164               	.global	twiSLARW
 1165               		.section	.bss.twiSLARW,"aw",@nobits
 1166               		.type	twiSLARW, @object
 1167               		.size	twiSLARW, 1
 1168               	twiSLARW:
 1169 0000 00        		.zero	1
 1170               	.global	twiState
 1171               		.section	.bss.twiState,"aw",@nobits
 1172               		.type	twiState, @object
 1173               		.size	twiState, 1
 1174               	twiState:
 1175 0000 00        		.zero	1
 1176               	.global	twiMode
 1177               		.section	.bss.twiMode,"aw",@nobits
 1178               		.type	twiMode, @object
GAS LISTING /tmp/ccjlgSmg.s 			page 30


 1179               		.size	twiMode, 1
 1180               	twiMode:
 1181 0000 00        		.zero	1
 1182               		.text
 1183               	.Letext0:
 1184               		.file 3 "/home/arhat109/progs/arduino-1.6.4/hardware/tools/avr/avr/include/stdint.h"
 1185               		.file 4 "/home/arhat109/Arduino/libraries/Arhat/arhat.h"
 1186               		.section	.debug_info,"",@progbits
 1187               	.Ldebug_info0:
 1188 0000 260B 0000 		.long	0xb26
 1189 0004 0200      		.word	0x2
 1190 0006 0000 0000 		.long	.Ldebug_abbrev0
 1191 000a 04        		.byte	0x4
 1192 000b 01        		.uleb128 0x1
 1193 000c 0000 0000 		.long	.LASF77
 1194 0010 04        		.byte	0x4
 1195 0011 0000 0000 		.long	.LASF78
 1196 0015 0000 0000 		.long	.LASF79
 1197 0019 0000 0000 		.long	.Ldebug_ranges0+0
 1198 001d 0000 0000 		.long	0
 1199 0021 0000 0000 		.long	0
 1200 0025 0000 0000 		.long	.Ldebug_line0
 1201 0029 02        		.uleb128 0x2
 1202 002a 01        		.byte	0x1
 1203 002b 06        		.byte	0x6
 1204 002c 0000 0000 		.long	.LASF0
 1205 0030 03        		.uleb128 0x3
 1206 0031 0000 0000 		.long	.LASF2
 1207 0035 03        		.byte	0x3
 1208 0036 7A        		.byte	0x7a
 1209 0037 3B00 0000 		.long	0x3b
 1210 003b 02        		.uleb128 0x2
 1211 003c 01        		.byte	0x1
 1212 003d 08        		.byte	0x8
 1213 003e 0000 0000 		.long	.LASF1
 1214 0042 04        		.uleb128 0x4
 1215 0043 02        		.byte	0x2
 1216 0044 05        		.byte	0x5
 1217 0045 696E 7400 		.string	"int"
 1218 0049 03        		.uleb128 0x3
 1219 004a 0000 0000 		.long	.LASF3
 1220 004e 03        		.byte	0x3
 1221 004f 7C        		.byte	0x7c
 1222 0050 5400 0000 		.long	0x54
 1223 0054 02        		.uleb128 0x2
 1224 0055 02        		.byte	0x2
 1225 0056 07        		.byte	0x7
 1226 0057 0000 0000 		.long	.LASF4
 1227 005b 02        		.uleb128 0x2
 1228 005c 04        		.byte	0x4
 1229 005d 05        		.byte	0x5
 1230 005e 0000 0000 		.long	.LASF5
 1231 0062 03        		.uleb128 0x3
 1232 0063 0000 0000 		.long	.LASF6
 1233 0067 03        		.byte	0x3
 1234 0068 7E        		.byte	0x7e
 1235 0069 6D00 0000 		.long	0x6d
GAS LISTING /tmp/ccjlgSmg.s 			page 31


 1236 006d 02        		.uleb128 0x2
 1237 006e 04        		.byte	0x4
 1238 006f 07        		.byte	0x7
 1239 0070 0000 0000 		.long	.LASF7
 1240 0074 02        		.uleb128 0x2
 1241 0075 08        		.byte	0x8
 1242 0076 05        		.byte	0x5
 1243 0077 0000 0000 		.long	.LASF8
 1244 007b 02        		.uleb128 0x2
 1245 007c 08        		.byte	0x8
 1246 007d 07        		.byte	0x7
 1247 007e 0000 0000 		.long	.LASF9
 1248 0082 02        		.uleb128 0x2
 1249 0083 01        		.byte	0x1
 1250 0084 02        		.byte	0x2
 1251 0085 0000 0000 		.long	.LASF10
 1252 0089 05        		.uleb128 0x5
 1253 008a 02        		.byte	0x2
 1254 008b 8F00 0000 		.long	0x8f
 1255 008f 06        		.uleb128 0x6
 1256 0090 02        		.uleb128 0x2
 1257 0091 01        		.byte	0x1
 1258 0092 06        		.byte	0x6
 1259 0093 0000 0000 		.long	.LASF11
 1260 0097 02        		.uleb128 0x2
 1261 0098 04        		.byte	0x4
 1262 0099 04        		.byte	0x4
 1263 009a 0000 0000 		.long	.LASF12
 1264 009e 02        		.uleb128 0x2
 1265 009f 04        		.byte	0x4
 1266 00a0 04        		.byte	0x4
 1267 00a1 0000 0000 		.long	.LASF13
 1268 00a5 02        		.uleb128 0x2
 1269 00a6 02        		.byte	0x2
 1270 00a7 07        		.byte	0x7
 1271 00a8 0000 0000 		.long	.LASF14
 1272 00ac 07        		.uleb128 0x7
 1273 00ad 0000 0000 		.long	.LASF80
 1274 00b1 02        		.byte	0x2
 1275 00b2 01        		.byte	0x1
 1276 00b3 8C        		.byte	0x8c
 1277 00b4 CB00 0000 		.long	0xcb
 1278 00b8 08        		.uleb128 0x8
 1279 00b9 0000 0000 		.long	.LASF15
 1280 00bd 01        		.sleb128 1
 1281 00be 08        		.uleb128 0x8
 1282 00bf 0000 0000 		.long	.LASF16
 1283 00c3 02        		.sleb128 2
 1284 00c4 08        		.uleb128 0x8
 1285 00c5 0000 0000 		.long	.LASF17
 1286 00c9 04        		.sleb128 4
 1287 00ca 00        		.byte	0
 1288 00cb 09        		.uleb128 0x9
 1289 00cc 14        		.byte	0x14
 1290 00cd 01        		.byte	0x1
 1291 00ce A6        		.byte	0xa6
 1292 00cf 0000 0000 		.long	.LASF81
GAS LISTING /tmp/ccjlgSmg.s 			page 32


 1293 00d3 6401 0000 		.long	0x164
 1294 00d7 0A        		.uleb128 0xa
 1295 00d8 0000 0000 		.long	.LASF18
 1296 00dc 01        		.byte	0x1
 1297 00dd A7        		.byte	0xa7
 1298 00de 4900 0000 		.long	0x49
 1299 00e2 02        		.byte	0x2
 1300 00e3 23        		.byte	0x23
 1301 00e4 00        		.uleb128 0
 1302 00e5 0A        		.uleb128 0xa
 1303 00e6 0000 0000 		.long	.LASF19
 1304 00ea 01        		.byte	0x1
 1305 00eb A7        		.byte	0xa7
 1306 00ec 4900 0000 		.long	0x49
 1307 00f0 02        		.byte	0x2
 1308 00f1 23        		.byte	0x23
 1309 00f2 02        		.uleb128 0x2
 1310 00f3 0A        		.uleb128 0xa
 1311 00f4 0000 0000 		.long	.LASF20
 1312 00f8 01        		.byte	0x1
 1313 00f9 A7        		.byte	0xa7
 1314 00fa 4900 0000 		.long	0x49
 1315 00fe 02        		.byte	0x2
 1316 00ff 23        		.byte	0x23
 1317 0100 04        		.uleb128 0x4
 1318 0101 0A        		.uleb128 0xa
 1319 0102 0000 0000 		.long	.LASF21
 1320 0106 01        		.byte	0x1
 1321 0107 A7        		.byte	0xa7
 1322 0108 4900 0000 		.long	0x49
 1323 010c 02        		.byte	0x2
 1324 010d 23        		.byte	0x23
 1325 010e 06        		.uleb128 0x6
 1326 010f 0A        		.uleb128 0xa
 1327 0110 0000 0000 		.long	.LASF22
 1328 0114 01        		.byte	0x1
 1329 0115 A7        		.byte	0xa7
 1330 0116 4900 0000 		.long	0x49
 1331 011a 02        		.byte	0x2
 1332 011b 23        		.byte	0x23
 1333 011c 08        		.uleb128 0x8
 1334 011d 0B        		.uleb128 0xb
 1335 011e 6D74 7800 		.string	"mtx"
 1336 0122 01        		.byte	0x1
 1337 0123 A7        		.byte	0xa7
 1338 0124 4900 0000 		.long	0x49
 1339 0128 02        		.byte	0x2
 1340 0129 23        		.byte	0x23
 1341 012a 0A        		.uleb128 0xa
 1342 012b 0B        		.uleb128 0xb
 1343 012c 6D72 7800 		.string	"mrx"
 1344 0130 01        		.byte	0x1
 1345 0131 A7        		.byte	0xa7
 1346 0132 4900 0000 		.long	0x49
 1347 0136 02        		.byte	0x2
 1348 0137 23        		.byte	0x23
 1349 0138 0C        		.uleb128 0xc
GAS LISTING /tmp/ccjlgSmg.s 			page 33


 1350 0139 0B        		.uleb128 0xb
 1351 013a 7372 7800 		.string	"srx"
 1352 013e 01        		.byte	0x1
 1353 013f A7        		.byte	0xa7
 1354 0140 4900 0000 		.long	0x49
 1355 0144 02        		.byte	0x2
 1356 0145 23        		.byte	0x23
 1357 0146 0E        		.uleb128 0xe
 1358 0147 0B        		.uleb128 0xb
 1359 0148 6772 7800 		.string	"grx"
 1360 014c 01        		.byte	0x1
 1361 014d A7        		.byte	0xa7
 1362 014e 4900 0000 		.long	0x49
 1363 0152 02        		.byte	0x2
 1364 0153 23        		.byte	0x23
 1365 0154 10        		.uleb128 0x10
 1366 0155 0B        		.uleb128 0xb
 1367 0156 7374 7800 		.string	"stx"
 1368 015a 01        		.byte	0x1
 1369 015b A7        		.byte	0xa7
 1370 015c 4900 0000 		.long	0x49
 1371 0160 02        		.byte	0x2
 1372 0161 23        		.byte	0x23
 1373 0162 12        		.uleb128 0x12
 1374 0163 00        		.byte	0
 1375 0164 03        		.uleb128 0x3
 1376 0165 0000 0000 		.long	.LASF23
 1377 0169 01        		.byte	0x1
 1378 016a A8        		.byte	0xa8
 1379 016b CB00 0000 		.long	0xcb
 1380 016f 05        		.uleb128 0x5
 1381 0170 02        		.byte	0x2
 1382 0171 3000 0000 		.long	0x30
 1383 0175 0C        		.uleb128 0xc
 1384 0176 01        		.byte	0x1
 1385 0177 0000 0000 		.long	.LASF26
 1386 017b 01        		.byte	0x1
 1387 017c B7        		.byte	0xb7
 1388 017d 0000 0000 		.long	.LFB102
 1389 0181 0000 0000 		.long	.LFE102
 1390 0185 03        		.byte	0x3
 1391 0186 92        		.byte	0x92
 1392 0187 20        		.uleb128 0x20
 1393 0188 03        		.sleb128 3
 1394 0189 01        		.byte	0x1
 1395 018a C901 0000 		.long	0x1c9
 1396 018e 0D        		.uleb128 0xd
 1397 018f 0000 0000 		.long	.LASF28
 1398 0193 01        		.byte	0x1
 1399 0194 B7        		.byte	0xb7
 1400 0195 6200 0000 		.long	0x62
 1401 0199 0000 0000 		.long	.LLST0
 1402 019d 0E        		.uleb128 0xe
 1403 019e 0000 0000 		.long	.LBB2
 1404 01a2 0000 0000 		.long	.LBE2
 1405 01a6 0F        		.uleb128 0xf
 1406 01a7 0000 0000 		.long	.LASF24
GAS LISTING /tmp/ccjlgSmg.s 			page 34


 1407 01ab 01        		.byte	0x1
 1408 01ac B9        		.byte	0xb9
 1409 01ad 4900 0000 		.long	0x49
 1410 01b1 06        		.byte	0x6
 1411 01b2 62        		.byte	0x62
 1412 01b3 93        		.byte	0x93
 1413 01b4 01        		.uleb128 0x1
 1414 01b5 63        		.byte	0x63
 1415 01b6 93        		.byte	0x93
 1416 01b7 01        		.uleb128 0x1
 1417 01b8 10        		.uleb128 0x10
 1418 01b9 0000 0000 		.long	.LASF25
 1419 01bd 01        		.byte	0x1
 1420 01be BA        		.byte	0xba
 1421 01bf 3000 0000 		.long	0x30
 1422 01c3 0000 0000 		.long	.LLST1
 1423 01c7 00        		.byte	0
 1424 01c8 00        		.byte	0
 1425 01c9 11        		.uleb128 0x11
 1426 01ca 01        		.byte	0x1
 1427 01cb 0000 0000 		.long	.LASF27
 1428 01cf 01        		.byte	0x1
 1429 01d0 C8        		.byte	0xc8
 1430 01d1 0000 0000 		.long	.LFB103
 1431 01d5 0000 0000 		.long	.LFE103
 1432 01d9 0000 0000 		.long	.LLST2
 1433 01dd 01        		.byte	0x1
 1434 01de 1D02 0000 		.long	0x21d
 1435 01e2 0D        		.uleb128 0xd
 1436 01e3 0000 0000 		.long	.LASF28
 1437 01e7 01        		.byte	0x1
 1438 01e8 C8        		.byte	0xc8
 1439 01e9 6200 0000 		.long	0x62
 1440 01ed 0000 0000 		.long	.LLST3
 1441 01f1 0D        		.uleb128 0xd
 1442 01f2 0000 0000 		.long	.LASF29
 1443 01f6 01        		.byte	0x1
 1444 01f7 C8        		.byte	0xc8
 1445 01f8 3000 0000 		.long	0x30
 1446 01fc 0000 0000 		.long	.LLST4
 1447 0200 12        		.uleb128 0x12
 1448 0201 0000 0000 		.long	.LVL10
 1449 0205 7501 0000 		.long	0x175
 1450 0209 13        		.uleb128 0x13
 1451 020a 0C        		.byte	0xc
 1452 020b 66        		.byte	0x66
 1453 020c 93        		.byte	0x93
 1454 020d 01        		.uleb128 0x1
 1455 020e 67        		.byte	0x67
 1456 020f 93        		.byte	0x93
 1457 0210 01        		.uleb128 0x1
 1458 0211 68        		.byte	0x68
 1459 0212 93        		.byte	0x93
 1460 0213 01        		.uleb128 0x1
 1461 0214 69        		.byte	0x69
 1462 0215 93        		.byte	0x93
 1463 0216 01        		.uleb128 0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 35


 1464 0217 03        		.byte	0x3
 1465 0218 F3        		.byte	0xf3
 1466 0219 01        		.uleb128 0x1
 1467 021a 66        		.byte	0x66
 1468 021b 00        		.byte	0
 1469 021c 00        		.byte	0
 1470 021d 14        		.uleb128 0x14
 1471 021e 01        		.byte	0x1
 1472 021f 0000 0000 		.long	.LASF30
 1473 0223 01        		.byte	0x1
 1474 0224 EF        		.byte	0xef
 1475 0225 0000 0000 		.long	.LFB104
 1476 0229 0000 0000 		.long	.LFE104
 1477 022d 0000 0000 		.long	.LLST5
 1478 0231 01        		.byte	0x1
 1479 0232 4602 0000 		.long	0x246
 1480 0236 15        		.uleb128 0x15
 1481 0237 5F6D 6400 		.string	"_md"
 1482 023b 01        		.byte	0x1
 1483 023c EF        		.byte	0xef
 1484 023d 3000 0000 		.long	0x30
 1485 0241 0000 0000 		.long	.LLST6
 1486 0245 00        		.byte	0
 1487 0246 16        		.uleb128 0x16
 1488 0247 01        		.byte	0x1
 1489 0248 0000 0000 		.long	.LASF31
 1490 024c 01        		.byte	0x1
 1491 024d 0401      		.word	0x104
 1492 024f 0000 0000 		.long	.LFB105
 1493 0253 0000 0000 		.long	.LFE105
 1494 0257 0000 0000 		.long	.LLST7
 1495 025b 01        		.byte	0x1
 1496 025c A402 0000 		.long	0x2a4
 1497 0260 0E        		.uleb128 0xe
 1498 0261 0000 0000 		.long	.LBB3
 1499 0265 0000 0000 		.long	.LBE3
 1500 0269 17        		.uleb128 0x17
 1501 026a 5F63 7200 		.string	"_cr"
 1502 026e 01        		.byte	0x1
 1503 026f 0601      		.word	0x106
 1504 0271 3000 0000 		.long	0x30
 1505 0275 0000 0000 		.long	.LLST8
 1506 0279 17        		.uleb128 0x17
 1507 027a 5F6D 6400 		.string	"_md"
 1508 027e 01        		.byte	0x1
 1509 027f 0701      		.word	0x107
 1510 0281 3000 0000 		.long	0x30
 1511 0285 0000 0000 		.long	.LLST9
 1512 0289 17        		.uleb128 0x17
 1513 028a 5F73 7400 		.string	"_st"
 1514 028e 01        		.byte	0x1
 1515 028f 0801      		.word	0x108
 1516 0291 3000 0000 		.long	0x30
 1517 0295 0000 0000 		.long	.LLST10
 1518 0299 18        		.uleb128 0x18
 1519 029a 0000 0000 		.long	.LVL31
 1520 029e 1D02 0000 		.long	0x21d
GAS LISTING /tmp/ccjlgSmg.s 			page 36


 1521 02a2 00        		.byte	0
 1522 02a3 00        		.byte	0
 1523 02a4 19        		.uleb128 0x19
 1524 02a5 01        		.byte	0x1
 1525 02a6 0000 0000 		.long	.LASF32
 1526 02aa 01        		.byte	0x1
 1527 02ab 8F01      		.word	0x18f
 1528 02ad 0000 0000 		.long	.LFB106
 1529 02b1 0000 0000 		.long	.LFE106
 1530 02b5 03        		.byte	0x3
 1531 02b6 92        		.byte	0x92
 1532 02b7 20        		.uleb128 0x20
 1533 02b8 03        		.sleb128 3
 1534 02b9 01        		.byte	0x1
 1535 02ba CF02 0000 		.long	0x2cf
 1536 02be 1A        		.uleb128 0x1a
 1537 02bf 0000 0000 		.long	.LASF33
 1538 02c3 01        		.byte	0x1
 1539 02c4 8F01      		.word	0x18f
 1540 02c6 3000 0000 		.long	0x30
 1541 02ca 0000 0000 		.long	.LLST11
 1542 02ce 00        		.byte	0
 1543 02cf 19        		.uleb128 0x19
 1544 02d0 01        		.byte	0x1
 1545 02d1 0000 0000 		.long	.LASF34
 1546 02d5 01        		.byte	0x1
 1547 02d6 9B01      		.word	0x19b
 1548 02d8 0000 0000 		.long	.LFB107
 1549 02dc 0000 0000 		.long	.LFE107
 1550 02e0 03        		.byte	0x3
 1551 02e1 92        		.byte	0x92
 1552 02e2 20        		.uleb128 0x20
 1553 02e3 03        		.sleb128 3
 1554 02e4 01        		.byte	0x1
 1555 02e5 FA02 0000 		.long	0x2fa
 1556 02e9 1A        		.uleb128 0x1a
 1557 02ea 0000 0000 		.long	.LASF33
 1558 02ee 01        		.byte	0x1
 1559 02ef 9B01      		.word	0x19b
 1560 02f1 3000 0000 		.long	0x30
 1561 02f5 0000 0000 		.long	.LLST12
 1562 02f9 00        		.byte	0
 1563 02fa 19        		.uleb128 0x19
 1564 02fb 01        		.byte	0x1
 1565 02fc 0000 0000 		.long	.LASF35
 1566 0300 01        		.byte	0x1
 1567 0301 AD01      		.word	0x1ad
 1568 0303 0000 0000 		.long	.LFB108
 1569 0307 0000 0000 		.long	.LFE108
 1570 030b 03        		.byte	0x3
 1571 030c 92        		.byte	0x92
 1572 030d 20        		.uleb128 0x20
 1573 030e 03        		.sleb128 3
 1574 030f 01        		.byte	0x1
 1575 0310 5903 0000 		.long	0x359
 1576 0314 1A        		.uleb128 0x1a
 1577 0315 0000 0000 		.long	.LASF33
GAS LISTING /tmp/ccjlgSmg.s 			page 37


 1578 0319 01        		.byte	0x1
 1579 031a AD01      		.word	0x1ad
 1580 031c 3000 0000 		.long	0x30
 1581 0320 0000 0000 		.long	.LLST13
 1582 0324 1A        		.uleb128 0x1a
 1583 0325 0000 0000 		.long	.LASF36
 1584 0329 01        		.byte	0x1
 1585 032a AD01      		.word	0x1ad
 1586 032c 5903 0000 		.long	0x359
 1587 0330 0000 0000 		.long	.LLST14
 1588 0334 1A        		.uleb128 0x1a
 1589 0335 0000 0000 		.long	.LASF37
 1590 0339 01        		.byte	0x1
 1591 033a AD01      		.word	0x1ad
 1592 033c 3000 0000 		.long	0x30
 1593 0340 0000 0000 		.long	.LLST15
 1594 0344 1B        		.uleb128 0x1b
 1595 0345 0000 0000 		.long	.LVL44
 1596 0349 01        		.byte	0x1
 1597 034a A402 0000 		.long	0x2a4
 1598 034e 13        		.uleb128 0x13
 1599 034f 01        		.byte	0x1
 1600 0350 68        		.byte	0x68
 1601 0351 05        		.byte	0x5
 1602 0352 F3        		.byte	0xf3
 1603 0353 01        		.uleb128 0x1
 1604 0354 68        		.byte	0x68
 1605 0355 31        		.byte	0x31
 1606 0356 24        		.byte	0x24
 1607 0357 00        		.byte	0
 1608 0358 00        		.byte	0
 1609 0359 05        		.uleb128 0x5
 1610 035a 02        		.byte	0x2
 1611 035b 5F03 0000 		.long	0x35f
 1612 035f 1C        		.uleb128 0x1c
 1613 0360 3000 0000 		.long	0x30
 1614 0364 19        		.uleb128 0x19
 1615 0365 01        		.byte	0x1
 1616 0366 0000 0000 		.long	.LASF38
 1617 036a 01        		.byte	0x1
 1618 036b B701      		.word	0x1b7
 1619 036d 0000 0000 		.long	.LFB109
 1620 0371 0000 0000 		.long	.LFE109
 1621 0375 03        		.byte	0x3
 1622 0376 92        		.byte	0x92
 1623 0377 20        		.uleb128 0x20
 1624 0378 03        		.sleb128 3
 1625 0379 01        		.byte	0x1
 1626 037a C503 0000 		.long	0x3c5
 1627 037e 1A        		.uleb128 0x1a
 1628 037f 0000 0000 		.long	.LASF33
 1629 0383 01        		.byte	0x1
 1630 0384 B701      		.word	0x1b7
 1631 0386 3000 0000 		.long	0x30
 1632 038a 0000 0000 		.long	.LLST16
 1633 038e 1A        		.uleb128 0x1a
 1634 038f 0000 0000 		.long	.LASF36
GAS LISTING /tmp/ccjlgSmg.s 			page 38


 1635 0393 01        		.byte	0x1
 1636 0394 B701      		.word	0x1b7
 1637 0396 6F01 0000 		.long	0x16f
 1638 039a 0000 0000 		.long	.LLST17
 1639 039e 1A        		.uleb128 0x1a
 1640 039f 0000 0000 		.long	.LASF37
 1641 03a3 01        		.byte	0x1
 1642 03a4 B701      		.word	0x1b7
 1643 03a6 3000 0000 		.long	0x30
 1644 03aa 0000 0000 		.long	.LLST18
 1645 03ae 1B        		.uleb128 0x1b
 1646 03af 0000 0000 		.long	.LVL47
 1647 03b3 01        		.byte	0x1
 1648 03b4 A402 0000 		.long	0x2a4
 1649 03b8 13        		.uleb128 0x13
 1650 03b9 01        		.byte	0x1
 1651 03ba 68        		.byte	0x68
 1652 03bb 07        		.byte	0x7
 1653 03bc F3        		.byte	0xf3
 1654 03bd 01        		.uleb128 0x1
 1655 03be 68        		.byte	0x68
 1656 03bf 31        		.byte	0x31
 1657 03c0 24        		.byte	0x24
 1658 03c1 31        		.byte	0x31
 1659 03c2 21        		.byte	0x21
 1660 03c3 00        		.byte	0
 1661 03c4 00        		.byte	0
 1662 03c5 1D        		.uleb128 0x1d
 1663 03c6 01        		.byte	0x1
 1664 03c7 0000 0000 		.long	.LASF39
 1665 03cb 01        		.byte	0x1
 1666 03cc C201      		.word	0x1c2
 1667 03ce 0000 0000 		.long	.LFB110
 1668 03d2 0000 0000 		.long	.LFE110
 1669 03d6 0000 0000 		.long	.LLST19
 1670 03da 01        		.byte	0x1
 1671 03db 3404 0000 		.long	0x434
 1672 03df 1A        		.uleb128 0x1a
 1673 03e0 0000 0000 		.long	.LASF33
 1674 03e4 01        		.byte	0x1
 1675 03e5 C201      		.word	0x1c2
 1676 03e7 3000 0000 		.long	0x30
 1677 03eb 0000 0000 		.long	.LLST20
 1678 03ef 1E        		.uleb128 0x1e
 1679 03f0 0000 0000 		.long	.LASF40
 1680 03f4 01        		.byte	0x1
 1681 03f5 C301      		.word	0x1c3
 1682 03f7 6F01 0000 		.long	0x16f
 1683 03fb 06        		.byte	0x6
 1684 03fc 66        		.byte	0x66
 1685 03fd 93        		.byte	0x93
 1686 03fe 01        		.uleb128 0x1
 1687 03ff 67        		.byte	0x67
 1688 0400 93        		.byte	0x93
 1689 0401 01        		.uleb128 0x1
 1690 0402 1E        		.uleb128 0x1e
 1691 0403 0000 0000 		.long	.LASF41
GAS LISTING /tmp/ccjlgSmg.s 			page 39


 1692 0407 01        		.byte	0x1
 1693 0408 C301      		.word	0x1c3
 1694 040a 3000 0000 		.long	0x30
 1695 040e 01        		.byte	0x1
 1696 040f 64        		.byte	0x64
 1697 0410 1E        		.uleb128 0x1e
 1698 0411 0000 0000 		.long	.LASF36
 1699 0415 01        		.byte	0x1
 1700 0416 C401      		.word	0x1c4
 1701 0418 6F01 0000 		.long	0x16f
 1702 041c 06        		.byte	0x6
 1703 041d 62        		.byte	0x62
 1704 041e 93        		.byte	0x93
 1705 041f 01        		.uleb128 0x1
 1706 0420 63        		.byte	0x63
 1707 0421 93        		.byte	0x93
 1708 0422 01        		.uleb128 0x1
 1709 0423 1A        		.uleb128 0x1a
 1710 0424 0000 0000 		.long	.LASF42
 1711 0428 01        		.byte	0x1
 1712 0429 C401      		.word	0x1c4
 1713 042b 3000 0000 		.long	0x30
 1714 042f 0000 0000 		.long	.LLST21
 1715 0433 00        		.byte	0
 1716 0434 19        		.uleb128 0x19
 1717 0435 01        		.byte	0x1
 1718 0436 0000 0000 		.long	.LASF43
 1719 043a 02        		.byte	0x2
 1720 043b E901      		.word	0x1e9
 1721 043d 0000 0000 		.long	.LFB111
 1722 0441 0000 0000 		.long	.LFE111
 1723 0445 03        		.byte	0x3
 1724 0446 92        		.byte	0x92
 1725 0447 20        		.uleb128 0x20
 1726 0448 03        		.sleb128 3
 1727 0449 01        		.byte	0x1
 1728 044a 8704 0000 		.long	0x487
 1729 044e 1A        		.uleb128 0x1a
 1730 044f 0000 0000 		.long	.LASF44
 1731 0453 02        		.byte	0x2
 1732 0454 E901      		.word	0x1e9
 1733 0456 3000 0000 		.long	0x30
 1734 045a 0000 0000 		.long	.LLST22
 1735 045e 1F        		.uleb128 0x1f
 1736 045f 5F72 7300 		.string	"_rs"
 1737 0463 02        		.byte	0x2
 1738 0464 E901      		.word	0x1e9
 1739 0466 3000 0000 		.long	0x30
 1740 046a 01        		.byte	0x1
 1741 046b 66        		.byte	0x66
 1742 046c 0E        		.uleb128 0xe
 1743 046d 0000 0000 		.long	.LBB4
 1744 0471 0000 0000 		.long	.LBE4
 1745 0475 20        		.uleb128 0x20
 1746 0476 0000 0000 		.long	.LASF45
 1747 047a 02        		.byte	0x2
 1748 047b EB01      		.word	0x1eb
GAS LISTING /tmp/ccjlgSmg.s 			page 40


 1749 047d 3000 0000 		.long	0x30
 1750 0481 0000 0000 		.long	.LLST23
 1751 0485 00        		.byte	0
 1752 0486 00        		.byte	0
 1753 0487 1D        		.uleb128 0x1d
 1754 0488 01        		.byte	0x1
 1755 0489 0000 0000 		.long	.LASF46
 1756 048d 02        		.byte	0x2
 1757 048e FE01      		.word	0x1fe
 1758 0490 0000 0000 		.long	.LFB112
 1759 0494 0000 0000 		.long	.LFE112
 1760 0498 0000 0000 		.long	.LLST24
 1761 049c 01        		.byte	0x1
 1762 049d 3205 0000 		.long	0x532
 1763 04a1 21        		.uleb128 0x21
 1764 04a2 6275 6600 		.string	"buf"
 1765 04a6 02        		.byte	0x2
 1766 04a7 FE01      		.word	0x1fe
 1767 04a9 8900 0000 		.long	0x89
 1768 04ad 0000 0000 		.long	.LLST25
 1769 04b1 21        		.uleb128 0x21
 1770 04b2 6C65 6E00 		.string	"len"
 1771 04b6 02        		.byte	0x2
 1772 04b7 FE01      		.word	0x1fe
 1773 04b9 3000 0000 		.long	0x30
 1774 04bd 0000 0000 		.long	.LLST26
 1775 04c1 0E        		.uleb128 0xe
 1776 04c2 0000 0000 		.long	.LBB5
 1777 04c6 0000 0000 		.long	.LBE5
 1778 04ca 17        		.uleb128 0x17
 1779 04cb 5F62 00   		.string	"_b"
 1780 04ce 02        		.byte	0x2
 1781 04cf 0002      		.word	0x200
 1782 04d1 6F01 0000 		.long	0x16f
 1783 04d5 0000 0000 		.long	.LLST27
 1784 04d9 17        		.uleb128 0x17
 1785 04da 5F6C 00   		.string	"_l"
 1786 04dd 02        		.byte	0x2
 1787 04de 0102      		.word	0x201
 1788 04e0 3000 0000 		.long	0x30
 1789 04e4 0000 0000 		.long	.LLST28
 1790 04e8 22        		.uleb128 0x22
 1791 04e9 0000 0000 		.long	.LVL66
 1792 04ed 3404 0000 		.long	0x434
 1793 04f1 FB04 0000 		.long	0x4fb
 1794 04f5 13        		.uleb128 0x13
 1795 04f6 01        		.byte	0x1
 1796 04f7 66        		.byte	0x66
 1797 04f8 01        		.byte	0x1
 1798 04f9 31        		.byte	0x31
 1799 04fa 00        		.byte	0
 1800 04fb 22        		.uleb128 0x22
 1801 04fc 0000 0000 		.long	.LVL67
 1802 0500 FA02 0000 		.long	0x2fa
 1803 0504 1C05 0000 		.long	0x51c
 1804 0508 13        		.uleb128 0x13
 1805 0509 06        		.byte	0x6
GAS LISTING /tmp/ccjlgSmg.s 			page 41


 1806 050a 66        		.byte	0x66
 1807 050b 93        		.byte	0x93
 1808 050c 01        		.uleb128 0x1
 1809 050d 67        		.byte	0x67
 1810 050e 93        		.byte	0x93
 1811 050f 01        		.uleb128 0x1
 1812 0510 05        		.byte	0x5
 1813 0511 03        		.byte	0x3
 1814 0512 0000 0000 		.long	lcdBuffer
 1815 0516 13        		.uleb128 0x13
 1816 0517 01        		.byte	0x1
 1817 0518 64        		.byte	0x64
 1818 0519 01        		.byte	0x1
 1819 051a 36        		.byte	0x36
 1820 051b 00        		.byte	0
 1821 051c 12        		.uleb128 0x12
 1822 051d 0000 0000 		.long	.LVL68
 1823 0521 190B 0000 		.long	0xb19
 1824 0525 13        		.uleb128 0x13
 1825 0526 06        		.byte	0x6
 1826 0527 68        		.byte	0x68
 1827 0528 93        		.byte	0x93
 1828 0529 01        		.uleb128 0x1
 1829 052a 69        		.byte	0x69
 1830 052b 93        		.byte	0x93
 1831 052c 01        		.uleb128 0x1
 1832 052d 01        		.byte	0x1
 1833 052e 35        		.byte	0x35
 1834 052f 00        		.byte	0
 1835 0530 00        		.byte	0
 1836 0531 00        		.byte	0
 1837 0532 19        		.uleb128 0x19
 1838 0533 01        		.byte	0x1
 1839 0534 0000 0000 		.long	.LASF47
 1840 0538 02        		.byte	0x2
 1841 0539 0B02      		.word	0x20b
 1842 053b 0000 0000 		.long	.LFB113
 1843 053f 0000 0000 		.long	.LFE113
 1844 0543 03        		.byte	0x3
 1845 0544 92        		.byte	0x92
 1846 0545 20        		.uleb128 0x20
 1847 0546 03        		.sleb128 3
 1848 0547 01        		.byte	0x1
 1849 0548 E806 0000 		.long	0x6e8
 1850 054c 22        		.uleb128 0x22
 1851 054d 0000 0000 		.long	.LVL71
 1852 0551 3404 0000 		.long	0x434
 1853 0555 5F05 0000 		.long	0x55f
 1854 0559 13        		.uleb128 0x13
 1855 055a 01        		.byte	0x1
 1856 055b 66        		.byte	0x66
 1857 055c 01        		.byte	0x1
 1858 055d 30        		.byte	0x30
 1859 055e 00        		.byte	0
 1860 055f 22        		.uleb128 0x22
 1861 0560 0000 0000 		.long	.LVL72
 1862 0564 FA02 0000 		.long	0x2fa
GAS LISTING /tmp/ccjlgSmg.s 			page 42


 1863 0568 8005 0000 		.long	0x580
 1864 056c 13        		.uleb128 0x13
 1865 056d 06        		.byte	0x6
 1866 056e 66        		.byte	0x66
 1867 056f 93        		.byte	0x93
 1868 0570 01        		.uleb128 0x1
 1869 0571 67        		.byte	0x67
 1870 0572 93        		.byte	0x93
 1871 0573 01        		.uleb128 0x1
 1872 0574 05        		.byte	0x5
 1873 0575 03        		.byte	0x3
 1874 0576 0000 0000 		.long	lcdBuffer
 1875 057a 13        		.uleb128 0x13
 1876 057b 01        		.byte	0x1
 1877 057c 64        		.byte	0x64
 1878 057d 01        		.byte	0x1
 1879 057e 36        		.byte	0x36
 1880 057f 00        		.byte	0
 1881 0580 22        		.uleb128 0x22
 1882 0581 0000 0000 		.long	.LVL73
 1883 0585 190B 0000 		.long	0xb19
 1884 0589 9805 0000 		.long	0x598
 1885 058d 13        		.uleb128 0x13
 1886 058e 06        		.byte	0x6
 1887 058f 68        		.byte	0x68
 1888 0590 93        		.byte	0x93
 1889 0591 01        		.uleb128 0x1
 1890 0592 69        		.byte	0x69
 1891 0593 93        		.byte	0x93
 1892 0594 01        		.uleb128 0x1
 1893 0595 01        		.byte	0x1
 1894 0596 35        		.byte	0x35
 1895 0597 00        		.byte	0
 1896 0598 22        		.uleb128 0x22
 1897 0599 0000 0000 		.long	.LVL74
 1898 059d 3404 0000 		.long	0x434
 1899 05a1 AB05 0000 		.long	0x5ab
 1900 05a5 13        		.uleb128 0x13
 1901 05a6 01        		.byte	0x1
 1902 05a7 66        		.byte	0x66
 1903 05a8 01        		.byte	0x1
 1904 05a9 30        		.byte	0x30
 1905 05aa 00        		.byte	0
 1906 05ab 22        		.uleb128 0x22
 1907 05ac 0000 0000 		.long	.LVL75
 1908 05b0 FA02 0000 		.long	0x2fa
 1909 05b4 CC05 0000 		.long	0x5cc
 1910 05b8 13        		.uleb128 0x13
 1911 05b9 06        		.byte	0x6
 1912 05ba 66        		.byte	0x66
 1913 05bb 93        		.byte	0x93
 1914 05bc 01        		.uleb128 0x1
 1915 05bd 67        		.byte	0x67
 1916 05be 93        		.byte	0x93
 1917 05bf 01        		.uleb128 0x1
 1918 05c0 05        		.byte	0x5
 1919 05c1 03        		.byte	0x3
GAS LISTING /tmp/ccjlgSmg.s 			page 43


 1920 05c2 0000 0000 		.long	lcdBuffer
 1921 05c6 13        		.uleb128 0x13
 1922 05c7 01        		.byte	0x1
 1923 05c8 64        		.byte	0x64
 1924 05c9 01        		.byte	0x1
 1925 05ca 36        		.byte	0x36
 1926 05cb 00        		.byte	0
 1927 05cc 22        		.uleb128 0x22
 1928 05cd 0000 0000 		.long	.LVL76
 1929 05d1 190B 0000 		.long	0xb19
 1930 05d5 E405 0000 		.long	0x5e4
 1931 05d9 13        		.uleb128 0x13
 1932 05da 06        		.byte	0x6
 1933 05db 68        		.byte	0x68
 1934 05dc 93        		.byte	0x93
 1935 05dd 01        		.uleb128 0x1
 1936 05de 69        		.byte	0x69
 1937 05df 93        		.byte	0x93
 1938 05e0 01        		.uleb128 0x1
 1939 05e1 01        		.byte	0x1
 1940 05e2 35        		.byte	0x35
 1941 05e3 00        		.byte	0
 1942 05e4 22        		.uleb128 0x22
 1943 05e5 0000 0000 		.long	.LVL77
 1944 05e9 3404 0000 		.long	0x434
 1945 05ed F705 0000 		.long	0x5f7
 1946 05f1 13        		.uleb128 0x13
 1947 05f2 01        		.byte	0x1
 1948 05f3 66        		.byte	0x66
 1949 05f4 01        		.byte	0x1
 1950 05f5 30        		.byte	0x30
 1951 05f6 00        		.byte	0
 1952 05f7 22        		.uleb128 0x22
 1953 05f8 0000 0000 		.long	.LVL78
 1954 05fc FA02 0000 		.long	0x2fa
 1955 0600 1806 0000 		.long	0x618
 1956 0604 13        		.uleb128 0x13
 1957 0605 06        		.byte	0x6
 1958 0606 66        		.byte	0x66
 1959 0607 93        		.byte	0x93
 1960 0608 01        		.uleb128 0x1
 1961 0609 67        		.byte	0x67
 1962 060a 93        		.byte	0x93
 1963 060b 01        		.uleb128 0x1
 1964 060c 05        		.byte	0x5
 1965 060d 03        		.byte	0x3
 1966 060e 0000 0000 		.long	lcdBuffer
 1967 0612 13        		.uleb128 0x13
 1968 0613 01        		.byte	0x1
 1969 0614 64        		.byte	0x64
 1970 0615 01        		.byte	0x1
 1971 0616 36        		.byte	0x36
 1972 0617 00        		.byte	0
 1973 0618 22        		.uleb128 0x22
 1974 0619 0000 0000 		.long	.LVL79
 1975 061d 190B 0000 		.long	0xb19
 1976 0621 3006 0000 		.long	0x630
GAS LISTING /tmp/ccjlgSmg.s 			page 44


 1977 0625 13        		.uleb128 0x13
 1978 0626 06        		.byte	0x6
 1979 0627 68        		.byte	0x68
 1980 0628 93        		.byte	0x93
 1981 0629 01        		.uleb128 0x1
 1982 062a 69        		.byte	0x69
 1983 062b 93        		.byte	0x93
 1984 062c 01        		.uleb128 0x1
 1985 062d 01        		.byte	0x1
 1986 062e 35        		.byte	0x35
 1987 062f 00        		.byte	0
 1988 0630 22        		.uleb128 0x22
 1989 0631 0000 0000 		.long	.LVL80
 1990 0635 3404 0000 		.long	0x434
 1991 0639 4806 0000 		.long	0x648
 1992 063d 13        		.uleb128 0x13
 1993 063e 01        		.byte	0x1
 1994 063f 68        		.byte	0x68
 1995 0640 01        		.byte	0x1
 1996 0641 31        		.byte	0x31
 1997 0642 13        		.uleb128 0x13
 1998 0643 01        		.byte	0x1
 1999 0644 66        		.byte	0x66
 2000 0645 01        		.byte	0x1
 2001 0646 30        		.byte	0x30
 2002 0647 00        		.byte	0
 2003 0648 22        		.uleb128 0x22
 2004 0649 0000 0000 		.long	.LVL81
 2005 064d FA02 0000 		.long	0x2fa
 2006 0651 6906 0000 		.long	0x669
 2007 0655 13        		.uleb128 0x13
 2008 0656 06        		.byte	0x6
 2009 0657 66        		.byte	0x66
 2010 0658 93        		.byte	0x93
 2011 0659 01        		.uleb128 0x1
 2012 065a 67        		.byte	0x67
 2013 065b 93        		.byte	0x93
 2014 065c 01        		.uleb128 0x1
 2015 065d 05        		.byte	0x5
 2016 065e 03        		.byte	0x3
 2017 065f 0000 0000 		.long	lcdBuffer
 2018 0663 13        		.uleb128 0x13
 2019 0664 01        		.byte	0x1
 2020 0665 64        		.byte	0x64
 2021 0666 01        		.byte	0x1
 2022 0667 36        		.byte	0x36
 2023 0668 00        		.byte	0
 2024 0669 22        		.uleb128 0x22
 2025 066a 0000 0000 		.long	.LVL82
 2026 066e 190B 0000 		.long	0xb19
 2027 0672 8106 0000 		.long	0x681
 2028 0676 13        		.uleb128 0x13
 2029 0677 06        		.byte	0x6
 2030 0678 68        		.byte	0x68
 2031 0679 93        		.byte	0x93
 2032 067a 01        		.uleb128 0x1
 2033 067b 69        		.byte	0x69
GAS LISTING /tmp/ccjlgSmg.s 			page 45


 2034 067c 93        		.byte	0x93
 2035 067d 01        		.uleb128 0x1
 2036 067e 01        		.byte	0x1
 2037 067f 35        		.byte	0x35
 2038 0680 00        		.byte	0
 2039 0681 22        		.uleb128 0x22
 2040 0682 0000 0000 		.long	.LVL83
 2041 0686 190B 0000 		.long	0xb19
 2042 068a 9906 0000 		.long	0x699
 2043 068e 13        		.uleb128 0x13
 2044 068f 06        		.byte	0x6
 2045 0690 68        		.byte	0x68
 2046 0691 93        		.byte	0x93
 2047 0692 01        		.uleb128 0x1
 2048 0693 69        		.byte	0x69
 2049 0694 93        		.byte	0x93
 2050 0695 01        		.uleb128 0x1
 2051 0696 01        		.byte	0x1
 2052 0697 40        		.byte	0x40
 2053 0698 00        		.byte	0
 2054 0699 22        		.uleb128 0x22
 2055 069a 0000 0000 		.long	.LVL84
 2056 069e 3404 0000 		.long	0x434
 2057 06a2 B106 0000 		.long	0x6b1
 2058 06a6 13        		.uleb128 0x13
 2059 06a7 01        		.byte	0x1
 2060 06a8 68        		.byte	0x68
 2061 06a9 01        		.byte	0x1
 2062 06aa 32        		.byte	0x32
 2063 06ab 13        		.uleb128 0x13
 2064 06ac 01        		.byte	0x1
 2065 06ad 66        		.byte	0x66
 2066 06ae 01        		.byte	0x1
 2067 06af 30        		.byte	0x30
 2068 06b0 00        		.byte	0
 2069 06b1 22        		.uleb128 0x22
 2070 06b2 0000 0000 		.long	.LVL85
 2071 06b6 FA02 0000 		.long	0x2fa
 2072 06ba D206 0000 		.long	0x6d2
 2073 06be 13        		.uleb128 0x13
 2074 06bf 06        		.byte	0x6
 2075 06c0 66        		.byte	0x66
 2076 06c1 93        		.byte	0x93
 2077 06c2 01        		.uleb128 0x1
 2078 06c3 67        		.byte	0x67
 2079 06c4 93        		.byte	0x93
 2080 06c5 01        		.uleb128 0x1
 2081 06c6 05        		.byte	0x5
 2082 06c7 03        		.byte	0x3
 2083 06c8 0000 0000 		.long	lcdBuffer
 2084 06cc 13        		.uleb128 0x13
 2085 06cd 01        		.byte	0x1
 2086 06ce 64        		.byte	0x64
 2087 06cf 01        		.byte	0x1
 2088 06d0 36        		.byte	0x36
 2089 06d1 00        		.byte	0
 2090 06d2 1B        		.uleb128 0x1b
GAS LISTING /tmp/ccjlgSmg.s 			page 46


 2091 06d3 0000 0000 		.long	.LVL86
 2092 06d7 01        		.byte	0x1
 2093 06d8 190B 0000 		.long	0xb19
 2094 06dc 13        		.uleb128 0x13
 2095 06dd 06        		.byte	0x6
 2096 06de 68        		.byte	0x68
 2097 06df 93        		.byte	0x93
 2098 06e0 01        		.uleb128 0x1
 2099 06e1 69        		.byte	0x69
 2100 06e2 93        		.byte	0x93
 2101 06e3 01        		.uleb128 0x1
 2102 06e4 01        		.byte	0x1
 2103 06e5 35        		.byte	0x35
 2104 06e6 00        		.byte	0
 2105 06e7 00        		.byte	0
 2106 06e8 1D        		.uleb128 0x1d
 2107 06e9 01        		.byte	0x1
 2108 06ea 0000 0000 		.long	.LASF48
 2109 06ee 02        		.byte	0x2
 2110 06ef 1702      		.word	0x217
 2111 06f1 0000 0000 		.long	.LFB114
 2112 06f5 0000 0000 		.long	.LFE114
 2113 06f9 0000 0000 		.long	.LLST29
 2114 06fd 01        		.byte	0x1
 2115 06fe D008 0000 		.long	0x8d0
 2116 0702 1A        		.uleb128 0x1a
 2117 0703 0000 0000 		.long	.LASF49
 2118 0707 02        		.byte	0x2
 2119 0708 1702      		.word	0x217
 2120 070a 3000 0000 		.long	0x30
 2121 070e 0000 0000 		.long	.LLST30
 2122 0712 1A        		.uleb128 0x1a
 2123 0713 0000 0000 		.long	.LASF50
 2124 0717 02        		.byte	0x2
 2125 0718 1702      		.word	0x217
 2126 071a 3000 0000 		.long	0x30
 2127 071e 0000 0000 		.long	.LLST31
 2128 0722 1A        		.uleb128 0x1a
 2129 0723 0000 0000 		.long	.LASF51
 2130 0727 02        		.byte	0x2
 2131 0728 1702      		.word	0x217
 2132 072a 3000 0000 		.long	0x30
 2133 072e 0000 0000 		.long	.LLST32
 2134 0732 1A        		.uleb128 0x1a
 2135 0733 0000 0000 		.long	.LASF52
 2136 0737 02        		.byte	0x2
 2137 0738 1702      		.word	0x217
 2138 073a 3000 0000 		.long	0x30
 2139 073e 0000 0000 		.long	.LLST33
 2140 0742 22        		.uleb128 0x22
 2141 0743 0000 0000 		.long	.LVL93
 2142 0747 C901 0000 		.long	0x1c9
 2143 074b 6907 0000 		.long	0x769
 2144 074f 13        		.uleb128 0x13
 2145 0750 0C        		.byte	0xc
 2146 0751 66        		.byte	0x66
 2147 0752 93        		.byte	0x93
GAS LISTING /tmp/ccjlgSmg.s 			page 47


 2148 0753 01        		.uleb128 0x1
 2149 0754 67        		.byte	0x67
 2150 0755 93        		.byte	0x93
 2151 0756 01        		.uleb128 0x1
 2152 0757 68        		.byte	0x68
 2153 0758 93        		.byte	0x93
 2154 0759 01        		.uleb128 0x1
 2155 075a 69        		.byte	0x69
 2156 075b 93        		.byte	0x93
 2157 075c 01        		.uleb128 0x1
 2158 075d 05        		.byte	0x5
 2159 075e 0C        		.byte	0xc
 2160 075f A086 0100 		.long	0x186a0
 2161 0763 13        		.uleb128 0x13
 2162 0764 01        		.byte	0x1
 2163 0765 64        		.byte	0x64
 2164 0766 01        		.byte	0x1
 2165 0767 36        		.byte	0x36
 2166 0768 00        		.byte	0
 2167 0769 22        		.uleb128 0x22
 2168 076a 0000 0000 		.long	.LVL94
 2169 076e 3404 0000 		.long	0x434
 2170 0772 8207 0000 		.long	0x782
 2171 0776 13        		.uleb128 0x13
 2172 0777 01        		.byte	0x1
 2173 0778 68        		.byte	0x68
 2174 0779 02        		.byte	0x2
 2175 077a 08        		.byte	0x8
 2176 077b 30        		.byte	0x30
 2177 077c 13        		.uleb128 0x13
 2178 077d 01        		.byte	0x1
 2179 077e 66        		.byte	0x66
 2180 077f 01        		.byte	0x1
 2181 0780 30        		.byte	0x30
 2182 0781 00        		.byte	0
 2183 0782 22        		.uleb128 0x22
 2184 0783 0000 0000 		.long	.LVL95
 2185 0787 190B 0000 		.long	0xb19
 2186 078b 9A07 0000 		.long	0x79a
 2187 078f 13        		.uleb128 0x13
 2188 0790 06        		.byte	0x6
 2189 0791 68        		.byte	0x68
 2190 0792 93        		.byte	0x93
 2191 0793 01        		.uleb128 0x1
 2192 0794 69        		.byte	0x69
 2193 0795 93        		.byte	0x93
 2194 0796 01        		.uleb128 0x1
 2195 0797 01        		.byte	0x1
 2196 0798 3F        		.byte	0x3f
 2197 0799 00        		.byte	0
 2198 079a 22        		.uleb128 0x22
 2199 079b 0000 0000 		.long	.LVL96
 2200 079f FA02 0000 		.long	0x2fa
 2201 07a3 BB07 0000 		.long	0x7bb
 2202 07a7 13        		.uleb128 0x13
 2203 07a8 06        		.byte	0x6
 2204 07a9 66        		.byte	0x66
GAS LISTING /tmp/ccjlgSmg.s 			page 48


 2205 07aa 93        		.byte	0x93
 2206 07ab 01        		.uleb128 0x1
 2207 07ac 67        		.byte	0x67
 2208 07ad 93        		.byte	0x93
 2209 07ae 01        		.uleb128 0x1
 2210 07af 05        		.byte	0x5
 2211 07b0 03        		.byte	0x3
 2212 07b1 0000 0000 		.long	lcdBuffer
 2213 07b5 13        		.uleb128 0x13
 2214 07b6 01        		.byte	0x1
 2215 07b7 64        		.byte	0x64
 2216 07b8 01        		.byte	0x1
 2217 07b9 33        		.byte	0x33
 2218 07ba 00        		.byte	0
 2219 07bb 22        		.uleb128 0x22
 2220 07bc 0000 0000 		.long	.LVL97
 2221 07c0 190B 0000 		.long	0xb19
 2222 07c4 D307 0000 		.long	0x7d3
 2223 07c8 13        		.uleb128 0x13
 2224 07c9 06        		.byte	0x6
 2225 07ca 68        		.byte	0x68
 2226 07cb 93        		.byte	0x93
 2227 07cc 01        		.uleb128 0x1
 2228 07cd 69        		.byte	0x69
 2229 07ce 93        		.byte	0x93
 2230 07cf 01        		.uleb128 0x1
 2231 07d0 01        		.byte	0x1
 2232 07d1 35        		.byte	0x35
 2233 07d2 00        		.byte	0
 2234 07d3 22        		.uleb128 0x22
 2235 07d4 0000 0000 		.long	.LVL98
 2236 07d8 190B 0000 		.long	0xb19
 2237 07dc EB07 0000 		.long	0x7eb
 2238 07e0 13        		.uleb128 0x13
 2239 07e1 06        		.byte	0x6
 2240 07e2 68        		.byte	0x68
 2241 07e3 93        		.byte	0x93
 2242 07e4 01        		.uleb128 0x1
 2243 07e5 69        		.byte	0x69
 2244 07e6 93        		.byte	0x93
 2245 07e7 01        		.uleb128 0x1
 2246 07e8 01        		.byte	0x1
 2247 07e9 35        		.byte	0x35
 2248 07ea 00        		.byte	0
 2249 07eb 22        		.uleb128 0x22
 2250 07ec 0000 0000 		.long	.LVL99
 2251 07f0 FA02 0000 		.long	0x2fa
 2252 07f4 0C08 0000 		.long	0x80c
 2253 07f8 13        		.uleb128 0x13
 2254 07f9 06        		.byte	0x6
 2255 07fa 66        		.byte	0x66
 2256 07fb 93        		.byte	0x93
 2257 07fc 01        		.uleb128 0x1
 2258 07fd 67        		.byte	0x67
 2259 07fe 93        		.byte	0x93
 2260 07ff 01        		.uleb128 0x1
 2261 0800 05        		.byte	0x5
GAS LISTING /tmp/ccjlgSmg.s 			page 49


 2262 0801 03        		.byte	0x3
 2263 0802 0000 0000 		.long	lcdBuffer
 2264 0806 13        		.uleb128 0x13
 2265 0807 01        		.byte	0x1
 2266 0808 64        		.byte	0x64
 2267 0809 01        		.byte	0x1
 2268 080a 33        		.byte	0x33
 2269 080b 00        		.byte	0
 2270 080c 22        		.uleb128 0x22
 2271 080d 0000 0000 		.long	.LVL100
 2272 0811 190B 0000 		.long	0xb19
 2273 0815 2408 0000 		.long	0x824
 2274 0819 13        		.uleb128 0x13
 2275 081a 06        		.byte	0x6
 2276 081b 68        		.byte	0x68
 2277 081c 93        		.byte	0x93
 2278 081d 01        		.uleb128 0x1
 2279 081e 69        		.byte	0x69
 2280 081f 93        		.byte	0x93
 2281 0820 01        		.uleb128 0x1
 2282 0821 01        		.byte	0x1
 2283 0822 35        		.byte	0x35
 2284 0823 00        		.byte	0
 2285 0824 22        		.uleb128 0x22
 2286 0825 0000 0000 		.long	.LVL101
 2287 0829 FA02 0000 		.long	0x2fa
 2288 082d 4508 0000 		.long	0x845
 2289 0831 13        		.uleb128 0x13
 2290 0832 06        		.byte	0x6
 2291 0833 66        		.byte	0x66
 2292 0834 93        		.byte	0x93
 2293 0835 01        		.uleb128 0x1
 2294 0836 67        		.byte	0x67
 2295 0837 93        		.byte	0x93
 2296 0838 01        		.uleb128 0x1
 2297 0839 05        		.byte	0x5
 2298 083a 03        		.byte	0x3
 2299 083b 0000 0000 		.long	lcdBuffer
 2300 083f 13        		.uleb128 0x13
 2301 0840 01        		.byte	0x1
 2302 0841 64        		.byte	0x64
 2303 0842 01        		.byte	0x1
 2304 0843 33        		.byte	0x33
 2305 0844 00        		.byte	0
 2306 0845 22        		.uleb128 0x22
 2307 0846 0000 0000 		.long	.LVL102
 2308 084a 190B 0000 		.long	0xb19
 2309 084e 5D08 0000 		.long	0x85d
 2310 0852 13        		.uleb128 0x13
 2311 0853 06        		.byte	0x6
 2312 0854 68        		.byte	0x68
 2313 0855 93        		.byte	0x93
 2314 0856 01        		.uleb128 0x1
 2315 0857 69        		.byte	0x69
 2316 0858 93        		.byte	0x93
 2317 0859 01        		.uleb128 0x1
 2318 085a 01        		.byte	0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 50


 2319 085b 35        		.byte	0x35
 2320 085c 00        		.byte	0
 2321 085d 22        		.uleb128 0x22
 2322 085e 0000 0000 		.long	.LVL103
 2323 0862 3404 0000 		.long	0x434
 2324 0866 7608 0000 		.long	0x876
 2325 086a 13        		.uleb128 0x13
 2326 086b 01        		.byte	0x1
 2327 086c 68        		.byte	0x68
 2328 086d 02        		.byte	0x2
 2329 086e 08        		.byte	0x8
 2330 086f 20        		.byte	0x20
 2331 0870 13        		.uleb128 0x13
 2332 0871 01        		.byte	0x1
 2333 0872 66        		.byte	0x66
 2334 0873 01        		.byte	0x1
 2335 0874 30        		.byte	0x30
 2336 0875 00        		.byte	0
 2337 0876 22        		.uleb128 0x22
 2338 0877 0000 0000 		.long	.LVL104
 2339 087b FA02 0000 		.long	0x2fa
 2340 087f 9708 0000 		.long	0x897
 2341 0883 13        		.uleb128 0x13
 2342 0884 06        		.byte	0x6
 2343 0885 66        		.byte	0x66
 2344 0886 93        		.byte	0x93
 2345 0887 01        		.uleb128 0x1
 2346 0888 67        		.byte	0x67
 2347 0889 93        		.byte	0x93
 2348 088a 01        		.uleb128 0x1
 2349 088b 05        		.byte	0x5
 2350 088c 03        		.byte	0x3
 2351 088d 0000 0000 		.long	lcdBuffer
 2352 0891 13        		.uleb128 0x13
 2353 0892 01        		.byte	0x1
 2354 0893 64        		.byte	0x64
 2355 0894 01        		.byte	0x1
 2356 0895 33        		.byte	0x33
 2357 0896 00        		.byte	0
 2358 0897 22        		.uleb128 0x22
 2359 0898 0000 0000 		.long	.LVL105
 2360 089c 190B 0000 		.long	0xb19
 2361 08a0 AF08 0000 		.long	0x8af
 2362 08a4 13        		.uleb128 0x13
 2363 08a5 06        		.byte	0x6
 2364 08a6 68        		.byte	0x68
 2365 08a7 93        		.byte	0x93
 2366 08a8 01        		.uleb128 0x1
 2367 08a9 69        		.byte	0x69
 2368 08aa 93        		.byte	0x93
 2369 08ab 01        		.uleb128 0x1
 2370 08ac 01        		.byte	0x1
 2371 08ad 35        		.byte	0x35
 2372 08ae 00        		.byte	0
 2373 08af 18        		.uleb128 0x18
 2374 08b0 0000 0000 		.long	.LVL106
 2375 08b4 3205 0000 		.long	0x532
GAS LISTING /tmp/ccjlgSmg.s 			page 51


 2376 08b8 1B        		.uleb128 0x1b
 2377 08b9 0000 0000 		.long	.LVL108
 2378 08bd 01        		.byte	0x1
 2379 08be 190B 0000 		.long	0xb19
 2380 08c2 13        		.uleb128 0x13
 2381 08c3 06        		.byte	0x6
 2382 08c4 68        		.byte	0x68
 2383 08c5 93        		.byte	0x93
 2384 08c6 01        		.uleb128 0x1
 2385 08c7 69        		.byte	0x69
 2386 08c8 93        		.byte	0x93
 2387 08c9 01        		.uleb128 0x1
 2388 08ca 03        		.byte	0x3
 2389 08cb 0A        		.byte	0xa
 2390 08cc F401      		.word	0x1f4
 2391 08ce 00        		.byte	0
 2392 08cf 00        		.byte	0
 2393 08d0 19        		.uleb128 0x19
 2394 08d1 01        		.byte	0x1
 2395 08d2 0000 0000 		.long	.LASF53
 2396 08d6 02        		.byte	0x2
 2397 08d7 4102      		.word	0x241
 2398 08d9 0000 0000 		.long	.LFB115
 2399 08dd 0000 0000 		.long	.LFE115
 2400 08e1 03        		.byte	0x3
 2401 08e2 92        		.byte	0x92
 2402 08e3 20        		.uleb128 0x20
 2403 08e4 03        		.sleb128 3
 2404 08e5 01        		.byte	0x1
 2405 08e6 4209 0000 		.long	0x942
 2406 08ea 0E        		.uleb128 0xe
 2407 08eb 0000 0000 		.long	.LBB6
 2408 08ef 0000 0000 		.long	.LBE6
 2409 08f3 23        		.uleb128 0x23
 2410 08f4 0000 0000 		.long	.LASF82
 2411 08f8 02        		.byte	0x2
 2412 08f9 4202      		.word	0x242
 2413 08fb 4900 0000 		.long	0x49
 2414 08ff 22        		.uleb128 0x22
 2415 0900 0000 0000 		.long	.LVL109
 2416 0904 E806 0000 		.long	0x6e8
 2417 0908 2209 0000 		.long	0x922
 2418 090c 13        		.uleb128 0x13
 2419 090d 01        		.byte	0x1
 2420 090e 68        		.byte	0x68
 2421 090f 02        		.byte	0x2
 2422 0910 08        		.byte	0x8
 2423 0911 27        		.byte	0x27
 2424 0912 13        		.uleb128 0x13
 2425 0913 01        		.byte	0x1
 2426 0914 66        		.byte	0x66
 2427 0915 01        		.byte	0x1
 2428 0916 40        		.byte	0x40
 2429 0917 13        		.uleb128 0x13
 2430 0918 01        		.byte	0x1
 2431 0919 64        		.byte	0x64
 2432 091a 01        		.byte	0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 52


 2433 091b 32        		.byte	0x32
 2434 091c 13        		.uleb128 0x13
 2435 091d 01        		.byte	0x1
 2436 091e 62        		.byte	0x62
 2437 091f 01        		.byte	0x1
 2438 0920 31        		.byte	0x31
 2439 0921 00        		.byte	0
 2440 0922 1B        		.uleb128 0x1b
 2441 0923 0000 0000 		.long	.LVL110
 2442 0927 01        		.byte	0x1
 2443 0928 8704 0000 		.long	0x487
 2444 092c 13        		.uleb128 0x13
 2445 092d 06        		.byte	0x6
 2446 092e 68        		.byte	0x68
 2447 092f 93        		.byte	0x93
 2448 0930 01        		.uleb128 0x1
 2449 0931 69        		.byte	0x69
 2450 0932 93        		.byte	0x93
 2451 0933 01        		.uleb128 0x1
 2452 0934 05        		.byte	0x5
 2453 0935 03        		.byte	0x3
 2454 0936 0000 0000 		.long	.LC0
 2455 093a 13        		.uleb128 0x13
 2456 093b 01        		.byte	0x1
 2457 093c 66        		.byte	0x66
 2458 093d 01        		.byte	0x1
 2459 093e 3D        		.byte	0x3d
 2460 093f 00        		.byte	0
 2461 0940 00        		.byte	0
 2462 0941 00        		.byte	0
 2463 0942 24        		.uleb128 0x24
 2464 0943 01        		.byte	0x1
 2465 0944 0000 0000 		.long	.LASF83
 2466 0948 02        		.byte	0x2
 2467 0949 4C02      		.word	0x24c
 2468 094b 0000 0000 		.long	.LFB116
 2469 094f 0000 0000 		.long	.LFE116
 2470 0953 03        		.byte	0x3
 2471 0954 92        		.byte	0x92
 2472 0955 20        		.uleb128 0x20
 2473 0956 03        		.sleb128 3
 2474 0957 01        		.byte	0x1
 2475 0958 25        		.uleb128 0x25
 2476 0959 0000 0000 		.long	.LASF54
 2477 095d 01        		.byte	0x1
 2478 095e 92        		.byte	0x92
 2479 095f 6A09 0000 		.long	0x96a
 2480 0963 01        		.byte	0x1
 2481 0964 05        		.byte	0x5
 2482 0965 03        		.byte	0x3
 2483 0966 0000 0000 		.long	twiMode
 2484 096a 26        		.uleb128 0x26
 2485 096b 3000 0000 		.long	0x30
 2486 096f 25        		.uleb128 0x25
 2487 0970 0000 0000 		.long	.LASF55
 2488 0974 01        		.byte	0x1
 2489 0975 93        		.byte	0x93
GAS LISTING /tmp/ccjlgSmg.s 			page 53


 2490 0976 6A09 0000 		.long	0x96a
 2491 097a 01        		.byte	0x1
 2492 097b 05        		.byte	0x5
 2493 097c 03        		.byte	0x3
 2494 097d 0000 0000 		.long	twiState
 2495 0981 25        		.uleb128 0x25
 2496 0982 0000 0000 		.long	.LASF56
 2497 0986 01        		.byte	0x1
 2498 0987 94        		.byte	0x94
 2499 0988 6A09 0000 		.long	0x96a
 2500 098c 01        		.byte	0x1
 2501 098d 05        		.byte	0x5
 2502 098e 03        		.byte	0x3
 2503 098f 0000 0000 		.long	twiSLARW
 2504 0993 25        		.uleb128 0x25
 2505 0994 0000 0000 		.long	.LASF57
 2506 0998 01        		.byte	0x1
 2507 0999 96        		.byte	0x96
 2508 099a 6A09 0000 		.long	0x96a
 2509 099e 01        		.byte	0x1
 2510 099f 05        		.byte	0x5
 2511 09a0 03        		.byte	0x3
 2512 09a1 0000 0000 		.long	twiMT_Count
 2513 09a5 25        		.uleb128 0x25
 2514 09a6 0000 0000 		.long	.LASF58
 2515 09aa 01        		.byte	0x1
 2516 09ab 97        		.byte	0x97
 2517 09ac B709 0000 		.long	0x9b7
 2518 09b0 01        		.byte	0x1
 2519 09b1 05        		.byte	0x5
 2520 09b2 03        		.byte	0x3
 2521 09b3 0000 0000 		.long	twiMT_Ptr
 2522 09b7 05        		.uleb128 0x5
 2523 09b8 02        		.byte	0x2
 2524 09b9 6A09 0000 		.long	0x96a
 2525 09bd 25        		.uleb128 0x25
 2526 09be 0000 0000 		.long	.LASF59
 2527 09c2 01        		.byte	0x1
 2528 09c3 99        		.byte	0x99
 2529 09c4 6A09 0000 		.long	0x96a
 2530 09c8 01        		.byte	0x1
 2531 09c9 05        		.byte	0x5
 2532 09ca 03        		.byte	0x3
 2533 09cb 0000 0000 		.long	twiRX_Count
 2534 09cf 25        		.uleb128 0x25
 2535 09d0 0000 0000 		.long	.LASF60
 2536 09d4 01        		.byte	0x1
 2537 09d5 9A        		.byte	0x9a
 2538 09d6 B709 0000 		.long	0x9b7
 2539 09da 01        		.byte	0x1
 2540 09db 05        		.byte	0x5
 2541 09dc 03        		.byte	0x3
 2542 09dd 0000 0000 		.long	twiRX_Ptr
 2543 09e1 25        		.uleb128 0x25
 2544 09e2 0000 0000 		.long	.LASF61
 2545 09e6 01        		.byte	0x1
 2546 09e7 9C        		.byte	0x9c
GAS LISTING /tmp/ccjlgSmg.s 			page 54


 2547 09e8 6A09 0000 		.long	0x96a
 2548 09ec 01        		.byte	0x1
 2549 09ed 05        		.byte	0x5
 2550 09ee 03        		.byte	0x3
 2551 09ef 0000 0000 		.long	twiST_Count
 2552 09f3 25        		.uleb128 0x25
 2553 09f4 0000 0000 		.long	.LASF62
 2554 09f8 01        		.byte	0x1
 2555 09f9 9D        		.byte	0x9d
 2556 09fa B709 0000 		.long	0x9b7
 2557 09fe 01        		.byte	0x1
 2558 09ff 05        		.byte	0x5
 2559 0a00 03        		.byte	0x3
 2560 0a01 0000 0000 		.long	twiST_Ptr
 2561 0a05 27        		.uleb128 0x27
 2562 0a06 25        		.uleb128 0x25
 2563 0a07 0000 0000 		.long	.LASF63
 2564 0a0b 01        		.byte	0x1
 2565 0a0c 9F        		.byte	0x9f
 2566 0a0d 180A 0000 		.long	0xa18
 2567 0a11 01        		.byte	0x1
 2568 0a12 05        		.byte	0x5
 2569 0a13 03        		.byte	0x3
 2570 0a14 0000 0000 		.long	twiHookRestart
 2571 0a18 05        		.uleb128 0x5
 2572 0a19 02        		.byte	0x2
 2573 0a1a 050A 0000 		.long	0xa05
 2574 0a1e 25        		.uleb128 0x25
 2575 0a1f 0000 0000 		.long	.LASF64
 2576 0a23 01        		.byte	0x1
 2577 0a24 A0        		.byte	0xa0
 2578 0a25 180A 0000 		.long	0xa18
 2579 0a29 01        		.byte	0x1
 2580 0a2a 05        		.byte	0x5
 2581 0a2b 03        		.byte	0x3
 2582 0a2c 0000 0000 		.long	twiMasterReader
 2583 0a30 25        		.uleb128 0x25
 2584 0a31 0000 0000 		.long	.LASF65
 2585 0a35 01        		.byte	0x1
 2586 0a36 A1        		.byte	0xa1
 2587 0a37 180A 0000 		.long	0xa18
 2588 0a3b 01        		.byte	0x1
 2589 0a3c 05        		.byte	0x5
 2590 0a3d 03        		.byte	0x3
 2591 0a3e 0000 0000 		.long	twiSlaveReader
 2592 0a42 25        		.uleb128 0x25
 2593 0a43 0000 0000 		.long	.LASF66
 2594 0a47 01        		.byte	0x1
 2595 0a48 A2        		.byte	0xa2
 2596 0a49 180A 0000 		.long	0xa18
 2597 0a4d 01        		.byte	0x1
 2598 0a4e 05        		.byte	0x5
 2599 0a4f 03        		.byte	0x3
 2600 0a50 0000 0000 		.long	twiSlaveWriter
 2601 0a54 0F        		.uleb128 0xf
 2602 0a55 0000 0000 		.long	.LASF67
 2603 0a59 01        		.byte	0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 55


 2604 0a5a AA        		.byte	0xaa
 2605 0a5b 650A 0000 		.long	0xa65
 2606 0a5f 05        		.byte	0x5
 2607 0a60 03        		.byte	0x3
 2608 0a61 0000 0000 		.long	_ZL12twiStatistic
 2609 0a65 26        		.uleb128 0x26
 2610 0a66 6401 0000 		.long	0x164
 2611 0a6a 28        		.uleb128 0x28
 2612 0a6b 0000 0000 		.long	.LASF68
 2613 0a6f 02        		.byte	0x2
 2614 0a70 DB01      		.word	0x1db
 2615 0a72 3000 0000 		.long	0x30
 2616 0a76 01        		.byte	0x1
 2617 0a77 05        		.byte	0x5
 2618 0a78 03        		.byte	0x3
 2619 0a79 0000 0000 		.long	lcdModes
 2620 0a7d 28        		.uleb128 0x28
 2621 0a7e 0000 0000 		.long	.LASF69
 2622 0a82 02        		.byte	0x2
 2623 0a83 DC01      		.word	0x1dc
 2624 0a85 3000 0000 		.long	0x30
 2625 0a89 01        		.byte	0x1
 2626 0a8a 05        		.byte	0x5
 2627 0a8b 03        		.byte	0x3
 2628 0a8c 0000 0000 		.long	lcdShifts
 2629 0a90 28        		.uleb128 0x28
 2630 0a91 0000 0000 		.long	.LASF70
 2631 0a95 02        		.byte	0x2
 2632 0a96 DD01      		.word	0x1dd
 2633 0a98 3000 0000 		.long	0x30
 2634 0a9c 01        		.byte	0x1
 2635 0a9d 05        		.byte	0x5
 2636 0a9e 03        		.byte	0x3
 2637 0a9f 0000 0000 		.long	lcdShows
 2638 0aa3 28        		.uleb128 0x28
 2639 0aa4 0000 0000 		.long	.LASF71
 2640 0aa8 02        		.byte	0x2
 2641 0aa9 DE01      		.word	0x1de
 2642 0aab 3000 0000 		.long	0x30
 2643 0aaf 01        		.byte	0x1
 2644 0ab0 05        		.byte	0x5
 2645 0ab1 03        		.byte	0x3
 2646 0ab2 0000 0000 		.long	lcdBackLight
 2647 0ab6 28        		.uleb128 0x28
 2648 0ab7 0000 0000 		.long	.LASF72
 2649 0abb 02        		.byte	0x2
 2650 0abc E001      		.word	0x1e0
 2651 0abe 3000 0000 		.long	0x30
 2652 0ac2 01        		.byte	0x1
 2653 0ac3 05        		.byte	0x5
 2654 0ac4 03        		.byte	0x3
 2655 0ac5 0000 0000 		.long	lcdAddress
 2656 0ac9 28        		.uleb128 0x28
 2657 0aca 0000 0000 		.long	.LASF73
 2658 0ace 02        		.byte	0x2
 2659 0acf E101      		.word	0x1e1
 2660 0ad1 3000 0000 		.long	0x30
GAS LISTING /tmp/ccjlgSmg.s 			page 56


 2661 0ad5 01        		.byte	0x1
 2662 0ad6 05        		.byte	0x5
 2663 0ad7 03        		.byte	0x3
 2664 0ad8 0000 0000 		.long	lcdCols
 2665 0adc 28        		.uleb128 0x28
 2666 0add 0000 0000 		.long	.LASF74
 2667 0ae1 02        		.byte	0x2
 2668 0ae2 E201      		.word	0x1e2
 2669 0ae4 3000 0000 		.long	0x30
 2670 0ae8 01        		.byte	0x1
 2671 0ae9 05        		.byte	0x5
 2672 0aea 03        		.byte	0x3
 2673 0aeb 0000 0000 		.long	lcdRows
 2674 0aef 29        		.uleb128 0x29
 2675 0af0 3B00 0000 		.long	0x3b
 2676 0af4 FF0A 0000 		.long	0xaff
 2677 0af8 2A        		.uleb128 0x2a
 2678 0af9 FF0A 0000 		.long	0xaff
 2679 0afd 05        		.byte	0x5
 2680 0afe 00        		.byte	0
 2681 0aff 02        		.uleb128 0x2
 2682 0b00 02        		.byte	0x2
 2683 0b01 07        		.byte	0x7
 2684 0b02 0000 0000 		.long	.LASF75
 2685 0b06 28        		.uleb128 0x28
 2686 0b07 0000 0000 		.long	.LASF76
 2687 0b0b 02        		.byte	0x2
 2688 0b0c E301      		.word	0x1e3
 2689 0b0e EF0A 0000 		.long	0xaef
 2690 0b12 01        		.byte	0x1
 2691 0b13 05        		.byte	0x5
 2692 0b14 03        		.byte	0x3
 2693 0b15 0000 0000 		.long	lcdBuffer
 2694 0b19 2B        		.uleb128 0x2b
 2695 0b1a 01        		.byte	0x1
 2696 0b1b 0000 0000 		.long	.LASF84
 2697 0b1f 04        		.byte	0x4
 2698 0b20 E101      		.word	0x1e1
 2699 0b22 01        		.byte	0x1
 2700 0b23 2C        		.uleb128 0x2c
 2701 0b24 4900 0000 		.long	0x49
 2702 0b28 00        		.byte	0
 2703 0b29 00        		.byte	0
 2704               		.section	.debug_abbrev,"",@progbits
 2705               	.Ldebug_abbrev0:
 2706 0000 01        		.uleb128 0x1
 2707 0001 11        		.uleb128 0x11
 2708 0002 01        		.byte	0x1
 2709 0003 25        		.uleb128 0x25
 2710 0004 0E        		.uleb128 0xe
 2711 0005 13        		.uleb128 0x13
 2712 0006 0B        		.uleb128 0xb
 2713 0007 03        		.uleb128 0x3
 2714 0008 0E        		.uleb128 0xe
 2715 0009 1B        		.uleb128 0x1b
 2716 000a 0E        		.uleb128 0xe
 2717 000b 55        		.uleb128 0x55
GAS LISTING /tmp/ccjlgSmg.s 			page 57


 2718 000c 06        		.uleb128 0x6
 2719 000d 11        		.uleb128 0x11
 2720 000e 01        		.uleb128 0x1
 2721 000f 52        		.uleb128 0x52
 2722 0010 01        		.uleb128 0x1
 2723 0011 10        		.uleb128 0x10
 2724 0012 06        		.uleb128 0x6
 2725 0013 00        		.byte	0
 2726 0014 00        		.byte	0
 2727 0015 02        		.uleb128 0x2
 2728 0016 24        		.uleb128 0x24
 2729 0017 00        		.byte	0
 2730 0018 0B        		.uleb128 0xb
 2731 0019 0B        		.uleb128 0xb
 2732 001a 3E        		.uleb128 0x3e
 2733 001b 0B        		.uleb128 0xb
 2734 001c 03        		.uleb128 0x3
 2735 001d 0E        		.uleb128 0xe
 2736 001e 00        		.byte	0
 2737 001f 00        		.byte	0
 2738 0020 03        		.uleb128 0x3
 2739 0021 16        		.uleb128 0x16
 2740 0022 00        		.byte	0
 2741 0023 03        		.uleb128 0x3
 2742 0024 0E        		.uleb128 0xe
 2743 0025 3A        		.uleb128 0x3a
 2744 0026 0B        		.uleb128 0xb
 2745 0027 3B        		.uleb128 0x3b
 2746 0028 0B        		.uleb128 0xb
 2747 0029 49        		.uleb128 0x49
 2748 002a 13        		.uleb128 0x13
 2749 002b 00        		.byte	0
 2750 002c 00        		.byte	0
 2751 002d 04        		.uleb128 0x4
 2752 002e 24        		.uleb128 0x24
 2753 002f 00        		.byte	0
 2754 0030 0B        		.uleb128 0xb
 2755 0031 0B        		.uleb128 0xb
 2756 0032 3E        		.uleb128 0x3e
 2757 0033 0B        		.uleb128 0xb
 2758 0034 03        		.uleb128 0x3
 2759 0035 08        		.uleb128 0x8
 2760 0036 00        		.byte	0
 2761 0037 00        		.byte	0
 2762 0038 05        		.uleb128 0x5
 2763 0039 0F        		.uleb128 0xf
 2764 003a 00        		.byte	0
 2765 003b 0B        		.uleb128 0xb
 2766 003c 0B        		.uleb128 0xb
 2767 003d 49        		.uleb128 0x49
 2768 003e 13        		.uleb128 0x13
 2769 003f 00        		.byte	0
 2770 0040 00        		.byte	0
 2771 0041 06        		.uleb128 0x6
 2772 0042 26        		.uleb128 0x26
 2773 0043 00        		.byte	0
 2774 0044 00        		.byte	0
GAS LISTING /tmp/ccjlgSmg.s 			page 58


 2775 0045 00        		.byte	0
 2776 0046 07        		.uleb128 0x7
 2777 0047 04        		.uleb128 0x4
 2778 0048 01        		.byte	0x1
 2779 0049 03        		.uleb128 0x3
 2780 004a 0E        		.uleb128 0xe
 2781 004b 0B        		.uleb128 0xb
 2782 004c 0B        		.uleb128 0xb
 2783 004d 3A        		.uleb128 0x3a
 2784 004e 0B        		.uleb128 0xb
 2785 004f 3B        		.uleb128 0x3b
 2786 0050 0B        		.uleb128 0xb
 2787 0051 01        		.uleb128 0x1
 2788 0052 13        		.uleb128 0x13
 2789 0053 00        		.byte	0
 2790 0054 00        		.byte	0
 2791 0055 08        		.uleb128 0x8
 2792 0056 28        		.uleb128 0x28
 2793 0057 00        		.byte	0
 2794 0058 03        		.uleb128 0x3
 2795 0059 0E        		.uleb128 0xe
 2796 005a 1C        		.uleb128 0x1c
 2797 005b 0D        		.uleb128 0xd
 2798 005c 00        		.byte	0
 2799 005d 00        		.byte	0
 2800 005e 09        		.uleb128 0x9
 2801 005f 13        		.uleb128 0x13
 2802 0060 01        		.byte	0x1
 2803 0061 0B        		.uleb128 0xb
 2804 0062 0B        		.uleb128 0xb
 2805 0063 3A        		.uleb128 0x3a
 2806 0064 0B        		.uleb128 0xb
 2807 0065 3B        		.uleb128 0x3b
 2808 0066 0B        		.uleb128 0xb
 2809 0067 8740      		.uleb128 0x2007
 2810 0069 0E        		.uleb128 0xe
 2811 006a 01        		.uleb128 0x1
 2812 006b 13        		.uleb128 0x13
 2813 006c 00        		.byte	0
 2814 006d 00        		.byte	0
 2815 006e 0A        		.uleb128 0xa
 2816 006f 0D        		.uleb128 0xd
 2817 0070 00        		.byte	0
 2818 0071 03        		.uleb128 0x3
 2819 0072 0E        		.uleb128 0xe
 2820 0073 3A        		.uleb128 0x3a
 2821 0074 0B        		.uleb128 0xb
 2822 0075 3B        		.uleb128 0x3b
 2823 0076 0B        		.uleb128 0xb
 2824 0077 49        		.uleb128 0x49
 2825 0078 13        		.uleb128 0x13
 2826 0079 38        		.uleb128 0x38
 2827 007a 0A        		.uleb128 0xa
 2828 007b 00        		.byte	0
 2829 007c 00        		.byte	0
 2830 007d 0B        		.uleb128 0xb
 2831 007e 0D        		.uleb128 0xd
GAS LISTING /tmp/ccjlgSmg.s 			page 59


 2832 007f 00        		.byte	0
 2833 0080 03        		.uleb128 0x3
 2834 0081 08        		.uleb128 0x8
 2835 0082 3A        		.uleb128 0x3a
 2836 0083 0B        		.uleb128 0xb
 2837 0084 3B        		.uleb128 0x3b
 2838 0085 0B        		.uleb128 0xb
 2839 0086 49        		.uleb128 0x49
 2840 0087 13        		.uleb128 0x13
 2841 0088 38        		.uleb128 0x38
 2842 0089 0A        		.uleb128 0xa
 2843 008a 00        		.byte	0
 2844 008b 00        		.byte	0
 2845 008c 0C        		.uleb128 0xc
 2846 008d 2E        		.uleb128 0x2e
 2847 008e 01        		.byte	0x1
 2848 008f 3F        		.uleb128 0x3f
 2849 0090 0C        		.uleb128 0xc
 2850 0091 03        		.uleb128 0x3
 2851 0092 0E        		.uleb128 0xe
 2852 0093 3A        		.uleb128 0x3a
 2853 0094 0B        		.uleb128 0xb
 2854 0095 3B        		.uleb128 0x3b
 2855 0096 0B        		.uleb128 0xb
 2856 0097 11        		.uleb128 0x11
 2857 0098 01        		.uleb128 0x1
 2858 0099 12        		.uleb128 0x12
 2859 009a 01        		.uleb128 0x1
 2860 009b 40        		.uleb128 0x40
 2861 009c 0A        		.uleb128 0xa
 2862 009d 9742      		.uleb128 0x2117
 2863 009f 0C        		.uleb128 0xc
 2864 00a0 01        		.uleb128 0x1
 2865 00a1 13        		.uleb128 0x13
 2866 00a2 00        		.byte	0
 2867 00a3 00        		.byte	0
 2868 00a4 0D        		.uleb128 0xd
 2869 00a5 05        		.uleb128 0x5
 2870 00a6 00        		.byte	0
 2871 00a7 03        		.uleb128 0x3
 2872 00a8 0E        		.uleb128 0xe
 2873 00a9 3A        		.uleb128 0x3a
 2874 00aa 0B        		.uleb128 0xb
 2875 00ab 3B        		.uleb128 0x3b
 2876 00ac 0B        		.uleb128 0xb
 2877 00ad 49        		.uleb128 0x49
 2878 00ae 13        		.uleb128 0x13
 2879 00af 02        		.uleb128 0x2
 2880 00b0 06        		.uleb128 0x6
 2881 00b1 00        		.byte	0
 2882 00b2 00        		.byte	0
 2883 00b3 0E        		.uleb128 0xe
 2884 00b4 0B        		.uleb128 0xb
 2885 00b5 01        		.byte	0x1
 2886 00b6 11        		.uleb128 0x11
 2887 00b7 01        		.uleb128 0x1
 2888 00b8 12        		.uleb128 0x12
GAS LISTING /tmp/ccjlgSmg.s 			page 60


 2889 00b9 01        		.uleb128 0x1
 2890 00ba 00        		.byte	0
 2891 00bb 00        		.byte	0
 2892 00bc 0F        		.uleb128 0xf
 2893 00bd 34        		.uleb128 0x34
 2894 00be 00        		.byte	0
 2895 00bf 03        		.uleb128 0x3
 2896 00c0 0E        		.uleb128 0xe
 2897 00c1 3A        		.uleb128 0x3a
 2898 00c2 0B        		.uleb128 0xb
 2899 00c3 3B        		.uleb128 0x3b
 2900 00c4 0B        		.uleb128 0xb
 2901 00c5 49        		.uleb128 0x49
 2902 00c6 13        		.uleb128 0x13
 2903 00c7 02        		.uleb128 0x2
 2904 00c8 0A        		.uleb128 0xa
 2905 00c9 00        		.byte	0
 2906 00ca 00        		.byte	0
 2907 00cb 10        		.uleb128 0x10
 2908 00cc 34        		.uleb128 0x34
 2909 00cd 00        		.byte	0
 2910 00ce 03        		.uleb128 0x3
 2911 00cf 0E        		.uleb128 0xe
 2912 00d0 3A        		.uleb128 0x3a
 2913 00d1 0B        		.uleb128 0xb
 2914 00d2 3B        		.uleb128 0x3b
 2915 00d3 0B        		.uleb128 0xb
 2916 00d4 49        		.uleb128 0x49
 2917 00d5 13        		.uleb128 0x13
 2918 00d6 02        		.uleb128 0x2
 2919 00d7 06        		.uleb128 0x6
 2920 00d8 00        		.byte	0
 2921 00d9 00        		.byte	0
 2922 00da 11        		.uleb128 0x11
 2923 00db 2E        		.uleb128 0x2e
 2924 00dc 01        		.byte	0x1
 2925 00dd 3F        		.uleb128 0x3f
 2926 00de 0C        		.uleb128 0xc
 2927 00df 03        		.uleb128 0x3
 2928 00e0 0E        		.uleb128 0xe
 2929 00e1 3A        		.uleb128 0x3a
 2930 00e2 0B        		.uleb128 0xb
 2931 00e3 3B        		.uleb128 0x3b
 2932 00e4 0B        		.uleb128 0xb
 2933 00e5 11        		.uleb128 0x11
 2934 00e6 01        		.uleb128 0x1
 2935 00e7 12        		.uleb128 0x12
 2936 00e8 01        		.uleb128 0x1
 2937 00e9 40        		.uleb128 0x40
 2938 00ea 06        		.uleb128 0x6
 2939 00eb 9742      		.uleb128 0x2117
 2940 00ed 0C        		.uleb128 0xc
 2941 00ee 01        		.uleb128 0x1
 2942 00ef 13        		.uleb128 0x13
 2943 00f0 00        		.byte	0
 2944 00f1 00        		.byte	0
 2945 00f2 12        		.uleb128 0x12
GAS LISTING /tmp/ccjlgSmg.s 			page 61


 2946 00f3 8982 01   		.uleb128 0x4109
 2947 00f6 01        		.byte	0x1
 2948 00f7 11        		.uleb128 0x11
 2949 00f8 01        		.uleb128 0x1
 2950 00f9 31        		.uleb128 0x31
 2951 00fa 13        		.uleb128 0x13
 2952 00fb 00        		.byte	0
 2953 00fc 00        		.byte	0
 2954 00fd 13        		.uleb128 0x13
 2955 00fe 8A82 01   		.uleb128 0x410a
 2956 0101 00        		.byte	0
 2957 0102 02        		.uleb128 0x2
 2958 0103 0A        		.uleb128 0xa
 2959 0104 9142      		.uleb128 0x2111
 2960 0106 0A        		.uleb128 0xa
 2961 0107 00        		.byte	0
 2962 0108 00        		.byte	0
 2963 0109 14        		.uleb128 0x14
 2964 010a 2E        		.uleb128 0x2e
 2965 010b 01        		.byte	0x1
 2966 010c 3F        		.uleb128 0x3f
 2967 010d 0C        		.uleb128 0xc
 2968 010e 03        		.uleb128 0x3
 2969 010f 0E        		.uleb128 0xe
 2970 0110 3A        		.uleb128 0x3a
 2971 0111 0B        		.uleb128 0xb
 2972 0112 3B        		.uleb128 0x3b
 2973 0113 0B        		.uleb128 0xb
 2974 0114 11        		.uleb128 0x11
 2975 0115 01        		.uleb128 0x1
 2976 0116 12        		.uleb128 0x12
 2977 0117 01        		.uleb128 0x1
 2978 0118 40        		.uleb128 0x40
 2979 0119 06        		.uleb128 0x6
 2980 011a 9642      		.uleb128 0x2116
 2981 011c 0C        		.uleb128 0xc
 2982 011d 01        		.uleb128 0x1
 2983 011e 13        		.uleb128 0x13
 2984 011f 00        		.byte	0
 2985 0120 00        		.byte	0
 2986 0121 15        		.uleb128 0x15
 2987 0122 05        		.uleb128 0x5
 2988 0123 00        		.byte	0
 2989 0124 03        		.uleb128 0x3
 2990 0125 08        		.uleb128 0x8
 2991 0126 3A        		.uleb128 0x3a
 2992 0127 0B        		.uleb128 0xb
 2993 0128 3B        		.uleb128 0x3b
 2994 0129 0B        		.uleb128 0xb
 2995 012a 49        		.uleb128 0x49
 2996 012b 13        		.uleb128 0x13
 2997 012c 02        		.uleb128 0x2
 2998 012d 06        		.uleb128 0x6
 2999 012e 00        		.byte	0
 3000 012f 00        		.byte	0
 3001 0130 16        		.uleb128 0x16
 3002 0131 2E        		.uleb128 0x2e
GAS LISTING /tmp/ccjlgSmg.s 			page 62


 3003 0132 01        		.byte	0x1
 3004 0133 3F        		.uleb128 0x3f
 3005 0134 0C        		.uleb128 0xc
 3006 0135 03        		.uleb128 0x3
 3007 0136 0E        		.uleb128 0xe
 3008 0137 3A        		.uleb128 0x3a
 3009 0138 0B        		.uleb128 0xb
 3010 0139 3B        		.uleb128 0x3b
 3011 013a 05        		.uleb128 0x5
 3012 013b 11        		.uleb128 0x11
 3013 013c 01        		.uleb128 0x1
 3014 013d 12        		.uleb128 0x12
 3015 013e 01        		.uleb128 0x1
 3016 013f 40        		.uleb128 0x40
 3017 0140 06        		.uleb128 0x6
 3018 0141 9642      		.uleb128 0x2116
 3019 0143 0C        		.uleb128 0xc
 3020 0144 01        		.uleb128 0x1
 3021 0145 13        		.uleb128 0x13
 3022 0146 00        		.byte	0
 3023 0147 00        		.byte	0
 3024 0148 17        		.uleb128 0x17
 3025 0149 34        		.uleb128 0x34
 3026 014a 00        		.byte	0
 3027 014b 03        		.uleb128 0x3
 3028 014c 08        		.uleb128 0x8
 3029 014d 3A        		.uleb128 0x3a
 3030 014e 0B        		.uleb128 0xb
 3031 014f 3B        		.uleb128 0x3b
 3032 0150 05        		.uleb128 0x5
 3033 0151 49        		.uleb128 0x49
 3034 0152 13        		.uleb128 0x13
 3035 0153 02        		.uleb128 0x2
 3036 0154 06        		.uleb128 0x6
 3037 0155 00        		.byte	0
 3038 0156 00        		.byte	0
 3039 0157 18        		.uleb128 0x18
 3040 0158 8982 01   		.uleb128 0x4109
 3041 015b 00        		.byte	0
 3042 015c 11        		.uleb128 0x11
 3043 015d 01        		.uleb128 0x1
 3044 015e 31        		.uleb128 0x31
 3045 015f 13        		.uleb128 0x13
 3046 0160 00        		.byte	0
 3047 0161 00        		.byte	0
 3048 0162 19        		.uleb128 0x19
 3049 0163 2E        		.uleb128 0x2e
 3050 0164 01        		.byte	0x1
 3051 0165 3F        		.uleb128 0x3f
 3052 0166 0C        		.uleb128 0xc
 3053 0167 03        		.uleb128 0x3
 3054 0168 0E        		.uleb128 0xe
 3055 0169 3A        		.uleb128 0x3a
 3056 016a 0B        		.uleb128 0xb
 3057 016b 3B        		.uleb128 0x3b
 3058 016c 05        		.uleb128 0x5
 3059 016d 11        		.uleb128 0x11
GAS LISTING /tmp/ccjlgSmg.s 			page 63


 3060 016e 01        		.uleb128 0x1
 3061 016f 12        		.uleb128 0x12
 3062 0170 01        		.uleb128 0x1
 3063 0171 40        		.uleb128 0x40
 3064 0172 0A        		.uleb128 0xa
 3065 0173 9742      		.uleb128 0x2117
 3066 0175 0C        		.uleb128 0xc
 3067 0176 01        		.uleb128 0x1
 3068 0177 13        		.uleb128 0x13
 3069 0178 00        		.byte	0
 3070 0179 00        		.byte	0
 3071 017a 1A        		.uleb128 0x1a
 3072 017b 05        		.uleb128 0x5
 3073 017c 00        		.byte	0
 3074 017d 03        		.uleb128 0x3
 3075 017e 0E        		.uleb128 0xe
 3076 017f 3A        		.uleb128 0x3a
 3077 0180 0B        		.uleb128 0xb
 3078 0181 3B        		.uleb128 0x3b
 3079 0182 05        		.uleb128 0x5
 3080 0183 49        		.uleb128 0x49
 3081 0184 13        		.uleb128 0x13
 3082 0185 02        		.uleb128 0x2
 3083 0186 06        		.uleb128 0x6
 3084 0187 00        		.byte	0
 3085 0188 00        		.byte	0
 3086 0189 1B        		.uleb128 0x1b
 3087 018a 8982 01   		.uleb128 0x4109
 3088 018d 01        		.byte	0x1
 3089 018e 11        		.uleb128 0x11
 3090 018f 01        		.uleb128 0x1
 3091 0190 9542      		.uleb128 0x2115
 3092 0192 0C        		.uleb128 0xc
 3093 0193 31        		.uleb128 0x31
 3094 0194 13        		.uleb128 0x13
 3095 0195 00        		.byte	0
 3096 0196 00        		.byte	0
 3097 0197 1C        		.uleb128 0x1c
 3098 0198 26        		.uleb128 0x26
 3099 0199 00        		.byte	0
 3100 019a 49        		.uleb128 0x49
 3101 019b 13        		.uleb128 0x13
 3102 019c 00        		.byte	0
 3103 019d 00        		.byte	0
 3104 019e 1D        		.uleb128 0x1d
 3105 019f 2E        		.uleb128 0x2e
 3106 01a0 01        		.byte	0x1
 3107 01a1 3F        		.uleb128 0x3f
 3108 01a2 0C        		.uleb128 0xc
 3109 01a3 03        		.uleb128 0x3
 3110 01a4 0E        		.uleb128 0xe
 3111 01a5 3A        		.uleb128 0x3a
 3112 01a6 0B        		.uleb128 0xb
 3113 01a7 3B        		.uleb128 0x3b
 3114 01a8 05        		.uleb128 0x5
 3115 01a9 11        		.uleb128 0x11
 3116 01aa 01        		.uleb128 0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 64


 3117 01ab 12        		.uleb128 0x12
 3118 01ac 01        		.uleb128 0x1
 3119 01ad 40        		.uleb128 0x40
 3120 01ae 06        		.uleb128 0x6
 3121 01af 9742      		.uleb128 0x2117
 3122 01b1 0C        		.uleb128 0xc
 3123 01b2 01        		.uleb128 0x1
 3124 01b3 13        		.uleb128 0x13
 3125 01b4 00        		.byte	0
 3126 01b5 00        		.byte	0
 3127 01b6 1E        		.uleb128 0x1e
 3128 01b7 05        		.uleb128 0x5
 3129 01b8 00        		.byte	0
 3130 01b9 03        		.uleb128 0x3
 3131 01ba 0E        		.uleb128 0xe
 3132 01bb 3A        		.uleb128 0x3a
 3133 01bc 0B        		.uleb128 0xb
 3134 01bd 3B        		.uleb128 0x3b
 3135 01be 05        		.uleb128 0x5
 3136 01bf 49        		.uleb128 0x49
 3137 01c0 13        		.uleb128 0x13
 3138 01c1 02        		.uleb128 0x2
 3139 01c2 0A        		.uleb128 0xa
 3140 01c3 00        		.byte	0
 3141 01c4 00        		.byte	0
 3142 01c5 1F        		.uleb128 0x1f
 3143 01c6 05        		.uleb128 0x5
 3144 01c7 00        		.byte	0
 3145 01c8 03        		.uleb128 0x3
 3146 01c9 08        		.uleb128 0x8
 3147 01ca 3A        		.uleb128 0x3a
 3148 01cb 0B        		.uleb128 0xb
 3149 01cc 3B        		.uleb128 0x3b
 3150 01cd 05        		.uleb128 0x5
 3151 01ce 49        		.uleb128 0x49
 3152 01cf 13        		.uleb128 0x13
 3153 01d0 02        		.uleb128 0x2
 3154 01d1 0A        		.uleb128 0xa
 3155 01d2 00        		.byte	0
 3156 01d3 00        		.byte	0
 3157 01d4 20        		.uleb128 0x20
 3158 01d5 34        		.uleb128 0x34
 3159 01d6 00        		.byte	0
 3160 01d7 03        		.uleb128 0x3
 3161 01d8 0E        		.uleb128 0xe
 3162 01d9 3A        		.uleb128 0x3a
 3163 01da 0B        		.uleb128 0xb
 3164 01db 3B        		.uleb128 0x3b
 3165 01dc 05        		.uleb128 0x5
 3166 01dd 49        		.uleb128 0x49
 3167 01de 13        		.uleb128 0x13
 3168 01df 02        		.uleb128 0x2
 3169 01e0 06        		.uleb128 0x6
 3170 01e1 00        		.byte	0
 3171 01e2 00        		.byte	0
 3172 01e3 21        		.uleb128 0x21
 3173 01e4 05        		.uleb128 0x5
GAS LISTING /tmp/ccjlgSmg.s 			page 65


 3174 01e5 00        		.byte	0
 3175 01e6 03        		.uleb128 0x3
 3176 01e7 08        		.uleb128 0x8
 3177 01e8 3A        		.uleb128 0x3a
 3178 01e9 0B        		.uleb128 0xb
 3179 01ea 3B        		.uleb128 0x3b
 3180 01eb 05        		.uleb128 0x5
 3181 01ec 49        		.uleb128 0x49
 3182 01ed 13        		.uleb128 0x13
 3183 01ee 02        		.uleb128 0x2
 3184 01ef 06        		.uleb128 0x6
 3185 01f0 00        		.byte	0
 3186 01f1 00        		.byte	0
 3187 01f2 22        		.uleb128 0x22
 3188 01f3 8982 01   		.uleb128 0x4109
 3189 01f6 01        		.byte	0x1
 3190 01f7 11        		.uleb128 0x11
 3191 01f8 01        		.uleb128 0x1
 3192 01f9 31        		.uleb128 0x31
 3193 01fa 13        		.uleb128 0x13
 3194 01fb 01        		.uleb128 0x1
 3195 01fc 13        		.uleb128 0x13
 3196 01fd 00        		.byte	0
 3197 01fe 00        		.byte	0
 3198 01ff 23        		.uleb128 0x23
 3199 0200 34        		.uleb128 0x34
 3200 0201 00        		.byte	0
 3201 0202 03        		.uleb128 0x3
 3202 0203 0E        		.uleb128 0xe
 3203 0204 3A        		.uleb128 0x3a
 3204 0205 0B        		.uleb128 0xb
 3205 0206 3B        		.uleb128 0x3b
 3206 0207 05        		.uleb128 0x5
 3207 0208 49        		.uleb128 0x49
 3208 0209 13        		.uleb128 0x13
 3209 020a 00        		.byte	0
 3210 020b 00        		.byte	0
 3211 020c 24        		.uleb128 0x24
 3212 020d 2E        		.uleb128 0x2e
 3213 020e 00        		.byte	0
 3214 020f 3F        		.uleb128 0x3f
 3215 0210 0C        		.uleb128 0xc
 3216 0211 03        		.uleb128 0x3
 3217 0212 0E        		.uleb128 0xe
 3218 0213 3A        		.uleb128 0x3a
 3219 0214 0B        		.uleb128 0xb
 3220 0215 3B        		.uleb128 0x3b
 3221 0216 05        		.uleb128 0x5
 3222 0217 11        		.uleb128 0x11
 3223 0218 01        		.uleb128 0x1
 3224 0219 12        		.uleb128 0x12
 3225 021a 01        		.uleb128 0x1
 3226 021b 40        		.uleb128 0x40
 3227 021c 0A        		.uleb128 0xa
 3228 021d 9742      		.uleb128 0x2117
 3229 021f 0C        		.uleb128 0xc
 3230 0220 00        		.byte	0
GAS LISTING /tmp/ccjlgSmg.s 			page 66


 3231 0221 00        		.byte	0
 3232 0222 25        		.uleb128 0x25
 3233 0223 34        		.uleb128 0x34
 3234 0224 00        		.byte	0
 3235 0225 03        		.uleb128 0x3
 3236 0226 0E        		.uleb128 0xe
 3237 0227 3A        		.uleb128 0x3a
 3238 0228 0B        		.uleb128 0xb
 3239 0229 3B        		.uleb128 0x3b
 3240 022a 0B        		.uleb128 0xb
 3241 022b 49        		.uleb128 0x49
 3242 022c 13        		.uleb128 0x13
 3243 022d 3F        		.uleb128 0x3f
 3244 022e 0C        		.uleb128 0xc
 3245 022f 02        		.uleb128 0x2
 3246 0230 0A        		.uleb128 0xa
 3247 0231 00        		.byte	0
 3248 0232 00        		.byte	0
 3249 0233 26        		.uleb128 0x26
 3250 0234 35        		.uleb128 0x35
 3251 0235 00        		.byte	0
 3252 0236 49        		.uleb128 0x49
 3253 0237 13        		.uleb128 0x13
 3254 0238 00        		.byte	0
 3255 0239 00        		.byte	0
 3256 023a 27        		.uleb128 0x27
 3257 023b 15        		.uleb128 0x15
 3258 023c 00        		.byte	0
 3259 023d 00        		.byte	0
 3260 023e 00        		.byte	0
 3261 023f 28        		.uleb128 0x28
 3262 0240 34        		.uleb128 0x34
 3263 0241 00        		.byte	0
 3264 0242 03        		.uleb128 0x3
 3265 0243 0E        		.uleb128 0xe
 3266 0244 3A        		.uleb128 0x3a
 3267 0245 0B        		.uleb128 0xb
 3268 0246 3B        		.uleb128 0x3b
 3269 0247 05        		.uleb128 0x5
 3270 0248 49        		.uleb128 0x49
 3271 0249 13        		.uleb128 0x13
 3272 024a 3F        		.uleb128 0x3f
 3273 024b 0C        		.uleb128 0xc
 3274 024c 02        		.uleb128 0x2
 3275 024d 0A        		.uleb128 0xa
 3276 024e 00        		.byte	0
 3277 024f 00        		.byte	0
 3278 0250 29        		.uleb128 0x29
 3279 0251 01        		.uleb128 0x1
 3280 0252 01        		.byte	0x1
 3281 0253 49        		.uleb128 0x49
 3282 0254 13        		.uleb128 0x13
 3283 0255 01        		.uleb128 0x1
 3284 0256 13        		.uleb128 0x13
 3285 0257 00        		.byte	0
 3286 0258 00        		.byte	0
 3287 0259 2A        		.uleb128 0x2a
GAS LISTING /tmp/ccjlgSmg.s 			page 67


 3288 025a 21        		.uleb128 0x21
 3289 025b 00        		.byte	0
 3290 025c 49        		.uleb128 0x49
 3291 025d 13        		.uleb128 0x13
 3292 025e 2F        		.uleb128 0x2f
 3293 025f 0B        		.uleb128 0xb
 3294 0260 00        		.byte	0
 3295 0261 00        		.byte	0
 3296 0262 2B        		.uleb128 0x2b
 3297 0263 2E        		.uleb128 0x2e
 3298 0264 01        		.byte	0x1
 3299 0265 3F        		.uleb128 0x3f
 3300 0266 0C        		.uleb128 0xc
 3301 0267 03        		.uleb128 0x3
 3302 0268 0E        		.uleb128 0xe
 3303 0269 3A        		.uleb128 0x3a
 3304 026a 0B        		.uleb128 0xb
 3305 026b 3B        		.uleb128 0x3b
 3306 026c 05        		.uleb128 0x5
 3307 026d 3C        		.uleb128 0x3c
 3308 026e 0C        		.uleb128 0xc
 3309 026f 00        		.byte	0
 3310 0270 00        		.byte	0
 3311 0271 2C        		.uleb128 0x2c
 3312 0272 05        		.uleb128 0x5
 3313 0273 00        		.byte	0
 3314 0274 49        		.uleb128 0x49
 3315 0275 13        		.uleb128 0x13
 3316 0276 00        		.byte	0
 3317 0277 00        		.byte	0
 3318 0278 00        		.byte	0
 3319               		.section	.debug_loc,"",@progbits
 3320               	.Ldebug_loc0:
 3321               	.LLST0:
 3322 0000 0000 0000 		.long	.LVL0
 3323 0004 0000 0000 		.long	.LVL1
 3324 0008 0C00      		.word	0xc
 3325 000a 66        		.byte	0x66
 3326 000b 93        		.byte	0x93
 3327 000c 01        		.uleb128 0x1
 3328 000d 67        		.byte	0x67
 3329 000e 93        		.byte	0x93
 3330 000f 01        		.uleb128 0x1
 3331 0010 68        		.byte	0x68
 3332 0011 93        		.byte	0x93
 3333 0012 01        		.uleb128 0x1
 3334 0013 69        		.byte	0x69
 3335 0014 93        		.byte	0x93
 3336 0015 01        		.uleb128 0x1
 3337 0016 0000 0000 		.long	.LVL1
 3338 001a 0000 0000 		.long	.LVL2
 3339 001e 0C00      		.word	0xc
 3340 0020 62        		.byte	0x62
 3341 0021 93        		.byte	0x93
 3342 0022 01        		.uleb128 0x1
 3343 0023 63        		.byte	0x63
 3344 0024 93        		.byte	0x93
GAS LISTING /tmp/ccjlgSmg.s 			page 68


 3345 0025 01        		.uleb128 0x1
 3346 0026 64        		.byte	0x64
 3347 0027 93        		.byte	0x93
 3348 0028 01        		.uleb128 0x1
 3349 0029 65        		.byte	0x65
 3350 002a 93        		.byte	0x93
 3351 002b 01        		.uleb128 0x1
 3352 002c 0000 0000 		.long	.LVL2
 3353 0030 0000 0000 		.long	.LFE102
 3354 0034 0400      		.word	0x4
 3355 0036 F3        		.byte	0xf3
 3356 0037 01        		.uleb128 0x1
 3357 0038 66        		.byte	0x66
 3358 0039 9F        		.byte	0x9f
 3359 003a 0000 0000 		.long	0
 3360 003e 0000 0000 		.long	0
 3361               	.LLST1:
 3362 0042 0000 0000 		.long	.LVL3
 3363 0046 0000 0000 		.long	.LVL4
 3364 004a 0200      		.word	0x2
 3365 004c 30        		.byte	0x30
 3366 004d 9F        		.byte	0x9f
 3367 004e 0000 0000 		.long	.LVL4
 3368 0052 0000 0000 		.long	.LFE102
 3369 0056 0100      		.word	0x1
 3370 0058 68        		.byte	0x68
 3371 0059 0000 0000 		.long	0
 3372 005d 0000 0000 		.long	0
 3373               	.LLST2:
 3374 0061 0000 0000 		.long	.LFB103
 3375 0065 0000 0000 		.long	.LCFI0
 3376 0069 0300      		.word	0x3
 3377 006b 92        		.byte	0x92
 3378 006c 20        		.uleb128 0x20
 3379 006d 03        		.sleb128 3
 3380 006e 0000 0000 		.long	.LCFI0
 3381 0072 0000 0000 		.long	.LCFI1
 3382 0076 0300      		.word	0x3
 3383 0078 92        		.byte	0x92
 3384 0079 20        		.uleb128 0x20
 3385 007a 04        		.sleb128 4
 3386 007b 0000 0000 		.long	.LCFI1
 3387 007f 0000 0000 		.long	.LCFI2
 3388 0083 0300      		.word	0x3
 3389 0085 92        		.byte	0x92
 3390 0086 20        		.uleb128 0x20
 3391 0087 05        		.sleb128 5
 3392 0088 0000 0000 		.long	.LCFI2
 3393 008c 0000 0000 		.long	.LCFI3
 3394 0090 0300      		.word	0x3
 3395 0092 92        		.byte	0x92
 3396 0093 20        		.uleb128 0x20
 3397 0094 06        		.sleb128 6
 3398 0095 0000 0000 		.long	.LCFI3
 3399 0099 0000 0000 		.long	.LFE103
 3400 009d 0200      		.word	0x2
 3401 009f 8C        		.byte	0x8c
GAS LISTING /tmp/ccjlgSmg.s 			page 69


 3402 00a0 06        		.sleb128 6
 3403 00a1 0000 0000 		.long	0
 3404 00a5 0000 0000 		.long	0
 3405               	.LLST3:
 3406 00a9 0000 0000 		.long	.LVL9
 3407 00ad 0000 0000 		.long	.LVL10-1
 3408 00b1 0C00      		.word	0xc
 3409 00b3 66        		.byte	0x66
 3410 00b4 93        		.byte	0x93
 3411 00b5 01        		.uleb128 0x1
 3412 00b6 67        		.byte	0x67
 3413 00b7 93        		.byte	0x93
 3414 00b8 01        		.uleb128 0x1
 3415 00b9 68        		.byte	0x68
 3416 00ba 93        		.byte	0x93
 3417 00bb 01        		.uleb128 0x1
 3418 00bc 69        		.byte	0x69
 3419 00bd 93        		.byte	0x93
 3420 00be 01        		.uleb128 0x1
 3421 00bf 0000 0000 		.long	.LVL10-1
 3422 00c3 0000 0000 		.long	.LFE103
 3423 00c7 0400      		.word	0x4
 3424 00c9 F3        		.byte	0xf3
 3425 00ca 01        		.uleb128 0x1
 3426 00cb 66        		.byte	0x66
 3427 00cc 9F        		.byte	0x9f
 3428 00cd 0000 0000 		.long	0
 3429 00d1 0000 0000 		.long	0
 3430               	.LLST4:
 3431 00d5 0000 0000 		.long	.LVL9
 3432 00d9 0000 0000 		.long	.LVL10-1
 3433 00dd 0100      		.word	0x1
 3434 00df 64        		.byte	0x64
 3435 00e0 0000 0000 		.long	.LVL10-1
 3436 00e4 0000 0000 		.long	.LFE103
 3437 00e8 0400      		.word	0x4
 3438 00ea F3        		.byte	0xf3
 3439 00eb 01        		.uleb128 0x1
 3440 00ec 64        		.byte	0x64
 3441 00ed 9F        		.byte	0x9f
 3442 00ee 0000 0000 		.long	0
 3443 00f2 0000 0000 		.long	0
 3444               	.LLST5:
 3445 00f6 0000 0000 		.long	.LFB104
 3446 00fa 0000 0000 		.long	.LCFI4
 3447 00fe 0300      		.word	0x3
 3448 0100 92        		.byte	0x92
 3449 0101 20        		.uleb128 0x20
 3450 0102 03        		.sleb128 3
 3451 0103 0000 0000 		.long	.LCFI4
 3452 0107 0000 0000 		.long	.LFE104
 3453 010b 0300      		.word	0x3
 3454 010d 92        		.byte	0x92
 3455 010e 20        		.uleb128 0x20
 3456 010f 04        		.sleb128 4
 3457 0110 0000 0000 		.long	0
 3458 0114 0000 0000 		.long	0
GAS LISTING /tmp/ccjlgSmg.s 			page 70


 3459               	.LLST6:
 3460 0118 0000 0000 		.long	.LVL11
 3461 011c 0000 0000 		.long	.LVL12
 3462 0120 0100      		.word	0x1
 3463 0122 68        		.byte	0x68
 3464 0123 0000 0000 		.long	.LVL12
 3465 0127 0000 0000 		.long	.LVL13
 3466 012b 0400      		.word	0x4
 3467 012d F3        		.byte	0xf3
 3468 012e 01        		.uleb128 0x1
 3469 012f 68        		.byte	0x68
 3470 0130 9F        		.byte	0x9f
 3471 0131 0000 0000 		.long	.LVL13
 3472 0135 0000 0000 		.long	.LVL14
 3473 0139 0100      		.word	0x1
 3474 013b 68        		.byte	0x68
 3475 013c 0000 0000 		.long	.LVL14
 3476 0140 0000 0000 		.long	.LVL15
 3477 0144 0400      		.word	0x4
 3478 0146 F3        		.byte	0xf3
 3479 0147 01        		.uleb128 0x1
 3480 0148 68        		.byte	0x68
 3481 0149 9F        		.byte	0x9f
 3482 014a 0000 0000 		.long	.LVL15
 3483 014e 0000 0000 		.long	.LVL16-1
 3484 0152 0100      		.word	0x1
 3485 0154 68        		.byte	0x68
 3486 0155 0000 0000 		.long	.LVL16-1
 3487 0159 0000 0000 		.long	.LVL17
 3488 015d 0400      		.word	0x4
 3489 015f F3        		.byte	0xf3
 3490 0160 01        		.uleb128 0x1
 3491 0161 68        		.byte	0x68
 3492 0162 9F        		.byte	0x9f
 3493 0163 0000 0000 		.long	.LVL17
 3494 0167 0000 0000 		.long	.LVL18
 3495 016b 0100      		.word	0x1
 3496 016d 68        		.byte	0x68
 3497 016e 0000 0000 		.long	.LVL18
 3498 0172 0000 0000 		.long	.LFE104
 3499 0176 0400      		.word	0x4
 3500 0178 F3        		.byte	0xf3
 3501 0179 01        		.uleb128 0x1
 3502 017a 68        		.byte	0x68
 3503 017b 9F        		.byte	0x9f
 3504 017c 0000 0000 		.long	0
 3505 0180 0000 0000 		.long	0
 3506               	.LLST7:
 3507 0184 0000 0000 		.long	.LFB105
 3508 0188 0000 0000 		.long	.LCFI5
 3509 018c 0300      		.word	0x3
 3510 018e 92        		.byte	0x92
 3511 018f 20        		.uleb128 0x20
 3512 0190 03        		.sleb128 3
 3513 0191 0000 0000 		.long	.LCFI5
 3514 0195 0000 0000 		.long	.LCFI6
 3515 0199 0300      		.word	0x3
GAS LISTING /tmp/ccjlgSmg.s 			page 71


 3516 019b 92        		.byte	0x92
 3517 019c 20        		.uleb128 0x20
 3518 019d 04        		.sleb128 4
 3519 019e 0000 0000 		.long	.LCFI6
 3520 01a2 0000 0000 		.long	.LCFI7
 3521 01a6 0300      		.word	0x3
 3522 01a8 92        		.byte	0x92
 3523 01a9 20        		.uleb128 0x20
 3524 01aa 05        		.sleb128 5
 3525 01ab 0000 0000 		.long	.LCFI7
 3526 01af 0000 0000 		.long	.LCFI8
 3527 01b3 0300      		.word	0x3
 3528 01b5 92        		.byte	0x92
 3529 01b6 20        		.uleb128 0x20
 3530 01b7 06        		.sleb128 6
 3531 01b8 0000 0000 		.long	.LCFI8
 3532 01bc 0000 0000 		.long	.LCFI9
 3533 01c0 0300      		.word	0x3
 3534 01c2 92        		.byte	0x92
 3535 01c3 20        		.uleb128 0x20
 3536 01c4 07        		.sleb128 7
 3537 01c5 0000 0000 		.long	.LCFI9
 3538 01c9 0000 0000 		.long	.LCFI10
 3539 01cd 0300      		.word	0x3
 3540 01cf 92        		.byte	0x92
 3541 01d0 20        		.uleb128 0x20
 3542 01d1 08        		.sleb128 8
 3543 01d2 0000 0000 		.long	.LCFI10
 3544 01d6 0000 0000 		.long	.LCFI11
 3545 01da 0300      		.word	0x3
 3546 01dc 92        		.byte	0x92
 3547 01dd 20        		.uleb128 0x20
 3548 01de 09        		.sleb128 9
 3549 01df 0000 0000 		.long	.LCFI11
 3550 01e3 0000 0000 		.long	.LCFI12
 3551 01e7 0300      		.word	0x3
 3552 01e9 92        		.byte	0x92
 3553 01ea 20        		.uleb128 0x20
 3554 01eb 0A        		.sleb128 10
 3555 01ec 0000 0000 		.long	.LCFI12
 3556 01f0 0000 0000 		.long	.LCFI13
 3557 01f4 0300      		.word	0x3
 3558 01f6 92        		.byte	0x92
 3559 01f7 20        		.uleb128 0x20
 3560 01f8 0B        		.sleb128 11
 3561 01f9 0000 0000 		.long	.LCFI13
 3562 01fd 0000 0000 		.long	.LCFI14
 3563 0201 0300      		.word	0x3
 3564 0203 92        		.byte	0x92
 3565 0204 20        		.uleb128 0x20
 3566 0205 0C        		.sleb128 12
 3567 0206 0000 0000 		.long	.LCFI14
 3568 020a 0000 0000 		.long	.LCFI15
 3569 020e 0300      		.word	0x3
 3570 0210 92        		.byte	0x92
 3571 0211 20        		.uleb128 0x20
 3572 0212 0D        		.sleb128 13
GAS LISTING /tmp/ccjlgSmg.s 			page 72


 3573 0213 0000 0000 		.long	.LCFI15
 3574 0217 0000 0000 		.long	.LCFI16
 3575 021b 0300      		.word	0x3
 3576 021d 92        		.byte	0x92
 3577 021e 20        		.uleb128 0x20
 3578 021f 0E        		.sleb128 14
 3579 0220 0000 0000 		.long	.LCFI16
 3580 0224 0000 0000 		.long	.LCFI17
 3581 0228 0300      		.word	0x3
 3582 022a 92        		.byte	0x92
 3583 022b 20        		.uleb128 0x20
 3584 022c 0F        		.sleb128 15
 3585 022d 0000 0000 		.long	.LCFI17
 3586 0231 0000 0000 		.long	.LCFI18
 3587 0235 0300      		.word	0x3
 3588 0237 92        		.byte	0x92
 3589 0238 20        		.uleb128 0x20
 3590 0239 10        		.sleb128 16
 3591 023a 0000 0000 		.long	.LCFI18
 3592 023e 0000 0000 		.long	.LFE105
 3593 0242 0300      		.word	0x3
 3594 0244 92        		.byte	0x92
 3595 0245 20        		.uleb128 0x20
 3596 0246 11        		.sleb128 17
 3597 0247 0000 0000 		.long	0
 3598 024b 0000 0000 		.long	0
 3599               	.LLST8:
 3600 024f 0000 0000 		.long	.LVL34
 3601 0253 0000 0000 		.long	.LVL35
 3602 0257 0100      		.word	0x1
 3603 0259 69        		.byte	0x69
 3604 025a 0000 0000 		.long	0
 3605 025e 0000 0000 		.long	0
 3606               	.LLST9:
 3607 0262 0000 0000 		.long	.LVL19
 3608 0266 0000 0000 		.long	.LVL22
 3609 026a 0100      		.word	0x1
 3610 026c 68        		.byte	0x68
 3611 026d 0000 0000 		.long	.LVL22
 3612 0271 0000 0000 		.long	.LVL23
 3613 0275 0100      		.word	0x1
 3614 0277 69        		.byte	0x69
 3615 0278 0000 0000 		.long	.LVL23
 3616 027c 0000 0000 		.long	.LVL28
 3617 0280 0100      		.word	0x1
 3618 0282 68        		.byte	0x68
 3619 0283 0000 0000 		.long	.LVL30
 3620 0287 0000 0000 		.long	.LVL31-1
 3621 028b 0100      		.word	0x1
 3622 028d 68        		.byte	0x68
 3623 028e 0000 0000 		.long	.LVL32
 3624 0292 0000 0000 		.long	.LVL33
 3625 0296 0100      		.word	0x1
 3626 0298 69        		.byte	0x69
 3627 0299 0000 0000 		.long	.LVL33
 3628 029d 0000 0000 		.long	.LVL35
 3629 02a1 0100      		.word	0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 73


 3630 02a3 68        		.byte	0x68
 3631 02a4 0000 0000 		.long	0
 3632 02a8 0000 0000 		.long	0
 3633               	.LLST10:
 3634 02ac 0000 0000 		.long	.LVL20
 3635 02b0 0000 0000 		.long	.LVL21
 3636 02b4 0100      		.word	0x1
 3637 02b6 69        		.byte	0x69
 3638 02b7 0000 0000 		.long	.LVL21
 3639 02bb 0000 0000 		.long	.LVL24
 3640 02bf 0500      		.word	0x5
 3641 02c1 03        		.byte	0x3
 3642 02c2 0000 0000 		.long	twiState
 3643 02c6 0000 0000 		.long	.LVL24
 3644 02ca 0000 0000 		.long	.LVL25
 3645 02ce 0100      		.word	0x1
 3646 02d0 69        		.byte	0x69
 3647 02d1 0000 0000 		.long	.LVL25
 3648 02d5 0000 0000 		.long	.LVL26
 3649 02d9 0500      		.word	0x5
 3650 02db 03        		.byte	0x3
 3651 02dc 0000 0000 		.long	twiState
 3652 02e0 0000 0000 		.long	.LVL27
 3653 02e4 0000 0000 		.long	.LVL29-1
 3654 02e8 0100      		.word	0x1
 3655 02ea 69        		.byte	0x69
 3656 02eb 0000 0000 		.long	.LVL32
 3657 02ef 0000 0000 		.long	.LVL33
 3658 02f3 0500      		.word	0x5
 3659 02f5 03        		.byte	0x3
 3660 02f6 0000 0000 		.long	twiState
 3661 02fa 0000 0000 		.long	0
 3662 02fe 0000 0000 		.long	0
 3663               	.LLST11:
 3664 0302 0000 0000 		.long	.LVL36
 3665 0306 0000 0000 		.long	.LVL37
 3666 030a 0100      		.word	0x1
 3667 030c 68        		.byte	0x68
 3668 030d 0000 0000 		.long	.LVL37
 3669 0311 0000 0000 		.long	.LVL38
 3670 0315 0500      		.word	0x5
 3671 0317 03        		.byte	0x3
 3672 0318 0000 0000 		.long	twiSLARW
 3673 031c 0000 0000 		.long	.LVL38
 3674 0320 0000 0000 		.long	.LFE106
 3675 0324 0400      		.word	0x4
 3676 0326 F3        		.byte	0xf3
 3677 0327 01        		.uleb128 0x1
 3678 0328 68        		.byte	0x68
 3679 0329 9F        		.byte	0x9f
 3680 032a 0000 0000 		.long	0
 3681 032e 0000 0000 		.long	0
 3682               	.LLST12:
 3683 0332 0000 0000 		.long	.LVL39
 3684 0336 0000 0000 		.long	.LVL40
 3685 033a 0100      		.word	0x1
 3686 033c 68        		.byte	0x68
GAS LISTING /tmp/ccjlgSmg.s 			page 74


 3687 033d 0000 0000 		.long	.LVL40
 3688 0341 0000 0000 		.long	.LVL41
 3689 0345 0500      		.word	0x5
 3690 0347 03        		.byte	0x3
 3691 0348 0000 0000 		.long	twiSLARW
 3692 034c 0000 0000 		.long	.LVL41
 3693 0350 0000 0000 		.long	.LFE107
 3694 0354 0400      		.word	0x4
 3695 0356 F3        		.byte	0xf3
 3696 0357 01        		.uleb128 0x1
 3697 0358 68        		.byte	0x68
 3698 0359 9F        		.byte	0x9f
 3699 035a 0000 0000 		.long	0
 3700 035e 0000 0000 		.long	0
 3701               	.LLST13:
 3702 0362 0000 0000 		.long	.LVL42
 3703 0366 0000 0000 		.long	.LVL43
 3704 036a 0100      		.word	0x1
 3705 036c 68        		.byte	0x68
 3706 036d 0000 0000 		.long	.LVL43
 3707 0371 0000 0000 		.long	.LFE108
 3708 0375 0400      		.word	0x4
 3709 0377 F3        		.byte	0xf3
 3710 0378 01        		.uleb128 0x1
 3711 0379 68        		.byte	0x68
 3712 037a 9F        		.byte	0x9f
 3713 037b 0000 0000 		.long	0
 3714 037f 0000 0000 		.long	0
 3715               	.LLST14:
 3716 0383 0000 0000 		.long	.LVL42
 3717 0387 0000 0000 		.long	.LVL44-1
 3718 038b 0600      		.word	0x6
 3719 038d 66        		.byte	0x66
 3720 038e 93        		.byte	0x93
 3721 038f 01        		.uleb128 0x1
 3722 0390 67        		.byte	0x67
 3723 0391 93        		.byte	0x93
 3724 0392 01        		.uleb128 0x1
 3725 0393 0000 0000 		.long	.LVL44-1
 3726 0397 0000 0000 		.long	.LFE108
 3727 039b 0400      		.word	0x4
 3728 039d F3        		.byte	0xf3
 3729 039e 01        		.uleb128 0x1
 3730 039f 66        		.byte	0x66
 3731 03a0 9F        		.byte	0x9f
 3732 03a1 0000 0000 		.long	0
 3733 03a5 0000 0000 		.long	0
 3734               	.LLST15:
 3735 03a9 0000 0000 		.long	.LVL42
 3736 03ad 0000 0000 		.long	.LVL44-1
 3737 03b1 0100      		.word	0x1
 3738 03b3 64        		.byte	0x64
 3739 03b4 0000 0000 		.long	.LVL44-1
 3740 03b8 0000 0000 		.long	.LFE108
 3741 03bc 0400      		.word	0x4
 3742 03be F3        		.byte	0xf3
 3743 03bf 01        		.uleb128 0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 75


 3744 03c0 64        		.byte	0x64
 3745 03c1 9F        		.byte	0x9f
 3746 03c2 0000 0000 		.long	0
 3747 03c6 0000 0000 		.long	0
 3748               	.LLST16:
 3749 03ca 0000 0000 		.long	.LVL45
 3750 03ce 0000 0000 		.long	.LVL46
 3751 03d2 0100      		.word	0x1
 3752 03d4 68        		.byte	0x68
 3753 03d5 0000 0000 		.long	.LVL46
 3754 03d9 0000 0000 		.long	.LFE109
 3755 03dd 0400      		.word	0x4
 3756 03df F3        		.byte	0xf3
 3757 03e0 01        		.uleb128 0x1
 3758 03e1 68        		.byte	0x68
 3759 03e2 9F        		.byte	0x9f
 3760 03e3 0000 0000 		.long	0
 3761 03e7 0000 0000 		.long	0
 3762               	.LLST17:
 3763 03eb 0000 0000 		.long	.LVL45
 3764 03ef 0000 0000 		.long	.LVL47-1
 3765 03f3 0600      		.word	0x6
 3766 03f5 66        		.byte	0x66
 3767 03f6 93        		.byte	0x93
 3768 03f7 01        		.uleb128 0x1
 3769 03f8 67        		.byte	0x67
 3770 03f9 93        		.byte	0x93
 3771 03fa 01        		.uleb128 0x1
 3772 03fb 0000 0000 		.long	.LVL47-1
 3773 03ff 0000 0000 		.long	.LFE109
 3774 0403 0400      		.word	0x4
 3775 0405 F3        		.byte	0xf3
 3776 0406 01        		.uleb128 0x1
 3777 0407 66        		.byte	0x66
 3778 0408 9F        		.byte	0x9f
 3779 0409 0000 0000 		.long	0
 3780 040d 0000 0000 		.long	0
 3781               	.LLST18:
 3782 0411 0000 0000 		.long	.LVL45
 3783 0415 0000 0000 		.long	.LVL47-1
 3784 0419 0100      		.word	0x1
 3785 041b 64        		.byte	0x64
 3786 041c 0000 0000 		.long	.LVL47-1
 3787 0420 0000 0000 		.long	.LFE109
 3788 0424 0400      		.word	0x4
 3789 0426 F3        		.byte	0xf3
 3790 0427 01        		.uleb128 0x1
 3791 0428 64        		.byte	0x64
 3792 0429 9F        		.byte	0x9f
 3793 042a 0000 0000 		.long	0
 3794 042e 0000 0000 		.long	0
 3795               	.LLST19:
 3796 0432 0000 0000 		.long	.LFB110
 3797 0436 0000 0000 		.long	.LCFI19
 3798 043a 0300      		.word	0x3
 3799 043c 92        		.byte	0x92
 3800 043d 20        		.uleb128 0x20
GAS LISTING /tmp/ccjlgSmg.s 			page 76


 3801 043e 03        		.sleb128 3
 3802 043f 0000 0000 		.long	.LCFI19
 3803 0443 0000 0000 		.long	.LFE110
 3804 0447 0300      		.word	0x3
 3805 0449 92        		.byte	0x92
 3806 044a 20        		.uleb128 0x20
 3807 044b 04        		.sleb128 4
 3808 044c 0000 0000 		.long	0
 3809 0450 0000 0000 		.long	0
 3810               	.LLST20:
 3811 0454 0000 0000 		.long	.LVL48
 3812 0458 0000 0000 		.long	.LVL49
 3813 045c 0100      		.word	0x1
 3814 045e 68        		.byte	0x68
 3815 045f 0000 0000 		.long	.LVL49
 3816 0463 0000 0000 		.long	.LFE110
 3817 0467 0400      		.word	0x4
 3818 0469 F3        		.byte	0xf3
 3819 046a 01        		.uleb128 0x1
 3820 046b 68        		.byte	0x68
 3821 046c 9F        		.byte	0x9f
 3822 046d 0000 0000 		.long	0
 3823 0471 0000 0000 		.long	0
 3824               	.LLST21:
 3825 0475 0000 0000 		.long	.LVL48
 3826 0479 0000 0000 		.long	.LVL50
 3827 047d 0100      		.word	0x1
 3828 047f 60        		.byte	0x60
 3829 0480 0000 0000 		.long	.LVL50
 3830 0484 0000 0000 		.long	.LFE110
 3831 0488 0400      		.word	0x4
 3832 048a F3        		.byte	0xf3
 3833 048b 01        		.uleb128 0x1
 3834 048c 60        		.byte	0x60
 3835 048d 9F        		.byte	0x9f
 3836 048e 0000 0000 		.long	0
 3837 0492 0000 0000 		.long	0
 3838               	.LLST22:
 3839 0496 0000 0000 		.long	.LVL51
 3840 049a 0000 0000 		.long	.LVL56
 3841 049e 0100      		.word	0x1
 3842 04a0 68        		.byte	0x68
 3843 04a1 0000 0000 		.long	.LVL56
 3844 04a5 0000 0000 		.long	.LFE111
 3845 04a9 0400      		.word	0x4
 3846 04ab F3        		.byte	0xf3
 3847 04ac 01        		.uleb128 0x1
 3848 04ad 68        		.byte	0x68
 3849 04ae 9F        		.byte	0x9f
 3850 04af 0000 0000 		.long	0
 3851 04b3 0000 0000 		.long	0
 3852               	.LLST23:
 3853 04b7 0000 0000 		.long	.LVL52
 3854 04bb 0000 0000 		.long	.LVL54
 3855 04bf 0100      		.word	0x1
 3856 04c1 69        		.byte	0x69
 3857 04c2 0000 0000 		.long	.LVL54
GAS LISTING /tmp/ccjlgSmg.s 			page 77


 3858 04c6 0000 0000 		.long	.LVL55
 3859 04ca 0500      		.word	0x5
 3860 04cc 89        		.byte	0x89
 3861 04cd 00        		.sleb128 0
 3862 04ce 34        		.byte	0x34
 3863 04cf 21        		.byte	0x21
 3864 04d0 9F        		.byte	0x9f
 3865 04d1 0000 0000 		.long	.LVL55
 3866 04d5 0000 0000 		.long	.LVL57
 3867 04d9 0100      		.word	0x1
 3868 04db 69        		.byte	0x69
 3869 04dc 0000 0000 		.long	.LVL57
 3870 04e0 0000 0000 		.long	.LVL59
 3871 04e4 0100      		.word	0x1
 3872 04e6 68        		.byte	0x68
 3873 04e7 0000 0000 		.long	.LVL59
 3874 04eb 0000 0000 		.long	.LVL60
 3875 04ef 0500      		.word	0x5
 3876 04f1 88        		.byte	0x88
 3877 04f2 00        		.sleb128 0
 3878 04f3 34        		.byte	0x34
 3879 04f4 21        		.byte	0x21
 3880 04f5 9F        		.byte	0x9f
 3881 04f6 0000 0000 		.long	.LVL60
 3882 04fa 0000 0000 		.long	.LFE111
 3883 04fe 0100      		.word	0x1
 3884 0500 68        		.byte	0x68
 3885 0501 0000 0000 		.long	0
 3886 0505 0000 0000 		.long	0
 3887               	.LLST24:
 3888 0509 0000 0000 		.long	.LFB112
 3889 050d 0000 0000 		.long	.LCFI20
 3890 0511 0300      		.word	0x3
 3891 0513 92        		.byte	0x92
 3892 0514 20        		.uleb128 0x20
 3893 0515 03        		.sleb128 3
 3894 0516 0000 0000 		.long	.LCFI20
 3895 051a 0000 0000 		.long	.LCFI21
 3896 051e 0300      		.word	0x3
 3897 0520 92        		.byte	0x92
 3898 0521 20        		.uleb128 0x20
 3899 0522 04        		.sleb128 4
 3900 0523 0000 0000 		.long	.LCFI21
 3901 0527 0000 0000 		.long	.LCFI22
 3902 052b 0300      		.word	0x3
 3903 052d 92        		.byte	0x92
 3904 052e 20        		.uleb128 0x20
 3905 052f 05        		.sleb128 5
 3906 0530 0000 0000 		.long	.LCFI22
 3907 0534 0000 0000 		.long	.LFE112
 3908 0538 0300      		.word	0x3
 3909 053a 92        		.byte	0x92
 3910 053b 20        		.uleb128 0x20
 3911 053c 06        		.sleb128 6
 3912 053d 0000 0000 		.long	0
 3913 0541 0000 0000 		.long	0
 3914               	.LLST25:
GAS LISTING /tmp/ccjlgSmg.s 			page 78


 3915 0545 0000 0000 		.long	.LVL61
 3916 0549 0000 0000 		.long	.LVL63
 3917 054d 0600      		.word	0x6
 3918 054f 68        		.byte	0x68
 3919 0550 93        		.byte	0x93
 3920 0551 01        		.uleb128 0x1
 3921 0552 69        		.byte	0x69
 3922 0553 93        		.byte	0x93
 3923 0554 01        		.uleb128 0x1
 3924 0555 0000 0000 		.long	.LVL63
 3925 0559 0000 0000 		.long	.LFE112
 3926 055d 0400      		.word	0x4
 3927 055f F3        		.byte	0xf3
 3928 0560 01        		.uleb128 0x1
 3929 0561 68        		.byte	0x68
 3930 0562 9F        		.byte	0x9f
 3931 0563 0000 0000 		.long	0
 3932 0567 0000 0000 		.long	0
 3933               	.LLST26:
 3934 056b 0000 0000 		.long	.LVL61
 3935 056f 0000 0000 		.long	.LVL63
 3936 0573 0100      		.word	0x1
 3937 0575 66        		.byte	0x66
 3938 0576 0000 0000 		.long	.LVL63
 3939 057a 0000 0000 		.long	.LFE112
 3940 057e 0400      		.word	0x4
 3941 0580 F3        		.byte	0xf3
 3942 0581 01        		.uleb128 0x1
 3943 0582 66        		.byte	0x66
 3944 0583 9F        		.byte	0x9f
 3945 0584 0000 0000 		.long	0
 3946 0588 0000 0000 		.long	0
 3947               	.LLST27:
 3948 058c 0000 0000 		.long	.LVL62
 3949 0590 0000 0000 		.long	.LVL63
 3950 0594 0600      		.word	0x6
 3951 0596 68        		.byte	0x68
 3952 0597 93        		.byte	0x93
 3953 0598 01        		.uleb128 0x1
 3954 0599 69        		.byte	0x69
 3955 059a 93        		.byte	0x93
 3956 059b 01        		.uleb128 0x1
 3957 059c 0000 0000 		.long	.LVL63
 3958 05a0 0000 0000 		.long	.LVL64
 3959 05a4 0600      		.word	0x6
 3960 05a6 6C        		.byte	0x6c
 3961 05a7 93        		.byte	0x93
 3962 05a8 01        		.uleb128 0x1
 3963 05a9 6D        		.byte	0x6d
 3964 05aa 93        		.byte	0x93
 3965 05ab 01        		.uleb128 0x1
 3966 05ac 0000 0000 		.long	.LVL64
 3967 05b0 0000 0000 		.long	.LVL65
 3968 05b4 0300      		.word	0x3
 3969 05b6 8C        		.byte	0x8c
 3970 05b7 01        		.sleb128 1
 3971 05b8 9F        		.byte	0x9f
GAS LISTING /tmp/ccjlgSmg.s 			page 79


 3972 05b9 0000 0000 		.long	.LVL65
 3973 05bd 0000 0000 		.long	.LVL70
 3974 05c1 0600      		.word	0x6
 3975 05c3 6C        		.byte	0x6c
 3976 05c4 93        		.byte	0x93
 3977 05c5 01        		.uleb128 0x1
 3978 05c6 6D        		.byte	0x6d
 3979 05c7 93        		.byte	0x93
 3980 05c8 01        		.uleb128 0x1
 3981 05c9 0000 0000 		.long	0
 3982 05cd 0000 0000 		.long	0
 3983               	.LLST28:
 3984 05d1 0000 0000 		.long	.LVL62
 3985 05d5 0000 0000 		.long	.LVL63
 3986 05d9 0100      		.word	0x1
 3987 05db 66        		.byte	0x66
 3988 05dc 0000 0000 		.long	.LVL63
 3989 05e0 0000 0000 		.long	.LVL65
 3990 05e4 0C00      		.word	0xc
 3991 05e6 8C        		.byte	0x8c
 3992 05e7 00        		.sleb128 0
 3993 05e8 20        		.byte	0x20
 3994 05e9 F3        		.byte	0xf3
 3995 05ea 01        		.uleb128 0x1
 3996 05eb 66        		.byte	0x66
 3997 05ec 22        		.byte	0x22
 3998 05ed F3        		.byte	0xf3
 3999 05ee 01        		.uleb128 0x1
 4000 05ef 68        		.byte	0x68
 4001 05f0 22        		.byte	0x22
 4002 05f1 9F        		.byte	0x9f
 4003 05f2 0000 0000 		.long	.LVL65
 4004 05f6 0000 0000 		.long	.LVL69
 4005 05fa 0B00      		.word	0xb
 4006 05fc F3        		.byte	0xf3
 4007 05fd 01        		.uleb128 0x1
 4008 05fe 66        		.byte	0x66
 4009 05ff 8C        		.byte	0x8c
 4010 0600 00        		.sleb128 0
 4011 0601 1C        		.byte	0x1c
 4012 0602 F3        		.byte	0xf3
 4013 0603 01        		.uleb128 0x1
 4014 0604 68        		.byte	0x68
 4015 0605 22        		.byte	0x22
 4016 0606 9F        		.byte	0x9f
 4017 0607 0000 0000 		.long	.LVL69
 4018 060b 0000 0000 		.long	.LVL70
 4019 060f 0C00      		.word	0xc
 4020 0611 8C        		.byte	0x8c
 4021 0612 00        		.sleb128 0
 4022 0613 20        		.byte	0x20
 4023 0614 F3        		.byte	0xf3
 4024 0615 01        		.uleb128 0x1
 4025 0616 66        		.byte	0x66
 4026 0617 22        		.byte	0x22
 4027 0618 F3        		.byte	0xf3
 4028 0619 01        		.uleb128 0x1
GAS LISTING /tmp/ccjlgSmg.s 			page 80


 4029 061a 68        		.byte	0x68
 4030 061b 22        		.byte	0x22
 4031 061c 9F        		.byte	0x9f
 4032 061d 0000 0000 		.long	0
 4033 0621 0000 0000 		.long	0
 4034               	.LLST29:
 4035 0625 0000 0000 		.long	.LFB114
 4036 0629 0000 0000 		.long	.LCFI23
 4037 062d 0300      		.word	0x3
 4038 062f 92        		.byte	0x92
 4039 0630 20        		.uleb128 0x20
 4040 0631 03        		.sleb128 3
 4041 0632 0000 0000 		.long	.LCFI23
 4042 0636 0000 0000 		.long	.LFE114
 4043 063a 0300      		.word	0x3
 4044 063c 92        		.byte	0x92
 4045 063d 20        		.uleb128 0x20
 4046 063e 04        		.sleb128 4
 4047 063f 0000 0000 		.long	0
 4048 0643 0000 0000 		.long	0
 4049               	.LLST30:
 4050 0647 0000 0000 		.long	.LVL87
 4051 064b 0000 0000 		.long	.LVL88
 4052 064f 0100      		.word	0x1
 4053 0651 68        		.byte	0x68
 4054 0652 0000 0000 		.long	.LVL88
 4055 0656 0000 0000 		.long	.LVL89
 4056 065a 0500      		.word	0x5
 4057 065c 03        		.byte	0x3
 4058 065d 0000 0000 		.long	lcdAddress
 4059 0661 0000 0000 		.long	.LVL89
 4060 0665 0000 0000 		.long	.LVL90
 4061 0669 0100      		.word	0x1
 4062 066b 68        		.byte	0x68
 4063 066c 0000 0000 		.long	.LVL90
 4064 0670 0000 0000 		.long	.LVL93-1
 4065 0674 0500      		.word	0x5
 4066 0676 03        		.byte	0x3
 4067 0677 0000 0000 		.long	lcdAddress
 4068 067b 0000 0000 		.long	.LVL93-1
 4069 067f 0000 0000 		.long	.LFE114
 4070 0683 0400      		.word	0x4
 4071 0685 F3        		.byte	0xf3
 4072 0686 01        		.uleb128 0x1
 4073 0687 68        		.byte	0x68
 4074 0688 9F        		.byte	0x9f
 4075 0689 0000 0000 		.long	0
 4076 068d 0000 0000 		.long	0
 4077               	.LLST31:
 4078 0691 0000 0000 		.long	.LVL87
 4079 0695 0000 0000 		.long	.LVL92
 4080 0699 0100      		.word	0x1
 4081 069b 66        		.byte	0x66
 4082 069c 0000 0000 		.long	.LVL92
 4083 06a0 0000 0000 		.long	.LVL93-1
 4084 06a4 0500      		.word	0x5
 4085 06a6 03        		.byte	0x3
GAS LISTING /tmp/ccjlgSmg.s 			page 81


 4086 06a7 0000 0000 		.long	lcdCols
 4087 06ab 0000 0000 		.long	.LVL93-1
 4088 06af 0000 0000 		.long	.LFE114
 4089 06b3 0400      		.word	0x4
 4090 06b5 F3        		.byte	0xf3
 4091 06b6 01        		.uleb128 0x1
 4092 06b7 66        		.byte	0x66
 4093 06b8 9F        		.byte	0x9f
 4094 06b9 0000 0000 		.long	0
 4095 06bd 0000 0000 		.long	0
 4096               	.LLST32:
 4097 06c1 0000 0000 		.long	.LVL87
 4098 06c5 0000 0000 		.long	.LVL91
 4099 06c9 0100      		.word	0x1
 4100 06cb 64        		.byte	0x64
 4101 06cc 0000 0000 		.long	.LVL91
 4102 06d0 0000 0000 		.long	.LVL107
 4103 06d4 0100      		.word	0x1
 4104 06d6 6C        		.byte	0x6c
 4105 06d7 0000 0000 		.long	.LVL107
 4106 06db 0000 0000 		.long	.LFE114
 4107 06df 0400      		.word	0x4
 4108 06e1 F3        		.byte	0xf3
 4109 06e2 01        		.uleb128 0x1
 4110 06e3 64        		.byte	0x64
 4111 06e4 9F        		.byte	0x9f
 4112 06e5 0000 0000 		.long	0
 4113 06e9 0000 0000 		.long	0
 4114               	.LLST33:
 4115 06ed 0000 0000 		.long	.LVL87
 4116 06f1 0000 0000 		.long	.LVL93-1
 4117 06f5 0100      		.word	0x1
 4118 06f7 62        		.byte	0x62
 4119 06f8 0000 0000 		.long	.LVL93-1
 4120 06fc 0000 0000 		.long	.LFE114
 4121 0700 0400      		.word	0x4
 4122 0702 F3        		.byte	0xf3
 4123 0703 01        		.uleb128 0x1
 4124 0704 62        		.byte	0x62
 4125 0705 9F        		.byte	0x9f
 4126 0706 0000 0000 		.long	0
 4127 070a 0000 0000 		.long	0
 4128               		.section	.debug_aranges,"",@progbits
 4129 0000 8C00 0000 		.long	0x8c
 4130 0004 0200      		.word	0x2
 4131 0006 0000 0000 		.long	.Ldebug_info0
 4132 000a 04        		.byte	0x4
 4133 000b 00        		.byte	0
 4134 000c 0000      		.word	0
 4135 000e 0000      		.word	0
 4136 0010 0000 0000 		.long	.LFB102
 4137 0014 4800 0000 		.long	.LFE102-.LFB102
 4138 0018 0000 0000 		.long	.LFB103
 4139 001c 3000 0000 		.long	.LFE103-.LFB103
 4140 0020 0000 0000 		.long	.LFB104
 4141 0024 5800 0000 		.long	.LFE104-.LFB104
 4142 0028 0000 0000 		.long	.LFB105
GAS LISTING /tmp/ccjlgSmg.s 			page 82


 4143 002c E000 0000 		.long	.LFE105-.LFB105
 4144 0030 0000 0000 		.long	.LFB106
 4145 0034 2200 0000 		.long	.LFE106-.LFB106
 4146 0038 0000 0000 		.long	.LFB107
 4147 003c 2200 0000 		.long	.LFE107-.LFB107
 4148 0040 0000 0000 		.long	.LFB108
 4149 0044 2400 0000 		.long	.LFE108-.LFB108
 4150 0048 0000 0000 		.long	.LFB109
 4151 004c 2600 0000 		.long	.LFE109-.LFB109
 4152 0050 0000 0000 		.long	.LFB110
 4153 0054 5A00 0000 		.long	.LFE110-.LFB110
 4154 0058 0000 0000 		.long	.LFB111
 4155 005c 3A00 0000 		.long	.LFE111-.LFB111
 4156 0060 0000 0000 		.long	.LFB112
 4157 0064 4400 0000 		.long	.LFE112-.LFB112
 4158 0068 0000 0000 		.long	.LFB113
 4159 006c A400 0000 		.long	.LFE113-.LFB113
 4160 0070 0000 0000 		.long	.LFB114
 4161 0074 DA00 0000 		.long	.LFE114-.LFB114
 4162 0078 0000 0000 		.long	.LFB115
 4163 007c 1600 0000 		.long	.LFE115-.LFB115
 4164 0080 0000 0000 		.long	.LFB116
 4165 0084 0200 0000 		.long	.LFE116-.LFB116
 4166 0088 0000 0000 		.long	0
 4167 008c 0000 0000 		.long	0
 4168               		.section	.debug_ranges,"",@progbits
 4169               	.Ldebug_ranges0:
 4170 0000 0000 0000 		.long	.LFB102
 4171 0004 0000 0000 		.long	.LFE102
 4172 0008 0000 0000 		.long	.LFB103
 4173 000c 0000 0000 		.long	.LFE103
 4174 0010 0000 0000 		.long	.LFB104
 4175 0014 0000 0000 		.long	.LFE104
 4176 0018 0000 0000 		.long	.LFB105
 4177 001c 0000 0000 		.long	.LFE105
 4178 0020 0000 0000 		.long	.LFB106
 4179 0024 0000 0000 		.long	.LFE106
 4180 0028 0000 0000 		.long	.LFB107
 4181 002c 0000 0000 		.long	.LFE107
 4182 0030 0000 0000 		.long	.LFB108
 4183 0034 0000 0000 		.long	.LFE108
 4184 0038 0000 0000 		.long	.LFB109
 4185 003c 0000 0000 		.long	.LFE109
 4186 0040 0000 0000 		.long	.LFB110
 4187 0044 0000 0000 		.long	.LFE110
 4188 0048 0000 0000 		.long	.LFB111
 4189 004c 0000 0000 		.long	.LFE111
 4190 0050 0000 0000 		.long	.LFB112
 4191 0054 0000 0000 		.long	.LFE112
 4192 0058 0000 0000 		.long	.LFB113
 4193 005c 0000 0000 		.long	.LFE113
 4194 0060 0000 0000 		.long	.LFB114
 4195 0064 0000 0000 		.long	.LFE114
 4196 0068 0000 0000 		.long	.LFB115
 4197 006c 0000 0000 		.long	.LFE115
 4198 0070 0000 0000 		.long	.LFB116
 4199 0074 0000 0000 		.long	.LFE116
GAS LISTING /tmp/ccjlgSmg.s 			page 83


 4200 0078 0000 0000 		.long	0
 4201 007c 0000 0000 		.long	0
 4202               		.section	.debug_line,"",@progbits
 4203               	.Ldebug_line0:
 4204 0000 FE02 0000 		.section	.debug_str,"MS",@progbits,1
 4204      0200 B400 
 4204      0000 0201 
 4204      FB0E 0D00 
 4204      0101 0101 
 4205               	.LASF27:
 4206 0000 7477 6953 		.string	"twiSetup"
 4206      6574 7570 
 4206      00
 4207               	.LASF44:
 4208 0009 5F64 6174 		.string	"_data"
 4208      6100 
 4209               	.LASF9:
 4210 000f 6C6F 6E67 		.string	"long long unsigned int"
 4210      206C 6F6E 
 4210      6720 756E 
 4210      7369 676E 
 4210      6564 2069 
 4211               	.LASF18:
 4212 0026 7374 6172 		.string	"starts"
 4212      7473 00
 4213               	.LASF69:
 4214 002d 6C63 6453 		.string	"lcdShifts"
 4214      6869 6674 
 4214      7300 
 4215               	.LASF59:
 4216 0037 7477 6952 		.string	"twiRX_Count"
 4216      585F 436F 
 4216      756E 7400 
 4217               	.LASF8:
 4218 0043 6C6F 6E67 		.string	"long long int"
 4218      206C 6F6E 
 4218      6720 696E 
 4218      7400 
 4219               	.LASF0:
 4220 0051 7369 676E 		.string	"signed char"
 4220      6564 2063 
 4220      6861 7200 
 4221               	.LASF28:
 4222 005d 6672 6571 		.string	"freq"
 4222      00
 4223               	.LASF20:
 4224 0062 7374 6F70 		.string	"stops"
 4224      7300 
 4225               	.LASF17:
 4226 0068 5457 495F 		.string	"TWI_READY"
 4226      5245 4144 
 4226      5900 
 4227               	.LASF70:
 4228 0072 6C63 6453 		.string	"lcdShows"
 4228      686F 7773 
 4228      00
 4229               	.LASF5:
GAS LISTING /tmp/ccjlgSmg.s 			page 84


 4230 007b 6C6F 6E67 		.string	"long int"
 4230      2069 6E74 
 4230      00
 4231               	.LASF31:
 4232 0084 5F5F 7665 		.string	"__vector_39"
 4232      6374 6F72 
 4232      5F33 3900 
 4233               	.LASF67:
 4234 0090 7477 6953 		.string	"twiStatistic"
 4234      7461 7469 
 4234      7374 6963 
 4234      00
 4235               	.LASF3:
 4236 009d 7569 6E74 		.string	"uint16_t"
 4236      3136 5F74 
 4236      00
 4237               	.LASF13:
 4238 00a6 646F 7562 		.string	"double"
 4238      6C65 00
 4239               	.LASF41:
 4240 00ad 636C 656E 		.string	"clength"
 4240      6774 6800 
 4241               	.LASF66:
 4242 00b5 7477 6953 		.string	"twiSlaveWriter"
 4242      6C61 7665 
 4242      5772 6974 
 4242      6572 00
 4243               	.LASF39:
 4244 00c4 7477 6952 		.string	"twiRAW"
 4244      4157 00
 4245               	.LASF46:
 4246 00cb 6C63 6457 		.string	"lcdWrite"
 4246      7269 7465 
 4246      00
 4247               	.LASF38:
 4248 00d4 7477 6952 		.string	"twiRead"
 4248      6561 6400 
 4249               	.LASF25:
 4250 00dc 6269 744D 		.string	"bitMul"
 4250      756C 00
 4251               	.LASF4:
 4252 00e3 756E 7369 		.string	"unsigned int"
 4252      676E 6564 
 4252      2069 6E74 
 4252      00
 4253               	.LASF72:
 4254 00f0 6C63 6441 		.string	"lcdAddress"
 4254      6464 7265 
 4254      7373 00
 4255               	.LASF60:
 4256 00fb 7477 6952 		.string	"twiRX_Ptr"
 4256      585F 5074 
 4256      7200 
 4257               	.LASF40:
 4258 0105 636F 6D6D 		.string	"command"
 4258      616E 6400 
 4259               	.LASF83:
GAS LISTING /tmp/ccjlgSmg.s 			page 85


 4260 010d 6C6F 6F70 		.string	"loop"
 4260      00
 4261               	.LASF48:
 4262 0112 6C63 6453 		.string	"lcdSetup"
 4262      6574 7570 
 4262      00
 4263               	.LASF7:
 4264 011b 6C6F 6E67 		.string	"long unsigned int"
 4264      2075 6E73 
 4264      6967 6E65 
 4264      6420 696E 
 4264      7400 
 4265               	.LASF56:
 4266 012d 7477 6953 		.string	"twiSLARW"
 4266      4C41 5257 
 4266      00
 4267               	.LASF49:
 4268 0136 5F61 6464 		.string	"_address"
 4268      7265 7373 
 4268      00
 4269               	.LASF36:
 4270 013f 6461 7461 		.string	"data"
 4270      00
 4271               	.LASF14:
 4272 0144 7368 6F72 		.string	"short unsigned int"
 4272      7420 756E 
 4272      7369 676E 
 4272      6564 2069 
 4272      6E74 00
 4273               	.LASF23:
 4274 0157 5457 495F 		.string	"TWI_Stat"
 4274      5374 6174 
 4274      00
 4275               	.LASF51:
 4276 0160 5F72 6F77 		.string	"_rows"
 4276      7300 
 4277               	.LASF10:
 4278 0166 626F 6F6C 		.string	"bool"
 4278      00
 4279               	.LASF54:
 4280 016b 7477 694D 		.string	"twiMode"
 4280      6F64 6500 
 4281               	.LASF64:
 4282 0173 7477 694D 		.string	"twiMasterReader"
 4282      6173 7465 
 4282      7252 6561 
 4282      6465 7200 
 4283               	.LASF80:
 4284 0183 5457 495F 		.string	"TWI_Modes"
 4284      4D6F 6465 
 4284      7300 
 4285               	.LASF57:
 4286 018d 7477 694D 		.string	"twiMT_Count"
 4286      545F 436F 
 4286      756E 7400 
 4287               	.LASF30:
 4288 0199 7477 6953 		.string	"twiSendStop"
GAS LISTING /tmp/ccjlgSmg.s 			page 86


 4288      656E 6453 
 4288      746F 7000 
 4289               	.LASF33:
 4290 01a5 6164 6472 		.string	"address"
 4290      6573 7300 
 4291               	.LASF32:
 4292 01ad 5F74 7769 		.string	"_twiStartTo"
 4292      5374 6172 
 4292      7454 6F00 
 4293               	.LASF53:
 4294 01b9 7365 7475 		.string	"setup"
 4294      7000 
 4295               	.LASF12:
 4296 01bf 666C 6F61 		.string	"float"
 4296      7400 
 4297               	.LASF74:
 4298 01c5 6C63 6452 		.string	"lcdRows"
 4298      6F77 7300 
 4299               	.LASF84:
 4300 01cd 7469 6D65 		.string	"time_delay16"
 4300      5F64 656C 
 4300      6179 3136 
 4300      00
 4301               	.LASF58:
 4302 01da 7477 694D 		.string	"twiMT_Ptr"
 4302      545F 5074 
 4302      7200 
 4303               	.LASF43:
 4304 01e4 6C63 6450 		.string	"lcdPrepare"
 4304      7265 7061 
 4304      7265 00
 4305               	.LASF19:
 4306 01ef 7265 7374 		.string	"restarts"
 4306      6172 7473 
 4306      00
 4307               	.LASF52:
 4308 01f8 5F62 6163 		.string	"_backLight"
 4308      6B4C 6967 
 4308      6874 00
 4309               	.LASF77:
 4310 0203 474E 5520 		.string	"GNU C++ 4.8.1 -mmcu=atmega2560 -g -Os -ffunction-sections -fdata-sections -fno-threadsafe
 4310      432B 2B20 
 4310      342E 382E 
 4310      3120 2D6D 
 4310      6D63 753D 
 4311               	.LASF1:
 4312 0295 756E 7369 		.string	"unsigned char"
 4312      676E 6564 
 4312      2063 6861 
 4312      7200 
 4313               	.LASF50:
 4314 02a3 5F63 6F6C 		.string	"_cols"
 4314      7300 
 4315               	.LASF79:
 4316 02a9 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp"
 4316      2F62 7569 
 4316      6C64 3132 
GAS LISTING /tmp/ccjlgSmg.s 			page 87


 4316      3336 3837 
 4316      3935 3737 
 4317               	.LASF24:
 4318 02cb 6269 7452 		.string	"bitRate"
 4318      6174 6500 
 4319               	.LASF55:
 4320 02d3 7477 6953 		.string	"twiState"
 4320      7461 7465 
 4320      00
 4321               	.LASF78:
 4322 02dc 2F74 6D70 		.string	"/tmp/build1236879577286939714.tmp/LCD1602ex.cpp"
 4322      2F62 7569 
 4322      6C64 3132 
 4322      3336 3837 
 4322      3935 3737 
 4323               	.LASF6:
 4324 030c 7569 6E74 		.string	"uint32_t"
 4324      3332 5F74 
 4324      00
 4325               	.LASF76:
 4326 0315 6C63 6442 		.string	"lcdBuffer"
 4326      7566 6665 
 4326      7200 
 4327               	.LASF22:
 4328 031f 6E6F 736C 		.string	"noslarw"
 4328      6172 7700 
 4329               	.LASF37:
 4330 0327 6C65 6E67 		.string	"length"
 4330      7468 00
 4331               	.LASF11:
 4332 032e 6368 6172 		.string	"char"
 4332      00
 4333               	.LASF42:
 4334 0333 646C 656E 		.string	"dlength"
 4334      6774 6800 
 4335               	.LASF29:
 4336 033b 6D6F 6465 		.string	"mode"
 4336      00
 4337               	.LASF73:
 4338 0340 6C63 6443 		.string	"lcdCols"
 4338      6F6C 7300 
 4339               	.LASF21:
 4340 0348 6C6F 7374 		.string	"losts"
 4340      7300 
 4341               	.LASF82:
 4342 034e 7469 6D65 		.string	"time"
 4342      00
 4343               	.LASF26:
 4344 0353 7477 6953 		.string	"twiSpeed"
 4344      7065 6564 
 4344      00
 4345               	.LASF16:
 4346 035c 5457 495F 		.string	"TWI_SEND_STOP"
 4346      5345 4E44 
 4346      5F53 544F 
 4346      5000 
 4347               	.LASF71:
GAS LISTING /tmp/ccjlgSmg.s 			page 88


 4348 036a 6C63 6442 		.string	"lcdBackLight"
 4348      6163 6B4C 
 4348      6967 6874 
 4348      00
 4349               	.LASF2:
 4350 0377 7569 6E74 		.string	"uint8_t"
 4350      385F 7400 
 4351               	.LASF81:
 4352 037f 3854 5749 		.string	"8TWI_Stat"
 4352      5F53 7461 
 4352      7400 
 4353               	.LASF75:
 4354 0389 7369 7A65 		.string	"sizetype"
 4354      7479 7065 
 4354      00
 4355               	.LASF47:
 4356 0392 6C63 6449 		.string	"lcdInit"
 4356      6E69 7400 
 4357               	.LASF65:
 4358 039a 7477 6953 		.string	"twiSlaveReader"
 4358      6C61 7665 
 4358      5265 6164 
 4358      6572 00
 4359               	.LASF63:
 4360 03a9 7477 6948 		.string	"twiHookRestart"
 4360      6F6F 6B52 
 4360      6573 7461 
 4360      7274 00
 4361               	.LASF62:
 4362 03b8 7477 6953 		.string	"twiST_Ptr"
 4362      545F 5074 
 4362      7200 
 4363               	.LASF34:
 4364 03c2 5F74 7769 		.string	"_twiStartRe"
 4364      5374 6172 
 4364      7452 6500 
 4365               	.LASF35:
 4366 03ce 7477 6957 		.string	"twiWrite"
 4366      7269 7465 
 4366      00
 4367               	.LASF68:
 4368 03d7 6C63 644D 		.string	"lcdModes"
 4368      6F64 6573 
 4368      00
 4369               	.LASF45:
 4370 03e0 6E69 6262 		.string	"nibble"
 4370      6C65 00
 4371               	.LASF61:
 4372 03e7 7477 6953 		.string	"twiST_Count"
 4372      545F 436F 
 4372      756E 7400 
 4373               	.LASF15:
 4374 03f3 5457 495F 		.string	"TWI_IS_SLAVE"
 4374      4953 5F53 
 4374      4C41 5645 
 4374      00
 4375               		.ident	"GCC: (GNU) 4.8.1"
GAS LISTING /tmp/ccjlgSmg.s 			page 89


 4376               	.global __do_copy_data
 4377               	.global __do_clear_bss
GAS LISTING /tmp/ccjlgSmg.s 			page 90


DEFINED SYMBOLS
                            *ABS*:0000000000000000 LCD1602ex.cpp
     /tmp/ccjlgSmg.s:2      *ABS*:000000000000003e __SP_H__
     /tmp/ccjlgSmg.s:3      *ABS*:000000000000003d __SP_L__
     /tmp/ccjlgSmg.s:4      *ABS*:000000000000003f __SREG__
     /tmp/ccjlgSmg.s:5      *ABS*:000000000000003b __RAMPZ__
     /tmp/ccjlgSmg.s:6      *ABS*:0000000000000000 __tmp_reg__
     /tmp/ccjlgSmg.s:7      *ABS*:0000000000000001 __zero_reg__
     /tmp/ccjlgSmg.s:14     .text.twiSpeed:0000000000000000 twiSpeed
     /tmp/ccjlgSmg.s:84     .text.twiSetup:0000000000000000 twiSetup
     /tmp/ccjlgSmg.s:1180   .bss.twiMode:0000000000000000 twiMode
     /tmp/ccjlgSmg.s:141    .text.twiSendStop:0000000000000000 twiSendStop
     /tmp/ccjlgSmg.s:1126   .bss.twiHookRestart:0000000000000000 twiHookRestart
     /tmp/ccjlgSmg.s:1168   .bss.twiSLARW:0000000000000000 twiSLARW
     /tmp/ccjlgSmg.s:222    .text.__vector_39:0000000000000000 __vector_39
     /tmp/ccjlgSmg.s:1174   .bss.twiState:0000000000000000 twiState
     /tmp/ccjlgSmg.s:1144   .bss.twiRX_Ptr:0000000000000000 twiRX_Ptr
     /tmp/ccjlgSmg.s:1150   .bss.twiRX_Count:0000000000000000 twiRX_Count
     /tmp/ccjlgSmg.s:1120   .bss.twiMasterReader:0000000000000000 twiMasterReader
     /tmp/ccjlgSmg.s:426    .text._twiStartTo:0000000000000000 _twiStartTo
     /tmp/ccjlgSmg.s:461    .text._twiStartRe:0000000000000000 _twiStartRe
     /tmp/ccjlgSmg.s:496    .text.twiWrite:0000000000000000 twiWrite
     /tmp/ccjlgSmg.s:1156   .bss.twiMT_Ptr:0000000000000000 twiMT_Ptr
     /tmp/ccjlgSmg.s:1162   .bss.twiMT_Count:0000000000000000 twiMT_Count
     /tmp/ccjlgSmg.s:529    .text.twiRead:0000000000000000 twiRead
     /tmp/ccjlgSmg.s:563    .text.twiRAW:0000000000000000 twiRAW
     /tmp/ccjlgSmg.s:627    .text.lcdPrepare:0000000000000000 lcdPrepare
     /tmp/ccjlgSmg.s:1079   .data.lcdBackLight:0000000000000000 lcdBackLight
     /tmp/ccjlgSmg.s:1055   .bss.lcdBuffer:0000000000000000 lcdBuffer
     /tmp/ccjlgSmg.s:690    .text.lcdWrite:0000000000000000 lcdWrite
     /tmp/ccjlgSmg.s:1073   .data.lcdAddress:0000000000000000 lcdAddress
     /tmp/ccjlgSmg.s:761    .text.lcdInit:0000000000000000 lcdInit
     /tmp/ccjlgSmg.s:1097   .data.lcdModes:0000000000000000 lcdModes
     /tmp/ccjlgSmg.s:1085   .data.lcdShows:0000000000000000 lcdShows
     /tmp/ccjlgSmg.s:1091   .data.lcdShifts:0000000000000000 lcdShifts
     /tmp/ccjlgSmg.s:854    .text.lcdSetup:0000000000000000 lcdSetup
     /tmp/ccjlgSmg.s:1067   .data.lcdCols:0000000000000000 lcdCols
     /tmp/ccjlgSmg.s:1061   .data.lcdRows:0000000000000000 lcdRows
     /tmp/ccjlgSmg.s:1010   .text.setup:0000000000000000 setup
     /tmp/ccjlgSmg.s:1039   .text.loop:0000000000000000 loop
     /tmp/ccjlgSmg.s:1102   .bss._ZL12twiStatistic:0000000000000000 _ZL12twiStatistic
     /tmp/ccjlgSmg.s:1108   .bss.twiSlaveWriter:0000000000000000 twiSlaveWriter
     /tmp/ccjlgSmg.s:1114   .bss.twiSlaveReader:0000000000000000 twiSlaveReader
     /tmp/ccjlgSmg.s:1132   .bss.twiST_Ptr:0000000000000000 twiST_Ptr
     /tmp/ccjlgSmg.s:1138   .bss.twiST_Count:0000000000000000 twiST_Count

UNDEFINED SYMBOLS
__udivmodsi4
time_delay16
__do_copy_data
__do_clear_bss
