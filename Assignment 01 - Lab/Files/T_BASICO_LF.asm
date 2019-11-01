#include <p16F628A.inc>   ; processor specific variable definitions

                                                                    
X        EQU   0x70


ORG     0x000             ; processor reset vector
 goto    INI              ; go to beginning of program
	

ORG     0x004             ; interrupt vector location
 retfie                   ; return from interrupt

INI:
 bsf   STATUS,RP0 
 bcf   STATUS,RP1 
 movlw B'00000000'
 movwf TRISB
 bcf   STATUS,RP0 

MAIN:
 movlw 0xff
 call  atraso
 clrf  PORTB

 movlw 0x80
 call  atraso
 movlw 0xff										  	 
 movwf PORTB
 goto  MAIN		    


;==========================================
atraso
            movwf   X 
at1         decfsz  X
            goto    at1
            return
;==========================================


END
