// copyright: 2025: Mason England, Alec Stoeger, teague beauchamp
// use registers x0-x18 to handle arguments in order
// try to keep main game loop here, put extra functions in seperate files
// explain function usage either here or in a function.md file
// function usage: print_array, arg1 = array to be printed, arg2 = arr_height, arg3 = arr_width

.data
row1: .word 0, 1, 0, 1, 0, 0, 0
row2: .word 1, 0, 0, 0, 0, 1, 0
row3: .word 0, 1, 1, 0, 1, 0, 1
game_board: .space 32

.global main
.extern print_array
.text
main:
    bl create_2d_array
    mov x1, #3
    mov x2, #7
    bl print_array
    b exit


 // Explanation: the 2D array itself is an undefined 64-bit space
 // to add items to this array offset the items by 8 bytes
 // the child row arrays are .word arrays meaning they are 32-bit 
 // for 32 bit arrays use an offset of 4 bytes 
 // access and array element using ldr, [array_reg, offset(mutliple of 8 or 4)]
 // exmaple:
 //     lsl x2, x1, #3 left shift 3 multiplies by 8, left shift #2 multiplies by 4
 //     ldr, [x0, x2] 
 create_2d_array:
    //initialize a multi dimensional array
    ldr x0, =game_board // get the gameboard offset
    ldr x1, =row1       // load rows into the registers
    ldr x2, =row2
    ldr x3, =row3
    str x1, [x0]        // store the rows in the gameboard
    str x2, [x0, #8]   
    str x3, [x0, #16]
    ret

exit:
    mov x0, #0
    mov x8, #93 //93: exit syscall
    svc 0
