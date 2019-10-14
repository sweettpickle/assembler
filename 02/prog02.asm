CSEG segment
org 100h
Start:

	mov ah,9
	mov dx,offset String
	int 21h

	mov ah,10h
	int 16h

	int 20h

String db 'Click on any button please...$'

CSEG ends
end Start
