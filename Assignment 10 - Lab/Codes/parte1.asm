ORG 100H
W EQU 10
H EQU 7
MOV AH, 0
MOV AL, 13H
INT 10H
MOV CX, 100+W
MOV DX, 20
MOV AL, 15
U1:
    MOV AH, 0CH
    INT 10H
    DEC CX
    CMP CX, 100
    JAE U1
    MOV DX, 20+H
U2:
    MOV AH, 0CH
    INT 10H
    DEC DX
    CMP DX, 20
    JAE U2
    MOV CX, 100+W
    MOV DX, 20+H
U3:
    MOV AH, 0CH
    INT 10H
    DEC CX
    CMP CX, 100
    JAE U3
    MOV CX, 100+W    
U4:
    MOV AH, 0CH
    INT 10H
    DEC DX
    CMP DX, 20
    JAE U4
MOV AH,00
INT 16H
MOV AH,00
MOV AL,03
INT 10H
RET    