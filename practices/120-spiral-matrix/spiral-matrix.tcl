proc spiralMatrix {n} {
    if {$n == 0} {return {}}
    for {set i 0} {$i < $n} {incr i} {
        for {set j 0} {$j < $n} {incr j} {
            set m($i,$j) 0
        }
    }
    set r 0; set c 0; set dr 0; set dc 1
    for {set i 1} {$i <= $n * $n} {incr i} {
        set m($r,$c) $i
        set nr [expr {$r + $dr}]
        set nc [expr {$c + $dc}]
        if {$nr < 0 || $nr >= $n || $nc < 0 || $nc >= $n || $m($nr,$nc) != 0} {
            set temp $dr; set dr $dc; set dc [expr {-$temp}]
            set nr [expr {$r + $dr}]; set nc [expr {$c + $dc}]
        }
        set r $nr; set c $nc
    }
    set res {}
    for {set i 0} {$i < $n} {incr i} {
        set row {}
        for {set j 0} {$j < $n} {incr j} { lappend row $m($i,$j) }
        lappend res $row
    }
    return $res
}
