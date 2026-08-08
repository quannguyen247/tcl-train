# ==============================================================================
# EXERCISM TCL PRACTICE: FLOWER-FIELD
# ==============================================================================
# # Instructions
#
# Your task is to add flower counts to empty squares in a completed Flower Field garden.
# The garden itself is a rectangle board composed of squares that are either empty (`' '`) or a flower (`'*'`).
#
# For each empty square, count the number of flowers adjacent to it (horizontally, vertically, diagonally).
# If the empty square has no adjacent flowers, leave it empty.
# Otherwise replace it with the count of adjacent flowers.
#
# For example, you may receive a 5 x 4 board like this (empty spaces are represented here with the '·' character for display on screen):
#
# ```text
# ·*·*·
# ··*··
# ··*··
# ·····
# ```
#
# Which your code should transform into this:
#
# ```text
# 1*3*1
# 13*31
# ·2*2·
# ·111·
# ```

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

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

