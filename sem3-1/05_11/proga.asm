Assume CS:Code;, DS:Code
Code Segment
org 100h
Start:
	mov ah, 01h
	int 21h

	cmp al, 1Bh
	je @out
	
	cmp al, '0'
	jb @not_num
	
	cmp al, '9'
	jbe @num

@not_num:
	jmp Start

@num:
	mov ah, 9h
	mov dx, offset space
	int 21h
	jmp Start

@out:
	int 20h

space db "  $"

Code ends
end Start
