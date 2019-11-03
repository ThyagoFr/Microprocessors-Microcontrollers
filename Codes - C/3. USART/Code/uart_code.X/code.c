/*
 * File:   code.c
 * Author: thyag
 *
 * Created on 3 de Novembro de 2019, 13:36
 */

#include <xc.h>
#include "uart.h"
#define _XTAL_FREQ 10000000

void main(void) {
    UART_Init(9600);
    char frase [25] = "pqp o thyago é muito foda";
    
    for(int i = 0; frase[i] != '\0' ; i++){
        UART_Write(frase[i]);
        __delay_ms(1000);
    };
        
    return;
}
