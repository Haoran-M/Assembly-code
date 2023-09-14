#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include "lab11.h"

#define DOT_LENGTH        20000000
#define POLYNOMIAL_LENGTH 10000000

#define TIMING_RESULT(DESCR, CODE) do { \
    struct timespec start, end; \
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start); \
    CODE; \
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end); \
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; \
    printf("%25s took %7.1f ms\n", descr, elapsed * 1000); \
} while(0)


void dot_speed_double(const char* descr, double dot_prod(double*, double*, uint64_t), uint64_t length) {
    double* d1 = create_array(length);
    assert(d1 != NULL);
    double* d2 = create_array(length);
    assert(d2 != NULL);

    TIMING_RESULT(descr, dot_prod(d1, d2, length));

    free(d1);
    free(d2);
}

void dot_speed_single(const char* descr, float dot_prod(float*, float*, uint64_t), uint64_t length) {
    double* d1 = create_array(length);
    assert(d1 != NULL);
    double* d2 = create_array(length);
    assert(d2 != NULL);
    float* s1 = to_single(d1, length);
    assert(s1 != NULL);
    float* s2 = to_single(d2, length);
    assert(s2 != NULL);

    TIMING_RESULT(descr, dot_prod(s1, s2, length));

    free(d1);
    free(d2);
    free(s1);
    free(s2);
}


void polynomial_speed_double(const char* descr, void polynomial_eval(double*, double*, uint64_t, double, double, double, double), uint64_t length) {
    double* doubles = create_array(length);
    assert(doubles != NULL);
    double* out = (double*)malloc(length * sizeof(double));
    assert(out != NULL);

    TIMING_RESULT(descr, polynomial_eval(doubles, out, length, 6.0, 7.0, 8.0, 9.0));

    free(doubles);
    free(out);
}

void polynomial_speed_single(const char* descr, void polynomial_eval(float*, float*, uint64_t, float, float, float, float), uint64_t length) {
    double* doubles = create_array(length);
    assert(doubles != NULL);
    float* singles = to_single(doubles, length);
    assert(singles != NULL);
    float* out = (float*)malloc(length * sizeof(float));
    assert(out != NULL);

    TIMING_RESULT(descr, polynomial_eval(singles, out, length, 6.0, 7.0, 8.0, 9.0));

    free(doubles);
    free(singles);
    free(out);
}

int main(void) {
    dot_speed_double("warmup", dot_double_c, DOT_LENGTH);
    dot_speed_double("warmup", dot_double_c, DOT_LENGTH);

    dot_speed_double("dot_double_c", dot_double_c, DOT_LENGTH);
    dot_speed_double("dot_double", dot_double, DOT_LENGTH);
    dot_speed_double("dot_double_vec", dot_double_vec, DOT_LENGTH);
    dot_speed_double("dot_double_vc", dot_double_vc, DOT_LENGTH);
    putchar('\n');
    dot_speed_single("dot_single_c", dot_single_c, DOT_LENGTH);
    dot_speed_single("dot_single", dot_single, DOT_LENGTH);
    dot_speed_single("dot_single_vec", dot_single_vec, DOT_LENGTH);
    dot_speed_single("dot_single_vc", dot_single_vc, DOT_LENGTH);
    putchar('\n');

    polynomial_speed_double("map_poly_double_c1", map_poly_double_c1, POLYNOMIAL_LENGTH);
    polynomial_speed_double("map_poly_double_c2", map_poly_double_c2, POLYNOMIAL_LENGTH);
    polynomial_speed_double("map_poly_double", map_poly_double, POLYNOMIAL_LENGTH);
    polynomial_speed_double("map_poly_double_vec", map_poly_double_vec, POLYNOMIAL_LENGTH);
    polynomial_speed_double("map_poly_double_vc", map_poly_double_vc, POLYNOMIAL_LENGTH);
    putchar('\n');
    polynomial_speed_single("map_poly_single_c", map_poly_single_c, POLYNOMIAL_LENGTH);
    polynomial_speed_single("map_poly_single", map_poly_single, POLYNOMIAL_LENGTH);
    polynomial_speed_single("map_poly_single_vec", map_poly_single_vec, POLYNOMIAL_LENGTH);
    polynomial_speed_single("map_poly_single_vc", map_poly_single_vc, POLYNOMIAL_LENGTH);

    return 0;
}
