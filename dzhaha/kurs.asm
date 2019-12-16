	.model tiny ;определяем модель памяти, программа формата .com
	.code ;задаем начало сегмента кода
	org 100h ;смещаем адрес кода на 100h байт

Start: 

input: 
	mov ah, 0 
	int 16h 
	cmp al, 13 
	je @enter 
	cmp al, 1Bh 
	je @out

	cmp ah, 053h
	je @is_del	

	mov dl, al
	mov ah, 2 
	int 21h
	
@not_del:
	jmp input 

@is_del: 
	mov ah, 00h
	mov al, 03h
	int 10h
	jmp input

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
