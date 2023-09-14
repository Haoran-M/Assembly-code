#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#define BLEN 100
char buffer[BLEN];
char* digits = "0123456789abcdef";

uint64_t factorial(uint64_t n) {
    //Haoran Miao 301542189
    if ( n == 0 ) {
        return 1;
    } else {
        int m = n - 1;
        int result = factorial(m);
        result *= n;
        return result;
    }
}

char* to_base(uint64_t v, short base, char ending) {
    unsigned char c;
    char* pos = buffer + BLEN - 2;
    buffer[BLEN-1] = ending;
    do {
        c = v % base;
        *pos = digits[c];
        v /= base;
        pos--;
    } while ( v != 0 );
    return pos + 1;
}


int main(int argc, char *argv[]) {
    uint64_t f = factorial(6);
    printf("f = %ld\n", f);
    
    printf("0b%s\n", to_base(254, 2, '\0'));
    printf("%s\n", to_base(254, 10, '\0'));
    printf("0x%s\n", to_base(254, 16, '\0'));
    
    return 0;
}
