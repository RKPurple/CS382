// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf

_start:
    ADR X1, coeff // load the address of coefficent into X1
    ADR X2, N // Load n into X2
    LDR X2, [X2] // load value of N into X2
    ADR X3, tolerance // load address of tolerance into X3
    LDR D3, [X3] // load value of tolerance into D3
    ADR X4, a // load address of a into X4
    LDR D4, [X4] // load value of a into D4
    ADR X5, b // load address of b into X5
    LDR D5, [X5] // load value of b into D5
    ADR X28, one // load address into x28
    LDR D28, [X28] // load value of 1 into D28
    ADR X27, negone // load address of negone into x27
    LDR D27, [X27] // load value of -1 into D27
    ADR X26, half // load address of half into x26
    LDR D26, [X26] // load value of 0.5 into D26
    ADR X25, zr // load address of zero into x25
    LDR D25, [X25] // load value of 0 into D25
    FMUL D6, D3, D27 // negative tolerance
    MOV X16, 0 // load value 0 into D16 (iterator i)
    MOV X17, 0 // load value 0 into d17 (exponent tracker)
    FMOV D19, D25 // Make f(c) = 0
    FMOV D21, D25 // make f(a) = 0
    BL new // find root function
    B end // print and end

new:
    FADD D0, D4, D5 // Add a and b into D0
    FMUL D0, D0, D26 // divide the sum of a and b by 2 to get midpoint c
    FMOV D20, D28 // current state of c exponent multiplaction
creatingfoa:
    CMP X16, X2 // compare the value of the iterator to the egree
    FMOV D20, D28 // reset d20 to 1
    B.LE foa // Branch to foa if i < degree
    MOV X16, 0 // reset i
    MOV X17, 0 // reset exponenet tracker
    FMOV D20, D28 // current state of c exponent multiplication
creatingfoc:
    CMP X16, X2 // compare the value of the iterator to the egree
    FMOV D20, D28 // reset d20 to 1
    B.LE foc // Branch to foc if i < degree
    FCMP D19, D3 // compare f(c) to tolerance
    B.LT checktolerance // check if f(c) is greater than -tolerance
    FMUL D23, D19, D21 // multiply f(c) and f(a) to determine signage
    FCMP D23, D25 // compare the signage to 0 if its less than they have oposite signs if its greater than they have the same
    B.LT swapbc
    FMOV D4, D0 // make a = c
    MOV X16, 0 // reset x16
    MOV X17, 0 // reset x17
    FMOV D19, D25 // Make f(c) = 0
    FMOV D21, D25 // make f(a) = 0
    B new // redo algo until it works

checktolerance:
    FCMP D19, D6 // compare f(c) to -tolerance
    B.GT foundtolerance // congrats you found your root
    FMUL D23, D19, D21 // multiply f(c) and f(a) to determine signage
    FCMP D23, D25 // compare the signage to 0 if its less than they have oposite signs if its greater than they have the same
    B.LT swapbc
    FMOV D4, D0 // make a = c
    MOV X16, 0 // reset x16
    MOV X17, 0 // reset x17
    FMOV D19, D25 // Make f(c) = 0
    FMOV D21, D25 // make f(a) = 0
    B new // redo algo until it works

swapbc:
    FMOV D5, D0 // make b = c
    MOV X16, 0 // reset x16
    MOV X17, 0 // reset x17
    FMOV D19, D25 // Make f(c) = 0
    FMOV D21, D25 // make f(a) = 0
    B new // redo algo until it works

foundtolerance:
    RET

/* Find f(a) and store it in D21*/
foa:
    LSL X15, X16, 3 // find the d16th element in the array coeff
    LDR D18, [X1, X15] // get the coeff for the current exponent
    CMP X16, XZR // compare the iterator to zero
    B.EQ consta // if i == 0  
expoa:
    CMP X17, X16 // compare the exponent tracker to i
    B.EQ endexpa // if expt tracker == i
    FMUL D20, D20, D4 // exponent multiplication
    ADD X17, X17, 1 // increment exponent tracker by 1  
    B expoa // return to the exponenet addition 
consta:
    FADD D21, D21, D18 // add to the total of f(a)
    ADD X16, X16, 1 // iterate 1
    MOV X17, 0 // reset exponent tracker
    B creatingfoa
endexpa:
    FMUL D20, D20, D18 // multiply the constant by the value of c to the exponent
    FADD D21, D21, D20 // add to f(c)
    ADD X16, X16, 1 // iterate 1
    MOV X17, 0 // reset exponent tracker
    B creatingfoa

 /* Find f(c) */
foc:
    LSL X15, X16, 3 // find the d16th element in the array coeff
    LDR D18, [X1, X15] // get the coeff for the current exponent
    CMP X16, XZR // compare the iterator to zero
    B.EQ const // if i == 0  
expo:
    CMP X17, X16 // compare the exponent tracker to i
    B.EQ endexp // if expt tracker == i
    FMUL D20, D20, D0 // exponent multiplication
    ADD X17, X17, 1 // increment exponent tracker by 1
    B expo // return to the exponenet addition 
const:
    FADD D19, D19, D18 // add to the total of f(c)
    ADD X16, X16, 1 // iterate 1
    MOV X17, 0 // reset exponent tracker
    B creatingfoc
endexp:
    FMUL D20, D20, D18 // multiply the constant by the value of c to the exponent
    FADD D19, D19, D20 // add to f(c)
    ADD X16, X16, 1 // iterate 1
    MOV X17, 0 // reset exponent tracker
    B creatingfoc

end:
    FMOV D1, D19 // move value of f(root) into D2
    ADR X0, fmt_str // load address of string into x0
    BL printf
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
coeff: .double 0.2, 3.1, -0.3, 1.9, 0.2
N: .dword 4
tolerance: .double 0.01
a: .double -1
b: .double 1
one: .double 1
negone: .double -1
half: .double 0.5
zr: .double 0
fmt_str: .ascii "Root: %lf, f(root): %lf\n\0"
