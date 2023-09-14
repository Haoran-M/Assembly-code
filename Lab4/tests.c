#include <stdio.h>
#include <stdint.h>
#include "lab4.h"

int main() {
    int64_t two62 = 1L<<62;  // == 2^62
    printf("is_prime(2) == 1 == %lu\n", is_prime(2));
    printf("is_prime(6) == 0 == %lu\n", is_prime(6));
    printf("is_prime(7) == 1 == %lu\n", is_prime(7));
    printf("is_prime(3083) == 1 == %lu\n", is_prime(3083));
    printf("is_prime(1472741) == 0 == %lu\n", is_prime(1472741));
    
    printf("largest_power_unsigned(3) == 12157665459056928801 == %lu\n", largest_power_unsigned(3));
    printf("largest_power_unsigned(7) == 3909821048582988049 == %lu\n", largest_power_unsigned(7));
   
    printf("overflowing_subtract(10, 3) == 7 == %li\n", overflowing_subtract(10, 3));
    printf("overflowing_subtract(two62, two62-3) == 3 == %li\n", overflowing_subtract(two62, two62-3));
    printf("overflowing_subtract(-two62, two62) == -9223372036854775808 == %li\n", overflowing_subtract(-two62, two62));
    printf("overflowing_subtract(two62, -two62) == 0 == %li\n", overflowing_subtract(two62, -two62));
    // The next case is a signed overflow but *not* an unsigned overflow...
    printf("overflowing_subtract(-two62, two62+1) == 0 == %li\n", overflowing_subtract(-two62, two62+1));
    
    printf("dumb(0, 5) == 5 == %li\n", dumb(0, 5));
    printf("dumb(7, 0) == 7 == %li\n", dumb(7, 0));
    printf("dumb(3, 5) == 32 == %li\n", dumb(3, 5));
    printf("dumb(17, 63) == 2069 == %li\n", dumb(17, 63));
    

}
