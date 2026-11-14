source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Model retention readback; voltage and delay are annotations, not electrical simulation.
set text [lab::read_input retention_netlist.v]
set pattern [lab::match_one $text {Pattern:\s*(0x[0-9A-Fa-f]+)} pattern]
set ms [lab::match_one $text {Pause:\s*([0-9.]+) ms} pause]
set words [lrepeat 1024 $pattern]
if {$argc && [lindex $argv 0] eq "inject-bitflip"} {lset words 17 0xAAAAAAAB}
set failures 0
foreach word $words {if {$word ne $pattern} {incr failures}}
puts "Virtual retention pause: $ms ms; checked [llength $words] words; mismatches=$failures"
puts "No real time delay, voltage or analog leakage was simulated."
if {$failures} {exit 1}
