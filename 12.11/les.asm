	.286 
	.model tiny
	.code
	org 100h

Start:
	
input:
	mov ah, 0
	int 16h
	
@check:
	cmp al, 1Bh
	je @out	

	cmp al, 'A'
	jb @not_eng
 
	cmp al, 'Z'
	jbe @is_eng

@not_eng:
	mov dl, al
	mov ah, 2
	int 21h
	jmp input

@is_eng:
	add al, 32
	mov dl, al
	mov ah, 2
	int 21h
	jmp input

@out:
	int 20h

end Start
