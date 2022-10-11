#include <stdio.h>
unsigned int shld5(unsigned int a, unsigned int b);

int main(){
    unsigned int a;
    unsigned int b;
    scanf("%u %u",&a,&b);
    printf("%u\n",shld5(a,b));
    return 0;
}

unsigned int shld5(unsigned int a, unsigned int b){
    unsigned int result;    
    asm(
        "shl $5,%%eax\n\t"
        "shr $27,%%ebx\n\t"
        "orl %%ebx,%%eax\n\t"
        :"=a"(result)
        :"a"(a),"b"(b)
    );
    //result = (a << 5) |( b>>(32-5));  //此语句用嵌入式汇编编写   
    return result;
}