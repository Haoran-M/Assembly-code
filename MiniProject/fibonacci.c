
int fib_dynamic_cache(int n) {
    if (n <= 0)
        return 0;
    if (n == 1)
        return 1;

    int prev_prev = 0; // The (n-2)th Fibonacci number
    int prev = 1;      // The (n-1)th Fibonacci number
    int result = 0;    // The nth Fibonacci number

    for (int i = 2; i <= n; i++) {
        result = prev + prev_prev;
        prev_prev = prev;
        prev = result;
    }

    return result;
}
