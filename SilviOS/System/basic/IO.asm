; SilviOS IO assembler routines
; Basic routines that can not be implemented in the c language

global load_gdt
global read_port
global write_port
global load_idt

load_gdt:
mov     EDX, [ESP + 4]
lgdt    [EDX]

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

switch_32:
;code for switching to protected mode TODO
