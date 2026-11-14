source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Read examples of memory fault models from a text fixture.
set text [lab::read_input sram_fault_spec.txt]
set count 0
foreach line [split $text "\n"] {
    if {![regexp {FAULT_TYPE\s*=\s*(\w+)} $line -> kind]} continue
    puts "$kind: $line"
    incr count
}
if {$count == 0} {error "No fault examples found"}
puts "$count illustrative records; no fault simulation was run."
