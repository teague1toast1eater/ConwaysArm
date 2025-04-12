// should be a simple wrapper around a call to printf. I just thought it would
// be easier to call this so we don't have to remember the ANSII code every
// time


// ansii_code has two ANSII escape codes, \x1b[2J and \x1b[0;0H.
// \x1b[2J is used to clear the screen, and \x1b[0;0H is used to move the
// cursor back to the top left corner

.data
    ansii_code: .asciz "\033[2J\033[H" 

.extern printf
.global clear_screen
.text

clear_screen:
    str x30, [sp, #-16]!

    ldr x0, =ansii_code
    bl printf

    ldr x30, [sp], #16
    ret

