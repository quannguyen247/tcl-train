# lab2 5 area vs speed: see the lesson README for the task and inputs.
# Lab 2.5: Area vs Speed Strategy Comparison

set fp1 [open "synth_area.rpt" r]
set synth_strat1_log [read $fp1]
close $fp1

set fp2 [open "synth_speed.rpt" r]
set synth_strat2_log [read $fp2]
close $fp2

#           set saved_pct [format "%.2f" [expr {(($area2 - $area1) / $area2) * 100.0}]]

regexp {Chip area for module [^:]+: ([0-9.]+)} $synth_strat1_log _ area1
regexp {Chip area for module [^:]+: ([0-9.]+)} $synth_strat2_log _ area2

puts "===================================================="
puts "         SYNTHESIS STRATEGY COMPARISON"
puts "===================================================="
puts "Strategy 1 (Area-Optimized)  : Area = $area1 gate_units"
puts "Strategy 2 (Speed-Optimized) : Area = $area2 gate_units"
puts "----------------------------------------------------"
set saved_pct [format "%.2f" [expr {(($area2 - $area1) / $area2) * 100.0}]]
puts "\[RECOMMENDATION\] Area strategy saved ${saved_pct}% area!"
puts "===================================================="
