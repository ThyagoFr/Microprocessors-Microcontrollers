; Universidade Federal do Cear�
; Departamento de Engenharia El�trica
; Disciplina : Microprocessadores
; Aluno : Thyago Freitas da Silva
; Parte I do Projeto de Laborat�rio
    
#INCLUDE <P16F628A.INC>

#DEFINE  MOTOR_ESQ   PORTB,0
#DEFINE  MOTOR_DIR   PORTB,1
    
#DEFINE	 SENSOR      PORTA,2
    
#DEFINE	 CHAVE_MSB   PORTA,0
#DEFINE	 CHAVE_LSB   PORTA,1
    

#DEFINE  CONTROLE2   PORTB,2
#DEFINE	 CONTROLE1   PORTB,3
    
#DEFINE	 LED	     PORTB,4
    
CONT1   EQU 0X21
CONT2   EQU 0X22
CONT3   EQU 0X23

ORG     0x00
    GOTO    INI

ORG     0x04
    RETFIE
    
INI:
  ; DESLIGANDO MODULO COMPARADOR 
    BANKSEL CMCON
    MOVLW   0x07
    MOVWF   CMCON
    
  ; CONFIGURANDO PORTA COMO INPUT ATRAVES DO REGISTRADOR TRISA
    BANKSEL TRISA
    MOVLW   B'00000111'
    MOVWF   TRISA
    
  ; CONFIGURANDO PORTB COMO OUTPUT ATRAVES DO REGISTRADOR TRISB
    BANKSEL TRISB
    MOVLW   0x00
    MOVWF   TRISB
    
  ; CONFIGURA�AO INICIAL DOS MOTORES = ATIVO
 
    ; LIMPANDO REGISTRADORES
    BANKSEL PORTA
    CLRF    PORTA
    BANKSEL PORTB
    CLRF    PORTB
    
    BCF	    PORTB,4
    
    BSF	    PORTB,5
    
GIROINICIAL: 
    
    ; GIRO REVERSO - 180
    BANKSEL PORTB
    BSF	    MOTOR_ESQ
    BCF	    CONTROLE1
    
    BCF	    MOTOR_DIR
    BSF	    CONTROLE2
    
    ; VOLTANDO AO NORMAL
    CALL    DELAY
    BCF	    MOTOR_ESQ
    BSF	    CONTROLE1
    BCF	    MOTOR_DIR
    BSF	    CONTROLE2
    GOTO    MAIN_1
    
MAIN_1:
    BTFSS   SENSOR          ; SE FOR 1, QUER DIZER QUE UMA LINHA FOI DETECTADA.
    NOP
    BTFSC   SENSOR	     ; SE FOR 1, QUER DIZER QUE UMA OUTRA LINHA FOI DETECTADA.
    CALL    ANALISE_CURVA_1
    GOTO    MAIN_1 

ANALISE_CURVA_1:
    BTFSC   CHAVE_MSB       ; SE CHAVE MSB = 1, CURVA PRA DIREITA
    CALL    CURVA_DIREITA
    BTFSS   CHAVE_MSB
    CALL    CURVA_ESQUERDA  ; SE CHAVE MSB = 0, CURVA PRA ESQUERDA
    GOTO    MAIN_2
    
MAIN_2:
    BTFSS   SENSOR          ; SE FOR 1, QUER DIZER QUE UMA LINHA FOI DETECTADA.
    NOP
    BTFSC   SENSOR	     ; SE FOR 1, QUER DIZER QUE UMA OUTRA LINHA FOI DETECTADA.
    CALL    ANALISE_CURVA_2
    GOTO    MAIN_2
    
ANALISE_CURVA_2:
    BTFSC   CHAVE_LSB       ; SE CHAVE MSB = 1, CURVA PRA DIREITA
    CALL    CURVA_DIREITA
    BTFSS   CHAVE_LSB
    CALL    CURVA_ESQUERDA  ; SE CHAVE MSB = 0, CURVA PRA ESQUERDA
    GOTO    ESPERAR_FIM
    
ESPERAR_FIM:
    BTFSS   SENSOR           ; SE FOR 1, QUER DIZER QUE UMA LINHA FOI DETECTADA.
    NOP
    BTFSC   SENSOR 	     ; SE FOR 1, QUER DIZER QUE UMA OUTRA LINHA FOI DETECTADA.
    CALL    ACENDER_LED
    GOTO    ESPERAR_FIM

ACENDER_LED:
    BANKSEL PORTA
    BSF	    LED
    BANKSEL PORTB
    BSF	    MOTOR_DIR
    BSF	    MOTOR_ESQ
    GOTO    LOOP_INFINITO
    
LOOP_INFINITO:
    GOTO    LOOP_INFINITO
    
CURVA_DIREITA:
    BSF	    MOTOR_DIR
    CALL    DELAY
    BCF	    MOTOR_DIR
    RETURN
    
CURVA_ESQUERDA:
    BSF	    MOTOR_ESQ
    CALL    DELAY
    BCF	    MOTOR_ESQ
    RETURN

DELAY:
    MOVLW 0X6D
    MOVWF CONT1
    MOVLW 0X5E
    MOVWF CONT2
    MOVLW 0X1A
    MOVWF CONT3
    LOOP
    DECFSZ CONT1, 1
    GOTO LOOP
    DECFSZ CONT2, 1
    GOTO LOOP
    DECFSZ CONT3, 1
    GOTO LOOP
    RETURN

END