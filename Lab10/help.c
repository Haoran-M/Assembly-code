#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include "lab10.h"

double dot_double(double* arr1, double* arr2, uint64_t length) {
    double total = 0.0;
    for (uint64_t i = 0; i < length; i++) {
        total += arr1[i] * arr2[i];
    }
    return total;
}


void map_poly_double(double* input, double* output, uint64_t length, double a, double b, double c, double d) {
    for (uint64_t i = 0; i < length; i++) {
        double x = input[i];
        output[i] =  a*x*x*x + b*x*x + c*x + d;
    }
}

float dot_single(float* arr1, float* arr2, uint64_t length) {
    float total = 0.0;
    for (uint64_t i = 0; i < length; i++) {
        total += arr1[i] * arr2[i];
    }
    return total;
}


void map_poly_single(float* input, float* output, uint64_t length, float a, float b, float c, float d) {
    for (uint64_t i = 0; i < length; i++) {
        float x = input[i];
        output[i] = ((a*x + b)*x + c)*x + d;
    }
}