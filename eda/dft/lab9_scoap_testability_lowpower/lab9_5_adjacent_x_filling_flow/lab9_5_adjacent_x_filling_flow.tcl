source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Fill each X with the preceding bit; a leading X is filled with zero.
set d [lab::fields raw_atpg_vectors.vec]
set raw [string toupper [lab::required $d RAW_VECTOR]]
if {![regexp {^[01X]+$} $raw]} {error "Expected a nonempty 0/1/X vector"}
set zero [string map {X 0} $raw]
set filled ""; set previous 0
foreach bit [split $raw ""] {
    if {$bit eq "X"} {append filled $previous} else {append filled $bit; set previous $bit}
}
proc transitions {bits} {
    set n 0
    for {set i 1} {$i < [string length $bits]} {incr i} {
        if {[string index $bits $i] ne [string index $bits [expr {$i-1}]]} {incr n}
    }
    return $n
}
puts "raw=$raw"
puts "zero-fill=$zero transitions=[transitions $zero]"
puts "adjacent-fill=$filled transitions=[transitions $filled]"
puts "Serial transitions are a proxy only; they do not quantify circuit power."
