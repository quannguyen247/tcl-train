proc triangle {n} {
    set res {}
    for {set i 0} {$i < $n} {incr i} {
        set row {1}
        set prev [lindex $res end]
        if {[llength $prev] > 0} {
            for {set j 0} {$j < [llength $prev]-1} {incr j} {
                lappend row [expr {[lindex $prev $j] + [lindex $prev $j+1]}]
            }
            lappend row 1
        }
        lappend res $row
    }
    return $res
}
