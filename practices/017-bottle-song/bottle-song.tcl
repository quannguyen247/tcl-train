proc bottleSong {start {take 1}} {
    set names {no One Two Three Four Five Six Seven Eight Nine Ten}
    set result {}
    for {set i 0} {$i < $take} {incr i} {
        set cur [expr {$start - $i}]
        set next [expr {$cur - 1}]
        set cw [lindex $names $cur]
        set nw [string tolower [lindex $names $next]]
        set cb [expr {$cur == 1 ? "bottle" : "bottles"}]
        set nb [expr {$next == 1 ? "bottle" : "bottles"}]
        if {$i > 0} { lappend result "" }
        lappend result "$cw green $cb hanging on the wall,"
        lappend result "$cw green $cb hanging on the wall,"
        lappend result "And if one green bottle should accidentally fall,"
        lappend result "There'll be $nw green $nb hanging on the wall."
    }
    return $result
}
