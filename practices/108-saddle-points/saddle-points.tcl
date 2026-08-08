proc saddlePoints {matrix} {
    if {$matrix eq {} || [lindex $matrix 0] eq {}} {
        return {}
    }

    set result {}
    set rows [llength $matrix]
    set columns [llength [lindex $matrix 0]]

    for {set rowIndex 0} {$rowIndex < $rows} {incr rowIndex} {
        set row [lindex $matrix $rowIndex]
        set maxInRow [lindex [lsort -integer $row] end]
        for {set column 0} {$column < $columns} {incr column} {
            set value [lindex $row $column]
            if {$value != $maxInRow} {
                continue
            }

            set minInColumn {}
            for {set r 0} {$r < $rows} {incr r} {
                lappend minInColumn [lindex $matrix $r $column]
            }
            if {$value == [lindex [lsort -integer $minInColumn] 0]} {
                lappend result [list [expr {$rowIndex + 1}] \
                    [expr {$column + 1}]]
            }
        }
    }
    return $result
}
