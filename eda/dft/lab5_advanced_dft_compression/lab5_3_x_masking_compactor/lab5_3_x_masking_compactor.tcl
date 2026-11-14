source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Inspect one explicitly annotated unknown source in the fixture.
set text [lab::read_input compactor_netlist.v]
set gate [lab::match_one $text {and\s+(\w+)\s*\(masked_so\[2\],\s*int_so\[2\],\s*mask_ctrl\[2\]\)} {mask gate}]
puts "Fixture gate $gate masks input bit 2 when mask_ctrl\[2\] is 0."
puts "This structural check does not prove the mask is asserted during test."
