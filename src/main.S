// copyright: 2025: Mason England, Alec Stoeger, Teague Beauchamp
// use registers x0-x18 to handle arguments in order
// try to keep main game loop here, put extra functions in seperate files
// explain function usage either here or in a function.md file

.equ BOARD_HEIGHT, 30
.equ BOARD_WIDTH, 60

.data
message: .asciz "%d\n"

.global main 
.global get_board_dimensions
.extern printf print_game_board clear_screen create_game_board set_element_at_index
.extern update_game_board armalloc set_timeout
.text
main:
    
    // create the game board 
    mov x0, #1000
    bl armalloc // make a game board
    mov x19, x0
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl create_game_board
    
    bl seed2   // change the seed here

    bl clear_screen

    mov x0, x19
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl print_game_board

    mov x0, #300
    bl set_timeout


game_loop:

    bl clear_screen


    mov x0, x19
    bl update_game_board
    mov x19, x0

    mov x0, x19
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl print_game_board

    mov x0, #300
    bl set_timeout

    b game_loop


    

exit:
    mov x0, #0
    mov x8, #93 //93: exit syscall
    svc 0

get_board_dimensions:
    mov x0, BOARD_HEIGHT
    mov x1, BOARD_WIDTH
    ret

seed1:
    str x30, [sp, #-16]!

    mov x1, #12
    mov x2, #12
    mov x3, #1
    bl set_element_at_index

    mov x0, x19
    mov x1, #11
    mov x2, #12
    mov x3, #1
    bl set_element_at_index
    
    mov x0, x19
    mov x1, #10
    mov x2, #12
    mov x3, #1
    bl set_element_at_index

    mov x0, x19
    mov x1, #12
    mov x2, #11
    mov x3, #1
    bl set_element_at_index

    mov x0, x19
    mov x1, #11
    mov x2, #10
    mov x3, #1
    bl set_element_at_index

    ldr x30, [sp], #16
    ret 

seed2:
    str x30, [sp, #-16]!

mov x0, x19
    mov x1, #15
    mov x2, #35
    mov x3, #1
    bl set_element_at_index

mov x0, x19
    mov x1, #15
    mov x2, #34
    mov x3, #1
    bl set_element_at_index

mov x0, x19
    mov x1, #15
    mov x2, #33
    mov x3, #1
    bl set_element_at_index

mov x0, x19
    mov x1, #15
    mov x2, #32
    mov x3, #1
    bl set_element_at_index

mov x0, x19
    mov x1, #15
    mov x2, #31
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #15
    mov x2, #30
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #15
    mov x2, #29
    mov x3, #1
    bl set_element_at_index



mov x0, x19
    mov x1, #15
    mov x2, #28
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #15
    mov x2, #27
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #14
    mov x2, #34
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #13
    mov x2, #33
    mov x3, #1
    bl set_element_at_index



mov x0, x19
    mov x1, #12
    mov x2, #32
    mov x3, #1
    bl set_element_at_index


mov x0, x19
    mov x1, #11
    mov x2, #31
    mov x3, #1
    bl set_element_at_index



mov x0, x19
    mov x1, #12
    mov x2, #30
    mov x3, #1
    bl set_element_at_index



mov x0, x19
    mov x1, #13
    mov x2, #29
    mov x3, #1
    bl set_element_at_index

mov x0, x19
    mov x1, #14
    mov x2, #28
    mov x3, #1
    bl set_element_at_index

    ldr x30, [sp], #16
    ret






