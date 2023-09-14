#include <stdio.h>

extern int abc(int a, int b);

int main() {
    int a = 5;
    int b = 10;
    int result = abc(a, b);

    printf("Result: %d\n", result);

    return 0;
}
