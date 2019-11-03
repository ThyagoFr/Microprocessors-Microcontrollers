/*
 * File:   code.c
 * Author: thyag
 *
 * Created on 3 de Novembro de 2019, 08:13
 */

#define _XTAL_FREQ 10000000
#include <xc.h>

int aux = 0;

void __interrupt() timer0(){
    if (INTCONbits.T0IF){
        aux ++;
        TMR0 = 0x00;                     // Zerando o valor de TIMER0
        INTCONbits.T0IF = 0x00;          // Limpando a flag de interrup�ao
    }
}

void main(void) {
    
    TRISA = 0x00;
    PORTAbits.RA0 = 0x00;
    INTCONbits.GIE = 0x01;            // Habilitar a interup��o global
    INTCONbits.PEIE = 0x01;           // Habilitar a interrup��o por perif�ricos
    INTCONbits.T0IE = 0x01;           // Habilita a interrup��o do timer 0 (estouro do contador)
    TMR0 = 0x00;                      // Valor inicial do contador

    OPTION_REG = 0x82;                // Resistores de Pull-up desabilitados e
                                      // Configura��o do Prescaler 1:8

    // Calculo do tempo de estouro
    // t_estouro = (256 - TMR0)*PreScaler * Ciclo_maquina
    // Ciclo_maquina = 4/(FreqOscilador)

    // Nesse caso, Ciclo_maquina = 4�(10^7) = 4,e-7
    // t_estouro = (256 - 0)*8*4,e-7 = 8,192e-4?
    // Isso � muito rapido,entao faremos um loop
    // Levar� 8,192e-4?s para o timer estoura,entao para podermos ver,
    // Apenas quando a interrup�ao ocorrer 1000x � que mudaremos o estado do pino.
    // Tempo para acender/apagar o LED = 1e3*8,192e-4? = 0.8s 
    
    while(1){
        if (aux == 1000){
            PORTAbits.RA0 = ~PORTAbits.RA0;
            aux = 0;
        }
    }

    return;
}
