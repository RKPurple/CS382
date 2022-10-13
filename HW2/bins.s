// Rohan Kallur
// I pledge my honor that I have abided by the Stevens Honor System
.text
.global _start
.extern printf

_start:
    ADR X2, arr // Load address of arr into x0
    ADR X3, length // load address of length into x1
    LDR X3, [X3] // load value of length into x1
    ADR X4, target // load address of target into x2
    LDR X4, [X4] // load value of target into x2
    MOV X5, 0 // Low variable
    MOV X6, X3 // High variable
    SUB X6, X6, 1 // High variable index

loop:
    CMP X6, X5 // Compare High and Low Var
    B.LT notInArray // Target not in Array
    ADD X7, X6, X5 // Add High and Low Vars
    LSR X7, X7, 1 // Div by two to find Mid Var
    LSL X7, X7, 3 // Multiply by 8 (arr is an integer)
    LDR X8, [X2, X7] // Load value of arr[mid]
    LSR X7, X7, 3 // Divide by 8 (find original index no)
    CMP X8, X4 // Compare X8 to X4
    B.EQ inArray // Target found
    B.LT Lower // If arr[mid] < target
    B.GT Higher // If arr[mid] > target

Lower:
    ADD X7, X7, 1 // Mid + 1
    MOV X5, X7 // Low = mid
    B loop

Higher:
    SUB X7, X7, 1 // Mid - 1
    MOV X6, X7 // High = Mid
    B loop

inArray:
    ADR X0, msg1 //store the string msg1 in X0
    MOV X1, X4 // Store target in X1
    BL printf // Print output
    B end

notInArray:
    ADR X0, msg2 // Store the string msg2 in X0
    MOV X1, X4 // Store target in X1
    BL printf // print output


end:
    /* Exit Function */
    MOV X0, 0 /* status := 0 */
    MOV X8, 93 /* exit is syscall #1 */
    SVC 0 /* Invoke syscall */

.data
arr: .quad -40, -25, -1, 0, 100, 300
length: .quad 6
target: .quad -25
msg1: .string "Target %ld is in the array.\n"
msg2: .string "Target %ld is not in the array.\n"
