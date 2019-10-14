CSEG segment
org 100h

Begin:

	mov ah,9
	mov dx,offset Mess2
	int 21h
	
	int 20h
	
Message db 'Hello, world!$'
Mess2 db 'Its me!$'
CSEG ends
end Begin
