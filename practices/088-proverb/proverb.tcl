proc recite {items} {
    if {[llength $items] == 0} { return {} }
    set res {}
    for {set i 0} {$i < [llength $items] - 1} {incr i} {
        set curr [lindex $items $i]
        set next [lindex $items [expr {$i + 1}]]
        lappend res "For want of a $curr the $next was lost."
    }
    lappend res "And all for the want of a [lindex $items 0]."
    return $res
}
