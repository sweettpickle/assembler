	.286 ;для использования инструкций pusha и popa
	.model tiny ;определяем модель памяти, программа формата .com
	.code ;задаем начало сегмента кода
	org 100h ;смещаем адрес кода на 100h байт

Start: 
	mov cx, 3

input: 
	mov ah, 0 
	int 16h 
	cmp al, 13 
	je @enter 
	cmp dl, 1Bh 
	je @out	
	mov dl, al
	mov ah, 2 
	int 21h

@check: 
	cmp dl, 80h 
	jb @not_eng 
	cmp dl, 0AFh 
	jbe @is_eng 
	cmp dl, 0E0h 
	jb @not_eng 
	cmp dl, 0F1h 
	jbe @is_eng 

@not_eng:
	jmp input 

@is_eng:
	dec cx 
	cmp cx, 0 
	je @is_three
	jne input

@is_three:
	mov cx, 3 
	call beep 
	jmp input 

beep proc 
	pusha 

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
	popa 
	ret 
beep endp 

@enter:
	mov dl, 0Dh 
	mov ah, 2 
	int 21h 
	mov dl, 0Ah 
	int 21h 
	jmp input

@out:
	mov ah, 2
	mov dl, 0Dh 
	int 21h 
	int 20h 

end Start 
