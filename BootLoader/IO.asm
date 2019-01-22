; mini-os IO assembler routines

load_ldt:

load_gdt:

read_port:
mov     EDX, [ESP + 4]
in      AL, DX	                                ; reads data from port with address DX and writes it into register AL
ret

write_port:
mov     EDX, [ESP + 4]
mov     AL, [ESP + 4 + 4]
out     DX, AL                                  ; writes data from AL to port with address DX
ret

load_idt:
mov     EDX, [ESP + 4]
lidt    [EDX]
sti                                             ; turn on interrupts
ret