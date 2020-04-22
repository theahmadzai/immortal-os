[org 0x7C00]
;----------------------------------------------------
; Boot loader main
;----------------------------------------------------
; all the bootstrap code to load os
;
                    mov     ax, 0x0
                    mov     ds, ax
                    mov     es, ax
                    mov     fs, ax
                    mov     gs, ax
                    mov     ss, ax
                    jmp     0x0:CODE_SEGMENT
CODE_SEGMENT:
                    mov     bp, 0xFFFE                          ; Set bottom of the stack
                    mov     sp, bp                              ; Set top of the stack

                    mov     si, msg_real_mode
                    call    print_string

                    mov     al, 0x9
                    mov     bx, kernel_start                    ; 0x7e00 [0x7c00+512]
                    call    read_from_disk

                    call    protected_mode                      ; Switch to protected mode

                    jmp     $                                   ; Hang

[bits 32]

BEGIN_PM:           mov     esi, msg_prot_mode                  ; Execute protected mode code
                    call    print_string_pm

                    jmp     kernel_start

                    jmp     $                                   ; Hang

[bits 16]

;------------------------
; Include dependencies
;------------------------
%include "boot/protected_mode.asm"
%include "boot/utills.asm"

DATA_SEGMENT:
%include "boot/messages.asm"

;------------------------
; Padding bytes
;------------------------
times 510-($-$$) db 0
dw 0xAA55

;------------------------
; Kernel entry
; 0x7e00 - c kernel
;------------------------
kernel_start:
