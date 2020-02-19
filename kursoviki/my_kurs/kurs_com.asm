	.286 ;для использования инструкций pusha и popa
	.model tiny ;определяем модель памяти, программа формата .com
	.code ;задаем начало сегмента кода
	org 100h ;смещаем адрес кода на 100h байт

Start: 
	mov cx, 3 ;счетчик

input: ;разбиваем условно программу на блоки, это блок ввода
	mov ah, 0 ;функция 0 прерывания 16
	int 16h ;ожидает нажатие клавиши и заносит расшир код ASCII в al
	cmp al, 13 ;сравниваем с кодом клавиши ENTER
	je @enter ;если равно, то переходим в блок @enter
	cmp dl, 1Bh ;если нажали escape
	je @out	;то переходим в блок @out
	mov dl, al ;помещаем в регистр dl содержимое регистра al 
	mov ah, 2 ;вызываем 2 функцию 21 прерывания
	int 21h ;которая выводит символ из dl на экран

	;символ нажатой клавиши хранится теперь в dl 

@check: ;блок, который проверяет, ввели ли кириллицу
	cmp dl, 80h ;сравниванием с буквой "А"
	jb @not_eng ;если меньше, то переходим в @not_eng
	cmp dl, 0AFh ;сравниванием с буквой "П"
	jbe @is_eng ;если меньше или равно, то переходим
	cmp dl, 0E0h ;сравниваем с "р"
	jb @not_eng ;если меньше, то переходим
	cmp dl, 0F1h ;сравниваем с "ё"
	jbe @is_eng ;если меньше или равно, то переходим

@not_eng:
	jmp input ;переходим в input

@is_eng:
	dec cx ;уменьшаем на 1 содеримое регистра cx
	cmp cx, 0 ;если cx равен 0
	je @is_three ;то переходим в блок @is_three
	jne input ;иначе переходим обратно в input

@is_three:
	mov cx, 3 ;помещаем в cx значение 3
	call beep ;вызываем процедуру beep 
	jmp input ;переходим в input

beep proc ;начало процесса
	pusha ;сохраняем содержимое регистров 

	in al, 61h ;получить состояние порта в al
	or al, 00000011b ;установить биты 0 и 1 в 1
	out 61h, al ;включить динамик

	mov al, 2h ;высота звука
	out 42h, al ;включаем таймер
	
	mov cx, 1 ;продолжительность звука
	mov ah, 86h ;функция 86h
	int 15h ;пауза
	
	in al, 61h ;получаем состояние динамика
	and al, 11111100b ;обнуляем младшие биты
	out 61h, al ;теперь динамик выключен 
	popa ;восстанавливаем значения регистров
	ret ; аналогично return 
beep endp ;конец процесса

@enter:
	mov dl, 0Dh ;перевод каретки
	mov ah, 2 ;функция вывода на экран
	int 21h ;вызов прерывания
	mov dl, 0Ah ;перевод строки 
	int 21h ;вызов прерывания
	jmp input

@out:
	mov ah, 2 ;функция вывода на экран
	mov dl, 0Dh ;перевод каретки
	int 21h ;вызов прерывания
	int 20h ;выход из программы

end Start ;конец программы