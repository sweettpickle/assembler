format ELF
section '.text' executable

extrn printf

public main
main:
        push msg
        call printf
        add  esp,4
        ret

section '.data' writeable
        msg db "Hello world!\n",0
