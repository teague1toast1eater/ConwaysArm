// takes an empty array and places a game board in it
// parameters: x0 == pre made array, x1 == board height, x2 == board width
// malloc is simply a helper function to create arrays 



.global create_game_board
.global armalloc

.text
create_game_board:
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

    // populate arr in x0
    upperloop:
        lsl x0, x21, #3 //multiply by 8
        bl armalloc // allocate width * 8 bytes
        mov x24, x0 // x24 == arr[i]
        mov x23, #0 // j == 0
        lowerloop:
            lsl x0, x23, #3 // j offset
            mov x1, #0  // change this to 0 to make it create an array of 0s
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

armalloc:
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
    mov x8, #93
    svc 0
