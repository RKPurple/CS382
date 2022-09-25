// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.
#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    unsigned int x;
    int i;
    for (i = 31; i >= 0; i--) {
        x = 1 << i;
        (num & x) ? display(1) : display(0);
    }
}

int main(int argc, char const *argv[]) {
    display_32(1993);
    return 0;
}
