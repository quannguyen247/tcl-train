source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Fibonacci LFSR: x^8 + x^6 + x^5 + x + 1, shift left.
set d [lab::fields lfsr_poly_spec.txt]
set width [lab::required $d BIT_WIDTH]
set polynomial [string map {" " ""} [lab::required $d POLYNOMIAL]]
if {$width != 8 || $polynomial ne "x^8+x^6+x^5+x+1"} {error "This example supports the documented 8-bit polynomial only"}
set seed [expr {int([lab::required $d INITIAL_SEED])}]
if {$seed < 1 || $seed > 255} {error "Seed must be a nonzero 8-bit value"}
set state $seed; set seen [dict create]
while {![dict exists $seen $state]} {
    dict set seen $state 1
    set feedback [expr {(($state>>7)^($state>>5)^($state>>4)^$state)&1}]
    set state [expr {(($state<<1)&255)|$feedback}]
}
set period [dict size $seen]
puts [format "8-bit LFSR: seed=0x%02X period=%d repeated=0x%02X" $seed $period $state]
if {$state != $seed || $period != [lab::required $d MAX_PERIOD]} {error "Unexpected period"}
puts "A maximal period does not imply cryptographic randomness."
