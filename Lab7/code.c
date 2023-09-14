#include <stdint.h>


typedef struct {
   int64_t a;
   int64_t b;
} pair64_t;

// Pseudo-random number generator
static uint64_t seed = 0;

uint64_t randint() {
    seed = seed * 6364136223846793005 + 1442695040888963407;
    return seed;
}

// Fill array with random values
void fill_array(int64_t* array, int64_t num_elements) {
    for (int64_t i = 0; i < num_elements; i++) {
        array[i] = (randint() & 0xFF) - 128;
    }
}

// Dot product of two arrays
int64_t dot(const int64_t* arr1, const int64_t* arr2, int64_t length) {
    int64_t result = 0;
    for (int64_t i = 0; i < length; i++) {
        result += arr1[i] * arr2[i];
    }
    return result;
}

// Dot product of an array of pair64_t
int64_t dot_struct(const pair64_t* array, int64_t length) {
    int64_t result = 0;
    for (int64_t i = 0; i < length; i++) {
        result += array[i].a * array[i].b;
    }
    return result;
}
