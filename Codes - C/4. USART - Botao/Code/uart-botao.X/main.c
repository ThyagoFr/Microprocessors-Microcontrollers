/*
 * File:   main.c
 * Author: thyag
 *
 * Created on 10 de Novembro de 2019, 14:09
 */


#include <xc.h>
#include "uart.h"
#define _XTAL_FREQ 4000000

void main(void) {
    
    char texto [] = "meu deus nao faco ideia";
    unsigned int i = 0;
    // Desligando comparadores
    CMCON = 0x07;
    // Configurando RA0 como ENTRADA DIGITAL
    TRISA = 0x01;
    
    // Configurando UART
    UART_Init(9600);
    
    while(i<25){
        if(PORTAbits.RA0){
            UART_Write(texto[i]);
            i++;
            __delay_ms(1000);
        };
    };
    
    return;
}
