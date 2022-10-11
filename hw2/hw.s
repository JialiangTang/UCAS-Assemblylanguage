#hw1.S
.section .data
stringvar:
    .ascii "0123456789abcdef"
.section .text
.globl _start
_start:
    movl $stringvar,%eax 
    movl $8,%ecx
    movl $0,%edx
L1:
    movw (%eax,%edx,2),%bx
    xchg %bl,%bh
    movw %bx,(%eax,%edx,2)
    inc %edx
    loop L1

#output
    movl $4,%eax
    movl $1,%ebx
    movl $stringvar,%ecx
    movl $16,%edx
    int $0x80
#exit
    movl $1,%eax
    movl $0,%ebx
    int $0x80
    