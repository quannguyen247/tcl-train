proc maximumValue {maxWeight items} {
    set best [lrepeat [expr {$maxWeight + 1}] 0]

    foreach item $items {
        dict with item {}

        for {set w $maxWeight} {$w >= $weight} {incr w -1} {
            set total [expr {[lindex $best [expr {$w - $weight}]] + $value}]
            if {$total > [lindex $best $w]} {
                lset best $w $total
            }
        }
    }

    return [lindex $best end]
}
