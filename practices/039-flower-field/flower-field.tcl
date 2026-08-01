proc annotate {field} {
    set result {}
    set rows [llength $field]

    for {set row 0} {$row < $rows} {incr row} {
        set line [lindex $field $row]
        set output ""

        for {set column 0} {$column < [string length $line]} {incr column} {
            if {[string index $line $column] eq "*"} {
                append output *
                continue
            }

            set flowers 0
            foreach {dr dc} {-1 -1 -1 0 -1 1 0 -1 0 1 1 -1 1 0 1 1} {
                set r [expr {$row + $dr}]
                set c [expr {$column + $dc}]
                if {$r >= 0 && $r < $rows
                    && $c >= 0 && $c < [string length [lindex $field $r]]
                    && [string index [lindex $field $r] $c] eq "*"} {
                    incr flowers
                }
            }
            append output [expr {$flowers ? $flowers : " "}]
        }
        lappend result $output
    }
    return $result
}
