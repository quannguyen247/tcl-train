proc makeRow {i n} {
    set c [format %c [expr {65 + $i}]]
    set outer [expr {$n - $i}]
    set outer_sp [string repeat " " $outer]
    if {$i == 0} {
        return "${outer_sp}${c}${outer_sp}"
    } else {
        set inner_sp [string repeat " " [expr {2 * $i - 1}]]
        return "${outer_sp}${c}${inner_sp}${c}${outer_sp}"
    }
}

proc diamond {char} {
    set n [expr {[scan $char %c] - 65}]
    set lines {}
    for {set i 0} {$i <= $n} {incr i} {
        lappend lines [makeRow $i $n]
    }
    for {set i [expr {$n - 1}]} {$i >= 0} {incr i -1} {
        lappend lines [makeRow $i $n]
    }
    return [join $lines "
"]
}
