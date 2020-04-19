[bits 16]

%include "gdt.asm"

protected_mode:     cli                             ; Switch off interrupts

                    lgdt [gdt_descriptor]           ; Load our global descriptor table.

                    mov eax, cr0                    ; Switch to protected mode
                    or eax, 0x1                     ; by setting fist bit of cr0 register
                    mov cr0, eax                    ; to 0x1

