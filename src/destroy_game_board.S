
.global destroy_game_board
.global arfree
.extern get_board_dimensions
.text
destroy_game_board:
    //x0 == arr
    str x30, [sp, #-16]!

    str x19, [sp, #-16]!
    str x20, [sp, #-16]!
    str x21, [sp, #-16]!
    str x22, [sp, #-16]!

    mov x19, x0 // x19 == arr
    bl get_board_dimensions
    mov x20, x0 // x20 == board height
    mov x21, x1 //x21 == board width 

    mov x22, #0 // i == 0
    loop:
        lsl x3, x2, #3 //calculate offset
        ldr x4, [x19, x3] // get game_board[i] pointer
        mov x0, x4 // set pointer to be freed
        lsl x1, x21, #3 // calculate byte size
        bl arfree
        
        add x22, x22, #1 // i++
        cmp x22, x21     // i < board width

    ldr x22, [sp], #16
    ldr x21, [sp], #16
    ldr x20, [sp], #16
    ldr x19, [sp], #16

    ldr x30, [sp], #16
    ret

arfree:
    // x0 == pointer to be freed
    // x1 == byte size to be freed
    
    str x30, [sp, #-16]!
    str x29, [sp, #-16]!
    mov x29, sp

    mov x8, #215
    svc 0


    ldr x29, [sp], #16
    ldr x30, [sp], #16
    ret
