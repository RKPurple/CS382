// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System.

.text
.global _start
.extern printf

_start:
    ADR X1, ending // load address of starting into X3
    LDR X1, [X1] // load value of starting into X3
    ADR X2, starting // load address of ending into X4
    LDR X2, [X2] // load value of ending into X4
    BL Recurse // start recursing
    BL exit // exit

Recurse:
    SUB X1, X1, #1 // subtract 1 from X4
    SUB SP, SP, #16 // Allocate space on stack pointer
    STR X1, [SP, #0] // Store the value of X2 (ending) into the stack pointer
    STR LR, [SP, #8] // Store Link register into the stack pointer
    CMP X1, X2 // Compare ending to starting
    B.LE S // recurse
    BL Recurse // base case

S:
    LDR X1, [SP, #0] // Load value you want to print into X1
    ADR X0, outstr // Load the address of string to X0
    BL printf // print out value
    LDR LR, [SP, #8] // Load the link register from the stack
    ADD SP, SP, #16 // Move stack pointer back up
    RET // return

exit:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
starting: .quad -10
ending: .quad -5
outstr: .string "%ld\n" 
