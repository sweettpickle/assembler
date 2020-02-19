Assume CS:Code;, DS:Code
Code segment
org 100h
Start:
	;mov ah, 9
	mov dx, tab
	lea al, 2
	xlat

	int 20h
tab db '100, 200, 300, 400, 500'

Code ends
end Start
