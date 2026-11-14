source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Compare two illustrative numbers with the thresholds in the fixture.
set d [lab::fields automotive_iso26262_spec.txt]
set latency [lab::required $d MEASURED_POST_TIME_MS]
set budget [lab::required $d MAX_POST_LATENCY_MS]
set spfm [lab::required $d MEASURED_SPFM_PERCENT]
set target [lab::required $d SPFM_TARGET_PERCENT]
puts "Sample POST time $latency ms <= $budget ms: [expr {$latency <= $budget}]"
puts "Sample SPFM $spfm% >= $target%: [expr {$spfm >= $target}]"
puts "Fixture comparison only; this does not establish functional-safety compliance."
if {$latency > $budget || $spfm < $target} {exit 1}
