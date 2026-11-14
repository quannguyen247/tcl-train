source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Greedy teaching example: one spare row and one spare column.
set points [list]
foreach line [split [lab::read_input memory_fail_map.txt] "\n"] {
    if {[regexp {Row\s+(\d+),\s*Col\s+(\d+)} $line -> row col]} {lappend points [list $row $col]}
}
if {![llength $points]} {error "No defects found"}
proc choose {points axis} {
    set counts [dict create]
    foreach point $points {dict incr counts [lindex $point $axis]}
    set best ""; set maximum 0
    foreach item [lsort -integer [dict keys $counts]] {
        if {[dict get $counts $item] > $maximum} {set best $item; set maximum [dict get $counts $item]}
    }
    return $best
}
set row [choose $points 0]
set remaining [list]
foreach point $points {if {[lindex $point 0] != $row} {lappend remaining $point}}
set col [expr {[llength $remaining] ? [choose $remaining 1] : "none"}]
set uncovered [list]
foreach point $remaining {if {[lindex $point 1] ne $col} {lappend uncovered $point}}
puts "Fixture defects: [llength $points]; choose row=$row, column=$col; uncovered=[llength $uncovered]"
puts "Greedy example only: no optimality or physical repair is implied."
if {[llength $uncovered]} {exit 1}
