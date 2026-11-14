source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Convert only the two supported fixture cells into behavioral scan cells.
# SI and SE remain tied low here; stitching is a separate exercise.
set text [lab::read_input dff_netlist.v]
set output [list]; set count 0; set inside 0
foreach line [split $text "\n"] {
    if {[regexp {^\s*\$_DFF_P_\s+(\w+)\s*\(} $line -> name]} {
        regsub {\$_DFF_P_} $line {SCAN_FF} line
        set inside 1; incr count
        puts "Converted fixture cell $name; scan pins are tied inactive."
    }
    lappend output $line
    if {$inside && [regexp {^\s*\.C\s*\(} $line]} {
        lappend output "    .SI(1'b0)," "    .SE(1'b0),"
    }
    if {$inside && [regexp {^\s*\)\s*;} $line]} {set inside 0}
}
if {$count != 2} {error "Expected two supported fixture flip-flops"}
lappend output {module SCAN_FF(input C, input D, input SI, input SE, output reg Q);} \
    {  always @(posedge C) Q <= SE ? SI : D;} {endmodule}
set build [file join [file dirname [file normalize [info script]]] build]
file mkdir $build
set out [open [file join $build scan_replaced.v] w]
try {puts $out [join $output "\n"]} finally {close $out}
puts "$count behavioral cells written to $build/scan_replaced.v; no scan chain was stitched."
