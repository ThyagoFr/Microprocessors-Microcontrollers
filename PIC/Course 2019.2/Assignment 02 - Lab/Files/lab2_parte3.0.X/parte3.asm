#INCLUDE <P16F628a.INC>
 
TEMPO   	EQU   0x20 
DESLOCAMENTO    EQU   0x21 
DIGITO   	EQU   0x22 
 
ORG 0x00 
  GOTO     INICIO 
  
ORG 0x04 
  BCF      INTCON, T0IF 
  DECFSZ   TEMPO, F 
  RETFIE 
  MOVLW    .15 
  MOVWF	   TEMPO 
  MOVF     DIGITO, W 
  CALL     DECOD_DISPLAY  
  MOVWF    PORTB 
  BCF      PORTB, 7 
  INCF     DIGITO 
  MOVLW   .16 
  SUBWF    DIGITO, W 
  BTFSC    STATUS, Z 
  CALL    ZERA 
  RETFIE 
  
ZERA: 
  MOVLW   .0 
  MOVWF   DIGITO 
  RETURN 

INICIO: 
  BANKSEL TRISB 
  CLRF    TRISB 
  MOVLW   B'10000111' 
  MOVWF   OPTION_REG 
  BANKSEL PORTB 
  MOVLW   B'10100000' 
  MOVWF   INTCON 
  MOVLW   D'15' 
  MOVWF   TEMPO 
  MOVLW   D'0' 
  MOVWF   DIGITO 
FIM:  
  GOTO    FIM 
  
DECOD_DISPLAY: 
  MOVWF   DESLOCAMENTO   ; armazena o n�mero na vari�vel deslocamento 
  MOVLW   TABELA   ; copia em W os 8 bits LSB do endere�o da TABELA 
  ADDWF   DESLOCAMENTO, F   ; adiciona o valor � vari�vel DESLOCAMENTO 
  MOVF    DESLOCAMENTO, W   ; copia o valor do DESLOCAMENTO para o W 
  MOVWF   PCL   ; copia o W para o PCL (desvia para a tabela) 
  
TABELA: 
  RETLW    B'00111111'   ; n�mero 0 
  RETLW    B'00000110'   ; n�mero 1 
  RETLW    B'01011011'   ; n�mero 2 
  RETLW    B'01001111'   ; n�mero 3 
  RETLW    B'01100110'   ; n�mero 4 
  RETLW    B'01101101'   ; n�mero 5 
  RETLW    B'01111101'   ; n�mero 6 
  RETLW    B'00000111'   ; n�mero 7 
  RETLW    B'01111111'   ; n�mero 8 
  RETLW    B'01100111'   ; n�mero 9 
  RETLW    B'01110111'   ; d�gito A 
  RETLW    B'01111100'   ; d�gito B 
  RETLW    B'00111001'   ; d�gito C 
  RETLW    B'01011110'   ; d�gito D  
  RETLW    B'01111001'   ; d�gito E 
  RETLW    B'01110001'   ; d�gito F 
END 


