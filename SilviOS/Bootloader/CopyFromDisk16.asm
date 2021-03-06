; Copies from floppy disk to Working memory!
; https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

CopyFromDisk16:
pusha
push    DX

reset:
mov     AH, 0x00
int     0x13
jc      reset

mov     AH, 0x02                    ; BIOS read sector function
mov     AL, DH                      ; Read AH sectors from the start point
mov     CH, 0x00                    ; Select Cylinder 0
mov     DH, 0x00                    ; Select Head
mov     CL, 0x02                    ; Start reading Sector 0x02

int     0x13

pop     DX
cmp     DH, AL
jne     DiskError                   ; check for error code of interrupt
mov     AH, [0x7E00]
cmp     AH, 0xFF
jne     DiskError                   ; check if 513 byte has the right value now

popa
ret

DiskError:
mov     BX, DiskErrorMessage
call    print16
jmp     $

;Data Section
DiskErrorMessage:
db 'Disk Read Error!',0

