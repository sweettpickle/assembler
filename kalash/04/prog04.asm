CSEG segment
org 100h
Start:
	;mov ax, 3
	;int 10h
	assume cs:CSEG, ds:CSEG
	mov ax, 0B800ah
	mov es, ax
	mov di, 0
	mov al, 1
	mov ah, 31
	mov cx, 01h

Next_face:
	mov es:[di], ax
	add di, 2
	;loop Next_face 
	dec cx
	jnz Next_face

	mov ah, 10h
	int 16h
	int 20h	
CSEG ends
end Start
