source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Compare annotated example numbers; this is not static timing analysis.
set text [lab::read_input timing_drc_netlist.v]
set delay [lab::match_one $text {delay = ([0-9.]+) ns} delay]
set fast [lab::match_one $text {Clock Period \(1.0 GHz\) = ([0-9.]+) ns} {fast period}]
set slow [lab::match_one $text {Shift Period \(([0-9.]+) ns\)} {shift period}]
puts [format "Annotated SE delay %.2f ns; fast period %.2f ns; shift period %.2f ns" $delay $fast $slow]
puts "Toy comparison: delay < fast period: [expr {$delay < $fast}]; delay < shift period: [expr {$delay < $slow}]"
puts "Real LOC/LOS checks require waveforms, constraints, setup/hold and STA."
