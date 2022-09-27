.text
.global _start

_start:

    /* Exit Function */
    MOV X0, 0
    Mov X8, 93
    SVC 0

.data