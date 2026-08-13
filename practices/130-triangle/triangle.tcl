namespace eval triangle {
    proc is {type sides} {
        lassign $sides a b c

        if {$a <= 0 || $b <= 0 || $c <= 0 || $a + $b < $c || $b + $c < $a || $a + $c < $b} {
            return false
        }

        switch -- $type {
            equilateral {
                return [expr {$a == $b && $b == $c}]
            }
            isosceles {
                return [expr {$a == $b || $b == $c || $a == $c}]
            }
            scalene {
                return [expr {$a != $b && $b != $c && $a != $c}]
            }
            default {
                return false
            }
        }
    }
}
