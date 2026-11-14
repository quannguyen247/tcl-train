# lab2 2 gate reporter: see the lesson README for the task and inputs.
# Lab 2.2: Yosys Gate Reporter (Log Parser)

set fp [open "stat.txt" r]
set content [read $fp]
close $fp

lassign {0 0} comb_count seq_count

foreach line [split $content "\n"] {
    set line [string trim $line]

    if {[llength $line] != 2 || ![string match {$_*} [lindex $line 0]]} continue

    lassign $line cell_name cell_count
    if {[string match *FF* $cell_name] || [string match *LATCH* $cell_name]} {
        incr seq_count $cell_count
    } else {
        incr comb_count $cell_count
    }
}

set total_cells [expr {$comb_count + $seq_count}]
set comb_percentage [format "%.2f" [expr {($comb_count * 100.0) / $total_cells}]]
set seq_percentage  [format "%.2f" [expr {($seq_count * 100.0) / $total_cells}]]

puts "=== YOSYS GATE COUNT REPORT ==="
puts "----------------------------------------------------"
puts "Combinational Gates : $comb_count ($comb_percentage%)"
puts "Sequential Gates    : $seq_count ($seq_percentage%)"
puts "Total Gate Count    : $total_cells"
puts "----------------------------------------------------"
