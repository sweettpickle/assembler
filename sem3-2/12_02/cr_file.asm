	.model tiny
	.data
	.code 
	org 100h ;смещаем адрес кода на 100h байт

Start:
	mov ah, 0ah
	lea dx, buf
	int 21h

;create file
	mov ah, 3ch
	mov cx, 0 ; атрибуты файлы - обычный файл
	mov dx, offset filename
	int 21h

	mov handler, ax

	mov ah, 40h
	mov bx, handler
	mov cx, 0
	mov cl, buf + 1
	mov dx, offset buf + 2
;	mov dx, offset text
	int 21h

;close file
	mov ah, 3eh
	mov bx, handler
	int 21h

	int 20h

buf db 30, 0, 30 dup(?), '$'
filename db "myfile.txt", 0
text db "Hi, friend$"
handler dw 0
buflen equ $-buf

end Start
