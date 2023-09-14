#include <stdint.h>
#include <stdlib.h>
#include "lab11.h"
#include "vectorclass.h"

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

// lab11_vc.cpp

#include "vectorclass.h"

// Dot product of two double precision arrays using SIMD instructions
double dot_double_vc(const double* a, const double* b, size_t size) {
    Vec8d sum = 0.0;
    for (size_t i = 0; i < size; i += 8) {
        Vec8d va = Vec8d().load(a + i);
        Vec8d vb = Vec8d().load(b + i);
        sum += va * vb;
    }
    return horizontal_add(sum);
}

// Dot product of two single precision arrays using SIMD instructions
float dot_single_vc(const float* a, const float* b, size_t size) {
    Vec16f sum = 0.0f;
    for (size_t i = 0; i < size; i += 16) {
        Vec16f va = Vec16f().load(a + i);
        Vec16f vb = Vec16f().load(b + i);
        sum += va * vb;
    }
    return horizontal_add(sum);
}

// Map polynomial to double precision array using SIMD instructions
void map_poly_double_vc(double* arr, size_t size, double a, double b, double c) {
    Vec8d av(a);
    Vec8d bv(b);
    Vec8d cv(c);

    for (size_t i = 0; i < size; i += 8) {
        Vec8d va = Vec8d().load(arr + i);
        Vec8d va_squared = va * va;
        Vec8d result = (av * va_squared) + (bv * va) + cv;
        result.store(arr + i);
    }
}

// Map polynomial to single precision array using SIMD instructions
void map_poly_single_vc(float* arr, size_t size, float a, float b, float c) {
    Vec16f av(a);
    Vec16f bv(b);
    Vec16f cv(c);

    for (size_t i = 0; i < size; i += 16) {
        Vec16f va = Vec16f().load(arr + i);
        Vec16f va_squared = va * va;
        Vec16f result = (av * va_squared) + (bv * va) + cv;
        result.store(arr + i);
    }
}

