Assume CS:Code;, DS: Code
Code segment
org 100h
Start:
;Установка видеорежима 3
	mov ah, 0
	mov al, 3
	int 10h 

	mov ah, 11h
	mov al, 12h
	mov bl, 0
	int 10h

	mov bh, 8
	mov bl, 0
	mov cx, 1
	mov dx, 41h
	mov ax, cs
	mov es, ax
	mov bp, offset tab1
	mov ah, 11h
	mov al, 10h
	int 10h

	mov ah, 2
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 10h

	mov ah, 0ah
	mov al, 41h
	mov bh, 0
	mov cx, 2000
	int 10h

	mov ah, 6h
	mov al, 0
	mov bh, 8ch
	mov ch, 4
	mov cl, 30
	mov dh, 20
	mov dl, 50
	int 10h

	mov ah, 2
	mov bh, 0
	mov dh, 4
	mov dl, 30
	int 10h

	mov ah, 0ah
	mov al, 42h
	mov bh, 0
	mov cx, 21
	int 10h

loop1:
	mov ah, 10h
	int 16h
	cmp al, ' '
	jnz loop1

int 20h

tab1 db 0c3h, 0c3h, 24h, 18h, 18h, 24h, 0c3h, 0c3h

Code ends
end Start
