#hw2.S
.section .data

iostring:

  .asciz "ab1g2hA0H56po9wK78nB"

.section .text

.globl _start

_start:
mov $iostring,%ebx  #p
mov %ebx,%edx  #q
L1:
mov (%ebx),%al
test %al,%al
je L2
cmp $'a',%al
jb L3
cmp $'z',%al
ja L3
sub $32,%al
mov %al,(%edx)

L3:
inc %ebx
inc %edx
jmp L1

L2:
mov %al,(%edx)  #*q=0

#output

         movl          $4, %eax

         movl          $1, %ebx

         movl          $iostring, %ecx

         sub           %ecx,%edx

         int    $0x80

#exit

         movl          $1, %eax

         movl          $0, %ebx

         int    $0x80
