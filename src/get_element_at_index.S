// function that returns the value of a game_board[i][i]
// parameters: x0 == the gameboard, x1 == i, x2 == j
// if i or j is out of bounds, returns 0



.global get_element_at_index
.extern get_board_dimensions
get_element_at_index:
    // x0 == 2d arr
    // x1 == i
    // x2 == j
    str x30, [sp, #-16]!
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    str x2, [sp, #-16]!

    bl get_board_dimensions
    mov x3, x0 // x3 == board Height
    mov x4, x1 // x4 == board Width

    ldr x2, [sp], #16
    ldr x1, [sp], #16
    ldr x0, [sp], #16

    // if i > board height || j > board width
    // return 0
    cmp x1, x3
    bge return_zero
    cmp x2, x4
    bge return_zero
    cmp x1, #0
    blt return_zero
    cmp x2, #0
    blt return_zero


    lsl x3, x1, #3 // calculate i offset, i == i * 8
    lsl x4, x2, #3 // calculate j offset, j == j * 4
    ldr x10, [x0, x3] // 2darr[i]
    ldr x11, [x10, x4] // 2darr[i][j]
    mov x0, x11
    b return

    return_zero:
        mov x0, #0
        b return


    return:
        ldr x30, [sp], #16
        ret
