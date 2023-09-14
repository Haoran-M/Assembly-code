#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "multiply_add.h"


void test(int64_t a, int64_t b, int64_t c) {
    int64_t result = multiply_add(a, b, c);
    printf("%ld + %ld * %ld = %ld\n", a, b, c, result);
}

int main(int argc, char *argv[]) {
    test(10, 20, 30);
    test(10, 1<<23, 3);
    test(6, -20, 30);
    test(10, 7, -2);
    test(-731, 852, -213);
    return 0;
}
