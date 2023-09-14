# 0 "fibonacci.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "fibonacci.c"

int fib_dynamic_cache(int n) {
    if (n <= 0)
        return 0;
    if (n == 1)
        return 1;

    int prev_prev = 0;
    int prev = 1;
    int result = 0;

    for (int i = 2; i <= n; i++) {
        result = prev + prev_prev;
        prev_prev = prev;
        prev = result;
    }

    return result;
}
