#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <x86intrin.h>
#include "array_sum.h"

int main(int argc, char *argv[]) {
    // Get array size from command line
    if ( argc < 2 ) {
        printf("Must give integer on command line for array size.\n");
        return 2;
    }
    size_t n = atoi(argv[1]);
    
    // Create and fill array.
    // Uses rand() unseeded, unless next line is un-commented.
    //srand(time(NULL)); 
    int32_t *arr = malloc(n*sizeof(int32_t));
    if ( arr == NULL ) {
        printf("Can't allocate memory.\n");
        return 1;
    }
    for(int i=0; i<n; i++) {
        arr[i] = rand() % 10;
    }
    
    // Sum array values several times, timing each one.
    int32_t total;
    for(int i=0; i<10; i++) {
        uint64_t st = __rdtsc();
        total = array_sum(arr, n);
        uint64_t en = __rdtsc();
        uint64_t elapsed = en - st;
        printf("calculated %d in %g cycles\n", total, (double)elapsed);
    }
    
    return 0;
}
