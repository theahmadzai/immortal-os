gdt_start:                                                  ; Start of gdt descriptor

;------------------------
; 16 Bytes null descriptor
;------------------------
gdt_null:           dd      0x00000000
                    dd      0x00000000

;------------------------
; Code segment descriptor
;------------------------
gdt_code:           dw      0xFFFF
                    dw      0x0000
                    db      0x00
                    db      0b10011010
                    db      0b11001111
                    db      0x00

;------------------------
; Data segment descriptor
;------------------------
gdt_data:           dw      0xFFFF
                    dw      0x0000
                    db      0x00
                    db      0b10010010
                    db      0b11001111
                    db      0x00

gdt_end:                                                    ; End of gdt descriptor

;------------------------
; Code segment descriptor
;------------------------
gdt_descriptor:     dw      gdt_end - gdt_start - 1
                    dd      gdt_start

CODE_SEG            equ     gdt_code - gdt_start
DATA_SEG            equ     gdt_data - gdt_start
