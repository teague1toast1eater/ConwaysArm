// function that returns the value of a game_board[i][i]
// parameters: x0 == the gameboard, x1 == i, x2 == j



.global get_element_at_index
get_element_at_index:
    // x0 == 2d arr
    // x1 == i
    // x2 == j
    lsl x3, x1, #3 // calculate i offset, i == i * 8
    lsl x4, x2, #2 // calculate j offset, j == j * 4
    ldr x10, [x0, x3] // 2darr[i]
    ldr x11, [x10, x4] // 2darr[i][j]
    mov x0, x11
    ret
