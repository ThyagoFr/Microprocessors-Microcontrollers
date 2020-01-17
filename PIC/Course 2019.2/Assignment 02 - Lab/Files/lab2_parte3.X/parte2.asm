#INCLUDE <P16F628a.INC>

CONTA	 EQU   0x21
TEMPO	 EQU   0x22
	
	; EXISTE UMA EQUAÇÃO PARA DESCOBRIR QUANTAS VEZES VOCE PRECISA FAZER UM LOOP PRA CADA DELAY;
	; Delay_minimo = 256/( (Fosc/4) / PRESCALER )
	; Ao descobrir o Delay_minimo, basta descobrirmos um valor multiplo.
	; No nosso caso,queriamos um delay de 0.5s, com os seguintes parametros :
	; PRESCALER = 1:2
	; Fosc = 1MHz
	; Resolvendo a equaçao,tempos DELAY_MININO = 0.00205
	; Assim tempos, DELAY_QUE_QUEREMOS = X*0.00205
	; X = 244
	; Logo, teremos que criar um loop que execute 244 vezes :v
ORG 	0x000	
    GOTO INICIO

ORG 0x0004
    BCF INTCON,T0IF
    DECFSZ TEMPO,F
    RETFIE
    MOVFW CONTA
    MOVWF TEMPO
    MOVLW B'10000000'
    XORWF PORTB,F
    RETFIE

INICIO:
    BANKSEL TRISB
    MOVLW B'01111111'
    MOVWF TRISB
    MOVLW B'10000000'    ; PRESCALER 1: 2 -- 000 NOS ULTIMOS BITS
    MOVWF OPTION_REG
    BANKSEL PORTB
    MOVLW B'10100000'
    MOVWF INTCON
    MOVLW D'244'   ; O LOOP
    MOVWF CONTA
    MOVWF TEMPO
FIM: 
    GOTO FIM

END

