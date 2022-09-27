// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.
.text
.global _start
.extern printf

_start:
    ADR X0, vec1 //Load vec1 array Address into register
    ADR X1, vec2 //Load vec2 array Address into register
    ADR X16, dot //Load long dot Address into register
    LDUR X2, [X0, 0] // Load the first element of array vec1 into register X2
    LDUR X3, [X1, 0] // Load the first element of array vec2 into register X3
    LDUR X4, [X0, 8] // Load the second element of array vec1 into register X4
    LDUR X5, [X1, 8] // Load the second element of array vec2 into register X5
    LDUR X6, [X0, 16] // Load the third element of array vec1 into register X6
    LDUR X7, [X1, 16] // Load the third element of array vec2 into register X7
    MUL X8, X2, X3 // Multiply the first two elements of the array and load it into X8
    MUL X9, X4, X5 // Multiply the second two elements of the array and then add the value stored in X8 and load it into X9
    MUL X10, X6, X7 // Multiply the third two elements of the array and then add the value stored in X9 and load it into X10
    ADD X11, X8, X9 // Add the products stored in register X8 and X9 into the register X11
    ADD X12, X11, X10 // Add the sum of the first two elements respective products in reg X11, with X10 the product of the third elements into reg X12 
    STUR X12, [X16] // Store the value in register X12 into the variable dot at address X16

    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
vec1: .quad 10, 20, 30
vec2: .quad 1, 2, 3
dot: .quad 0
