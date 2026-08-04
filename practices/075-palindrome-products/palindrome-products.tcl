proc isPalindrome {number} {
    return [expr {$number eq [string reverse $number]}]
}

proc palindromeProducts {smallestOrLargest min max} {
    if {$min > $max} {
        error "min must be <= max"
    }

    set best -1
    set factors {}

    if {$smallestOrLargest eq "smallest"} {
        set step 1
        set start $min
        set stop $max
    } else {
        set step -1
        set start $max
        set stop $min
    }

    for {set first $start} {
        ($step > 0 && $first <= $stop)
        || ($step < 0 && $first >= $stop)
    } {incr first $step} {
        if {$smallestOrLargest eq "smallest"} {
            set secondStart $first
            set secondStop $max
            set secondStep 1
        } else {
            set secondStart $max
            set secondStop $first
            set secondStep -1
        }

        for {set second $secondStart} {
            ($secondStep > 0 && $second <= $secondStop)
            || ($secondStep < 0 && $second >= $secondStop)
        } {incr second $secondStep} {
            set product [expr {$first * $second}]

            if {$best >= 0
                && (($step > 0 && $product > $best)
                    || ($step < 0 && $product < $best))} {
                break
            }

            if {![isPalindrome $product]} {
                continue
            }

            if {$best < 0 || ($step > 0 && $product < $best)
                || ($step < 0 && $product > $best)} {
                set best $product
                set factors {}
            }

            if {$product == $best} {
                lappend factors [list $first $second]
            }
        }
    }

    return [list $best [lsort -integer -index 0 $factors]]
}
