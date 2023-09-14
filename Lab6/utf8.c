#include <cstdint>
#include <stdio.h>
#include "utf8.h"
// Haoran Miao 
// 301542189

void decode_utf8(const char* str) {
    const unsigned char* ptr = (const unsigned char*)str;

    while (*ptr != '\0') {
        uint32_t character = 0;
        uint8_t bytes = 0;

        // Determine the number of bytes
        if ((*ptr & 0x80) == 0x00) {
            character = *ptr;
            bytes = 1;
        } else if ((*ptr & 0xE0) == 0xC0) {
            character = *ptr & 0x1F;
            bytes = 2;
        } else if ((*ptr & 0xF0) == 0xE0) {
            character = *ptr & 0x0F;
            bytes = 3;
        } else if ((*ptr & 0xF8) == 0xF0) {
            character = *ptr & 0x07;
            bytes = 4;
        } else {
            // Invalid UTF-8 byte, skip to the next byte
            ptr++;
            continue;
        }

        // Extract the continuation bytes and build the character
        for (int i = 1; i < bytes; i++) {
            if ((ptr[i] & 0xC0) != 0x80) {
                // Invalid, skip to the next
                character = 0;
                break;
            }
            character = (character << 6) | (ptr[i] & 0x3F);
        }
        // Report the character
        report_character(character, bytes);
        // Move to the next character
        ptr += bytes;
    }
}
