#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "lab7.h"

int main() {
    uint64_t n = 1000;
    int64_t* arr = (int64_t*)malloc(n * sizeof(int64_t));

    printf("randint() == %lu\n", randint());
    printf("randint() == %lu\n", randint());
    printf("randint() == %lu\n", randint());
    fill_array(arr, n);
    printf("arr[0] == %li\n", arr[0]);
    printf("arr[1] == %li\n", arr[1]);
    printf("arr[2] == %li\n", arr[2]);
    printf("arr[3] == %li\n", arr[3]);

    int64_t arr1[4] = {1, 2, 3, 5};
    int64_t arr2[4] = {4, 5, 10, 20};
    printf("{1, 2, 3, 5} . {4, 5, 10, 20} == %li\n", dot(arr1, arr2, 4));

    pair64_t arr_struct[4] = {{1, 4}, {2, 5}, {3, 10}, {5, 20}};
    printf("same, but array of structs    == %li\n", dot_struct(arr_struct, 4));

    free(arr);
    
    return 0;
}
