[org 0x7c00]                                ; Set the offset location of first byte

mov bp, 0xFFFF                              ; Set bottom of the stack
mov sp, bp                                  ; Set top of the stack

mov si, msg_real_mode
call print_string

call read_from_disk

;------------------------
; Hang
;------------------------
jmp $

;------------------------
; Include dependencies
;------------------------
%include "boot/messages.asm"
%include "boot/utills.asm"
%include "boot/protected_mode.asm"


;------------------------
; Padding bytes
;------------------------
times 510-($-$$) db 0
dw 0xaa55

test: db "testing.....", 0

times 512 db 0
