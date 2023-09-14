// This is a replacement main for your array-2d.c...

int main(int argc, char* argv[]) {
    if (argc < 3) {
        printf("Must give array size and height on command line.\n");
        return 1;
    }
    uint64_t n = atol(argv[1]);
    uint64_t h = atol(argv[2]);
    printf("Array size: %lu kB\n", n * sizeof(DATA_T) / 1024);
    
    if ( n % h != 0 ) {
        printf("n not divisible by h\n");
        return 1;
    }

    DATA_T* array = create_array(n);
    if (array == NULL) {
        printf("Couldn't allocate.\n");
        return 2;
    }
    time_result* res;

    uint64_t w = n / h;
    // treat array like it's h*w...
    res = time_it(sum_array_col, array, w, h);
    printf("Calculated " DATA_PRINTF " in %8.2f ms on %lu*%lu array.\n", res->result, res->elapsed_ms, w, h);
    free(res);
    free(array);
    return 0;
}
