source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Recognize a specific active-low reset override in the supplied fixture.
set text [lab::read_input reset_drc_netlist.v]
set forced_high [list]
foreach line [split $text "\n"] {
    if {[regexp {^\s*or\s*\(\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*\)} $line -> out a b] && ($a eq "test_mode" || $b eq "test_mode")} {lappend forced_high $out}
}
set current ""; set overrides 0; set review 0
foreach line [split $text "\n"] {
    if {[regexp {^\s*\$_DFF_PN0_\s+(\w+)} $line -> name]} {set current $name}
    if {$current ne "" && [regexp {\.R\(\s*(\w+)\s*\)} $line -> reset]} {
        if {$reset in $forced_high} {incr overrides; puts "$current: $reset forced high by fixture OR gate"} \
        else {incr review; puts "$current: $reset requires reset controllability review"}
        set current ""
    }
}
if {$overrides+$review == 0} {error "No supported active-low reset flops found"}
puts "Fixture: overrides=$overrides review=$review; polarity and timing require real DFT checks."
