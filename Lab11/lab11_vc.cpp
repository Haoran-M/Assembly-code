//Haoran Miao 
// 301542189
// hma98@sfu.ca

#include "vectorclass.h"

// Dot product of two double precision arrays using SIMD instructions
double dot_double_vc(double* a, double* b, unsigned long size) {
    Vec8d sum = 0.0;
    for (unsigned long i = 0; i < size; i += 8) {
        Vec8d va = Vec8d().load(a + i);
        Vec8d vb = Vec8d().load(b + i);
        sum += va * vb;
    }
    return horizontal_add(sum);
}

// Dot product of two single precision arrays using SIMD instructions
float dot_single_vc(float* a, float* b, unsigned long size) {
    Vec16f sum = 0.0f;
    for (unsigned long i = 0; i < size; i += 16) {
        Vec16f va = Vec16f().load(a + i);
        Vec16f vb = Vec16f().load(b + i);
        sum += va * vb;
    }
    return horizontal_add(sum);
}

// Map polynomial to double precision array using SIMD instructions
void map_poly_double_vc(double* arr, double* result, unsigned long size, double a, double b, double c, double d) {
    Vec8d av(a);
    Vec8d bv(b);
    Vec8d cv(c);
    Vec8d dv(d);

    for (unsigned long i = 0; i < size; i += 8) {
        Vec8d va = Vec8d().load(arr + i);
        Vec8d va_cubed = va * va * va;
        Vec8d result_vec = (av * va_cubed) + (bv * va * va) + (cv * va) + dv;
        result_vec.store(result + i);
    }
}

// Map polynomial to single precision array using SIMD instructions
void map_poly_single_vc(float* arr, float* result, unsigned long size, float a, float b, float c, float d) {
    Vec16f av(a);
    Vec16f bv(b);
    Vec16f cv(c);
    Vec16f dv(d);

    for (unsigned long i = 0; i < size; i += 16) {
        Vec16f va = Vec16f().load(arr + i);
        Vec16f va_cubed = va * va * va;
        Vec16f result_vec = (av * va_cubed) + (bv * va * va) + (cv * va) + dv;
        result_vec.store(result + i);
    }
}
