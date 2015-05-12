#include "stdio.h"

void main(){
    double a, b, c;
    /** float a, b, c; // In case we use float type variables the mantissa, or coefficient/significand
                       // will not be shown in printf()
                       // this happens because the float type precision is around 7 decimals
                       // in the other hand the double precision type is around 15 decimals
                        */
    a = 1000000.0;
    b = 0.01;
    c = a + b;

    printf("%.2f \n%.2f\n",b,c);
}
