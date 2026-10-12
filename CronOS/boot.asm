
BITS 16
ORG 0x7C00

start:
    xor ax, ax
    mov ds, ax

    cli
    mov ss, ax
    mov sp, 0x7C00
    sti

    ; Set VGA 80x25 color text mode
    mov ax, 0x0003
    int 0x10

    ; Set ES to VGA text memory segment
    mov ax, 0xB800
    mov es, ax

    ; Fill the screen with white-on-blue spaces
    xor di, di
    mov ax, 0x1F20
    mov cx, 2000
    cld
    rep stosw

    ; Point to the beginning of our string
    mov si, message

    ; Start writing at the top-left corner
    xor di, di

print_loop:
    mov al, [si]       ; Load current character
    inc si             ; Move to next character
    test al, al        ; Check for null terminator
    jz halt

    mov ah, 0x1F       ; White text on blue background
    stosw              ; Write character and attribute
    jmp print_loop

halt:
    cli
    hlt
    jmp halt

message:
    db 'CronOS ver 1.0', 0

times 510 - ($ - $$) db 0
dw 0xAA55
