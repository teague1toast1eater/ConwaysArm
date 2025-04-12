// copyright: 2025: Mason England, Alec Stoeger, teague beauchamp
// use registers x0-x18 to handle arguments in order
// try to keep main game loop here, put extra functions in seperate files
// explain function usage either here or in a function.md file

.equ BOARD_HEIGHT, 30
.equ BOARD_WIDTH, 30

.data
game_board: .space 1000
message: .asciz "%d\n"

.global main
.extern printf print_game_board clear_screen get_element_at_index
.text
main:
    ldr x0, =game_board
    mov x19, x0
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl create_2d_array
    mov x1, #1
    mov x2, #45
    bl get_element_at_index
    mov x1, x0
    ldr x0, =message
    bl printf
    mov x0, x19
    mov x1, BOARD_HEIGHT
    mov x2, BOARD_WIDTH
    bl print_game_board
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
    // x0 == arr
    // x1 == arr height
    // x2 == arr width
    str x30, [sp, #-16]!
    str x29, [sp, #-16]!
    mov x29, sp
    // store state to the stack
    str x19, [sp, #-16]!
    str x20, [sp, #-16]!
    str x21, [sp, #-16]!
    str x22, [sp, #-16]!
    str x23, [sp, #-16]!
    str x24, [sp, #-16]!


    mov x19, x0 // x19 == arr
    mov x20, x1 // x20 == arr height
    mov x21, x2 // x21 == arr width
    mov x22, #0 // i == 0
    upperloop:
        lsl x0, x21, #2 //multiply by 4 
        bl malloc // allocate width * 4 bytes
        mov x24, x0 // x24 == arr[i]
        mov x23, #0 // j == 0
        lowerloop:
            lsl x0, x23, #3 // j offset
            mov x1, #1
            str x1, [x24, x0] //set arr[i][j] to 1
            add x23, x23, #1 // j++
            cmp x23, x21
            blt lowerloop
        lsl x0, x22, #3 // i offset
        str x24, [x19, x0] // store array[i] in array 
        add x22, x22, #1 // i++
        cmp x22, x20 // if i < arr height
        blt upperloop
    mov x0, x19 // return the array

    //restore stack
    ldr x24, [sp], #16
    ldr x23, [sp], #16
    ldr x22, [sp], #16
    ldr x21, [sp], #16
    ldr x20, [sp], #16
    ldr x19, [sp], #16


    ldr x29, [sp], #16
    ldr x30, [sp], #16 // restore link register 
    ret

malloc:
    str x30, [sp, #-16]!
    str x29, [sp, #-16]!
    mov x29, sp

    mov x1, x0
    mov x0, #0            // Let OS choose address
    mov x2, #3
    mov x3, #0x22         // MAP_PRIVATE|MAP_ANONYMOUS
    mov x4, #-1           // No file descriptor
    mov x5, #0            // Offset
    mov x8, #222          // SYS_mmap
    svc #0                // x0 = allocated address
    
    ldr x29, [sp], #16
    ldr x30, [sp], #16
    cmp x0, #-1
    beq exit

    ret

exit:
    mov x0, #0
    mov x8, #93 //93: exit syscall
    svc 0
