proc tick {matrix} {
    set result {}
    set rows [llength $matrix]

    for {set row 0} {$row < $rows} {incr row} {
        set output {}
        set columns [llength [lindex $matrix $row]]

        for {set column 0} {$column < $columns} {incr column} {
            set neighbors 0
            foreach {dr dc} {-1 -1 -1 0 -1 1 0 -1 0 1 1 -1 1 0 1 1} {
                set r [expr {$row + $dr}]
                set c [expr {$column + $dc}]
                if {$r >= 0 && $r < $rows && $c >= 0 && $c < [llength [lindex $matrix $r]]} {
                    incr neighbors [lindex $matrix $r $c]
                }
            }

            set alive [lindex $matrix $row $column]
            lappend output [expr {$neighbors == 3 || ($alive && $neighbors == 2)}]
        }
        lappend result $output
    }
    return $result
}
