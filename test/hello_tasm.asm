;	.model tiny
Assume CS:Code;, DS:Code 
Code segment
org 100h
Start:
	mov ah, 9
	mov dx, offset mes
	int 21h
	ret
mes db "Hello world!", 0Dh, 0Ah, '$'

Code ends
end Start
