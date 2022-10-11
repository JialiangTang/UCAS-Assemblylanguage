#hw5
.code32
.section .data
var:
  .int 0x0812abcd   #0x80001234
.section .text
.globl _start
_start:
    pushl var
	call print_hex
	call as_exit
    
.type print_hex,@function
print_hex:
    push %ebp
	mov %esp,%ebp  #ebp points at old ebp
	sub $16,%esp  #esp=buf
	mov 8(%ebp),%eax  #eax=x
	mov %eax,%edx  #edx=eax=x
	lea 11(%esp),%ecx  #ecx=buf+11
    movb $0,(%ecx)  #(ecx)='\0'
	dec %ecx  #ecx=buf+10
	mov %eax,%ebx
	shr $31,%eax  #eax=000...001 or 00000..00 (32 bits)
	test %eax,%eax
	jnz L0  #jnz:-
	movb $0,(%ecx)
	dec %ecx  #ecx=buf+9
	movb $0,(%ecx)
	dec %ecx  #ecx=buf+8
	jmp L2  #else:+

L0: 
    negl %ebx
L1:
    mov %ebx,%edx
    lea 3(%esp),%esi
    movb $'-',0(%esp)
	movb $'0',1(%esp)
	movb $'x',2(%esp)
	andb $0xf,%dl
	cmpb $10,%dl
	jb L3 
	addb $0x57,%dl  #>10
    jmp L4
L3:
    orb $0x30,%dl
L4: 
    movb %dl,(%ecx)
    dec %ecx
	shrl $4,%ebx
	cmp %esi,%ecx
	jae L1
	jmp L5


L2:
    mov %ebx,%edx
    lea 2(%esp),%esi
    movb $'0',0(%esp)
	movb $'x',1(%esp)
	andb $0xf,%dl
	cmpb $10,%dl
	jb L7 
	addb $0x57,%dl  #>10
    jmp L8
L7:
    orb $0x30,%dl
L8: 
    movb %dl,(%ecx)
    dec %ecx
	shrl $4,%ebx
	cmp %esi,%ecx
	jae L2
	jmp L6
   
L5:
	mov $4,%eax
	mov $1,%ebx
	mov %esp,%ecx
	mov $11,%edx
	int $0x80
	leave
	ret
    loop L5
L6:
	mov $4,%eax
	mov $1,%ebx
	mov %esp,%ecx
	mov $9,%edx
	int $0x80
	leave
	ret
    loop L6

.globl as_exit
    .type as_exit, @function
as_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
