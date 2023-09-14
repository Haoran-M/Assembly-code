#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lab11.h"

void print_double_array(double* array, uint64_t length) {
    printf("{ ");
    for (uint64_t i = 0; i < length; i++) {
        printf("%.6g ", array[i]);
    }
    printf("}\n");
}

void print_single_array(float* array, uint64_t length) {
    printf("{ ");
    for (uint64_t i = 0; i < length; i++) {
        printf("%.6g ", array[i]);
    }
    printf("}\n");
}

int main(void) {
    uint64_t length = 16;
    double* doubles1 = create_array(length);
    double* doubles2 = create_array(length);
    double* double_out = (double*)malloc(length * sizeof(double));
    float* singles1 = to_single(doubles1, length);
    float* singles2 = to_single(doubles2, length);
    float* single_out = (float*)malloc(length * sizeof(float));

    assert(doubles1 != NULL);
    assert(doubles2 != NULL);
    assert(double_out != NULL);
    assert(singles1 != NULL);
    assert(singles2 != NULL);
    assert(single_out != NULL);

    printf("dot_double_c result:   %g\n", dot_double_c(doubles1, doubles2, length));
    printf("dot_double result:     %g\n", dot_double(doubles1, doubles2, length));
    printf("dot_double_vec result: %g\n", dot_double_vec(doubles1, doubles2, length));
    printf("dot_double_vc result:  %g\n", dot_double_vc(doubles1, doubles2, length));
    printf("dot_single_c result:   %g\n", dot_single_c(singles1, singles2, length));
    printf("dot_single result:     %g\n", dot_single(singles1, singles2, length));
    printf("dot_single_vec result: %g\n", dot_single_vec(singles1, singles2, length));
    printf("dot_single_vc result:  %g\n", dot_single_vc(singles1, singles2, length));

    //printf("map_poly_* inputs:\n");
    //print_double_array(doubles1, length);

    map_poly_double_c1(doubles1, double_out, length, 4, 5, 6, 7);
    printf("map_poly_double_c1 result:\n");
    print_double_array(double_out, length);

    printf("map_poly_double result:\n");
    // make sure the results are really from the next run, not leftovers.
    memset(double_out, 0, length * sizeof(double));
    map_poly_double(doubles1, double_out, length, 4, 5, 6, 7);
    print_double_array(double_out, length);
    
    printf("map_poly_double_vec result:\n");
    memset(double_out, 0, length * sizeof(double));
    map_poly_double_vec(doubles1, double_out, length, 4, 5, 6, 7);
    print_double_array(double_out, length);
        
    printf("map_poly_double_vc result:\n");
    memset(double_out, 0, length * sizeof(double));
    map_poly_double_vc(doubles1, double_out, length, 4, 5, 6, 7);
    print_double_array(double_out, length);
    

    printf("map_poly_single_c result:\n");
    map_poly_single_c(singles1, single_out, length, 4, 5, 6, 7);
    print_single_array(single_out, length);

    printf("map_poly_single result:\n");
    memset(single_out, 0, length * sizeof(float));
    map_poly_single(singles1, single_out, length, 4, 5, 6, 7);
    print_single_array(single_out, length);

    memset(single_out, 0, length * sizeof(float));
    printf("map_poly_single_vec result:\n");
    map_poly_single_vec(singles1, single_out, length, 4, 5, 6, 7);
    print_single_array(single_out, length);

    memset(single_out, 0, length * sizeof(float));
    printf("map_poly_single_vc result:\n");
    map_poly_single_vc(singles1, single_out, length, 4, 5, 6, 7);
    print_single_array(single_out, length);

    free(doubles1);
    free(doubles2);
    free(singles1);
    free(singles2);
    free(double_out);
    free(single_out);
    return 0;
}
