# Fault example 6. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup atpg
faultlab::run {fault atpg --cell-model cells_sim.v --clock clk --min-coverage 80 --ceiling 150 -v 50 -o tv.json gates.v} tv.json
