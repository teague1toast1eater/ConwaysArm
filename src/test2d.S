.data
// allocate space for the game board 
// array[n][m] size = (n * m * 4 bytes)
game_board: .space 100      // [5][5] = 100 bytes of space needed
message: .asciz "Value at game_board[4][4]: %d\n"

.text
.global main
.extern printf

main:
    // store 1 at game_board[0][0]
    ldr x0, =game_board     // load base address of game_board
    mov w1, #1              // value to store
    str w1, [x0]            // store value at game_board[0][0]

    // store 2 at game_board[0][1]
    mov w1, #2
    str w1, [x0, #4]        // offset by 4 bytes
    
    // store 3 at game_board[1][0]
    mov w1, #3
    str w1, [x0, #20]       // offset by 20 bytes (5 * 4 bytes)
    
    // store 4 at game_board[1][1]
    mov w1, #4
    str w1, [x0, #24]       // offset by 24 bytes (6 * 4 bytes)

    // store 8 at game_board[4][4]
    mov w1, #8
    str w1, [x0, #96]       // offset by 96 bytes (24 * 4 bytes)

    // access and print [4][4]
    ldr w1, [x0, #96]       // load value from game_board[4][4]

    // prepare to print
    ldr x0, =message
    mov x1, w1              // move the value to x1 for printf
    bl printf

exit:
    mov x0, #0
    mov x8, #93
    svc 0
