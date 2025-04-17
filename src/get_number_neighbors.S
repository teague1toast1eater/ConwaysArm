

.global get_number_neighbors
.extern get_element_at_index
get_number_neighbors:
    // x0 == arr
    // x1 == i
    // x2 == j
    str x30, [sp, #-16]!
    str x19, [sp, #-16]!
    str x20, [sp, #-16]!
    str x21, [sp, #-16]!
    str x22, [sp, #-16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, #0 // number of neighbors = 0

    // check i - 1, j
    mov x0, x19
    add x1, x20, #-1
    mov x2, x21
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next1 
    bl add_to_numbers
    mov x22, x0
    next1:

     // check i + 1, j
    mov x0, x19
    add x1, x20, #1
    mov x2, x21
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next2 
    bl add_to_numbers
    mov x22, x0
    next2:

    // check i, j - 1
    mov x0, x19
    mov x1, x20
    add x2, x21, #-1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next3 
    bl add_to_numbers
    mov x22, x0
    next3:

    // check i, j + 1
    mov x0, x19
    mov x1, x20
    add x2, x21, #1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next4 
    bl add_to_numbers
    mov x22, x0
    next4:

    // check i - 1, j - 1
    mov x0, x19
    add x1, x20, #-1
    add x2, x21, #-1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next5 
    bl add_to_numbers
    mov x22, x0
    next5:

    // check i + 1, j + 1
    mov x0, x19
    add x1, x20, #1
    add x2, x21, #1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next6 
    bl add_to_numbers
    mov x22, x0
    next6:

    // check i - 1, j + 1
    mov x0, x19
    add x1, x20, #-1
    add x2, x21, #1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next7 
    bl add_to_numbers
    mov x22, x0
    next7:

     // check i + 1, j - 1
    mov x0, x19
    add x1, x20, #1
    add x2, x21, #-1
    bl get_element_at_index
    cmp x0, #1
    mov x0, x22
    bne next8 
    bl add_to_numbers
    mov x22, x0
    next8:

    mov x0, x22

    ldr x22, [sp], #16
    ldr x21, [sp], #16
    ldr x20, [sp], #16
    ldr x19, [sp], #16

    ldr x30, [sp], #16

    ret




add_to_numbers:
    //x0 == number to increment
    add x0, x0, #1
    ret
