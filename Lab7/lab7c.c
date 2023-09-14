#include <stdint.h>
#include "lab7.h"

int64_t dot_c(int64_t* arr1, int64_t* arr2, uint64_t n) {
    int64_t acc = 0;
    for (uint64_t i = 0; i < n; i++) {
        acc += arr1[i] * arr2[i];
    }
    return acc;
}

int64_t dot_struct_c(pair64_t* pairs, uint64_t n) {
    int64_t acc = 0;
    for (uint64_t i = 0; i < n; i++) {
        acc += pairs[i].a * pairs[i].b;
    }
    return acc;
}
