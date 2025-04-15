
.global set_element_at_index
.extern get_board_dimensions
.text
set_element_at_index:
    // x0 == arr
    // x1 == i
    // x2 == j
    // x3 == 0 or 1

    // keep lr integirity 
    str x30, [sp, #-16]!

    // store needed state on the stack
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    str x2, [sp, #-16]!
    str x3, [sp, #-16]!

    // save board dimensions
    bl get_board_dimensions
    mov x5, x0  // x5 == board height
    mov x6, x1  // x6 == board width

    // return stored state
    ldr x3, [sp], #16
    ldr x2, [sp], #16
    ldr x1, [sp], #16
    ldr x0, [sp], #16

    // if i < 0 || i > game_board width || j < 0 || j > game board height: return
    cmp x1, #0
    blt return
    cmp x2, #0
    blt return
    cmp x1, x5
    bge return
    cmp x2, x6
    bge return


    // set array[i][j] to x3
    lsl x10, x1, #3
    ldr x4, [x0, x10]
    lsl x10, x2, #3
    str x3, [x4, x10]

return:
    // restore link register 
    ldr x30, [sp], #16
    ret 



