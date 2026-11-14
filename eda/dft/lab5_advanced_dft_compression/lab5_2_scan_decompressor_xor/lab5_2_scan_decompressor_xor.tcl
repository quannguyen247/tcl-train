source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# List the XOR equations and calculate the structural expansion factor.
set text [lab::read_input decompressor_netlist.v]
set outputs [regexp -all -inline {assign\s+int_si\[[0-9]+\]\s*=\s*[^;]+;} $text]
set inputs [lsort -unique [regexp -all -inline {ext_si\[[0-9]+\]} [join $outputs "\n"]]]
if {![llength $outputs] || ![llength $inputs]} {error "No supported equations found"}
foreach equation $outputs {puts $equation}
puts [format "%d internal chains / %d external inputs = %.2fx expansion" \
    [llength $outputs] [llength $inputs] [expr {double([llength $outputs])/[llength $inputs]}]]
