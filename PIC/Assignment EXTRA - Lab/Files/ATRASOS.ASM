#include <p16F628A.inc>   ; processor specific variable definitions

#define LED1   PORTB,0
#define MINHA_MATRICULA_MAIS_100   .135
                                                   
dTemp1        EQU   0x70
dTemp2        EQU   0x71
dTemp3        EQU   0x72


ORG     0x000             ; processor reset vector
goto    INI               ; go to beginning of program
	

ORG     0x004             ; interrupt vector location
retfie                    ; return from interrupt

INI:
 BANKSEL TRISB
 movlw B'00000000'
 movwf TRISB
 BANKSEL PORTB

MAIN:
    bsf   LED1
    movlw MINHA_MATRICULA_MAIS_100
    call  DELAY_03
    bcf   LED1
    movlw .20
    call  DELAY_01
    goto  MAIN		    

;==========================================
; ROTINA DE ATRASO 01
;==========================================
DELAY_01:
    movwf   dTemp1
    
D01_1:      
    decfsz  dTemp1
    goto    D01_1
    nop
    nop
    RETURN
;==========================================
; ROTINA DE ATRASO 02
;==========================================
    
DELAY_02:
    movwf   dTemp1 
    movlw   .50
D02_1:    
    movwf   dTemp2 
D02_2:       
    decfsz  dTemp2
    goto    D02_2
    decfsz  dTemp1
    goto    D02_1
    RETURN

;==========================================
; ROTINA DE ATRASO 03
;==========================================
DELAY_03:
    MOVWF	dTemp3    
    MOVLW	.50
D03_1:     
    MOVWF 	dTemp1
D03_2:      
    MOVWF 	dTemp2
D03_3:      
    DECFSZ 	dTemp2
    GOTO 	D03_3      
    DECFSZ 	dTemp1    
    GOTO 	D03_2      
    DECFSZ 	dTemp3    
    GOTO 	D03_1      
    RETURN      

END
