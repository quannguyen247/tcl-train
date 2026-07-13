# Exercise: File Operations
# 1. Write a timing report to a file.
# 2. Read it back and parse specific lines.
# 3. Query file metadata.
# 4. Clean up the file.

set filename "timing_report.rpt"

# 1. Write the timing report
set fd [open $filename "w"]
puts $fd "Timing Report"
puts $fd "Path: clk_in -> data_out"
puts $fd "Slack: -0.45 ns (VIOLATED)"
puts $fd "Slack: 1.25 ns (MET)"
close $fd

puts "--- File Metadata ---"
puts "Exists: [file exists $filename]"
puts "Size: [file size $filename] bytes"
puts "Tail: [file tail $filename]"

puts "\n--- Parsing Report ---"
# 2. Read and parse lines
set fd [open $filename "r"]
while {![eof $fd]} {
    if {[gets $fd line] >= 0} {
        if {[string match "*Slack*VIOLATED*" $line]} {
            puts "Found violation: $line"
        }
    }
}
close $fd

# 4. Cleanup
file delete $filename
puts "\nFile deleted: [expr {![file exists $filename] ? "Yes" : "No"}]"
