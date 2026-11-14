# lab2 6 multi synth analysis: see the lesson README for the task and inputs.
# Lab 2.6: Multi-Strategy Synthesis Log Analyzer (Batch Exploration)



set log_files [glob "synth_*.rpt"]

set result [list]

foreach log_file $log_files {
    set fp [open $log_file r]
    set content [read $fp]
    close $fp

    regexp {=== Strategy \d+: ([^=]+?) ===} $content _ strategy_name
    regexp {Chip area for module [^:]+: ([0-9.]+)} $content _ area_value
    lappend result [list $log_file $strategy_name $area_value]
}

set sorted_results [lsort -real -index 2 $result]

set best_entry [lindex $sorted_results 0]
set worst_entry [lindex $sorted_results end]

set best_strat [lindex $best_entry 1]
set best_area [lindex $best_entry 2]

set worst_strat [lindex $worst_entry 1]
set worst_area [lindex $worst_entry 2]

set max_saving_val [format "%.2f" [expr {(($worst_area - $best_area) / $worst_area) * 100.0}]]

puts "=== MULTI-STRATEGY SYNTHESIS EXPLORATION (N = [llength $sorted_results]) ==="
puts "----------------------------------------------------------------------"
puts [format "%-20s | %-20s | %s" "FILE" "STRATEGY" "AREA (gate_units)"]
puts "----------------------------------------------------------------------"
foreach entry $sorted_results {
    puts [format "%-20s | %-20s | %s" [lindex $entry 0] [lindex $entry 1] [lindex $entry 2]]
    puts "----------------------------------------------------------------------"
}
puts "----------------------------------------------------------------------"
puts "\[BEST CHOICE\] '$best_strat' has the smallest area: $best_area gate_units"
puts "\[MAX SAVING\] Saves $max_saving_val% area compared to '$worst_strat'!"
puts "======================================================================"
