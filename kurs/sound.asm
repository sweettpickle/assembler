	.286 ;разрешены непривилегированные команды 80286;
	.386 ;разрешены непривилегированные команды 80386;
	.model flat
	.stack 20h
	.code
	org 100h
 
sound proc 
    pusha
    ;mov di,6000   ;частота звука
    ;mov bx,2000   ;длительность
    mov al,0b6H
    out 43H,al
    mov dx,0014H
    mov ax,4f38H
    div di
    out 42H,al
    mov al,ah
    out 42H,al
    in al,61H
    mov ah,al
    or al,3
    out 61H,al
    l1:     mov cx,2801H
    l2:     loop l2
    dec bx
    jnz l1
    mov al,ah
    out 61H,al
    popa
    ret
sound endp

start:
    mov di,500 ;     загрузка частоты звучания динамика
    mov bx,500;    загрузка длительности звучания в тактах м/п
    call sound

    mov di,1000 ;     загрузка частоты звучания динамика
    mov bx,1000;    загрузка длительности звучания в тактах м/п
    call sound

    mov di,1500 ;     загрузка частоты звучания динамика
    mov bx,500;    загрузка длительности звучания в тактах м/п
    call sound

    mov ah,4cH
    int 21H

end start
