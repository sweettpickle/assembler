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

;print proc
;	mov ah, 09h
;	mov dx, offset mes
;	int 21h
;	ret
;print endp

;mes db "ha$"
mas dw 4 dup (0)

;Code ends
end Start
