# Vivado Tcl Lesson: 03_timing_constraints
# -------------------------------------------------------------------------
# Description: Defining clocks and timing requirements (XDC).
# -------------------------------------------------------------------------

# 1. create_clock
# Defines a primary clock entering the FPGA.
# Example: 100 MHz clock on port 'clk_in'
# create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports clk_in]

# 2. create_generated_clock
# Defines a clock derived from a primary clock (e.g., from a PLL or clock divider).
# create_generated_clock -name clk_div2 -source [get_pins my_pll/clk_in] -divide_by 2 [get_pins my_pll/clk_out]

# 3. set_clock_groups
# Specifies clocks that are asynchronous or exclusive to each other.
# set_clock_groups -asynchronous -group [get_clocks sys_clk] -group [get_clocks pcie_clk]

# 4. set_input_delay / set_output_delay
# Constrains the I/O interface timing relative to a clock.
# set_input_delay -clock [get_clocks sys_clk] 2.0 [get_ports data_in]
# set_output_delay -clock [get_clocks sys_clk] 1.5 [get_ports data_out]

# 5. set_false_path
# Instructs the timing analyzer to ignore timing on specific paths.
# set_false_path -from [get_ports reset_n] -to [all_registers]

# 6. set_max_delay / set_multicycle_path
# Advanced timing constraints to override default setup/hold requirements.
# set_max_delay -from [get_cells reg_A] -to [get_cells reg_B] 5.0
# set_multicycle_path -setup -from [get_clocks clk1] -to [get_clocks clk2] 2

# 7. read_xdc / write_xdc
# Reads constraints from a file, or exports current constraints in memory to a file.
# read_xdc ./constraints/timing.xdc
# write_xdc ./out/exported_constraints.xdc
