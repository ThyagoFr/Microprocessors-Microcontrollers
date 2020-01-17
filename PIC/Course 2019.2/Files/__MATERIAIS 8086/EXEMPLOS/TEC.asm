org 100h

ini:

mov ah,6
mov dl,255
int 21h

jz  ini:


mov dl,al
mov ah,2
int 21h

cmp al,'a'
jz  sai


jmp ini


sai:
.EXIT
  