/*
 * File:   code.c
 * Author: thyag
 *
 * Created on 3 de Novembro de 2019, 13:36
 */

#include <xc.h>
#include "uart.h"
#define _XTAL_FREQ 4000000

void main(void) {
    UART_Init(9600);
    char frase [25] = "eu sou o bixao mermo ein";
    
    for(int i = 0; frase[i] != '\0' ; i++){
        UART_Write(frase[i]);
        __delay_ms(500);
    };
    UART_Write('\n');
    UART_Write('\r');
        
    return;
}
