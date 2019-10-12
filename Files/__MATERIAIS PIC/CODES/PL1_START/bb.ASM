#INCLUDE <P16F628A.INC>
  
at_x       EQU   0x70   
at_tmp1    EQU   0x71   
at_tmp2    EQU   0x72   

  ORG 0x00      
  GOTO INICIO    
  ORG 0x04      
  RETFIE      
 
INICIO        

      BANKSEL TRISB    
      MOVLW 0x00  
      MOVWF TRISB    

	  BANKSEL  CCP1CON  
      MOVLW 0x0C
      movwf CCP1CON

	  BANKSEL  PR2 
      MOVLW 0x80
      movwf PR2

	  BANKSEL  CCPR1L 
      MOVLW 0x60
      movwf CCPR1L

	  BANKSEL  T2CON 
      MOVLW 0x04
      movwf T2CON
  
MAIN   
  
       
  GOTO MAIN    


atraso:
  BANKSEL  at_x
  MOVWF at_x    
  MOVLW .50    
at1:  MOVWF at_tmp1    
at2:  MOVWF at_tmp2    
at3:  DECFSZ at_tmp2    
  GOTO at3      
  DECFSZ at_tmp1    
  GOTO at2      
  DECFSZ at_x    
  GOTO at1      
  RETURN      

  END