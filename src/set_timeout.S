.global set_timeout
set_timeout:
    // x0 = delay_ms

    mrs x1, cntfrq_el0        // x1 = timer frequency (Hz)
    mrs x2, cntvct_el0        // x2 = current timer value

    mul x3, x1, x0            // x3 = frequency * delay_ms
    mov x6, #1000
    udiv x3, x3, x6           // x3 = ticks to wait

    add x4, x2, x3            // x4 = target timer value

1:
    mrs x5, cntvct_el0        // x5 = current timer value
    cmp x5, x4
    blt 1b                    // repeat if not reached target

    ret
