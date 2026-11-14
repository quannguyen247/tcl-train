# Read a sample report. Its numbers are fixtures, not measurements.
source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
set text [lab::read_input atpg_report.rpt]
set total [lab::match_one $text {Total Collapsed Faults:\s*(\d+)} total]
set detected [lab::match_one $text {Detected Faults\s*\(DT\):\s*(\d+)} detected]
set reported [lab::match_one $text {Fault Coverage:\s*([0-9.]+)%} coverage]
set dpm [lab::match_one $text {Estimated Defect Rate:\s*(\d+)} DPM]
if {$total <= 0 || $detected > $total} {error "Invalid fault counts"}
set calculated [expr {100.0 * $detected / $total}]
if {abs($calculated - $reported) > 0.02} {error "Coverage does not match fault counts"}
puts [format "Sample: %d/%d detected = %.2f%%" $detected $total $calculated]
puts "Sample DPM field: $dpm (not derived from coverage alone)"
