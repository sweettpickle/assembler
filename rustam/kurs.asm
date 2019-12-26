;	.286
	.model tiny ;определяем модель памяти, программа формата .com
	.code ;задаем начало сегмента кода
	org 100h ;смещаем адрес кода на 100h байт

Start: 
	mov ah, 10h 
	int 16h 
	cmp al, 13 
	je is_enter 
	cmp al, 1Bh 
	je is_out

	cmp ah, 86h
	je is_f12	

	mov dl, al
	mov ah, 2 
	int 21h
	
	jmp Start

is_f12: 
	call beep
	jmp Start

beep proc 
;	pusha 

	in al, 61h 
	or al, 00000011b
	out 61h, al 

	mov al, 2h
	out 42h, al
	
	mov cx, 1 
	mov ah, 86h 
	int 15h 
	
	in al, 61h 
	and al, 11111100b 
	out 61h, al 
;	popa 
	ret 
beep endp 

is_enter:
	mov dl, 0Dh 
	mov ah, 2 
	int 21h 
	mov dl, 0Ah 
	int 21h 
	jmp Start

is_out:
	mov ah, 2
	mov dl, 0Dh 
	int 21h 
	int 20h 

end Start 
