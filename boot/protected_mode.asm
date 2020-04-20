[bits 16]

%include "boot/gdt.asm"

protected_mode:     cli                                     ; Switch off interrupts

                    lgdt    [gdt_descriptor]                ; Load our global descriptor table.

                    mov     eax, cr0                        ; Switch to protected mode
                    or      eax, 0x1                        ; by setting fist bit of cr0 register
                    mov     cr0, eax                        ; to 0x1

                    jmp     CODE_SEG:init_pm

[bits 32]

init_pm:            mov     ax, DATA_SEG
                    mov     ds, ax
                    mov     ss, ax
                    mov     es, ax
                    mov     fs, ax
                    mov     gs, ax

                    mov     ebp, 0x90000
                    mov     esp, ebp

                    call    BEGIN_PM

[bits 16]
