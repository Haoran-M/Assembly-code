#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include "lab10.h"

// Create an array of random doubles
double* create_array(uint64_t length) {
    double* array = (double*)malloc(length * sizeof(double));
    if (array == NULL) {
        return NULL;
    }
    for (uint64_t i = 0; i < length; i++) {
        array[i] = ((double)rand() / RAND_MAX - 0.25);
    }
    return array;
}

// Convert an array of doubles to an equivalent array of singles
float* to_single(double* doubles, uint64_t length) {
    float* floats = (float*)malloc(length * sizeof(float));
    if (floats == NULL) {
        return NULL;
    }
    for (uint64_t i = 0; i < length; i++) {
        floats[i] = (float)doubles[i];
    }
    return floats;
}

// equivalent-to-assembly implementations...

double dot_double_c(double* arr1, double* arr2, uint64_t length) {
    double total = 0.0;
    for (uint64_t i = 0; i < length; i++) {
        total += arr1[i] * arr2[i];
    }
    return total;
}

float dot_single_c(float* arr1, float* arr2, uint64_t length) {
    float total = 0.0;
    for (uint64_t i = 0; i < length; i++) {
        total += arr1[i] * arr2[i];
    }
    return total;
}

void map_poly_double_c1(double* input, double* output, uint64_t length, double a, double b, double c, double d) {
    for (uint64_t i = 0; i < length; i++) {
        double x = input[i];
        output[i] =  a*x*x*x + b*x*x + c*x + d;
    }
}

void map_poly_double_c2(double* input, double* output, uint64_t length, double a, double b, double c, double d) {
    for (uint64_t i = 0; i < length; i++) {
        double x = input[i];
        output[i] = ((a*x + b)*x + c)*x + d;
    }
}

void map_poly_single_c(float* input, float* output, uint64_t length, float a, float b, float c, float d) {
    for (uint64_t i = 0; i < length; i++) {
        float x = input[i];
        output[i] = ((a*x + b)*x + c)*x + d;
    }
}
