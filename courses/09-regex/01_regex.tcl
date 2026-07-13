# Exercise: Regular Expressions in EDA
# Scenario: Parsing timing report lines

set report_lines {
    "Startpoint: reg_A/CK (rising edge-triggered flip-flop clocked by clk_sys)"
    "Endpoint: reg_B/D (rising edge-triggered flip-flop clocked by clk_sys)"
    "Path Group: clk_sys"
    "Path Type: max"
    "Slack (VIOLATED)        -0.45"
    "Slack (MET)              1.20"
}

puts "--- Slack Extraction ---"
foreach line $report_lines {
    # 1. Extract Slack value and status (MET or VIOLATED)
    # Hint: Match "Slack (STATUS) VALUE"
    if {[regexp {Slack\s+\((MET|VIOLATED)\)\s+([-\d.]+)} $line match status value]} {
        puts "Found Slack: $value (Status: $status)"
    }
}

puts "\n--- Pin Extraction ---"
foreach line $report_lines {
    # 2. Extract startpoint and endpoint pins
    if {[regexp {^(Startpoint|Endpoint):\s+(\S+)} $line match type pin]} {
        puts "$type Pin: $pin"
    }
}

puts "\n--- Report Formatting ---"
set ugly_string "delay= 1.50   slack= -0.2   cap=  0.05"
# 3. Use regsub to clean up multiple spaces to a single space, 
# and replace '=' with ':'
regsub -all {\s+} $ugly_string " " clean1
regsub -all {\s*=\s*} $clean1 ": " clean2
puts "Original: $ugly_string"
puts "Cleaned:  $clean2"
