# Compare idealized shift cycles, not simulator runtime or measured chip power.
# Usage: tclsh run_compression_benchmark.tcl ?patterns? ?flops? ?chains?
set patterns [expr {$argc > 0 ? [lindex $argv 0] : 3500}]
set flops [expr {$argc > 1 ? [lindex $argv 1] : 20000}]
set chains [expr {$argc > 2 ? [lindex $argv 2] : 100}]
foreach value [list $patterns $flops $chains] {
    if {![string is integer -strict $value] || $value <= 0} {error "Arguments must be positive integers"}
}
set max_chain_length [expr {($flops + $chains - 1) / $chains}]
set serial_cycles [expr {$patterns * $flops}]
set parallel_cycles [expr {$patterns * $max_chain_length}]
puts "Ideal shift cycles: serial=$serial_cycles parallel=$parallel_cycles"
puts [format "Ideal cycle ratio: %.2fx" [expr {double($serial_cycles)/$parallel_cycles}]]
puts "Assumes balanced chains and equal pattern counts; capture and compression hardware are excluded."
