# Summarize supplied sample reports; this script does not run a DFT flow.
source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
set rtl [lab::read_input alu_top.v]
set synth [lab::read_input synth_summary.txt]
set atpg [lab::read_input atpg_result.txt]
set top [lab::match_one $rtl {module\s+(\w+)} {RTL module}]
set reported_top [lab::match_one $synth {Top Module Name:\s*(\w+)} {reported top}]
if {$top ne $reported_top} {error "RTL and report top names disagree"}
foreach {key text pattern} [list gates $synth {Total Gate Count:\s*(\d+)} \
    length $synth {Scan Chain Length:\s*(\d+)} drc $synth {DFT DRC Violations:\s*(\d+)} \
    vectors $atpg {Total Test Vectors:\s*(\d+)} coverage $atpg {Final Fault Coverage:\s*([0-9.]+)%}] {
    set $key [lab::match_one $text $pattern $key]
}
puts "Sample report only (no synthesis, scan insertion or ATPG was run):"
puts "Top=$top gates=$gates scan_length=$length DRC=$drc vectors=$vectors coverage=$coverage%"
