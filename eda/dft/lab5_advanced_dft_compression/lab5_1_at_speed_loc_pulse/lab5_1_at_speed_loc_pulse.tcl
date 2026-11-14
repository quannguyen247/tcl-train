source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Identify the clock connections in a small annotated fixture.
set text [lab::read_input occ_clock_netlist.v]
set occ [lab::match_one $text {OCC_CELL\s+(\w+)} {OCC instance}]
set fast [lab::match_one $text {\.FAST_CLK\((\w+)\)} {fast clock}]
set output [lab::match_one $text {\.OUT_CLK\((\w+)\)} {OCC output}]
set sinks [regexp -all [format {\.C\(%s\)} $output] $text]
puts "OCC=$occ fast_clock=$fast output=$output connected_fixture_flops=$sinks"
puts "Connectivity alone does not verify pulse count, frequency, or timing."
