;----------------------------------------------------
; Functions
;----------------------------------------------------
; All the utility functions used in
; the boot loader are defined here
;

;------------------------
; Argument: al
;------------------------
print_char:
    push ax

    mov ah, 0x0e
    int 0x10

    pop ax

    ret

;------------------------
; Argument: si
;------------------------
print_string:
    push ax
    push si

    mov ah, 0x0e

    _loop:
        lodsb
        cmp al, 0
        je _end
        int 0x10
        jmp _loop

    _end:

    pop si
    pop ax

    ret

;------------------------
; Argument: dx
;------------------------
print_hex:
    push dx
    push cx

    mov ah, 0x0e
    mov cx, 4

    _hloop:
        mov al, dh                          ; 0x1E3F -> 0x1E
        shr al, 4                           ; 0x1E   -> 0x01

        cmp al, 9
        jle skip_add

        add al, 7                           ; Move to alphabet bracket

        skip_add:
            add al, 48                      ; Move to number bracket
            call print_char

        rol dx, 4                           ; 0x1E3F -> 0xE3F1

        loop _hloop

    pop cx
    pop dx

    ret

;------------------------
; Argument: None
;------------------------
find_bios_string:
    push ax
    push bx
    push dx
    push es

    mov bx, 0
    mov es, bx

    _bs_loop:
        mov al, [es:bx]
        cmp al, 'B'
        jne _bs_continue

        mov al, [es:bx+1]
        cmp al, 'I'
        jne _bs_continue

        mov al, [es:bx+2]
        cmp al, 'O'
        jne _bs_continue

        mov al, [es:bx+3]
        cmp al, 'S'
        jne _bs_continue

        mov dx, es
        call print_hex

        mov dx, bx
        call print_hex

        jmp _bs_end

    _bs_continue:
        mov dx, bx
        call print_hex

        inc bx
        cmp bx, 0
        je _bs_inc_segment

        jmp _bs_loop

    _bs_inc_segment:
        mov dx, es
        add cx, 0x1000
        mov ds, dx
        jmp _bs_loop

    _bs_end:

    pop es
    pop dx
    pop bx
    pop ax

    ret

;------------------------
; Argument: None
;------------------------
read_from_disk:
    push ax
    push bx
    push cx
    push dx
    push es

    mov ah, 0x2                             ; Read sectors from drive
    mov al, 0x1                             ; Number of sectors to read

    mov ch, 0x0                             ; Select cylinder
    mov cl, 0x2                             ; Select sector
    mov dh, 0x0                             ; Select head
    ;mov dl, 0x80                           ; Select drive

    mov bx, 0
    mov es, bx
    mov bx, 0x7c00 + 512

    int 0x13

    jnc _rfd_end

    mov si, msg_read_error
    call print_string

    _rfd_end:

    pop es
    pop dx
    pop cx
    pop bx
    pop ax

    ret

