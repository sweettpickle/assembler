;nasm -felf64 file.asm
;ld -o hel file.o
;./hel

global _start

section .rodata ;тут хранятся констаны (только для чтения)
	msg: db "Hello World!", 0xA, 0x0
;0xA = новая строка, 0x0 = окончание строки

section .text

_start:
	mov eax, 4 ; write()
	mov ebx, 1
	mov ecx, msg
	mov edx, 14 ; lenght of string
	int 0x80

	mov eax, 0x01
	mov ebx, 0
	int 0x80

;section .rodata
;  msg: db "Hello, world!", 10
;  msglen: equ $ - msg
