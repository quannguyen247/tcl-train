source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Compare supplied sample power values against a supplied limit.
set d [lab::fields power_profile.txt]
set before [lab::required $d UNMANAGED_POWER_W]
set after [lab::required $d MANAGED_POWER_W]
set limit [lab::required $d SAFE_POWER_LIMIT_W]
set phases [lab::required $d CLOCK_GATING_PHASES]
if {$phases <= 0} {error "Number of phases must be positive"}
puts "Sample peak power: $before W -> $after W, limit $limit W, phases=$phases"
puts "Sample above limit: before=[expr {$before > $limit}], after=[expr {$after > $limit}]"
puts "The fixture is not a power measurement or a thermal-safety proof."
