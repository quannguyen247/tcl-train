# Vivado Tcl Lesson: 01_advanced_netlist_querying
# -------------------------------------------------------------------------
# Description: Filtering and tracing complex paths in the netlist.
# -------------------------------------------------------------------------

# 1. -filter and -regexp
# Use powerful regex and property filters to narrow down searches.
# set my_brams [get_cells -filter {PRIMITIVE_TYPE =~ BLOCKRAM.*.*}]
# set fast_clks [get_clocks -regexp {clk_(high|fast)_.*}]

# 2. -hierarchical
# Search through all levels of the design hierarchy instead of just the current level.
# set all_dsp_blocks [get_cells -hierarchical -filter {PRIMITIVE_TYPE =~ DSP.*.*}]

# 3. -of_objects
# Retrieve related objects (e.g., finding the pins connected to a specific net).
# set my_net [get_nets my_critical_path_net]
# set connected_pins [get_pins -of_objects $my_net]

# 4. all_fanin / all_fanout
# Trace logic paths forwards or backwards from a specific point.
# set endpoints [all_fanout -from [get_pins my_reg/Q] -endpoints_only]
# set startpoints [all_fanin -to [get_pins my_comb/I0] -startpoints_only]

# 5. get_timing_paths
# Query the timing engine directly for worst-case paths.
# set worst_path [get_timing_paths -max_paths 1 -setup]
# report_property $worst_path
