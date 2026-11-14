source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Back-propagate observability through the supplied two-input AND.
set text [lab::read_input scoap_obs_netlist.v]
if {![regexp {and\s*\(Z,\s*A,\s*B\)} $text]} {error "Unsupported fixture topology"}
set co_z 0; set cc1_a 1; set cc1_b 1
set co_a [expr {$co_z + $cc1_b + 1}]
set co_b [expr {$co_z + $cc1_a + 1}]
puts "Z: CO=$co_z; A: CO=$co_a; B: CO=$co_b"
puts "Example T=CC0+CC1+CO: A=[expr {1+1+$co_a}], Z=[expr {2+3+$co_z}]"
