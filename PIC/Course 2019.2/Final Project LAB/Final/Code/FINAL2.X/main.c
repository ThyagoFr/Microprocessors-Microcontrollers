/*
 * File:   main.c
 * Author: thyag
 *
 * Created on 2 de Dezembro de 2019, 08:54
 */

#define _XTAL_FREQ 4000000
#include <xc.h>

void curvaEsquerda(){
    PORTBbits.RB0 = 0;
    PORTBbits.RB1 = 0;
    PORTBbits.RB2 = 1;
    PORTBbits.RB3 = 0;
}

void curvaDireita(){
    PORTBbits.RB2 = 0;
    PORTBbits.RB3 = 0;
    PORTBbits.RB0 = 1;
    PORTBbits.RB1 = 0;
}

void paraTudo(){
    PORTBbits.RB0 = 0;
    PORTBbits.RB1 = 0;
    PORTBbits.RB2 = 0;
    PORTBbits.RB3 = 0;
}

void curva90Direita(){
    PORTBbits.RB0 = 1;
    PORTBbits.RB1 = 0;
    PORTBbits.RB2 = 0;
    PORTBbits.RB3 = 0;
    __delay_ms(1200);
    PORTBbits.RB2 = 1;
    PORTBbits.RB3 = 0;
}

void curva90Esquerda(){
    PORTBbits.RB2 = 1;
    PORTBbits.RB3 = 0;
    PORTBbits.RB0 = 0;
    PORTBbits.RB1 = 0;
    __delay_ms(1200);
    PORTBbits.RB0 = 1;
    PORTBbits.RB1 = 0;
}

void segueFrente(){
    PORTBbits.RB0 = 1;
    PORTBbits.RB1 = 0;
    PORTBbits.RB2 = 1;
    PORTBbits.RB3 = 0;
}

void main(void) {
    CMCON = 0x07;
    TRISA = 0b10111111;
    TRISB = 0b11000000;
    PORTA = 0x00;
    int contador = 3;
    // LED DE AVISO PRA PROGRAMACAO
    PORTBbits.RB4 = 1;
    
    // PARTE 1 - INDO PRO CENTRO
    segueFrente();
    
    while(1){
        PORTBbits.RB0 = 1;
        PORTBbits.RB1 = 0;
        PORTBbits.RB2 = 1;
        PORTBbits.RB3 = 0;
        if (PORTAbits.RA7 == 1){
            curvaEsquerda();
        }
        if (PORTAbits.RA2 == 1){
            curvaDireita();
        }
        if (PORTAbits.RA7 == 0 && PORTAbits.RA2 == 0){
            segueFrente();
        }
        if ( PORTAbits.RA4 == 0 && PORTAbits.RA0 == 1){
            curva90Esquerda();
            contador--;
        }
        if ( PORTAbits.RA4 == 1 && PORTAbits.RA0 == 0){
            curva90Direita();
            contador--;
        }
        PORTBbits.RB0 = 0;
        PORTBbits.RB1 = 0;
        PORTBbits.RB2 = 0;
        PORTBbits.RB3 = 0;

    }
    
    return;
}
