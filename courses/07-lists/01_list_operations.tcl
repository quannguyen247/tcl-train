# Exercise: EDA List Operations
# Scenario: You are analyzing a timing report.
# You have raw data about clock domains and timing paths.

# 1. Create a list of clock names: clk_sys, clk_mem, clk_io
set clocks [list clk_sys clk_mem clk_io]
puts "Initial clocks: $clocks"

# 2. Append a new clock 'clk_cpu' to the list
lappend clocks clk_cpu
puts "After append: $clocks"

# 3. Sort the clocks alphabetically (dictionary sort)
set sorted_clocks [lsort -dictionary $clocks]
puts "Sorted clocks: $sorted_clocks"

# 4. Search for any clock starting with 'clk_m' and print it
set mem_clk [lsearch -inline -glob $clocks clk_m*]
puts "Found memory clock: $mem_clk"

# 5. You have a list of timing path delays
set delays {1.2 0.8 2.5 1.1 0.9 3.0}

# Sort the delays in decreasing order (as real numbers)
set sorted_delays [lsort -real -decreasing $delays]
puts "Sorted delays: $sorted_delays"

# 6. Extract the top 3 worst delays (highest values) using lrange
set worst_delays [lrange $sorted_delays 0 2]
puts "Top 3 worst delays: $worst_delays"

# 7. You have a CSV string of pin names. Convert to list, then join with " -> "
set pin_csv "FF1/Q,U1/A,U1/Y,FF2/D"
set pin_list [split $pin_csv ","]
set path_string [join $pin_list " -> "]
puts "Timing path: $path_string"

# ==============================================================================
# 8. PARALLEL FOREACH ITERATION IN EDA SCRIPTING
# ==============================================================================
# In EDA tools, we frequently process paired lists: {cell_names} and {pin_names}
set cells {U_INV_01 U_NAND_02 U_FF_03}
set pins  {Y        OUT       Q}

# Iterate over multiple lists simultaneously in a single foreach loop
foreach cell $cells pin $pins {
    puts "Connecting Cell: $cell -> Output Pin: $pin"
}
