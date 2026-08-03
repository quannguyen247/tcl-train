# ==============================================================================
# EXERCISM TCL PRACTICE: COLLATZ-CONJECTURE
# ==============================================================================
# # Instructions
#
# Given a positive integer, return the number of steps it takes to reach 1 according to the rules of the Collatz Conjecture.

# ==============================================================================
# ALGORITHM & TCL SYNTAX NOTES
# ==============================================================================
# 1. ERROR HANDLING:
#    - Use `error "Only positive integers are allowed"` for invalid input (number <= 0).
#    - Avoid `throw {}` as Tcl requires a non-empty list for error codes in `throw`.
#
# 2. LINE BREAKING WITH `else`:
#    - Tcl terminates statements at newlines.
#    - `} else {` MUST be placed on the SAME LINE.
#
# 3. VARIABLE ASSIGNMENT & EXPR:
#    - Always use `set var [expr {...}]`.
#    - Wrap expressions in `{}` for bytecode performance optimization.
# ==============================================================================

proc steps {number} {
    if {$number <= 0} {
        error "Only positive integers are allowed"
    }

    set count 0
    while {$number > 1} {
        incr count

        if {$number % 2 == 0} {
            set number [expr {$number / 2}]
        } else {
            set number [expr {$number * 3 + 1}]
        }
    }

    return $count
}




proc steps {n} {
    if {$n <= 0} {
        error "Only positive integers are allowed"
    }
    set count 0
    while {$n > 1} {
        if {$n % 2 == 0} {
            set n [expr {$n / 2}]
        } else {
            set n [expr {3 * $n + 1}]
        }
        incr count
    }
    return $count
}
