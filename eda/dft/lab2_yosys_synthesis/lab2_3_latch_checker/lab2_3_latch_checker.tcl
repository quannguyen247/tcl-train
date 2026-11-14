# lab2 3 latch checker: see the lesson README for the task and inputs.
# Lab 2.3: Unintentional Latch Checker (DRC Rule Check)

set fp [open "alu_latch_bad.v" r]
set content [read $fp]
close $fp

set latches [list]

foreach line [split $content "\n"] {
    set line [string trim $line]

    if {[llength $line] >= 2 && [string match {*LATCH*} [lindex $line 0]]} {
        lassign $line cell_name inst_name
        lappend latches [list $inst_name $cell_name]
    }
}

if {[llength $latches] > 0} {
    puts "\[WARNING\] Detected [llength $latches] unintentional Latch(es) in design:"
    foreach latch $latches {
        puts "  - [lindex $latch 0] ([lindex $latch 1])"
    }
    puts {[DRC STATUS] FAIL - Please fix unhandled conditions in always blocks!}
} else {
    puts {[DRC STATUS] PASS - No unintentional latches found.}
}
