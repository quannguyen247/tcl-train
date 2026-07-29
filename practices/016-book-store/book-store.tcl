proc basketCost {basket} {
    array set counts {1 0 2 0 3 0 4 0 5 0}
    foreach item $basket {
        incr counts($item)
    }
    set groups {}
    while 1 {
        set num_distinct 0
        for {set b 1} {$b <= 5} {incr b} {
            if {$counts($b) > 0} {
                incr num_distinct
            }
        }
        if {$num_distinct == 0} break
        for {set b 1} {$b <= 5} {incr b} {
            if {$counts($b) > 0} {
                incr counts($b) -1
            }
        }
        lappend groups $num_distinct
    }
    set count5 0
    set count4 0
    set count3 0
    set count2 0
    set count1 0
    foreach g $groups {
        if {$g == 5} { incr count5 }
        if {$g == 4} { incr count4 }
        if {$g == 3} { incr count3 }
        if {$g == 2} { incr count2 }
        if {$g == 1} { incr count1 }
    }
    while {$count5 > 0 && $count3 > 0} {
        incr count5 -1
        incr count3 -1
        incr count4 2
    }
    set total [expr {$count1 * 800 + $count2 * 1520 + $count3 * 2160 + $count4 * 2560 + $count5 * 3000}]
    return $total
}
