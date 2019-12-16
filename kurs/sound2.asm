Assume CS:Code;, DS:Code
Code Segment
org 100h
Start:
	
input:
	mov ah, 0
	int 16h
	cmp al, 1Bh
	je @out
	cmp al, "a"
	jne input
	mov dl, al
	mov ah, 2
	int 21h
	call beep
	jmp input

beep proc near
	mov al, 10110110b ;канал 2, режим 3
	out 43h ,al
	
	mov al, 45h ;младший бит делитея частоты 11D0h
	out 42h ,al
	mov al, 9h ;старший байт делителя частоты
	out 42h ,al
	
	in al, 61h ;текущее состояние порта 61h в al
	or al, 3h ;установить биты 0 и 1 в 1
	out 61h ,al ; теперь динамик включен
	
	mov cx, 1 ;старшее слово числа микросекунд паузы
	;mov dx, 10 ;младшее слово числа микросекунд паузы
	mov ah, 86h ;функция 86ш
	int 15h ;пауза

	in al, 61h ;обнулить млашдие два биты
	and al, 11111100b ;теперь динамик отключенi
	out 61h, al
	ret
beep endp

@out:
	int 20h


Code ends
end Start
