#print_hex--mips
.section .data
    var: .int 0x0fff
.section .text
    .global __start
__start:
    addiu $sp,$sp,-20  #open a new peice of stack 
    addiu $t2,$sp,16  #t0:point to sp+4,the start addr of result
    la $t3,var  #t3:addr of data
    lw $t4,0($t3)  #t4:data,0x9812abcd
    addiu $t3,$0,10  #t3:10,used to div
    addiu $t5,$0,0  #t5:0,the count of the length of result 
    beq $t4,$0,L2  #if t4==0,then turn to L2
    nop
L1:
    sub $t2,1  #t2=t2-1
    addiu $t5,$t5,1  #count+=1
    divu $t4,$t3  #t4/10,result in LO,leave in HI
    mfhi $t6  #t6:leave
    mflo $t7  #t7:result
    addiu $t4,$t7,0  #t4=t4/10
    addiu $t6,$t6,0x30  #t6=t6+'0'
    sb $t6,0($t2)  #store the t6--the lowest decimal bit of data 
    bne $t4,$0,L1  #if t4!=0,then go to L1
    nop
    beq $t4,$0,L3  #else go to L3 

L2:
    sub $t2,1
    addiu $t6,$0,0x30
    sb $t6,0($t2)
    addiu $t5,$t5,1

L3: #deal with the output and exit
    addiu $v0,$0,4004
    addiu $a0,$0,1
    addiu $a1,$t2,0  #t2 is the start addr of output
    addiu $a2,$t5,0  #t5 is the length of output
    syscall
    addiu $v0,$0,4001
    addiu $a0,$0,0
    syscall

