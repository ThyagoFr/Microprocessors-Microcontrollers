#INCLUDE <P16F877A.INC>

ad_L       EQU   0x71
ad_H       EQU   0x72
tempd1     EQU   0x73 
tempd2     EQU   0x74
aux	   EQU	 0x75

ORG 0x00
    GOTO INI

ORG 0x04
    BCF	    INTCON,TMR0IF
    DECFSZ  aux
    RETFIE
    MOVLW   D'19'
    MOVWF   aux
    CALL    le_ad
    BANKSEL ad_H
    MOVFW   ad_H
    BANKSEL TXREG
    MOVWF   TXREG
    CALL    d10_1ms
    MOVLW   0x0A
    BANKSEL TXREG
    MOVWF   TXREG
    CALL    d10_1ms
    MOVLW   D'13'
    BANKSEL TXREG
    MOVWF   TXREG
    RETFIE 

INI:	
    BANKSEL TRISA
    MOVLW   0xFF	; Dica: Os pinos ANx de entrada analógica  estão em PORTA
    MOVWF   TRISA	; Dica: Os pinos Anx devem ser configurados como entradas 
    
    BANKSEL TRISC 
    BCF	    TRISC,6 

    BANKSEL ADCON1
    MOVLW   0x00	; Configurar conforme pedido no guia
    MOVWF   ADCON1
    
    ; INICIO - Configuraçao da UART ---------------------------------
    BANKSEL SPBRG
    MOVLW   D'64'
    MOVWF   SPBRG
    
    BANKSEL TXSTA
    BSF	    TXSTA,TXEN
    BSF	    TXSTA,BRGH
    
    BANKSEL RCSTA
    BSF	    RCSTA,SPEN
    BSF	    RCSTA,CREN
    
    ; FIM - Configuraçao da UART ------------------------------------
    
    ; INICIO - Configuraçao do TIMER0 -------------------------------
    BANKSEL OPTION_REG
    MOVLW   B'10000110'
    MOVWF   OPTION_REG 
    
    BANKSEL INTCON 
    MOVLW   B'10100000'
    MOVWF   INTCON
    
    BANKSEL aux
    MOVLW   D'19'
    MOVWF   aux

    ; FIM - Configuraçao do TIMER0 ----------------------------------

MAIN:
    GOTO    MAIN

le_ad:
    BANKSEL ADCON0
    MOVLW   0x81
    MOVWF   ADCON0
		
    BANKSEL tempd1
    CALL    d10_1ms

    BANKSEL ADCON0
    BSF	    ADCON0, 2

    BANKSEL tempd1
    CALL    d10_1ms

    BANKSEL ADRESH
    MOVFW   ADRESH
    MOVWF   ad_H

    RETURN

;******************
;1 ms delay routine (10 MHz)
;******************
d10_1ms:
    movlw   .4			
    movwf   tempd1		
dly_1my:
    movlw   .204	
    movwf   tempd2	
dly_1mx:
    decfsz  tempd2,1	
    goto    dly_1mx
    clrwdt  	   
    decfsz  tempd1,1		
    goto    dly_1my
    return	
END






