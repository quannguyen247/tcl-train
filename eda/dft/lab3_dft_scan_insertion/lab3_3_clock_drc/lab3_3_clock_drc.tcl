source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Classify direct and non-direct clock connections in one text fixture.
set text [lab::read_input clock_drc_netlist.v]
set current ""; set direct 0; set review 0
foreach line [split $text "\n"] {
    if {[regexp {^\s*\$_DFF_P_\s+(\w+)} $line -> name]} {set current $name}
    if {$current ne "" && [regexp {\.C\(\s*(\w+)\s*\)} $line -> clock]} {
        if {$clock eq "clk"} {incr direct; puts "$current: direct clock $clock"} \
        else {incr review; puts "$current: clock $clock requires connectivity review"}
        set current ""
    }
}
if {$direct+$review == 0} {error "No supported flip-flops found"}
puts "Fixture: direct=$direct review=$review; text matching is not DFT DRC."
