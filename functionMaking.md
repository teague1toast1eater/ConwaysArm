
# How to make a function 

when making a function in arm always use the registers x0-x18 if possible
because these are called "caller saved registers" which means by convention
function can change what is in them at will all other registers must have the
same value before and after the function call for convention sake if you muse
use a register other than these in your functions be sure to save the value of
those registers to the stack and then restore the values before the function
returns. x19-x30 are callee saved which means they must be the same both before
and after the function call

## nested functions

if you are making a function that is relient on other function understand the
functions like printf and scanf will use the sane guilines about registers
stated earlier so understand that calling one of those functions will likely
alter the values of registers x1-x18 so if you are calling a function be
sure to store any sate you need to persist after the call in these registers
on the stack and then restore it after the function call. If you are making
a function that calls other function be sure to maintain the link register
by storing it on the stack at the beginning of the function and retoring it
after so that the nested function calls do not ruin the link register return
location. you can see how this is implemented in the clear screen and print
game board functions

## the stack 

to add to the stack use "str registers-to-store, [sp, #-16]!" to pop off the
stack use "ldr register, [sp], #16"</br> Example: `str x0, [sp, #-16]!`, `ldr
x0, [sp], #16`. The stack must also remain the same before and after any
function call
