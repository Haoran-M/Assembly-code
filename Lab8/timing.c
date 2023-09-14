// Enable clock_gettime: https://stackoverflow.com/a/40515669
#define _POSIX_C_SOURCE 199309L
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include "lab8.h"

#define HAILSTONE_ITERS 800000

void hailstone_speed(const char* descr, uint64_t hail_len(uint64_t)) {
    uint64_t total = 0;
    struct timespec start, end;

    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    for (uint64_t i = 1; i < HAILSTONE_ITERS; i++) {
        total += hail_len(i);
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("%25s calculated %10lu in %.3g ms\n", descr, total, elapsed * 1000);
}

int main(void) {
    hailstone_speed("warmup", hailstone_length_c);
    hailstone_speed("warmup", hailstone_length_c);
    hailstone_speed("warmup", hailstone_length_c);

    hailstone_speed("hailstone_length_c", hailstone_length_c);
    hailstone_speed("hailstone_length", hailstone_length);
    hailstone_speed("hailstone_length_cmov", hailstone_length_cmov);

    return 0;
}
