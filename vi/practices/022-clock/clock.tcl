# ==============================================================================
# EXERCISM TCL PRACTICE: CLOCK
# ==============================================================================
# # Instructions
#
# Implement a clock that handles times without dates.
#
# You should be able to add and subtract minutes to it.
#
# Two clocks that represent the same time should be equal to each other.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create Clock {

    constructor {hour minute} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method toString {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method add {minutes} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method subtract {minutes} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method equals {other} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}

