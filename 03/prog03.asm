CSEG segment
org 100h
Start:

	mov ax, 3
	int 10h

	mov ax, 0B800h
	mov es, ax
	mov di, 0

	mov ah, 31h
	mov al, 1h
	mov es:[di], ax

	mov ah, 10h
	int 16h

	int 20h

CSEG ends
end Start
