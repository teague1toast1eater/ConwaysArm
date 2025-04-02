.data
message: .asciz "Hello World\n"

.text
.global main
.extern printf

main:
    ldr x0, =message
    bl printf

exit:
    mov x0, #0
    mov x8, #93
    svc 0
