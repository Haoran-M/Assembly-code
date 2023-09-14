/*
This code implements some useful functions that (1) can be called from assembly code,
and (2) do not rely on any C standard library logic, so it can be linked with easily
with ld, and also be very clean if looking carefully in a debugger.

Possible usage:
    gcc -Og -c helpers.c -o helpers.o
    as --warn yourcode.S -o yourcode.o
    ld helpers.o yourcode.o -o yourcode
    ./yourcode
*/

#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/syscall.h>

#define BLEN 100  // at least long enough to hold any of our representations
char buffer[BLEN];
char* digits = "0123456789abcdef";


// from musl https://github.com/kraj/musl/blob/kraj/master/arch/x86_64/syscall_arch.h
static __inline long __syscall1(long n, long a1)
{
	unsigned long ret;
	__asm__ __volatile__ ("syscall" : "=a"(ret) : "a"(n), "D"(a1) : "rcx", "r11", "memory");
	return ret;
}

// from musl https://github.com/kraj/musl/blob/kraj/master/arch/x86_64/syscall_arch.h
static __inline long __syscall3(long n, long a1, long a2, long a3)
{
	unsigned long ret;
	__asm__ __volatile__ ("syscall" : "=a"(ret) : "a"(n), "D"(a1), "S"(a2),
						  "d"(a3) : "rcx", "r11", "memory");
	return ret;
}

char* to_base(uint64_t v, short base, char ending) {
	// Build representation of v in given base, right-to-left in buffer.
    unsigned char c;
    char* pos = buffer + BLEN - 2;
    buffer[BLEN-1] = ending;
    do {
        c = v % base;
        *pos = digits[c];
        v /= base;
        pos--;
    } while ( v != 0 );
    return pos;
}

int64_t print_uint64(uint64_t v) {
    char* pos = to_base(v, 10, '\n');
    return __syscall3(SYS_write, STDOUT_FILENO, (long)pos+1, buffer + BLEN - pos - 1);
}

int64_t print_uint64_with_hex(uint64_t v) {
    int64_t res1, res2;

    char* pos = to_base(v, 10, ' ');
    res1 = __syscall3(SYS_write, STDOUT_FILENO, (long)pos+1, buffer + BLEN - pos - 1);
    if ( res1 < 0 ) {
        return res1;
    }

    pos = to_base(v, 16, '\n');
    *pos = 'x';
    *(pos-1) = '0';
    res2 = __syscall3(SYS_write, STDOUT_FILENO, (long)pos-1, buffer + BLEN - pos + 1);
    if ( res2 < 0 ) {
        return res2;
    }
    
    return res1 + res2;
}

int64_t print_uint64_with_binary(uint64_t v) {
    int64_t res1, res2;

    char* pos = to_base(v, 10, ' ');
    res1 = __syscall3(SYS_write, STDOUT_FILENO, (long)pos+1, buffer + BLEN - pos - 1);
    if ( res1 < 0 ) {
        return res1;
    }

    pos = to_base(v, 2, '\n');
    *pos = 'b';
    *(pos-1) = '0';
    res2 = __syscall3(SYS_write, STDOUT_FILENO, (long)pos-1, buffer + BLEN - pos + 1);
    if ( res2 < 0 ) {
        return res2;
    }
    
    return res1 + res2;
}

uint64_t print_int64(int64_t v) {
    char negative = false;
    if ( v < 0 ) {
        negative = true;
        v *= -1;
    }
	char* pos = to_base(v, 10, '\n');
    if ( negative ) {
        *pos = '-';
        pos--;
    }
    
    return __syscall3(SYS_write, STDOUT_FILENO, (long)pos+1, buffer + BLEN - pos - 1);
}

void syscall_exit(int64_t exit_code) {
	// exit the process with the given exit code
	__syscall1(SYS_exit, exit_code);
}
