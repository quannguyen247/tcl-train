# Fault example 3. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup cut
faultlab::synth
faultlab::run {fault cut --clock clk --reset rst -d DFFARX1 -o seq_cut.v seq_synth.v} seq_cut.v
