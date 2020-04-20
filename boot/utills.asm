[bits 16]
;----------------------------------------------------
; Functions
;----------------------------------------------------
; All the utility functions used in
; the boot loader are defined here
;

;------------------------
; Argument: al
;------------------------
print_char:         push    ax

                    mov     ah, 0x0e
                    int     0x10

                    pop     ax

                    ret

;------------------------
; Argument: si
;------------------------
print_string:       push    ax
                    push    si

                    mov     ah, 0x0e

_ps.loop:           lodsb
                    cmp     al, 0
                    je      _ps.end
                    int     0x10
                    jmp     _ps.loop

_ps.end:            pop     si
                    pop     ax

                    ret

;------------------------
; Argument: dx
;------------------------
print_hex:          push    dx
                    push    cx

                    mov     ah, 0x0e
                    mov     cx, 4

_ph.loop:           mov     al, dh                          ; 0x1E3F -> 0x1E
                    shr     al, 4                           ; 0x1E   -> 0x01

                    cmp     al, 9
                    jle     _ph.skip7

                    add     al, 7                           ; Move to alphabet bracket

_ph.skip7:          add     al, 48                          ; Move to number bracket
                    call    print_char

                    rol     dx, 4                           ; 0x1E3F -> 0xE3F1

                    loop     _ph.loop

                    pop     cx
                    pop     dx

                    ret

;------------------------
; Argument: None
;------------------------
read_from_disk:     push    ax
                    push    bx
                    push    cx
                    push    dx
                    push    es

                    mov     ah, 0x2                             ; Read sectors from drive
                    mov     al, 0x1                             ; Number of sectors to read

                    mov     ch, 0x0                             ; Select cylinder
                    mov     cl, 0x2                             ; Select sector
                    mov     dh, 0x0                             ; Select head
                    ;mov    dl, 0x80                           ; Select drive

                    mov     bx, 0
                    mov     es, bx
                    mov     bx, 0x7c00 + 512

                    int     0x13

                    jnc     _rfd.end

                    mov     si, msg_read_error
                    call    print_string

_rfd.end:           pop     es
                    pop     dx
                    pop     cx
                    pop     bx
                    pop     ax

                    ret


[bits 32]

VIDEO_MEMORY        equ     0xb8000
WHITE_ON_BLACK      equ     0x0f

print_string_pm:    pusha
                    mov     edx, VIDEO_MEMORY

_psp.loop:          mov     al, [esi]
                    mov     ah, WHITE_ON_BLACK

                    cmp     al, 0
                    je      _psp.end

                    mov     [edx], ax

                    add     esi, 1
                    add     edx, 2

                    jmp     _psp.loop

_psp.end:           popa
                    ret

[bits 16]
