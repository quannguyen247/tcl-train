source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Interpret the example's comments as a hypothetical dynamic path.
set text [lab::read_input ijtag_sib_network.v]
set matches [regexp -all -inline {SIB_([0-9]+):\s*Gate for\s+(\w+)\s*\(([0-9]+)-bit\)\s*->\s*(OPEN|CLOSED)} $text]
set count 0; set bits 0
foreach {whole index name width status} $matches {
    incr count
    incr bits ;# The SIB itself remains in the path in this simplified model.
    if {$status eq "OPEN"} {incr bits $width}
    puts "SIB_$index: $status $name ($width bits)"
}
if {!$count} {error "No SIB annotations found"}
puts "Illustrative active-path length: $bits bits; no IJTAG hardware was exercised."
