
// Haoran Miao , 301542189 , hma98@sfu.ca


#include <stdint.h>
#include "array_sum.h"
int32_t array_sum(int32_t *arr, uint32_t n){
    int total = 0;
    int i = 0;
    while(i<n){
        total += arr[i];
        i++;
    }
    return total;
}