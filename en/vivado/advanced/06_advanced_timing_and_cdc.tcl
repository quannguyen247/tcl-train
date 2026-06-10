# Vivado Tcl Lesson: 06_advanced_timing_and_cdc
# -------------------------------------------------------------------------
# Description: Advanced timing constraints, grouping, and Clock Domain Crossing analysis.
# -------------------------------------------------------------------------

# 1. group_path / get_path_groups
# Group specific timing paths to assign them different priorities or weights during implementation.
# group_path -name my_critical_paths -weight 2.0 -from [get_cells *critical*]

# 2. report_exceptions
# View all timing exceptions (false paths, multicycle paths, max delays) applied to the design.
# report_exceptions -file ./timing_exceptions.rpt

# 3. report_cdc
# Comprehensive analysis of Clock Domain Crossings to find unsafe synchronizers.
# report_cdc -details -file ./cdc_report.rpt

# 4. report_methodology
# Runs methodology checks for Xilinx recommendations (timing, CDC, reset practices).
# report_methodology -file ./methodology.rpt

# 5. set_clock_uncertainty
# Add jitter or margin to a clock for a more pessimistic timing analysis.
# set_clock_uncertainty -setup 0.5 [get_clocks sys_clk]
