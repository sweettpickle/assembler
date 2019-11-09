Assume CS:Code;, DS:Code;, ES:Code;, SS:Code
Code Segment
org 100h
Start:
	mov ax, 0B800h ; сегмент дисплея в текст режиме (видеобуфер))
	mov es, ax ;помещаем в наш сегмент кода
	mov al, 1 ;символ рожицы
	mov ah, 31 ;цвет - белый
	mov cx, 2 ;счетчик основного цикла

next_screen: ;основной уикл 
;	mov di, 0 ;анулир, тк будет постоянно меняться во влож процедуре
	call out_chars
	;inc al
	loop next_screen

	mov ah, 10h
	int 16h

	int 20h

out_chars proc
	mov dx, cx ;сохр метку глав цикла
	mov cx, 5 ;5 раз выведится рожица
next_face: ;меняем поцизицию след рожицы
	mov es:[di], ax
	add di, 2
	loop next_face

	mov cx, dx ;возвращаем метку глав цикла
	ret
out_chars endp

Code ends
end Start
