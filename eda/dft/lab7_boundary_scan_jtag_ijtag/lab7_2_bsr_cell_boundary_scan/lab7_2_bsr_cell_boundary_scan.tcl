source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# List the three annotated boundary-cell instances in this fixture.
set text [lab::read_input bsr_pad_netlist.v]
set matches [regexp -all -inline {(BSR_IN|BSR_OUT|BSR_CTRL)\s+(\w+)\s*\(\.PAD\(([^)]+)\)\)} $text]
set count 0
foreach {whole type instance pad} $matches {
    puts "$instance: $type on $pad"
    incr count
}
if {!$count} {error "No boundary cells found"}
puts "$count instances listed; serial connectivity is not defined by this fixture."
