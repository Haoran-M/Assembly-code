#ifndef LAB11_H
#define LAB11_H

#include <stdint.h>

// "extern" allows calling C/assembly functions from C++ https://zakuarbor.github.io/blog/extern-c-name-mangling/
#ifdef __cplusplus
extern "C" {
#endif

double dot_double(double* arr1, double* arr2, uint64_t n);
double dot_double_vec(double* arr1, double* arr2, uint64_t n);
float dot_single(float* arr1, float* arr2, uint64_t n);
float dot_single_vec(float* arr1, float* arr2, uint64_t n);

void map_poly_double(double* input, double* output, uint64_t length, double a, double b, double c, double d);
void map_poly_single(float* input, float* output, uint64_t length, float a, float b, float c, float d);

void map_poly_double_vec(double* input, double* output, uint64_t length, double a, double b, double c, double d);
void map_poly_single_vec(float* input, float* output, uint64_t length, float a, float b, float c, float d);

#ifdef __cplusplus
}
#endif

double* create_array(uint64_t length);
float* to_single(double* doubles, uint64_t length);

double dot_double_c(double* arr1, double* arr2, uint64_t n);
float dot_single_c(float* arr1, float* arr2, uint64_t n);
void map_poly_double_c1(double* input, double* output, uint64_t length, double a, double b, double c, double d);
void map_poly_double_c2(double* input, double* output, uint64_t length, double a, double b, double c, double d);
void map_poly_single_c(float* input, float* output, uint64_t length, float a, float b, float c, float d);

double dot_double_vc(double* arr1, double* arr2, uint64_t n);
float dot_single_vc(float* arr1, float* arr2, uint64_t n);
void map_poly_double_vc(double* input, double* output, uint64_t length, double a, double b, double c, double d);
void map_poly_single_vc(float* input, float* output, uint64_t length, float a, float b, float c, float d);

#endif
