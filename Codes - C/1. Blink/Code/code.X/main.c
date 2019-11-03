/*
 * File:   main.c
 * Author: thyag
 *
 * Created on 2 de Novembro de 2019, 20:18
 */

#define _XTAL_FREQ 10000000
#include <xc.h>

void main(void) {
    TRISA0 = 0;
    while(1){
        RA0 = 0;
        __delay_ms(5000);
        RA0 = 1;
        __delay_ms(5000);
    }
    return;
}
