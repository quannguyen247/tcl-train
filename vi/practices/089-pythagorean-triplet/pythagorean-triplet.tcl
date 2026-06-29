# ==============================================================================
# EXERCISM TCL PRACTICE: PYTHAGOREAN-TRIPLET
# ==============================================================================
# # Description
#
# A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for which,
#
# ```text
# a² + b² = c²
# ```
#
# and such that,
#
# ```text
# a < b < c
# ```
#
# For example,
#
# ```text
# 3² + 4² = 5².
# ```
#
# Given an input integer N, find all Pythagorean triplets for which `a + b + c = N`.
#
# For example, with N = 1000, there is exactly one Pythagorean triplet for which `a + b + c = 1000`: `{200, 375, 425}`.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc tripletsWithSum {perimeter} {
    set result {}

    # Từ a và chu vi, suy ra b rồi tính c
    for {set a 1} {$a < $perimeter / 3} {incr a} {
        set numerator [expr {$perimeter * ($perimeter - 2 * $a)}]
        set denominator [expr {2 * ($perimeter - $a)}]

        if {$numerator % $denominator} {
            continue
        }

        set b [expr {$numerator / $denominator}]
        set c [expr {$perimeter - $a - $b}]

        # Chỉ nhận bộ có thứ tự a < b < c
        if {$a < $b && $b < $c} {
            lappend result [list $a $b $c]
        }
    }
    return $result
}

