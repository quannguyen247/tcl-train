# Restricted text transformation for the supplied teaching fixture only.
# Production netlists require a real parser and functional/DFT verification.
source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
set text [lab::read_input bus_tristate_netlist.v]
set cells [regexp -all {\$_TBUF_\s+u_tbuf_[0-9]+} $text]
if {$cells == 0} {error "No supported buffers found"}
set converted [regsub -all {\.E\(enable\)} $text {.E(enable \& ~test_mode)} text]
if {$converted != $cells} {error "Unsupported buffer enable syntax"}
regsub -all {\$_TBUF_} $text {TBUF} text
append text "\nmodule TBUF(input A, input E, output Y);\n  assign Y = E ? A : 1'bz;\nendmodule\n"
set build [file join [file dirname [file normalize [info script]]] build]
file mkdir $build
set out [open [file join $build netlist_isolated.v] w]
try {puts -nonewline $out $text} finally {close $out}
puts "$cells fixture buffers use enable & ~test_mode. Output: $build/netlist_isolated.v"
puts "Run simulation and DFT checks before using a transformation in a real flow."
