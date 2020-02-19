Assume CS:Code; DS:Code; ES:Code; SS:Code
Code Segment
org 100h
Start:
	call our_proc
	int 20h

our_proc proc
	ret
our_proc endp

Code ends
end Start
