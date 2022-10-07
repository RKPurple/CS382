// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start

_start:
    ADR X0, p1 // Load Address of P1, into register X0
    ADR X1, p2 // Load Address of P2, into register X1
    ADR X2, p3 // Load address of p3, into register X2
    LDUR X3, [X0, 0] // Load the X coord of p1 to register X3
    LDUR X4, [X0, 8] // Load the Y coord of p1 to register X4
    LDUR X5, [X1, 0] // Load the X coord of p2 to register X5
    LDUR X6, [X1, 8] // Load the Y coord of p2 to register X6
    LDUR X7, [X2, 0] // Load the X coord of p3 to register X7
    LDUR X8, [X2, 8] // Load the Y coord of p3 to register X8

    SUB X9, X3, X5 // Find x distance from p1 to p2
    SUB X10, X4, X6 // Find y distance from p1 to p2
    MUL X9, X9, X9 // Square the x distance from p1 to p2
    MUL X10, X10, X10 // Square the y distance from p1 to p2
    ADD X11, X9, X10 // Add the squared x and y distances (distance from p1 to p2)

    SUB X9, X3, X7 // Find x distance from p1 to p3
    SUB X10, X4, X8 // Find y distance from p1 to p3
    MUL X9, X9, X9 // Square the x distance from p1 to p3
    MUL X10, X10, X10 // Square the y distance from p1 to p3
    ADD X12, X9, X10 // Add the squared x and y distances (distance from p1 to p3)

    SUB X9, X5, X7 // Find x distance from p2 to p3
    SUB X10, X6, X8 // Find y distance from p2 to p3
    MUL X9, X9, X9 // Square the x distance from p2 to p3
    MUL X10, X10, X10 // Square the y distance from p2 to p3
    ADD X13, X9, X10 // Add the squared x and y distances (distance from p2 to p3)

    ADD X14, X11, X12 // Add the distances together
    ADD X14, X14, X13 // Add distances together
    ADD X13, X13, X13 // Multiply the distance by 2
    ADD X12, X12, X12 // Multiply the distance by 2
    ADD X11, X11, X11 // Multiply the distance by 2
    SUB X15, X14, X13 // Subtract doubled distance from summed distances
    CBZ X15, W // goto Is a right triangle
    SUB X15, X14, X12 // Subtract doubled distance from summed distances
    CBZ X15, W // goto Is a right triangle
    SUB X15, X14, X11 // Subtract doubled distance from summed distances
    CBZ X15, W // goto Is a right triangle
    B L // goto Not a right triangle

    W:
    ADR X1, yes // Load yes into X1
    B end // Go to end code
    L:
    ADR X1, no // Load no into X1

    end:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */


.data
p1: .quad 0, -1
p2: .quad 0, 4
p3: .quad 3, 0
yes: .string "It is a right triangle."
no: .string "It is not a right triangle."
