# Compare two sample reports for the same fault list.
source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
foreach {kind file} {Random random_sim.rpt ATPG atpg_sim.rpt} {
    set text [lab::read_input $file]
    set n [lab::match_one $text {Total Vectors Applied:\s*(\d+)} vectors]
    set total [lab::match_one $text {Simulated Faults:\s*(\d+)} faults]
    set found [lab::match_one $text {Detected Faults:\s*(\d+)} detected]
    set cov [lab::match_one $text {Fault Coverage:\s*([0-9.]+)%} coverage]
    if {$total <= 0 || $found > $total || abs($cov - 100.0*$found/$total) > 0.02} {
        error "$file has inconsistent fault counts and coverage"
    }
    set coverage($kind) $cov
    set faults($kind) $total
    puts [format "%s sample: %d vectors, %.2f%% (%d/%d)" $kind $n $cov $found $total]
}
if {$faults(Random) != $faults(ATPG)} {error "Fault populations differ"}
puts [format "Coverage difference: %.2f percentage points" [expr {$coverage(ATPG)-$coverage(Random)}]]
