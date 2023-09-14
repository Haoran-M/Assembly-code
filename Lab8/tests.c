#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "lab8.h"

int main(void) {
    printf("hailstone_length(1) == 0 == %lu\n", hailstone_length(1));
    printf("hailstone_length(5) == 5 == %lu\n", hailstone_length(5));
    printf("hailstone_length(20) == 7 == %lu\n", hailstone_length(20));
    printf("hailstone_length(123) == 46 == %lu\n", hailstone_length(123));

    printf("hailstone_length_cmov(1) == 0 == %lu\n", hailstone_length_cmov(1));
    printf("hailstone_length_cmov(5) == 5 == %lu\n", hailstone_length_cmov(5));
    printf("hailstone_length_cmov(20) == 7 == %lu\n", hailstone_length_cmov(20));
    printf("hailstone_length_cmov(123) == 46 == %lu\n", hailstone_length_cmov(123));

    return 0;
}
