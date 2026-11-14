# Fault example 7. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup atpg_metadata
faultlab::run {fault atpg --cell-model cells_sim.v --clock clk --min-coverage 80 --ceiling 150 -v 50 --output-coverage-metadata coverage.yml -o tv.json gates.v} tv.json
if {![file isfile coverage.yml]} {error "Coverage metadata not produced"}
