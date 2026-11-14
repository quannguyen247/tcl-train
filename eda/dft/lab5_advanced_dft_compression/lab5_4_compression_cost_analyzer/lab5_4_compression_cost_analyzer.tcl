source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Estimate shift-only time and tester cost using supplied assumptions.
set d [lab::fields compression_profile.txt]
foreach key {UNCOMPRESSED_CHAIN_LENGTH COMPRESSED_CHAIN_LENGTH TOTAL_PATTERNS SHIFT_FREQUENCY_MHZ ATE_COST_PER_SECOND_USD CHIP_PRODUCTION_VOLUME} {
    set $key [lab::required $d $key]
}
if {$COMPRESSED_CHAIN_LENGTH <= 0 || $SHIFT_FREQUENCY_MHZ <= 0 || $TOTAL_PATTERNS < 0 || $UNCOMPRESSED_CHAIN_LENGTH < 0 || $ATE_COST_PER_SECOND_USD < 0 || $CHIP_PRODUCTION_VOLUME < 0} {error "Invalid profile"}
set before [expr {double($UNCOMPRESSED_CHAIN_LENGTH)*$TOTAL_PATTERNS/($SHIFT_FREQUENCY_MHZ*1e6)}]
set after [expr {double($COMPRESSED_CHAIN_LENGTH)*$TOTAL_PATTERNS/($SHIFT_FREQUENCY_MHZ*1e6)}]
set savings [expr {($before-$after)*$ATE_COST_PER_SECOND_USD*$CHIP_PRODUCTION_VOLUME}]
puts [format "Shift-only: %.2f s -> %.2f s; %.2fx" $before $after [expr {double($UNCOMPRESSED_CHAIN_LENGTH)/$COMPRESSED_CHAIN_LENGTH}]]
puts [format "Estimated savings: USD %.2f for %d chips" $savings $CHIP_PRODUCTION_VOLUME]
puts "Capture cycles, overhead and changed pattern counts are excluded."
