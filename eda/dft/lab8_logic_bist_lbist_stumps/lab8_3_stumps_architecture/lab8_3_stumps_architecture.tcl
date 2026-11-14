source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Read configuration annotations from the teaching fixture.
set d [lab::fields stumps_channel_netlist.v]
foreach key {PARALLEL_CHAINS PRPG_WIDTH LBIST_CYCLES} {puts "$key = [lab::required $d $key]"}
puts "These are fixture parameters; no STUMPS test or signature calculation ran."
