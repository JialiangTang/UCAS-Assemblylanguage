Inthandler:
    pushw %ax
1:  movb (%si),%al
    test %al,%al
    jz 1f
    subb $'0',%al
    cmp $10,%al
    jae 2f
    andb 0x0,%al
    movb %al,(%si)
2:  inc %si
    jmp 1b
1:  popw %ax
    iret
