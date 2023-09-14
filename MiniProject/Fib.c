#include <stdio.h>
#include <time.h>
#include <x86intrin.h>
#include <stdint.h>

#define BILLION 1000000000L

int fib_dynamic(int n) {
    int f[n + 2]; // 1 extra to handle case, n = 0
    int i;

    f[0] = 0;
    f[1] = 1;

    for (i = 2; i <= n; i++) {
        f[i] = f[i - 1] + f[i - 2];
    }

    return f[n];
}

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

extern int fib(int n);
extern int fib_mod(int n);

uint64_t measureCycles(int (*func)(int), int n) {
    uint64_t start_time, end_time;
    start_time = __rdtsc();
    int result = func(n);
    end_time = __rdtsc();

    printf("Result: %d\n", result);
    return end_time - start_time;
}

double measureTime(int (*func)(int), int n) {
    clock_t start_time, end_time;
    start_time = clock();
    int result = func(n);
    end_time = clock();

    double elapsed_time = (double)(end_time - start_time) * 1000.0 / CLOCKS_PER_SEC; // Convert to milliseconds

    printf("Result: %d\n", result);
    return elapsed_time;
}

int main() {
    int n = 40; // You can change this value to test different Fibonacci numbers
    int num_runs = 20;
    double time_fib = 0.0;
    double time_fib_mod = 0.0;
    double time_dynamic = 0.0;
    double time_dynamic_cache = 0.0;
    uint64_t cycles_fib = 0;
    uint64_t cycles_fib_mod = 0;
    uint64_t cycles_dynamic = 0;
    uint64_t cycles_dynamic_cache = 0;

    for (int i = 0; i < num_runs; i++) {
        printf("\nRun %d:\n", i + 1);

        printf("\nFibonacci assembly:\n");
        time_fib += measureTime(fib, n);
        cycles_fib += measureCycles(fib, n);

        printf("\nFib mod assembly:\n");
        time_fib_mod += measureTime(fib_mod, n);
        cycles_fib_mod += measureCycles(fib_mod, n);

        printf("\nFibonacci using Dynamic Programming:\n");
        time_dynamic += measureTime(fib_dynamic, n);
        cycles_dynamic += measureCycles(fib_dynamic, n);

        printf("\nFibonacci using Dynamic Programming with caching:\n");
        time_dynamic_cache += measureTime(fib_dynamic_cache, n);
        cycles_dynamic_cache += measureCycles(fib_dynamic_cache, n);
    }

    time_fib /= num_runs;
    time_fib_mod /= num_runs;
    time_dynamic /= num_runs;
    time_dynamic_cache /= num_runs;
    cycles_fib /= num_runs;
    cycles_fib_mod /= num_runs;
    cycles_dynamic /= num_runs;
    cycles_dynamic_cache /= num_runs;

    printf("\nAverage Results:\n");

    printf("\nFibonacci assembly:\n");
    printf("Average Time taken: %.3f milliseconds\n", time_fib);
    printf("Average Cycles taken: %lu\n", cycles_fib);

    printf("\nFib mod assembly:\n");
    printf("Average Time taken: %.3f milliseconds\n", time_fib_mod);
    printf("Average Cycles taken: %lu\n", cycles_fib_mod);

    printf("\nFibonacci using Dynamic Programming:\n");
    printf("Average Time taken: %.3f milliseconds\n", time_dynamic);
    printf("Average Cycles taken: %lu\n", cycles_dynamic);

    printf("\nFibonacci using Dynamic Programming with caching:\n");
    printf("Average Time taken: %.3f milliseconds\n", time_dynamic_cache);
    printf("Average Cycles taken: %lu\n", cycles_dynamic_cache);

    return 0;
}
