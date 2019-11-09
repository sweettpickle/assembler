;CSEG segment
;org 100h ;размещение команд в памяти начинается с 100аш, пропустив 100 байтов
_start:
;	mov si, 0x100
	mov eax, 9
	mov dx,offset Message
	int 21h
	int 0x80

	int 20h
Message db "Hello, world!", 0
;CSEG ends
;end Begin
