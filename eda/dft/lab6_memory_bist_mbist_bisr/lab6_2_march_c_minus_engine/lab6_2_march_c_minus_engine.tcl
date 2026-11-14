source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Software model of March C- on 1024 words, with optional stuck-at-0 injection.
# Usage: tclsh SCRIPT ?stuck-at-0?
set mode [expr {$argc ? [lindex $argv 0] : "none"}]
if {$mode ni {none stuck-at-0}} {error "Expected none or stuck-at-0"}
set n 1024
set memory [lrepeat $n 0]
set failures 0
set operations 0
foreach {direction commands} {up {w0} up {r0 w1} up {r1 w0} down {r0 w1} down {r1 w0} up {r0}} {
    for {set i 0} {$i < $n} {incr i} {
        set address [expr {$direction eq "up" ? $i : $n-1-$i}]
        foreach operation $commands {
            incr operations
            set bit [string index $operation 1]
            set expected [expr {$bit eq "1" ? 0xffffffff : 0}]
            if {[string index $operation 0] eq "w"} {
                if {$mode eq "stuck-at-0" && $address == 23} {set expected 0}
                lset memory $address $expected
            } elseif {[lindex $memory $address] != $expected} {
                incr failures
            }
        }
    }
    puts "$direction $commands complete"
}
puts "March C- model: $operations operations, $failures read mismatches"
if {$failures} {exit 1}
puts "PASS: fault-free software model only; this is not SRAM silicon coverage."
