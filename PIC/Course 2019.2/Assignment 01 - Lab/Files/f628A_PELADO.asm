#include <p16F628A.inc>   ; processor specific variable definitions

ORG     0x000             ; processor reset vector
 goto    INI              ; go to beginning of program
	

OR G     0x004            ; interrupt vector location
 retfie                   ; return from interrupt

ini:

MAIN:

 goto  MAN		    

END
