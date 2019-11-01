org 100h

.DATA
texto1 db 'teste:$'
texto2 db 'texto:$'
.CODE

mov ah,9
mov dx,offset texto1
int 21h
       
mov ah,1
int 21h
  
mov ah,2
mov dl,0Ah
int 21h
mov dl,0Dh
int 21h


mov ah,9
mov dx,offset texto2
int 21h

mov ah,2
mov dl,0Ah
int 21h
mov dl,0Dh
int 21h

mov ah,1
int 21h



.EXIT
