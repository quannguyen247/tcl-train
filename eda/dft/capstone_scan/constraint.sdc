# Educational functional-mode timing constraints, in ns.
create_clock -name core_clk -period 10 [get_ports clk]
set_input_delay -clock core_clk 1 [get_ports {enable scan_enable scan_in}]
set_output_delay -clock core_clk 1 [all_outputs]
set_false_path -from [get_ports rst_n]
