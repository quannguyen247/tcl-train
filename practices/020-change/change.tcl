proc findMinimumCoins {target coins} {
    if {$target < 0} {
        error "target can't be negative"
    }
    if {$target == 0} {
        return {}
    }

    array set best {0 {}}

    for {set value 1} {$value <= $target} {incr value} {
        foreach coin $coins {
            if {$coin > $value || ![info exists best([expr {$value - $coin}])]} {
                continue
            }

            set candidate [lsort -integer \
                [concat $best([expr {$value - $coin}]) $coin]]

            if {![info exists best($value)]
                || [llength $candidate] < [llength $best($value)]} {
                set best($value) $candidate
            }
        }
    }

    if {![info exists best($target)]} {
        error "can't make target with given coins"
    }

    return $best($target)
}
