#INCLUDE <P16F628A.INC>

#DEFINE    LED1 PORTB,6
#DEFINE    LED2 PORTB,7

aux        EQU   0x20
tempd1     EQU   0x21
tempd2     EQU   0x22

ORG     0x00
    GOTO    INI

ORG     0x04
    RETFIE

INI:
    BANKSEL SPBRG
    MOVLW   D'64'
    MOVWF   SPBRG

    BANKSEL TXSTA
    MOVLW   0X24
    MOVWF   TXSTA

    BANKSEL TRISA
    BCF     TRISA,RA0
    BCF     TRISA,RA1

    BANKSEL CMCON
    MOVLW   0x07
    MOVWF   CMCON

    BANKSEL RCSTA
    MOVLW   0X90
    MOVWF   RCSTA

    BANKSEL TRISB
    BCF     TRISB,2
    BSF     TRISB,1
    BCF	    TRISB,6
    BCF	    TRISB,7

MAIN:
    BANKSEL PIR1
    BTFSC   PIR1,RCIF
    CALL    RECEBE
    CALL    d10_10ms
    GOTO    MAIN
    
RECEBE:
    BANKSEL RCREG
    MOVFW   RCREG
    MOVWF   aux
    SUBLW   'A'
    BTFSC   STATUS,Z
    BCF	    LED1
    MOVFW   aux
    SUBLW   'Z'
    BTFSC   STATUS,Z
    BSF	    LED1
    MOVFW   aux
    SUBLW   'S'
    BTFSC   STATUS,Z
    BCF	    LED2
    MOVFW   aux
    SUBLW   'X'
    BTFSC   STATUS,Z
    BSF	    LED2
    RETURN

;10 ms delay routine (10 MHz)
;*******************
d10_10ms:
	MOVLW	.32		
	MOVWF	tempd1		
dly_10y:
	MOVLW	.255		
	MOVWF	tempd2		
dly_10x:
	DECFSZ	tempd2,1	
	GOTO	dly_10x		
	CLRWDT			
	DECFSZ	tempd1,1	
	GOTO	dly_10y		
	RETURN			
;*******************
END
