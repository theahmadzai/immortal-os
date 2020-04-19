;------------------------
; Boot loader messages
;------------------------
msg_real_mode:
    db "Started in 16-bit Real Mode", 10, 13, 0

msg_protected_mode:
    db "Successfully Switched into 32-bit Protected Mode", 10, 13, 0

msg_read_error:
    db "Error reading from disk!", 10, 13, 0
