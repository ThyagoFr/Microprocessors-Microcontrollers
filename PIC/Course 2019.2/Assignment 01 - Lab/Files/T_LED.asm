#include <p16F628A.inc>   ; processor specific variable definitions

#define LED1   PORTB,0                            
                                                                       
tempd1        EQU   0x70
tempd2        EQU   0x71


ORG     0x000             ; processor reset vector
 goto    INI              ; go to beginning of program
	

ORG     0x004             ; interrupt vector location
 retfie                   ; return from interrupt

INI:
 bsf   STATUS,RP0 
 bcf   STATUS,RP1 
 BANKSEL TRISB
 
 movlw B'00000000'
 movwf TRISB

 bcf   STATUS,RP0 
 BANKSEL PORTB

MAIN:
 call  atraso
 bcf   LED1
 call  atraso
 bsf   LED1
 goto  MAIN		    


atraso:
    movlw 10
    movwf tempd1
dly_1:
    movlw 100
    movwf tempd2
dly_2:
    decfsz tempd2,1
    goto dly_2
    clrwdt
    decfsz tempd1,1
    goto dly_1
    return

END