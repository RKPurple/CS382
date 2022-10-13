// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start

_start:
    ADR X0, src_str // Load Address of the source string into X0
    ADR X1, dst_str // Load address of the destination string in X1
    MOV X10, 0 // i = 0
    MOV X11, 1 // incrementer

    L1:
    LDRB W2, [X0, X10] // get the ith character of src_str
    CBZ W2, end // Check for null terminator, and end function if its there 
    STR W2, [X1, X10] // store the character at the current index of src string into the corresponding index of destination string
    ADD X10, X10, X11 // Increment i by 1 each time
    B L1 // Loop

    end:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */



.data
src_str: .string "I love 382 and assembly!" // Source string

.bss
dst_str: .skip 100 // Destination string
