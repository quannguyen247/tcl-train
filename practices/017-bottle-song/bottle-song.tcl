set NUMBERS {10 Ten 9 Nine 8 Eight 7 Seven 6 Six 5 Five 4 Four 3 Three 2 Two 1 One 0 no}

proc bottleSong {start {take 1}} {
    global NUMBERS
    set lines {}
    for {set i $start} {$i > $start - $take} {incr i -1} {
        set n_word [dict get $NUMBERS $i]
        set n_plural [expr {$i == 1 ? "bottle" : "bottles"}]
        set next_i [expr {$i - 1}]
        set next_word [string tolower [dict get $NUMBERS $next_i]]
        set next_plural [expr {$next_i == 1 ? "bottle" : "bottles"}]
        
        lappend lines "$n_word green $n_plural hanging on the wall,"
        lappend lines "$n_word green $n_plural hanging on the wall,"
        lappend lines "And if one green bottle should accidentally fall,"
        lappend lines "There'll be $next_word green $next_plural hanging on the wall."
        if {$i > $start - $take + 1} {
            lappend lines ""
        }
    }
    return $lines
}
