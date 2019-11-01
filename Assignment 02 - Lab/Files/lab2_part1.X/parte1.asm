#INCLUDE <P16F628a.INC>

ORG 	0x000	
    GOTO INI

ORG     0x004                 ; interrupt vector location
    RETFIE                    ; return from interrupt

INI:
 BANKSEL TRISB
 MOVLW   0x01
 MOVWF   TRISB
 BANKSEL PORTB

MAIN:
 BTFSC  PORTB,0   ; SE FOR 0,PULA LINHA
 BCF    PORTB,5   ; SE NAO FOR, 1
 BTFSS  PORTB,0   ; SE FOR 1,PULA LINHA
 BSF    PORTB,5
 GOTO MAIN

END



