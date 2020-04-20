[org 0x7c00]
;----------------------------------------------------
; Boot loader main
;----------------------------------------------------
; all the bootstrap code to load os
;

                    mov     bp, 0xfffe                          ; Set bottom of the stack
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
%include "boot/messages.asm"
%include "boot/protected_mode.asm"
%include "boot/utills.asm"

;------------------------
; Padding bytes
;------------------------
times 510-($-$$) db 0
dw 0xaa55

;------------------------
; Kernel entry
; 0x7e00 - c kernel
;------------------------
kernel_start:
