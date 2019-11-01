#INCLUDE <P16F628A.INC>

at_x        EQU   0x70
at_tmp1     EQU   0x71
at_tmp2     EQU   0x72

	ORG 0
    GOTO INI

	ORG 4
	RETFIE


INI:
    BANKSEL OPTION_REG
	movlw   0x80
	movwf	OPTION_REG

    BANKSEL TRISA
    movlw 0x00
    movwf TRISA
    movlw 0xFF
    movwf TRISB


    BANKSEL SPBRG
    movlw .64
    movwf SPBRG
    BANKSEL TXSTA
    bsf  TXSTA,TXEN     
    bsf  TXSTA,BRGH     
    BANKSEL RCSTA
    bsf  RCSTA,SPEN     
    bsf  RCSTA,CREN     

    BANKSEL INTCON
    movlw 0x00
    movwf INTCON

MAIN:

 	MOVlW .110								  ; W = tempo de atraso
 	CALL  atraso							  ; chama a funcao atraso 

    BANKSEL TXREG
 	MOVLW 0x41
 	MOVWF TXREG

	GOTO MAIN

;==========================================
;==========================================
atraso
        movwf   at_x 
 	    movlw   .8

at1:    movwf   at_tmp1
at2:    movwf   at_tmp2
at3:    decfsz  at_tmp2
        goto    at3
        decfsz  at_tmp1
        goto    at2
        decfsz  at_x
        goto    at1
        return
;==========================================
;==========================================


END
