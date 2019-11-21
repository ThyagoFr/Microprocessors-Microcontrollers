#include <xc.h>
#define _XTAL_FREQ 4000000

void UART_Init(const unsigned int baudrate){
    unsigned int SPBRG_VALUE;
    SPBRG_VALUE = (_XTAL_FREQ - 16*baudrate)/(16*baudrate);
    SPBRG = SPBRG_VALUE;
    
    TXSTAbits.BRGH = 1;
    TXSTAbits.SYNC = 0;
    RCSTAbits.SPEN = 1;
    TRISBbits.TRISB1 = 1;
    TRISBbits.TRISB2 = 0;
    TXSTAbits.TXEN = 1;
    RCSTAbits.CREN = 1;
}

void UART_Write(char data){
  while(!TXSTAbits.TRMT);
  TXREG = data;
}