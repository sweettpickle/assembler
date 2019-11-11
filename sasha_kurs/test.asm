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
	
	cmp al, 0E8h
	je is_not_beg
	jne not_sh

is_not_beg:
	cmp cx, 0
	jl is_sh
	jmp input

print:
	mov ah, 09h
	mov dx, offset mes
	int 21h
	
not_sh:
	push ax
	jmp input

is_sh:
	pop ax
	pop ax
	pop ax
	cmp al, 0A7h
	je @call
	jne input

@call:
	call beep
	jmp input

beep proc 
	pusha

	mov al, 0b6h
	out 43h, al 
	
	mov al, 0
	out 42h, al
	mov al, 3h
	out 42h, al
	
	in al, 61h
	or al, 00000011b
	out 61h, al
	
	mov cx, 1
	mov ah, 86h
	int 15h
	
	in al, 16h
	and al, 11111100b
	out 61h, al
	popa
	ret
beep endp

is_enter:
	mov dl, 0Dh
	mov ah, 2
	int 21h
	mov dl, 0Ah
	int 21h
	jmp check

@out:
	mov ah, 2
	mov dl, 0Dh
	int 21h
	int 20h

mes db "ha$"

;Code ends
end Start
