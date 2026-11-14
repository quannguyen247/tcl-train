# Fault example 8. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup atpg_bypass
faultlab::run {fault atpg --cell-model cells_sim.v --clock clk --min-coverage 85 --ceiling 150 --bypassing op -o tv.json alu_comb.v} tv.json
