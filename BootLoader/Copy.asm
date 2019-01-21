; Copies BX bytes from address DS:BX
; Copy CX bytes from SI to DI
Copy8:
pusha
Copy8_loop:
cmp     CX
jz      Copy8End
mov     AX, [DS:SI]
mov     [DS:DI], AX
inc     DS
inc     SI
dec     CX
jmp     Copy_loop
Copy8End:
popa
ret
