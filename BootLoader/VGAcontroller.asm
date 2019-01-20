; 32-bit print function
VGA_MEM equ 0xB8000
WHITE_ON_BLACK equ 0x0F
CHARACTERS_PER_LINE equ 80
NUMBER_OF_LINES equ 50

display32:
pusha

mov     DX, [DS:0x500]                          ;check if VGA controller has been initialized before!
cmp     DX, 0x3347
jne     display32_init
jmp     display32_do

display32_init:
mov     EDX, 0x00                               ;set x and y coordinates of current character to (0,0)
mov     [DS:0x504], EDX
mov     EDX, 0x000F3347                         ;set initialization completed memory sign and color
mov     [DS:0x500], EDX
jmp     display32_do

write32:
mov     AH, [DS:0x502]
push    EAX
mov     EAX, 0x00
mov     EBX, 0x00
mov     AX, [DS:0x504]
mov     BX, [DS:0x506]
mov     ECX, EAX
mov     EDI, CHARACTERS_PER_LINE
mul     EDI
mov     EDI, 0x02
mul     EDI
mov     EDI, EAX
pop     EAX
add     EDI, VGA_MEM
mov     [EDI], AX
mov     EAX, ECX

inc     EBX
cmp     EBX, CHARACTERS_PER_LINE
jl      token
mov     EBX, 0x00
inc     EAX
token:
cmp     EAX, NUMBER_OF_LINES-1
jge     shift32
jmp     display32_end



shift32:
pusha
mov     BX, 2*CHARACTERS_PER_LINE
mov     CX, 0x00
shift_loop:
mov     DI, VGA_MEM
add     DI, CX
mov     SI, DI
add     SI, BX
mov     AX, [DS:SI]
mov     [DS:DI], AX
add     CX, 0x02
mov     DI, 2*CHARACTERS_PER_LINE*(NUMBER_OF_LINES-1)
cmp     CX, DI
jl      shift_loop
popa
dec     EAX
jmp     display32_end


clear32:
pusha
mov     CX, 0x0000
mov     AX, 0x0000
clear_loop:
mov     DI, VGA_MEM
add     DI, CX
mov     [DS:DI], AX
add     CX, 0x02
mov     DI, 2*CHARACTERS_PER_LINE*(NUMBER_OF_LINES-1)
cmp     CX, DI
jle     clear_loop
popa
jmp     display32_end



get_coordinate32:
pusha
mov     EBX, [DS:0x508]
mov     EDI, 0x00
mov     DI, BX
shr     EBX, 16
mov     EAX, CHARACTERS_PER_LINE
mul     EDI
add     EBX, EAX
mov     [DS:0x510]
popa
ret



display32_do:
cmp     AH, 0x00
je      write32




display32_end:
popa
ret