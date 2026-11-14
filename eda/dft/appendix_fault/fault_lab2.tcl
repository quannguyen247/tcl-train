# Fault example 2. A failed tool invocation stops this exercise.
source [file join [file dirname [file normalize [info script]]] fault_common.tcl]
faultlab::setup synth
faultlab::synth
