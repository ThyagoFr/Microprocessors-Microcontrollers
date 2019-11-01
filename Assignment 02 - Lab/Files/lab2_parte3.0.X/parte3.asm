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
  MOVWF   DESLOCAMENTO   ; armazena o número na variável deslocamento 
  MOVLW   TABELA   ; copia em W os 8 bits LSB do endereço da TABELA 
  ADDWF   DESLOCAMENTO, F   ; adiciona o valor à variável DESLOCAMENTO 
  MOVF    DESLOCAMENTO, W   ; copia o valor do DESLOCAMENTO para o W 
  MOVWF   PCL   ; copia o W para o PCL (desvia para a tabela) 
  
TABELA: 
  RETLW    B'00111111'   ; número 0 
  RETLW    B'00000110'   ; número 1 
  RETLW    B'01011011'   ; número 2 
  RETLW    B'01001111'   ; número 3 
  RETLW    B'01100110'   ; número 4 
  RETLW    B'01101101'   ; número 5 
  RETLW    B'01111101'   ; número 6 
  RETLW    B'00000111'   ; número 7 
  RETLW    B'01111111'   ; número 8 
  RETLW    B'01100111'   ; número 9 
  RETLW    B'01110111'   ; dígito A 
  RETLW    B'01111100'   ; dígito B 
  RETLW    B'00111001'   ; dígito C 
  RETLW    B'01011110'   ; dígito D  
  RETLW    B'01111001'   ; dígito E 
  RETLW    B'01110001'   ; dígito F 
END 


