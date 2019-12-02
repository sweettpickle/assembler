	.286 ; for pusha and popa
	.model tiny
	.code
	org 100h

Start:
	mov cx, 3
	jmp input	

input:
	mov ah, 01h
	int 21h ;после вызова прирывания ждет нажатия и заносит в ah
	cmp al, 1Bh
	je @out	;если это esc, то выход из проги
	cmp al,'A' ;если меньше А
	jb @not_eng ;то это не латиница
	cmp al, 'Z'; если меньше или равно Z
	jbe @is_eng ;то это латиница
	cmp al, 'a'
	jb @not_eng
	cmp al, 'z'
	jbe @is_eng

@not_eng:
	jmp input

@is_eng:
	dec cx
	cmp cx, 0
	je @is_three ;переход если равно
	jne input ;переход если не равно

@is_three:
	mov cx, 3
	call beep
	jmp input

;порт 43h - управляющий регистр первого таймера
;порт 42 канал 2 - управляет динамиком

;канал 2 системного таймера управляет динамиком компьютера 
;- он генерирует прямоугольные импульсы с частотой, равной
;1 193 180/начальное_значение_счетчика.
; 0 бит - разрешить работу данного канала таймера
; 1 бит - включает динамик

beep proc 
	pusha
;0b6h -одно и то же 
	mov al, 10110110b ;канал 2, режим 3
	out 43h, al ;вывод значения в порт ввода-вывода (из al в 43h)
	
	mov al, 0 ;младший байт делитея частоты 11D0h
	out 42h, al
	mov al, 1h ;старший байт делителя частоты
	out 42h, al
	
	in al, 61h ;текущее состояние порта 61h в al
	or al, 00000011b ;установить биты 0 и 1 в 1
	out 61h, al ; теперь динамик включен
	
	mov cx, 1 ;старшее слово числа микросекунд паузы
;	mov dx, 10 ;младшее слово числа микросекунд паузы
	mov ah, 86h ;функция 86h
	int 15h ;пауза

	in al, 61h 
	and al, 11111100b ;обнулить млашдие два биты
	out 61h, al ;теперь динамик отключен
	popa
	ret
beep endp

@out:
	int 20h

end Start
