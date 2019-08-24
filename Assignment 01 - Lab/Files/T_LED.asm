#include <p16F628A.inc>   ; processor specific variable definitions

#define LED1   PORTB,5                             
                                                                       
X        EQU   0x70
Y        EQU   0x71


ORG     0x000             ; processor reset vector
 goto    INI              ; go to beginning of program
	

ORG     0x004             ; interrupt vector location
 retfie                   ; return from interrupt

INI:
 ;bsf   STATUS,RP0 
 ;bcf   STATUS,RP1 
 BANKSEL TRISB
 
 movlw B'00000000'
 movwf TRISB

 ;bcf   STATUS,RP0 
 BANKSEL portb

MAIN:
 movlw 0xff
 call  atraso
 bcf   LED1

 movlw 0x80
 call  atraso
 bsf   LED1
 goto  MAIN1		    


;==========================================
atraso
            movwf   X 

            movlw   100 
            movwf   Y 
at2         decfsz  Y
            goto    at2

at1         decfsz  X
            goto    at1
            return
;==========================================



