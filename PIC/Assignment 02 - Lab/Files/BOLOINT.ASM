#INCLUDE <P16F628a.INC>

w_temp        EQU     0x71        ; variable used for context saving 
status_temp   EQU     0x72        ; variable used for context saving



 	ORG 	0x000	
 	goto 	INI

;==========================================================================
;==========================================================================
	ORG     0x004             ; interrupt vector location
	movwf   w_temp            ; save off current W register contents
	movf	STATUS,w          ; move status register into W register
	movwf	status_temp       ; save off contents of STATUS register
;=================================

; isr code can go here or be located as a call subroutine elsewhere

;=================================
	movf    status_temp,w     ; retrieve copy of STATUS register
	movwf	STATUS            ; restore pre-isr STATUS register contents
	swapf   w_temp,f
	swapf   w_temp,w          ; restore pre-isr W register contents
	retfie                    ; return from interrupt
;==========================================================================
;==========================================================================


INI
 banksel TRISB
 clrf    TRISB
 banksel PORTB

MAIN

 goto MAIN

END

