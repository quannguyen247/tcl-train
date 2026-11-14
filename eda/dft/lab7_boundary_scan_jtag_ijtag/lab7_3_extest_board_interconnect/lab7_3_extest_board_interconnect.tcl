source [file join [file dirname [file normalize [info script]]] .. .. common.tcl]
# Summarize an invented interconnect report, not a measured EXTEST run.
set count 0; set bad 0
foreach line [split [lab::read_input pcb_board_report.txt] "\n"] {
    if {![regexp {^(NET_DATA\[[0-9]+\]):\s*(.+)\|\s*STATUS\s*=\s*(\S+)} $line -> net route status]} continue
    incr count
    if {$status ne "OK"} {incr bad}
    puts "$net: [string trim $route] => $status"
}
if {!$count} {error "No fixture records"}
puts "Sample report: $bad flagged of $count records; no physical board was tested."
