# Fault example 5. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup tap
faultlab::synth
faultlab::chain
faultlab::run {fault tap --clock clk --liberty tech_lib.lib -o seq_jtag.v seq_chained.v} seq_jtag.v
