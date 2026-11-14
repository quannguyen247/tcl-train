# lab1 1 timing slack: see the lesson README for the task and inputs.
# Lab 1.1: Timing Slack & Frequency Calculation

set clock_period 2.5
set setup_time 0.2
set hold_time 0.1
set clk_skew 0.05
set data_delay 2.1

set arrival_time $data_delay
set required_time [expr {$clock_period - $setup_time + $clk_skew}]
set setup_slack [expr {$required_time - $arrival_time}]
set max_freq_mhz [expr {1000.0 / $clock_period}]

puts "=== TIMING REPORT ==="
puts "Clock Period  : $clock_period ns"
puts "Arrival Time  : $arrival_time ns"
puts "Required Time : [format "%.2f" $required_time] ns"
puts "Setup Slack   : [format "%.2f" $setup_slack] ns"
puts "Clock Frequency : [format "%.1f" $max_freq_mhz] MHz"
puts "This simple setup calculation does not analyze hold timing."
