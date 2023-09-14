// https://stackoverflow.com/a/40515669
#define _POSIX_C_SOURCE 199309L
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <algorithm>
#include <cassert>
#ifdef USE_PDQSORT
    /*
    Want to try pdqsort too? https://github.com/orlp/pdqsort
    Get the header file:  wget https://raw.githubusercontent.com/orlp/pdqsort/master/pdqsort.h
    And add "-DUSE_PDQSORT" when compiling.
    */
    #include "pdqsort.h"
#endif

/*
#define DATA_T int64_t
#define DATA_PRINTF "%ld"
#define RAND_EXPR (rand() % 256 - 128)
*/
#define DATA_T double
#define DATA_PRINTF "%g"
#define RAND_EXPR ((double)rand() / RAND_MAX - 0.5)


// Haoran Miao
// 301542189
// hma98@sfu.ca


/*
*  Utility code to create appropriate arrays.
*/

enum array_ordering { RANDOM, SORTED, REVERSE_SORTED, ALMOST_SORTED };

void gently_shuffle_array(DATA_T* array, uint64_t length) {
    uint64_t limit = 10;
    // shuffle array indicies with nearby values
    for (uint64_t i = 0; i < length - limit - 1; i++) {
        uint64_t offset = rand() % limit;
        DATA_T tmp = array[i + offset];
        array[i + offset] = array[i];
        array[i] = tmp;
    }
}

DATA_T* create_array(uint64_t length, array_ordering order) {
    DATA_T* array = (DATA_T*)malloc(length * sizeof(DATA_T));
    if (array == NULL) {
        return NULL;
    }
    for (uint64_t i = 0; i < length; i++) {
        array[i] = RAND_EXPR;
    }

    // order the array as requested
    switch (order) {
    case RANDOM:
        break;
    case SORTED:
        std::sort(array, array + length);
        break;
    case ALMOST_SORTED:
        std::sort(array, array + length);
        gently_shuffle_array(array, length);
        break;
    case REVERSE_SORTED:
        std::sort(array, array + length);
        std::reverse(array, array + length);
        break;
    }
    return array;
}


/*
*  Library sorting implementations, adapted to have the same (DATA_T*, uint64_t) signature.
*/

int data_cmp(const void* a, const void* b) {
    // comparator function for qsort: https://en.cppreference.com/w/c/algorithm/qsort
    DATA_T arg1 = *(const DATA_T*)a;
    DATA_T arg2 = *(const DATA_T*)b;
    if (arg1 < arg2) return -1;
    if (arg1 > arg2) return 1;
    return 0;
}

void stdlib_qsort(DATA_T* array, uint64_t length) {
    qsort(array, length, sizeof(DATA_T), data_cmp);
}

void std_sort(DATA_T* array, uint64_t length) {
    // adapt std::sort to the interface the other functions use
    std::sort(array, array + length);
}

#ifdef USE_PDQSORT
void pdq_sort(DATA_T* array, uint64_t length) {
    // adapt pdqsort to the interface the other functions use
    pdqsort(array, array + length);
}
#endif


void bubble_sort(DATA_T* array, uint64_t length) {
    uint64_t i, j;
    DATA_T temp;
    for (i = 0; i < length - 1; i++) {
        for (j = 0; j < length - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                // Swap elements
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}



/*
*  Testing code.
*/

bool is_sorted(DATA_T* array, uint64_t length) {
    for (uint64_t i = 0; i < length - 1; i++) {
        if (array[i] > array[i + 1]) {
            return false;
        }
    }
    return true;
}

void time_sort(const char* descr, void(*sort)(DATA_T*, uint64_t), uint64_t length, array_ordering order) {
    struct timespec start, end;

    DATA_T* array = create_array(length, order);
    if (array == NULL) {
        printf("Couldn't allocate.\n");
        return;
    }

    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    sort(array, length);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end);
    assert(is_sorted(array, length));

    free(array);
    double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("%25s sorted %8lu values in %7.2f ms\n", descr, length, elapsed * 1000);
}

void time_them(uint64_t length) {
    time_sort("bubble_sort on sorted", bubble_sort, length, SORTED);
    time_sort("bubble_sort on reverse", bubble_sort, length, REVERSE_SORTED);
    time_sort("bubble_sort on random", bubble_sort, length, RANDOM);
    time_sort("qsort on random", stdlib_qsort, length, RANDOM);
    time_sort("std::sort on random", std_sort, length, RANDOM);
    #ifdef USE_PDQSORT
    time_sort("pdqsort on random", pdq_sort, length, RANDOM);
    time_sort("pdqsort on sorted", pdq_sort, length, SORTED);
    #endif
}

void just_sort(void(*sort)(DATA_T*, uint64_t), uint64_t length, array_ordering order) {
    DATA_T* array = create_array(length, order);
    if (array == NULL) {
        printf("Couldn't allocate.\n");
        return;
    }
    sort(array, length);
    assert(is_sorted(array, length));
    free(array);
}




int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Must give array size on command line.\n");
        return 1;
    }
    uint64_t length = atol(argv[1]);
    printf("Array size: %lu kB\n", length * sizeof(DATA_T) / 1024);
    
    // Try to get the CPU out of a low-power state...
    just_sort(bubble_sort, length, RANDOM);
   //just_sort(bubble_sort, length, RANDOM);
  // just_sort(bubble_sort, length, RANDOM);
    
    // The real test...
    time_them(length);

    return 0;
}


