# Vivado Tcl Lesson: 05_reports_and_analysis
# -------------------------------------------------------------------------
# Description: Generating reports for timing, utilization, power, and DRC.
# -------------------------------------------------------------------------

# 1. report_timing_summary
# Generates a comprehensive timing report for the whole design.
# -file saves it to a file.
# report_timing_summary -file ./reports/timing_summary.rpt -delay_type min_max

# 2. report_timing
# Reports timing for specific paths, often used for debugging failing paths.
# report_timing -from [get_ports data_in] -to [get_cells my_reg] -max_paths 10 -file ./reports/path_timing.rpt

# 3. report_utilization
# Shows FPGA resource usage (LUTs, FFs, BRAMs, DSPs, etc.).
# report_utilization -file ./reports/utilization.rpt -hierarchical

# 4. report_power
# Estimates power consumption based on the design and activity rates.
# report_power -file ./reports/power.rpt

# 5. report_drc
# Runs Design Rule Checks to identify potential hardware issues.
# report_drc -file ./reports/drc.rpt

# 6. report_design_analysis
# Provides advanced analysis on logic depth, fanout, and congestion.
# report_design_analysis -complexity -timing -file ./reports/design_analysis.rpt
