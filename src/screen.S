.data
fmt: .asciz "%s"
message: .asciz "Hello World\n"
bar: .asciz "\033[2J\033[H"
foo: .asciz "yo\n"

.text
.global main
.extern printf

main:
    // test print Hello world
    ldr x0, =fmt
    ldr x1, =message
    bl printf

    //bl clear_screen
    ldr x0, =fmt
    ldr x1, =bar
    bl printf

    // test print yo
    ldr x0, =fmt
    ldr x1, =foo
    bl printf


exit:
    mov x0, #0
    mov x8, #93
    svc 0
