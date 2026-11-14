source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Stitch the supplied simple fixture, whose scan cells are in source order.
set text [lab::read_input sdff_cells.v]
set output [list]; set count 0; set in_cell 0; set previous_q ""
foreach line [split $text "\n"] {
    if {[regexp {^\s*SDFF\s+(\w+)\s*\(} $line -> instance]} {
        if {$in_cell} {error "Nested scan cell"}
        set in_cell 1; incr count
        set input_net [expr {$count == 1 ? "scan_in" : $previous_q}]
        if {$input_net eq ""} {error "Missing previous Q"}
        set seen_si 0; set seen_se 0; set cell_q ""
    }
    if {$in_cell} {
        if {[regexp {\.SI\s*\([^)]*\)} $line]} {
            regsub {\.SI\s*\([^)]*\)} $line ".SI($input_net)" line
            set seen_si 1
        }
        if {[regexp {\.SE\s*\([^)]*\)} $line]} {
            regsub {\.SE\s*\([^)]*\)} $line {.SE(scan_en)} line
            set seen_se 1
        }
        if {[regexp {\.Q\s*\(\s*(\w+)\s*\)} $line -> q]} {set cell_q $q}
        if {[regexp {^\s*\)\s*;} $line]} {
            if {!$seen_si || !$seen_se || $cell_q eq ""} {error "Incomplete cell $instance"}
            puts "$instance: SI=$input_net Q=$cell_q"
            set previous_q $cell_q; set in_cell 0
        }
    }
    if {[string trim $line] eq "endmodule"} {
        if {!$count || $in_cell} {error "No complete scan chain"}
        lappend output "  assign scan_out = $previous_q;"
    }
    lappend output $line
}
lappend output {module SDFF(input CLK, input D, input SI, input SE, output reg Q);} \
    {  always @(posedge CLK) Q <= SE ? SI : D;} {endmodule}
set build [file join [file dirname [file normalize [info script]]] build]
file mkdir $build
set out [open [file join $build stitched_scan_netlist.v] w]
try {puts $out [join $output "\n"]} finally {close $out}
puts "Wrote a $count-cell behavioral scan chain to $build/stitched_scan_netlist.v"
