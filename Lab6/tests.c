#include <stdio.h>
#include <stdint.h>
#include "lab6.h"

#include "test_strings.c"

int main() {
    for (unsigned i = 0; i < n_strings; i++) {
        char* s = strings[i];
        printf("strlen_mine(\"%s\") == %ld == %ld\n", s, byte_lengths[i], strlen_mine(s));
        printf("strlen_utf8(\"%s\") == %ld == %ld\n", s, utf8_lengths[i], strlen_utf8(s));
    }
    return 0;
}
