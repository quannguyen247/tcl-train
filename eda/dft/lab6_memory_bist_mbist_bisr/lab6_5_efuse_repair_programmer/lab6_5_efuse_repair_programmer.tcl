source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Format a repair plan as example register values. Nothing is programmed.
set d [lab::fields repair_plan.txt]
set chip [lab::required $d CHIP_ID]
foreach kind {ROW COL} {
    set value [lab::required $d REDUNDANT_${kind}_0]
    if {![string is integer -strict $value] || $value < 0 || $value > 65535} {error "Invalid $kind address"}
    puts [format "%s_REPAIR_0 = 0x%04X" $kind $value]
}
puts "Fixture chip $chip: register values only; no eFuse access or lock operation."
