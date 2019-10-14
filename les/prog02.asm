CSEG segment
org 100h
Start:
	;mov ax, 3
	;int 10h

	;mov ah,9
	;mov dx,offset String
	;int 21h

	;mov ah,10h
	;int 16h
	
	mov ax, 55
	
	push ax
	xor ax, ax
	pop ax

	int 20h

;String db 'Click on any button please...$'

CSEG ends
end Start
