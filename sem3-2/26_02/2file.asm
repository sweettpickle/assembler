	.model tiny
	.data
	.code 
	org 100h ;смещаем адрес кода на 100h байт

Start:
	jmp start1
	color db 0
	x1 dw 0
	y1 dw 0	
	x2 dw 0
	y2 dw 0

start1:
;устанавливаем видеорежим
	mov ah, 0
	mov al, 4
	int 10h
;горизонтали, построение голубой рамки
	mov al, 1 ;голубой цвет
	mov x1, 15
	mov x2, 65
	mov y1, 15
	call lineh ;верзняя горизонталь
	mov x1, 15
	mov x2, 65
	mov y1, 65
	call lineh ;нижняя горизонталь
;вертикали
	mov x1, 15
	mov y1, 15
	mov y2, 65
	call linev ;левая вертикаль
	mov x1, 65
	mov y1, 15
	mov y2, 65
	call linev ;правая горизонталь
;прямоугольник
	mov al, 2 ;сиреневый цвет
	mov x1, 20
	mov y1, 20
	mov x2, 60
	mov y2, 60
	call bar

	call kbin
	int 20h

;ввод с клавы
kbin proc near
	mov ah, 0
	int 16h
	ret
kbin endp

bar proc near
	mov cx, x1
	cmp cx, x2 ;сравниваем сначала с концом
	jc bar1 ; x1 < x2
	ret ;выход при нулевой ширине прямоуг

bar1:
	mov dx, y1 ;начало линии
	cmp dx, y2 ;сравниваем сначала с концом
	jc bar2 ;y1 < y2
	ret ; выход при нулевой высоте прямоуг
;построение CX DX - левый верхний угор
bar2:
	mov bp, y2
	sub bp, dx
	inc bp

bar3:
	call lineh
	inc word ptr y1
	dec bp
	jnz bar3
	ret
bar endp

;построение вертикальной линии

linev proc near
	mov cx, x1
	mov dx, y1 ;начало линии
	cmp dx, y2 ;сравнение начала с концом
	jnz lvl ;длина не нулевая
	ret ;выход при нулевой длине
	
lvl:
	jc lv2 ;начало меньше конца
	sub dx, y2 ;здесь начало cx больше конца x2
	inc dx
	mov bx, dx ;длина линии
	mov dx, y2 ;высший конец линии
	jmp short lv3
lv2:
	mov bx, y2 ;конце (cx - начало)
	sub bx, y1 ;минус начало
	inc bx ;длина
lv3:
	call pixel
	inc dx
	dec bx
	jnz lv3
	ret
linev endp

;построение горизонтальной линии
lineh proc near
	mov dx, y1
	mov cx, x1 ;начало линии
	cmp cx, x2 ;сравнение начала с концом
	jnz lh1 ;длина не нулевая
	ret ;выход при нулевой длине
lh1:
	jc lh2 ;начало меньше конца
	sub cx, x2 ;здесь начал cx больше конца x2
	inc cx
	mov bx, cx ;длина линии
	mov cx, x2 ;бывший конец линии
	jmp short lh3
lh2:
	mov bx, x2 ;конец cx - начало
	sub bx, x1 ;минус начало 
	inc bx ;длина
lh3:
	call pixel
	inc cx
	dec bx
	jnz lh3
	ret
lineh endp

;построение текущего цвета
;cx колонка
;dx строка
pixel proc near
	push bx
	mov ah, 0ch
	mov bh, 0
	int 10h
	pop bx
	ret
pixel endp	

end Start
