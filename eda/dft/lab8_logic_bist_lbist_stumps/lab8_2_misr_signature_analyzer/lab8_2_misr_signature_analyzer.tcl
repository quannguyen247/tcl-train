source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Compare two supplied signatures and show an idealized aliasing estimate.
set d [lab::fields misr_signature.txt]
set measured [lab::required $d MEASURED_SIGNATURE]
set golden [lab::required $d GOLDEN_SIGNATURE]
set width [lab::required $d MISR_WIDTH]
if {$width <= 0 || $width > 64} {error "Invalid signature width"}
puts "Sample measured=$measured golden=$golden match=[expr {$measured == $golden}]"
puts [format "Ideal uniform-error estimate: 2^(-%d) = %.3e" $width [expr {pow(2.0,-$width)}]]
puts "A matching signature does not prove defect-free silicon; aliasing depends on the error model."
if {$measured != $golden} {exit 1}
