#INCLUDE <P16F877A.INC>

ad_L       EQU   0x71
ad_H       EQU   0x72
tempd1     EQU   0x73 
tempd2     EQU   0x74 

ORG 0x00
    GOTO INI

ORG 0x04
    RETFIE 

INI:	
    BANKSEL TRISA
    MOVLW   0xFF	; Dica: Os pinos ANx de entrada analógica  estão em PORTA
    MOVWF   TRISA	; Dica: Os pinos Anx devem ser configurados como entradas 

    BANKSEL TRISC 
    MOVLW   0x00	; Dica: Os pinos de acionamento dos LEDs do BARGRAPH estão conectados a PORTC 
    MOVWF   TRISC	; Dica: Pinos para acionamento externo devem ser configurados como saídas 
    
    BANKSEL TRISB 
    MOVLW   0x00	; Dica: Os pinos de acionamento dos LEDs do BARGRAPH estão conectados a PORTC 
    MOVWF   TRISB	; Dica: Pinos para acionamento externo devem ser configurados como saídas 

    BANKSEL ADCON1
    MOVLW   0x00	; Configurar conforme pedido no guia
    MOVWF   ADCON1

MAIN:
    CALL    le_ad
    BANKSEL ad_H
    MOVFW   ad_H
    BANKSEL PORTC
    MOVWF   PORTC
    BANKSEL ad_L
    MOVFW   ad_L
    BANKSEL PORTB
    MOVWF   PORTB
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

    BANKSEL ADRESL
    MOVFW   ADRESL
    MOVWF   ad_L

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



