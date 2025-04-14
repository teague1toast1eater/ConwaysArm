// copyright: 2025: Mason England, Alec Stoeger, teague beauchamp
// use registers x0-x18 to handle arguments in order
// try to keep main game loop here, put extra functions in seperate files
// explain function usage either here or in a function.md file

.equ BOARD_HEIGHT, 30
.equ BOARD_WIDTH, 60

.data
game_board: .space 1000
message: .asciz "%d\n"

.global main 
.global get_board_dimensions
.extern printf print_game_board clear_screen get_element_at_index create_game_board
.text
main:
    
    // create the game board 
    ldr x0, =game_board
    mov x19, x0
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl create_game_board

    
    mov x1, #31
    mov x2, #28
    bl get_element_at_index

    mov x1, x0
    ldr x0, =message
    bl printf

    mov x0, x19
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl print_game_board

    b exit


exit:
    mov x0, #0
    mov x8, #93 //93: exit syscall
    svc 0

get_board_dimensions:
    mov x0, BOARD_HEIGHT
    mov x1, BOARD_WIDTH
    ret
