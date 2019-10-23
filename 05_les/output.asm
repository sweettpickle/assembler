Assume CS:Code, DS:Code
Code segment
org 100h
Start:
	mov ah, 0ah
	mov ah, 9
	int 21h
	int 20h

Code ends
end Start
