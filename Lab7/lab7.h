#ifndef LAB7_H
#define LAB7_H

#include <stdint.h>

typedef struct {
   int64_t a;
   int64_t b;
} pair64_t;

uint64_t randint(void);
void fill_array(int64_t* array, uint64_t length);
int64_t dot(int64_t* arr1, int64_t* arr2, uint64_t n);
int64_t dot_struct(pair64_t* pairs, uint64_t n);
int64_t dot_c(int64_t* arr1, int64_t* arr2, uint64_t n);
int64_t dot_struct_c(pair64_t* pairs, uint64_t n);

#endif
