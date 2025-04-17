.data
newline: .asciz "\n"
x_value: .asciz "X"
blank: .asciz " "

.global print_game_board
.extern printf
.text

// takes a 2D array of 0s and 1s and prints it to the screen as " " and "X"
// Parameters: x0 == array to be printed, x1 == array height, x2 == arr width
print_game_board:
    // x0 == 2darray
    // x1 == parent array length
    // x2 == child array length 
    str x20, [sp, #-16]! // we want to use register 20 and 21 so we store them on the stack 
    str x21, [sp, #-16]!
    str x30, [sp, #-16]! // sotre link register on the stack
    mov x20, x1
    mov x21, x2
    mov x10, #0         //i = 0    
    upperloop:

        mov x11, #0         //j = 0
        lowerloop:
            lsl x3, x10, #3    //i offset 
            lsl x4, x11, #3    //j offset
            ldr x5, [x0, x3] // multarray[i]
            ldr x1, [x5, x4] // multarray[i][j]

            //store needed variables in the stack
            str x0, [sp, #-16]!
            str x10, [sp, #-16]!
            str x11, [sp, #-16]!

            // print value of multarray[i][j]
            cmp x1, #1      // 2dArray[i][j] == 1
            bne skip_x      
            bl print_x
            skip_x:
            beq skip        // comparison persists across function calls
            bl print_space
            skip:
            ldr x11, [sp], #16 // restore the stack
            ldr x10, [sp], #16
            ldr x0, [sp], #16

            add x11, x11, #1    //j++
            cmp x11, x21         //j < array width
            blt lowerloop
        
        // save state on the stack
        str x0, [sp, #-16]!
        str x10, [sp, #-16]!
        str x11, [sp, #-16]!


        ldr x0, =newline
        bl printf         // print \n

        //retrive saved state
        ldr x11, [sp], #16
        ldr x10, [sp], #16
        ldr x0, [sp], #16

        add x10, x10, #1  // i++
        cmp x10, x20       // i < array height
        blt upperloop
    ldr x30, [sp], #16
    ldr x21, [sp], #16
    ldr x20, [sp], #16
    ret

print_x:
    str x30, [sp, #-16]!
    ldr x0, =x_value
    bl printf
    ldr x30, [sp], #16
    ret

print_space: 
    str x30, [sp, #-16]!
    ldr x0, =blank
    bl printf
    ldr x30, [sp], #16
    ret
