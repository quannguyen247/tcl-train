# ==============================================================================
# VIVADO COMMON LESSON 02: REPORTING HARDWARE UTILIZATION AND TIMING
# ==============================================================================
# In IC/FPGA design, verifying that the chip meets timing constraints (Worst Negative
# Slack - WNS) and does not exceed hardware resources (LUT/FF/BRAM/DSP) is mandatory.
# ==============================================================================

# 1. TIMING SUMMARY REPORT
# ------------------------------------------------------------------------------
# Export overall Timing Summary report to a text file
puts "--> Generating Timing Summary report..."
report_timing_summary -file ./build_output/reports/timing_summary.rpt -max_paths 10

# Query Worst Negative Slack (WNS) programmatically (WNS < 0 indicates timing violation)
set wns [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]]
puts "Current Worst Negative Slack (WNS): $wns ns"

if {$wns < 0} {
    puts "[WARNING]: Setup Timing Violation detected! WNS = $wns ns"
} else {
    puts "[SUCCESS]: Design MET TIMING constraints!"
}

# 2. HARDWARE UTILIZATION REPORT
# ------------------------------------------------------------------------------
puts "--> Exporting Hardware Resource Utilization report (LUT, FF, BRAM, DSP)..."
report_utilization -file ./build_output/reports/utilization.rpt

# 3. POWER CONSUMPTION REPORT
# ------------------------------------------------------------------------------
puts "--> Calculating Power Consumption analysis..."
report_power -file ./build_output/reports/power_analysis.rpt

# 4. I/O BANK AND PIN VOLTAGE REPORT
# ------------------------------------------------------------------------------
puts "--> Exporting I/O Pin placement and voltage standard report..."
report_io -file ./build_output/reports/io_report.rpt

puts "--> All design reports exported successfully to ./build_output/reports/"
