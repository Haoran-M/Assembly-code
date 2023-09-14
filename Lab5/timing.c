#include <stdio.h>
#include <stdint.h>
#include <x86intrin.h>
#include "lab5.h"

#define REPS 10000000

#define CODE_TEST(CODE) do { \
    int64_t total = 0; \
    elapsed = 0; \
    for(int i=0; i<REPS; i++) { \
        st = __rdtsc(); \
        total += CODE + CODE + CODE + CODE + CODE + CODE + CODE + CODE + CODE + CODE; \
        en = __rdtsc(); \
        elapsed += en - st; \
    } \
    printf("%23s calculated %16ld in %12ld cycles\n", #CODE, total, elapsed - overhead); \
} while(0)

int64_t __attribute__((noinline)) warmup(int64_t n) {
    return n;
}

int main() {
    uint64_t elapsed, overhead = 0;
    uint64_t st, en;

    // Some fibonacci tests to avoid needing another .c program for this lab...
    printf("%ld %ld %ld %ld %ld %ld %ld %ld %ld %ld\n", fibonacci(0), fibonacci(1),
           fibonacci(2), fibonacci(3), fibonacci(4), fibonacci(5), fibonacci(6),
           fibonacci(7), fibonacci(8), fibonacci(9));
    printf("fibonacci(35) == 9227465 == %ld\n", fibonacci(35));

    // Do some meaningless work to wake up the processor (we hope)...
    CODE_TEST(warmup(1));
    CODE_TEST(warmup(2));
    CODE_TEST(warmup(3));
    CODE_TEST(warmup(4));
    CODE_TEST(warmup(5));
    /*
    Count that last run time as the overhead needed to just call the functions
    that many times and do the accounting. Subtract that off subsequent runs, to
    try to approximate the time to run the operations themselves.
    */
    overhead = elapsed;

   CODE_TEST(polynomial1(3,2,7,-1,2));
    CODE_TEST(polynomial2(3,2,7,-1,2));
    CODE_TEST(polynomial3(3,2,7,-1,2));

   CODE_TEST(is_odd1(7) + is_odd1(8));
   CODE_TEST(is_odd2(7) + is_odd2(8));
    CODE_TEST(is_odd3(7) + is_odd3(8));

    CODE_TEST(mul1(123));
    CODE_TEST(mul2(123));
    CODE_TEST(mul3(123));

    return 0;
}
