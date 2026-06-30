# ==============================================================================
# EXERCISM TCL PRACTICE: SADDLE-POINTS
# ==============================================================================
# # Instructions
#
# Your task is to find the potential trees where you could build your tree house.
#
# The data company provides the data as grids that show the heights of the trees.
# The rows of the grid represent the east-west direction, and the columns represent the north-south direction.
#
# An acceptable tree will be the largest in its row, while being the smallest in its column.
#
# A grid might not have any good trees at all.
# Or it might have one, or even several.
#
# Here is a grid that has exactly one candidate tree.
#
# ```text
#       ↓
#       1  2  3  4
#     |-----------
#   1 | 9  8  7  8
# → 2 |[5] 3  2  4
#   3 | 6  6  7  1
# ```
#
# - Row 2 has values 5, 3, 2, and 4. The largest value is 5.
# - Column 1 has values 9, 5, and 6. The smallest value is 5.
#
# So the point at `[2, 1]` (row: 2, column: 1) is a great spot for a tree house.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

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

