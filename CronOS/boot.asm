
BITS 16                ; Generate 16-bit x86 code
ORG 0x7C00             ; Set the code origin to 0x7C00

start:
    xor ax, ax         ; Clear AX (AX = 0)
    mov ds, ax         ; Set Data Segment to 0
    mov es, ax         ; Set Extra Segment to 0

    cli                ; Disable maskable interrupts
    mov ss, ax         ; Set Stack Segment to 0
    mov sp, 0x7C00     ; Set the stack top to 0x7C00
    sti                ; Enable maskable interrupts

    mov si, message    ; Point SI to the start of the string

print_loop:
    mov al, [si]       ; Load the current character into AL
    inc si             ; Move to the next character
    test al, al        ; Check whether AL is zero
    jz halt            ; Jump if the string has ended

    mov ah, 0x0E       ; Select BIOS teletype output
    mov bh, 0x00       ; Select video page 0
    mov bl, 0x07       ; Set text color attribute
    int 0x10           ; Call BIOS video services

    jmp print_loop    ; Continue printing characters

halt:
    cli                ; Disable maskable interrupts
    hlt                ; Halt the CPU
    jmp halt           ; Halt again if execution resumes

message:
    db 'CronOS ver 1.0', 0  ; Null-terminated string

times 510 - ($ - $$) db 0  ; Pad the sector to 510 bytes
dw 0xAA55                  ; Boot signature (55 AA)
