format ELF
section '.text' executable
public _start
_start:
              push msg_len   ; size of message
              push msg       ; offset of message
              push 1         ; stdout
              mov  eax,4     ; 4 =  sys_write
              push eax
              int  0x80
              add  esp,4*3   ; очищаем за собой стэк

              xor  eax,eax
              push eax       ; код выхода
              inc  eax       ; 1 = sys_exit
              int  0x80

section '.data' writeable
              msg db "Hello world",0
              msg_len = $-msg
