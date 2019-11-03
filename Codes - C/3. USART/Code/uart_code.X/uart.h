#include <xc.h>
#define _XTAL_FREQ 10000000

char UART_Init(const long int baudrate) {
    
	unsigned int x;
	x = (_XTAL_FREQ - baudrate*64)/(baudrate*64);
    
	if(x>255) {
		x = (_XTAL_FREQ - baudrate*16)/(baudrate*16);
		TXSTAbits.BRGH = 1;
	}
    
	if(x<256)	{
        SPBRG = x;
        TXSTAbits.SYNC = 0;
        RCSTAbits.SPEN = 1;
        TRISBbits.TRISB1 = 1;
        TRISBbits.TRISB2 = 0;
        TXSTAbits.TXEN = 1;
        RCSTAbits.CREN = 1;
        return 1;
	}
	return 0;
}

char UART_TX_Empty(){
  return TXSTAbits.TRMT;
}

char UART_Data_Ready(){
   return PIR1bits.RCIF;
}

char UART_Read(){
  while(!PIR1bits.RCIF);
  return RCREG;
}

void UART_Read_Text(char *Output, unsigned int length){
	unsigned int i;
	for(int i=0;i<length;i++)
		Output[i] = UART_Read();
}

void UART_Write(char data){
  while(!TXSTAbits.TRMT);
  TXREG = data;
}

void UART_Write_Text(char *text){
  for(int i = 0; text[i]!='\0' ;i++)
	  UART_Write(text[i]);
}