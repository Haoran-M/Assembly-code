#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

uint64_t hailstone_length(uint64_t n) {
    bool is_even = n % 2 == 0;
    if (n == 1) {
        return 0;
    } else if (is_even) {
        return 1 + hailstone_length(n / 2);
    } else {
        return 1 + hailstone_length(3 * n + 1);
    }
}

float dot_single_c(float* arr1, float* arr2, uint64_t length) {
    float total = 0.0;
    for (uint64_t i = 0; i < length; i++) {
        total += arr1[i] * arr2[i];

    }
    return total;
}

void map_poly_single_c(float* input, float* __restrict output, uint64_t length, float a, float b, float c, float d) {
    for (uint64_t i = 0; i < length; i++) {
        float x = input[i];
        output[i] = a*x*x*x + b*x*x + c*x + d;
    }
}

int main(void) {
    float farr1[4] = {1, 2, 3, 4};
    float farr2[4] = {0.5, 1.5, 2.5, 3.5};
    uint64_t len = 4;

    printf("hailstone_length(1) == %lu\n", hailstone_length(1));
    printf("hailstone_length(20) == %lu\n", hailstone_length(20));

    printf("dot_single_c(farr1, farr2, len) == %g\n", dot_single_c(farr1, farr2, len));

    map_poly_single_c(farr1, farr2, 4, 10.01, 11.01, 12.01, 13.01);
    printf("map_poly_single_c: { %g %g %g %g }\n", farr2[0], farr2[1], farr2[2], farr2[3]);
    

    return 0;
}