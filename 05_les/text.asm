Assume CS:Code;, DS:Code
Code segment
org 100h
Start:
	mov ah, 0
	mov al, 3
	int 10h

	mov ah, 2
	mov bh, 0
	mov dh, 5
	mov dl, 35
	int 10h

	mov ah, 9
	mov dx, offset Str
	int 21h	
	
	mov ah, 2
	mov bh, 0
	mov dh, 10
	mov dl, 55
	INT 10h
;dh - str, dl - colom

	int 20h

Str db 'TEXT!!!$'

Code ends
end Start
