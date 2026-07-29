proc encrypt {text} {
    set clean [string tolower [regsub -all {[^a-zA-Z0-9]} $text ""]]
    set len [string length $clean]
    if {$len == 0} { return "" }
    
    set r 1
    set c 1
    while {$r * $c < $len} {
        if {$c > $r} {
            incr r
        } else {
            incr c
        }
    }
    
    set target_len [expr {$r * $c}]
    set padded $clean
    while {[string length $padded] < $target_len} {
        append padded " "
    }
    
    set columns {}
    for {set col 0} {$col < $c} {incr col} {
        set col_str ""
        for {set row 0} {$row < $r} {incr row} {
            set idx [expr {$row * $c + $col}]
            append col_str [string index $padded $idx]
        }
        lappend columns $col_str
    }
    return [join $columns " "]
}
