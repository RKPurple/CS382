// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start
.extern printf

_start:
    ADR X2, arr // Load address of arr into X2
    ADR X3, length // Load address of length into X3
    LDR X3, [X3] // Load value of length into X3
    LDR X19, [X2, 0] // load first element into x19
    BL recurse // recursion
    MOV X1, X19 // move the max into X1
    ADR X0, outstr // address of string to be printed
    BL printf // print it
    BL exit // end

recurse:
    SUB X3, X3, #1 // increment by 1
    LSL X4, X3, 3 // multiply by 8
    LDR X1, [X2, X4] // load element of the array
    SUB SP, SP, #16 // allocate memory
    STR LR, [SP, #8] // store the link register
    STR X1, [SP, #0] // store value of X1 into SP
    CMP X3, XZR // compare length to 0
    B.LE S // base case
    BL recurse // recursion

S:
    LDR X1, [SP, #0]
    CMP X1, X19 // compare the current element value to stored max
    B.GT newMax // if current element > max
    LDR LR, [SP, #8] // load LR from stack
    ADD SP, SP, #16 // go next iteration
    RET // return
newMax:
    MOV X19, X1 // load new max into max storage
    LDR LR, [SP, #8] // load the link register
    ADD SP, SP, #16 // add back the sp
    RET // return

exit:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
arr: .quad -7, 52, 0, -32, 41, 4
length: .quad 6
outstr: .string "%ld\n"
