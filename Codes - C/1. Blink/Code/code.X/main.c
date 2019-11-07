/*
 * File:   main.c
 * Author: thyag
 *
 * Created on 2 de Novembro de 2019, 20:18
 */

#define _XTAL_FREQ 4000000
#include <xc.h>

void main(void) {
    CMCON = 0x07;
    TRISA = 0x00;
    while(1){
        PORTAbits.RA0 = 0;
        __delay_ms(5000);
        PORTAbits.RA0 = 1;
        __delay_ms(5000);
    }
    return;
}
