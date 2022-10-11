#University of CAS
.section .data
    output:.ascii "University of CAS\n"
.section .text
.global _start
_start:
    movl  $4,%eax
    movl  $1,%ebx
    movl  $output,%ecx
    movl  $18,%edx
    int  $0x80
    movl  $1,%eax
    movl  $0,%ebx
    int  $0x80
    