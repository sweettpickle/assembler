	.286 ; for pusha and popa
	.model tiny
	.code
	org 100h

Start:
	mov cx, 4

input:
	mov ah, 0
	int 16h

	cmp al, 13
	je is_enter

	mov dl, al
	mov ah, 2
	int 21h

	dec cx

check:
	cmp al, 1Bh
	je @out	;если это esc, то выход из проги

	cmp cx, 0
	jge not_sh
	
	cmp al, 0E8h
	jne not_sh
	je is_sh
	
not_sh:
	push ax
	jmp input

@push:
	push mas[si]
	dec si
	push mas[si]
	dec si
	push mas[si]
	dec si
	push mas[si]
	mov al, 0E8h
	push ax
	jmp input

is_sh:
	mov si, 0

	pop ax
	mov mas[si], ax
	inc si
	pop ax
	mov mas[si], ax
	inc si
	pop ax
	mov mas[si], ax
	inc si
	pop ax
	mov mas[si], ax
	
	cmp al, 0A7h
	jne @push
	call beep
	jmp @push
	
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

@out:
	mov ah, 2
	mov dl, 0Dh
	int 21h
	int 20h

is_enter:
	mov dl, 0Dh
	mov ah, 2
	int 21h
	mov dl, 0Ah
	int 21h
	jmp check

print proc
	mov ah, 09h
	mov dx, offset mes
	int 21h
	ret
print endp

mes db "ha$"
mas dw 4 dup (0)

;Code ends
end Start
