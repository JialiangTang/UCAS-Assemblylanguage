#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>


void matrix(double *a, double *b, double *c,long n);
int main(void){
    double *ptr_a;  
    double *ptr_b;
    double *ptr_c;
    struct timeval tv1, tv2;
    long i,j,n,sec,usec;

    printf("Input matrix size :");
    scanf("%ld",&n);
    ptr_a = malloc(n*n*8);   
    ptr_b = malloc(n*n*8);
    ptr_c = malloc(n*n*8);

    for(i = 0; i< n; i++)
        for(j =0; j < n; j++){   
        ptr_a[i*n+j] = 2.0;
        ptr_b[i*n+j] = -2.0;
        ptr_c[i*n+j] = 0.0;
        }
    gettimeofday(&tv1, NULL);
    matrix(ptr_a, ptr_b, ptr_c,n);
    gettimeofday(&tv2, NULL);
    usec = (tv2.tv_sec - tv1.tv_sec)*1000000 + (tv2.tv_usec - tv1.tv_usec);
    sec = usec / 1000000;
    usec = usec - sec*1000000;
    printf("time elapse %ld s: %ld us\n", sec, usec);

    for(i =0; i<n; i++)
      for(j=0; j<n; j++)
        if(ptr_c[i*n+j] != -4.0*n) printf("error!");

    return 0;
}

/*void matrix(double *a, double *b, double *c, long n)
{
   long i, j, k;
   for(i = 0; i < n; i++)
        for(j = 0; j < n; j++)
            for(k= 0; k < n; k++)
                c[i*n+j] += a[i*n+k]*b[k*n+j];
}*/