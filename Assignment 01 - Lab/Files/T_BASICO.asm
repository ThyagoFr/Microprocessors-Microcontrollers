#include <p16F628A.inc>   ; processor specific variable definitions

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
 movlw 0x00										  	  
 movwf PORTB
 movlw 0xFF										  	 
 movwf PORTB
 goto  MAIN		    

END
