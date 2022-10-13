// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.
.text
.global _start

_start:
    ADR X0, arr // Load the address of arr into X0
    ADR X1, length // Load the address of length into X1
    LDR W3, [X1] // Load the value of the length into W3
    MOV X2, 0 // front index
    LSL W3, W3, 2 // Multiply the length by 4
    MOV X4, 1 // incrementor
    SUB W3, W3, 1 // Last index of the element

loop:
    LDRB W5, [X0, X2] // Get the first two digits in the array
    LSR W7, W5, 4 // isolate the first nibble in order to put in second position
    AND W8, W5, 15 // store the two nibbles nad remove the first one
    LSL W8, W8, 4 // isolate second nibble to be put in first position
    ADD W5, W8, W7 // swap nibble placements

    LDRB W6, [X0, X3] // Get last two digits in the array
    LSR W9, W6, 4 // isolate the first nibble in order to put in second position
    AND W10, W6, 15 // store the two nibbles nad remove the first one
    LSL W10, W10, 4 // isolate second nibble to be put in first position
    ADD W6, W10, W9 // swap nibble placements

    STRB W6, [X0, X2] // Swap the bytes indexes
    STRB W5, [X0, X3] // swap bytes indexes

    ADD X2, X2, X4 // increment front counter by 1
    SUB X3, X3, X4 // decrease back counter by 1

    CMP X3, X2 // compare back to front counter
    B.LT end // go to end of code if back counter is less than front counter
    B loop // loop
    

end:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
arr: .word 0x12BFDA09, 0x9089CDBA, 0x56788910
length: .word 3
