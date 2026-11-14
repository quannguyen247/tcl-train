source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# SCOAP controllability for the supplied two-input AND and OR only.
set text [lab::read_input scoap_netlist.v]
if {![regexp {and\s*\(N_AND,\s*A,\s*B\)} $text] || ![regexp {or\s*\(N_OR,\s*A,\s*B\)} $text]} {error "Unsupported fixture topology"}
set a0 1; set a1 1; set b0 1; set b1 1
puts "A: CC0=$a0 CC1=$a1; B: CC0=$b0 CC1=$b1"
puts "N_AND: CC0=[expr {1+min($a0,$b0)}] CC1=[expr {1+$a1+$b1}]"
puts "N_OR: CC0=[expr {1+$a0+$b0}] CC1=[expr {1+min($a1,$b1)}]"
puts "Combinational SCOAP cost is a heuristic, not fault coverage."
