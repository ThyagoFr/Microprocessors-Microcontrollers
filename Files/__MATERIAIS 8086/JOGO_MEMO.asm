ORG 100H 


JMP INI

MEMO DB 20 DUP(0)
MSG_ERRO DB "!!       ERROU       !!$"
MSG_END DB "!!    MEMORIA BOA    !!$"


INI: 

   MOV BL,1
   LEA DI,MEMO
L0:
   CALL ALEO
   MOV  [DI],DL
   CALL SHOWDL
   CALL CR
   MOV  CL,BL
   MOV  CH,0
   LEA SI,MEMO
L1: 
   CALL INUM 
   MOV BH,[SI]
   INC SI
   LOOP L1
   CALL APAGA
   INC  BL
   INC  DI
   JMP L0


ERRO:
   CALL CR
   mov dx, offset MSG_ERRO
   mov ah, 9
   int 21h
  .EXIT
  

GAME_OVER:

   CALL CR
   mov dx, offset MSG_END
   mov ah, 9
   int 21h
  .EXIT

INUM:
  MOV AH,1
  INT 21H
RET  
  


CR:
  PUSH AX
  PUSH DX  
  MOV AH,2
  MOV DL,0X0D
  INT 21H
  POP DX
  POP AX  
RET


APAGA:
  PUSH AX
  PUSH DX  
  PUSH CX
  
  MOV CL,BL
  MOV CH,0

  MOV AH,2
  MOV DL,0X0D
  INT 21H

A1:     
        MOV DL,"*"
        INT 21H
        LOOP A1: 

  POP CX
  POP DX
  POP AX  
RET




SHOWDL:

  PUSH AX
  MOV  AH,2
  INT  21H
  POP  AX
  RET

ALEO:
   PUSH AX
   PUSH CX

   MOV AH,00H
   INT 1AH
   MOV AL,DL
   MOV CL,26
   DIV CL
   MOV DL,AL
   ADD DL,48
   
   POP CX
   POP AX

RET




