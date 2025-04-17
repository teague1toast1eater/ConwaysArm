// for every item in gameboard
// get neighbor count 
// if oldboard[i][j] == 1 && (count == 2 or == 3) : newboard[i][j] = 1
// if count == 3: newboard[i][j] = 1
// else newboard[i][j] = 0


.data

.global update_game_board
.extern get_number_neighbors create_game_board get_board_dimensions get_element_at_index set_element_at_index destroy_game_board
.extern armalloc arfree
.text
update_game_board:
    //preamble
    str x30, [sp, #-16]!
    str x19, [sp, #-16]!
    str x20, [sp, #-16]!
    str x21, [sp, #-16]!
    str x22, [sp, #-16]!
    str x23, [sp, #-16]!



    // x0 == old game board
    mov x19, x0 // old arr in x19
    mov x0, #1000
    bl armalloc
    mov x23, x0
    bl get_board_dimensions
    mov x1, x0
    mov x2, x1
    mov x0, x23
    bl create_game_board // make a new game board

    mov x20, #0 // i = 0
    upperloop:
        mov x21, #0 // j = 0
        lowerloop:
            
            // get the number of neighbors
            mov x0, x19 // x0 = game board
            mov x1, x20 // x1 = i
            mov x2, x21 // x2 = j
            bl get_number_neighbors
            cmp x0, #3    // num_neightbors == 3?
            beq equals_3
            cmp x0, #2    // num_neighbors == 2?
            beq equals_2
            b else        // else
            equals_3:
            // set new board i, j to 1
            mov x0, x23
            mov x1, x20
            mov x2, x21
            mov x3, #1
            bl set_element_at_index
            b next

            equals_2:
            mov x0, x19 // x0 = old gameboard
            mov x1, x20 // x1 == i
            mov x2, x21 // x2 == j
            bl get_element_at_index

            cmp x0, #1 // if oldarr[i][j] == 1
            bne else

            mov x0, x23 // new game board
            mov x1, x20
            mov x2, x21
            mov x3, #1
            bl set_element_at_index
            b next

            else:
            // set game_board[i][j] = 0
            mov x0, x23
            mov x1, x20
            mov x2, x21
            mov x3, #0
            bl set_element_at_index
            b next

            next:
            add x21, x21, #1        //j++
            bl get_board_dimensions
            cmp x21, x1             // j < boardWidth
            blt lowerloop
        add x20, x20, #1           // i++
        bl get_board_dimensions    
        cmp x20, x0                // i < boardHeight
        blt upperloop

    
    mov x0, x19
    bl destroy_game_board
    mov x0, x19
    mov x1, #1000
    bl arfree
    mov x0, x23

    //postamble
    ldr x23, [sp], #16
    ldr x22, [sp], #16
    ldr x21, [sp], #16
    ldr x20, [sp], #16 
    ldr x19, [sp], #16
    ldr x30, [sp], #16
    ret

