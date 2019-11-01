#INCLUDE <P16F628a.INC>

#DEFINE LED1   PORTB,6                             

tempd1	EQU   0x20                           


 	ORG 0	
 	GOTO INI

 	ORG 0x04
 	NOP
 	nop
 	RETFIE

INI
 	NOP
 	NOP

MAIN
 	BCF  LED1
        call dly_4uS
 	BSF  LED1
        call dly_4uS
 	goto MAIN

END


;******************
;4.4uS delay routine (10 MHz)
;******************

dly_4uS
	movlw	.2		;
	movwf	tempd1		;
dlyloop4uS
	nop			;
	decfsz	tempd1,1	;		
	goto	dlyloop4uS	;
	return			;

