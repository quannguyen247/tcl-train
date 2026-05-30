# Exercise 05: File I/O and Regex
# Goal: Create a sample report, read it back, and extract values with regexp.

set report_path [file join [pwd] "sample_timing_report.txt"]

set writer [open $report_path w]
puts $writer {Path: U1/Q -> U9/D}
puts $writer {Slack: 34.62 ns}
puts $writer {Arrival: 215.40 ns}
close $writer

set reader [open $report_path r]
set report_data [read $reader]
close $reader

set slack_value ""
set arrival_value ""

if {[regexp {Slack:\s+([0-9.]+)\s+ns} $report_data -> slack_value] &&
    [regexp {Arrival:\s+([0-9.]+)\s+ns} $report_data -> arrival_value]} {
    puts "Parsed slack: $slack_value ns"
    puts "Parsed arrival: $arrival_value ns"
} else {
    puts "Failed to parse report"
}

file delete -force $report_path
