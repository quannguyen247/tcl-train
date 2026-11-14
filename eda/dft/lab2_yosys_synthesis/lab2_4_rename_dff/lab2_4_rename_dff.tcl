# lab2 4 rename dff: see the lesson README for the task and inputs.
# Lab 2.4: Flip-Flop Instance Renamer

set fp [open "reg_bank.v" r]
set netlist_code [read $fp]
close $fp

set index 0
set new_lines [list]

foreach line [split $netlist_code "\n"] {
    set trimmed_line [string trim $line]

    if {[llength $trimmed_line] >= 2 && [string match {*FF*} [lindex $trimmed_line 0]]} {
        lassign $trimmed_line cell_name inst_name

        puts "\[RENAME\] Renamed instance $inst_name -> u_dff_$index (Type: $cell_name)"

        regsub $inst_name $line "u_dff_$index" line
        incr index
    }

    lappend new_lines $line
}

file mkdir build
set fp_out [open "build/reg_bank_renamed.v" w]
puts $fp_out [join $new_lines "\n"]
close $fp_out

puts "\[INFO\] Renamed $index fixture Flip-Flops. Output: build/reg_bank_renamed.v"
