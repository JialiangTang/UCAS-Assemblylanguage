.code32
.section .data
testdata:
    .byte 'A','0','z','P','8','r','Z','2','f','H'
.section .text
.globl _start
_start:
    subl $8,%esp
    movl $10,4(%esp)
    movl $testdata,(%esp)
    call insert_sort
# output
    call as_puts

# exit 
    call as_exit


.globl insert_sort
    .type insert_sort, @function    
insert_sort:
.LFB0:
    pushl %edi
    pushl %esi
    pushl %ebx
    movl 16(%esp),%edi  #get a,edi:a
    movl 20(%esp),%esi  #get n,esi:n
    movl %edi,%edx  #edx:a
    movl %edi,%eax  #eax:a
    inc %eax        #eax:a+i,the initial state is i=1 and eax=a+1
    add %esi,%edi   #edi:a+n
    cmpl %edi,%eax  
    jge .L1
.L0:
        movzbl (%eax),%ebx  #ebx=tmp=a[i]
        movl %eax,%esi  #esi:a+i
        dec %esi  #j=i-1;esi:a+j
        movzbl (%esi),%ecx  #ecx:a[j]
        cmpl %edx,%esi
        jl .L2  #j<0
        cmpb %bl,%cl
        jle .L2  #a[j]<=tmp
.L3:     
        movb %cl,1(%esi)  #a[j+1]=a[j]
        dec %esi  #j--
		movzbl (%esi),%ecx   #renew the a[j]
        cmpl %edx,%esi
        jl .L2
        cmpb %bl,%cl
        jle .L2
        jmp .L3
.L2:
    movb %bl,1(%esi)
    inc %eax  #i++
    cmpl %eax,%edi  #eax:a+i,edi:a+n
    jle .L1  #i>=n
    jmp .L0 
.L1:
    popl %ebx
    popl %esi
    popl %edi
    ret

.type as_puts, @function
as_puts:
    pushl %ebx
    movl $4, %eax
    movl $1, %ebx
    movl 8(%esp),%ecx
    movl 12(%esp),%edx
    int $0x80
    popl %ebx
    ret

.type as_exit, @function
as_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
