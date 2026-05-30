# Exercise 02: Mathematical Expressions
# 1. Declare variable 'frequency_mhz' with value 400.0.
# 2. Calculate the clock period 'clock_period_ns' using the formula: Period (ns) = 1000.0 / Frequency (MHz).
# 3. Convert 'clock_period_ns' to picoseconds (ps) and store in 'clock_period_ps' (1 ns = 1000 ps).
# 4. Declare variables 'gate_delay_ps' = 850 and 'wire_delay_ps' = 450.
# 5. Calculate total path delay 'total_delay_ps' as the sum of gate and wire delays.
# 6. Calculate the percentage (%) of wire delay relative to the total path delay, store it in 'wire_delay_pct'.
# 7. Calculate the Timing Slack: Slack = clock_period_ps - total_delay_ps.
# 8. Print the calculated parameters in this format:
#    "Clock Period: <value> ns (<value> ps)"
#    "Total Path Delay: <value> ps"
#    "Wire Delay Ratio: <value>%"
#    "Timing Slack: <value> ps"
# Bonus: Ensure that the percentage result contains decimal places (e.g., 34.62% instead of 34%) and apply Tcl best practices by wrapping all mathematical expressions of the 'expr' command in braces `{}`.
# Write your code here:

# 1. Declare variable 'frequency_mhz' with value 400.0.
set frequency_mhz 400.0

# 2. Calculate the clock period 'clock_period_ns' using the formula: Period (ns) = 1000.0 / Frequency (MHz).
set clock_period_ns [expr {1000.0 / $frequency_mhz}]

# 3. Convert 'clock_period_ns' to picoseconds (ps) and store in 'clock_period_ps' (1 ns = 1000 ps).
set clock_period_ps [expr {$clock_period_ns * 1000.0}]

# 4. Declare variables 'gate_delay_ps' = 850 and 'wire_delay_ps' = 450.
set gate_delay_ps 850
set wire_delay_ps 450

# 5. Calculate total path delay 'total_delay_ps' as the sum of gate and wire delays.
set total_delay_ps [expr {$gate_delay_ps + $wire_delay_ps}]

# 6. Calculate the percentage (%) of wire delay relative to the total path delay, store it in 'wire_delay_pct'.
set wire_delay_pct [expr {($wire_delay_ps * 100.0) / $total_delay_ps}]

# 7. Calculate the Timing Slack: Slack = clock_period_ps - total_delay_ps.
set slack [expr {$clock_period_ps - $total_delay_ps}]

# 8. Print the calculated parameters in the requested format.
set wire_delay_pct_formatted [format "%.2f" $wire_delay_pct]
puts "Clock Period: $clock_period_ns ns ($clock_period_ps ps)"
puts "Total Path Delay: $total_delay_ps ps"
puts "Wire Delay Ratio: ${wire_delay_pct_formatted}%"
puts "Timing Slack: $slack ps"
