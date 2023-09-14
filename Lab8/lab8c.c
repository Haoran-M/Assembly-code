#include <stdint.h>
    
uint64_t hailstone_length_c(uint64_t n) {
    uint64_t count = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        count += 1;
    }
    return count;
}
