CSEG segment
org 100h
Start:
	mov ah, 9
	mov dx, offset String
	int 21h
	int 20h
	int 20h
String db 'Mes$'
CSEG ends
end Start
