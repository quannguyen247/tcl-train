source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Software model of TAP transitions. The supplied Verilog is only a shell.
set transitions [dict create \
    Reset {Idle Reset} Idle {Idle SelectDR} SelectDR {CaptureDR SelectIR} \
    CaptureDR {ShiftDR Exit1DR} ShiftDR {ShiftDR Exit1DR} \
    Exit1DR {PauseDR UpdateDR} PauseDR {PauseDR Exit2DR} \
    Exit2DR {ShiftDR UpdateDR} UpdateDR {Idle SelectDR} \
    SelectIR {CaptureIR Reset} CaptureIR {ShiftIR Exit1IR} \
    ShiftIR {ShiftIR Exit1IR} Exit1IR {PauseIR UpdateIR} \
    PauseIR {PauseIR Exit2IR} Exit2IR {ShiftIR UpdateIR} UpdateIR {Idle SelectDR}]
proc step {table state tms} {return [lindex [dict get $table $state] $tms]}
set state Reset
foreach bit {1 1 1 1 1 0 1 1 0 0} {set state [step $transitions $state $bit]}
if {$state ne "ShiftIR"} {error "Expected ShiftIR, got $state"}
set ir 0
set bits {1 0 0 0 0}
for {set i 0} {$i < [llength $bits]} {incr i} {
    set ir [expr {($ir >> 1) | ([lindex $bits $i] << 4)}]
    set state [step $transitions $state [expr {$i == 4}]]
}
set state [step $transitions $state 1]
puts [format "TAP model: state=%s, shifted instruction=0x%02X" $state $ir]
if {$state ne "UpdateIR" || $ir != 1} {error "Unexpected TAP model result"}
puts "This exercises one path, not complete IEEE 1149.1 conformance."
