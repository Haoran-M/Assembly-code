#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <x86intrin.h>
#include "lab7.h"

#define LENGTH 800000
#define REPS 1000

#define CODE_TEST(CODE) do { \
    int64_t total = 0; \
    elapsed = 0; \
    for(int i=0; i<REPS; i++) { \
        st = __rdtsc(); \
        total += CODE ; \
        en = __rdtsc(); \
        elapsed += en - st; \
    } \
    printf("%35s calculated %16ld in %5.2f cycles/elt\n", #CODE, total, (double)(elapsed)/LENGTH/REPS); \
} while(0)

int64_t __attribute__((noinline)) warmup(int64_t n) {
    int64_t total = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < LENGTH; j++) {
            total += i - j;
        }
    }
    return total;
}

int main(void) {
    uint64_t elapsed;
    uint64_t st, en;

    // Do some meaningless work to wake up the processor (we hope)...
    CODE_TEST(warmup(LENGTH));

    int64_t* arr1 = (int64_t*)malloc(LENGTH * sizeof(int64_t));
    int64_t* arr2 = (int64_t*)malloc(LENGTH * sizeof(int64_t));
    fill_array(arr1, LENGTH);
    fill_array(arr2, LENGTH);

    assert(sizeof(pair64_t) == 2 * sizeof(int64_t));
    pair64_t* arr_pair = (pair64_t*)malloc(LENGTH * sizeof(pair64_t));
    // copy the arr1, arr2 contents over, so we're doing the same calculation
    for (uint64_t i = 0; i < LENGTH; i++) {
        arr_pair[i].a = arr1[i];
        arr_pair[i].b = arr2[i];
    }

    CODE_TEST(dot(arr1, arr2, LENGTH));
    CODE_TEST(dot_c(arr1, arr2, LENGTH));
    CODE_TEST(dot_struct(arr_pair, LENGTH));
    CODE_TEST(dot_struct_c(arr_pair, LENGTH));

    free(arr1);
    free(arr2);
    free(arr_pair);
    return 0;
}
