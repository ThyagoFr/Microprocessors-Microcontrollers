#INCLUDE <P16F628A.INC>

tempd1     EQU   0x71
tempd2     EQU   0x72

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

MAIN:
    BTFSC   PORTA,0
    CALL    MANDAR_X
    BTFSS   PORTA,0
    CALL    MANDAR_A
    CALL    d10_10ms
    GOTO    MAIN

MANDAR_X:
    BANKSEL TXREG
    MOVLW   A'X'
    MOVWF   TXREG
    RETURN

MANDAR_A:
    BANKSEL TXREG
    MOVLW   A'A'
    MOVWF   TXREG
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
