	.globl	matrix
matrix:
.L0:
	testq	%rcx, %rcx
	jle	.L11
	leaq	8(%rsp), %r10
	andq	$-32, %rsp
	leaq	-1(%rcx), %rax
	pushq	-8(%r10)
	pushq	%rbp
	andq	$-512, %rax
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	leaq	0(,%rcx,8), %r15
	pushq	%r10
	pushq	%rbx
	movq	%r15, %r14
	movq	%rcx, %r15
	subq	$104, %rsp
	movq	%rax, -232(%rbp)
	addq	$512, %rax
	movq	%rsi, -184(%rbp)
	movq	%rax, -200(%rbp)
	movq	%rcx, %rax
	movq	%rdx, -192(%rbp)
	salq	$9, %rax
	movq	$0, -128(%rbp)
	movq	$0, -56(%rbp)
	movq	%rax, -224(%rbp)
	movq	%rcx, %rax
	salq	$12, %rax
	movq	%rax, -168(%rbp)
	movq	%rcx, %rax
	salq	$6, %rax
	movq	%rax, -208(%rbp)
	leaq	8192(%rdi), %rax
	movq	%rax, -240(%rbp)
	leaq	4096(%rdi), %rax
	movq	%rax, -248(%rbp)
	leaq	128(%rdx), %rax
	movq	%rax, -104(%rbp)
.L1:
	movq	-56(%rbp), %rax
	movq	$0, -120(%rbp)
	movq	$0, -88(%rbp)
	leaq	512(%rax), %rbx
	movq	-248(%rbp), %rax
	movq	%rbx, -80(%rbp)
	movq	%rax, -160(%rbp)
	movq	-192(%rbp), %rax
	movq	%rax, -176(%rbp)
	movq	-128(%rbp), %rax
	notq	%rax
	addq	%rbx, %rax
	andq	$-16, %rax
	movq	%rax, -96(%rbp)
	movq	%r15, %rax
	movq	%r14, %r15
	movq	%rax, %r14
.L10:
	movq	-88(%rbp), %rax
	movq	-240(%rbp), %rbx
	movq	$8, -152(%rbp)
	addq	$512, %rax
	movq	%rax, -64(%rbp)
	movq	-120(%rbp), %rax
	addq	-232(%rbp), %rax
	leaq	(%rbx,%rax,8), %rax
	movq	%rax, -216(%rbp)
	movq	-184(%rbp), %rax
	movq	%rax, -144(%rbp)
	movq	-160(%rbp), %rax
	movq	%rax, -112(%rbp)
.L9:
	movq	-112(%rbp), %rax
	movq	-152(%rbp), %r8
	leaq	-4096(%rax), %r11
	movq	-144(%rbp), %rax
	movq	%rax, -72(%rbp)
.L8:
	movq	-64(%rbp), %rbx
	cmpq	%rbx, -88(%rbp)
	jge	.L12
	movq	-120(%rbp), %r13
	addq	-128(%rbp), %r13
	leaq	64(%r11), %rax
	movq	-176(%rbp), %r12
	movq	-88(%rbp), %rbx
	leaq	-8(%r8), %r10
	movq	%rax, -136(%rbp)
	movq	%rax, %rsi
.L6:
	movq	-80(%rbp), %rdi
	cmpq	%rdi, -56(%rbp)
	jge	.L2
	movq	-96(%rbp), %rax
	movq	-104(%rbp), %rdi
	movq	%r12, %rcx
	addq	%r13, %rax
	leaq	(%rdi,%rax,8), %r9
	movq	-72(%rbp), %rdi
.L5:
	#fetch four vector in mem
	vmovupd	(%rcx), %ymm4
	vmovupd	32(%rcx), %ymm3
	vmovupd	64(%rcx), %ymm2
	vmovupd	96(%rcx), %ymm1
	#judge whether go to L4 or skip
	cmpq	%r10, %r8
	jle	.L3
	movq	%rdi, %rax
	movq	%r11, %rdx
.L4:
	#fetch vector of A
	vbroadcastsd	(%rdx), %ymm0
	#tmp_i += vector_a * vector_b_i
	vmulpd	(%rax), %ymm0, %ymm5
	vaddpd	%ymm5, %ymm4, %ymm4
	vmulpd	32(%rax), %ymm0, %ymm5
	vaddpd	%ymm5, %ymm3, %ymm3
	vmulpd	64(%rax), %ymm0, %ymm5
	vaddpd	%ymm5, %ymm2, %ymm2
	vmulpd	96(%rax), %ymm0, %ymm0
	vaddpd	%ymm0, %ymm1, %ymm1
	addq	%r15, %rax
	#judge loop
	addq	$8, %rdx
	cmpq	%rsi, %rdx
	jne	.L4
.L3:
	#store the res to mem
	vmovups	%ymm4, (%rcx)
	#otherwise segmentation fault
	subq	$-128, %rcx		
	vmovups	%ymm3, -96(%rcx)
	vmovups	%ymm2, -64(%rcx)
	vmovups	%ymm1, -32(%rcx)
	#judge whether continue the L5
	subq	$-128, %rdi
	cmpq	%r9, %rcx
	jne	.L5
.L2:
	addq	$1, %rbx
	addq	%r15, %r12
	addq	%r14, %r13
	addq	%r15, %r11
	addq	%r15, %rsi
	cmpq	-64(%rbp), %rbx
	jne	.L6
	jmp	.L7
.L12:
	leaq	64(%r11), %rax
	movq	%rax, -136(%rbp)
.L7:
	movq	-136(%rbp), %rbx
	movq	-112(%rbp), %rax
	addq	$8, %r8
	movq	-208(%rbp), %rdi
	addq	%rdi, -72(%rbp)
	cmpq	%rax, %rbx
	movq	%rbx, %r11
	jne	.L8
	movq	-136(%rbp), %rax
	movq	-168(%rbp), %rdi
	addq	$512, -152(%rbp)
	addq	%rdi, -144(%rbp)
	addq	$4096, %rax
	cmpq	-216(%rbp), %rax
	movq	%rax, -112(%rbp)
	jne	.L9
	movq	-224(%rbp), %rbx
	movq	-64(%rbp), %rax
	addq	%rbx, -120(%rbp)
	movq	-168(%rbp), %rbx
	addq	%rbx, -160(%rbp)
	addq	%rbx, -176(%rbp)
	movq	-200(%rbp), %rbx
	movq	%rax, -88(%rbp)
	cmpq	%rbx, %rax
	jne	.L10
	movq	%r14, %rax
	addq	$512, -128(%rbp)
	movq	%r15, %r14
	addq	$4096, -184(%rbp)
	movq	%rax, %r15
	movq	-80(%rbp), %rax
	addq	$4096, -192(%rbp)
	cmpq	%rax, -200(%rbp)
	movq	%rax, -56(%rbp)
	jne	.L1
	addq	$104, %rsp
	popq	%rbx
	popq	%r10
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
.L11:
	ret
