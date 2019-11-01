#include <p16F628A.inc>   ; processor specific variable definitions

#define LED1   PORTB,0
                                                   
dTemp1      EQU   0x70
dTemp2      EQU   0x71
dTemp3      EQU   0x72
x           EQU   0x73

ORG	    0x000  
    GOTO    INI 
ORG     0x004   
    RETFIE   

INI:
 BANKSEL TRISB
 MOVLW   B'00000000'
 MOVWF   TRISB
 BSF     TRISA,0
 BANKSEL PORTB

MAIN:
 BTFSC  PORTA,0
 GOTO   MAIN
 MOVLW  .5
 MOVWF  x
 
L1:
 decfsz x
 goto   P1
 goto   MAIN
 
P1:
 bsf   LED1
 movlw .50
 call  DELAY_03

 bcf   LED1
 movlw .50
 call  DELAY_03
 
 goto  L1

;==========================================
; ROTINA DE ATRASO 03
;==========================================
DELAY_03
  			MOVWF 	dTemp3    
  			MOVLW 	.50
D03_1       MOVWF 	dTemp1
D03_2       MOVWF 	dTemp2
D03_3       DECFSZ 	dTemp2
  			GOTO 	D03_3      
  			DECFSZ 	dTemp1    
  			GOTO 	D03_2      
  			DECFSZ 	dTemp3    
  			GOTO 	D03_1      
  			RETURN      

END
