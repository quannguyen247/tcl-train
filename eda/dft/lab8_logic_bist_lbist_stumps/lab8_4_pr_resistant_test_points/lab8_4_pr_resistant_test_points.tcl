source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Inspect hypothetical test-point candidates and coverage numbers.
set d [lab::fields pr_resistant_faults.txt]
set gate [lab::required $d HARD_GATE]
set inputs [lab::required $d INPUTS]
set before [lab::required $d INITIAL_COVERAGE]
set after [lab::required $d BOOSTED_COVERAGE]
if {$inputs <= 0 || $before < 0 || $before > 100 || $after < 0 || $after > 100} {error "Invalid fixture"}
puts [format "%s: P(all inputs high) = %.3e for independent unbiased inputs" $gate [expr {pow(0.5,$inputs)}]]
puts "Candidate control point: [lab::required $d CONTROL_POINT_INSERT]"
puts "Candidate observe point: [lab::required $d OBSERVE_POINT_INSERT]"
puts [format "Fixture coverage change: %.2f percentage points" [expr {$after-$before}]]
puts "No test point was inserted and coverage was not measured."
