#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "utf8.h"

#include "test_strings.c"

// setting the USE_GDBM macro will turn on usage of the Unicode character database created by chardb_prep.py
#ifdef USE_GDBM
    #include <gdbm.h>
    #define DATABASE_FILENAME "UnicodeData.gdbm"
    #define NAME_LENGTH 100
    GDBM_FILE gdbf;
#endif
const char* MISSING = "?";

void report_character(uint32_t n, uint8_t n_bytes) {
#ifdef USE_GDBM
    // get a 8-hexit representation as our database key
    char hexrepr[9];
    snprintf(hexrepr, 9, "%08X", n);
    datum key, content;
    char name[NAME_LENGTH];
    key.dptr = hexrepr;
    key.dsize = 8;

    // look it up in the character database
    content = gdbm_fetch(gdbf, key);
    if (content.dptr != NULL) {
        assert(content.dsize < NAME_LENGTH);
        strncpy(name, content.dptr, content.dsize);
        name[content.dsize] = '\0';
    } else {
        strncpy(name, MISSING, NAME_LENGTH - 1);
    }
    // produce the output
    printf("<li><a href=\"https://symbl.cc/en/%04x/\">U+%04X</a> <span class=\"char\">&#x%x;</span>&nbsp;(<span class=\"name\">%s</span>, %i bytes)</li>\n", n, n, n, name, n_bytes);
#else
    // produce the output
    printf("<li><a href=\"https://symbl.cc/en/%04x/\">U+%04X</a> <span class=\"char\">&#x%x;</span>&nbsp;(%i bytes)</li>\n", n, n, n, n_bytes);
#endif
}

void print_header() {
    printf("<!DOCTYPE html>\n<html lang=\"en\"><head><meta charset=\"UTF-8\" /><title>Unicode Characters</title><style>li { line-height: 1.4em;} span.char { overflow: clip; padding: 0.05em 0.5em; border: 1px solid #bbb; border-radius: 0.2em; } span.name { font-style: italic; }</style></head><body><h1>Unicode Characters</h1>\n<ul>\n");
}

void print_footer() {
    printf("</ul></body></html>\n");
}


int main() {
#ifdef USE_GDBM
    gdbf = gdbm_open(DATABASE_FILENAME, 0, GDBM_READER, 0, NULL);
    if (gdbf == NULL) {
        printf("Can't open database.\n");
        return 1;
    }
#endif
    print_header();
    for (unsigned i = 0; i < n_strings; i++) {
        const char* s = strings[i];
        decode_utf8(s);
    }
    print_footer();
#ifdef USE_GDBM
    gdbm_close(gdbf);
#endif
    return 0;
}
