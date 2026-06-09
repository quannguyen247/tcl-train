# Vivado Tcl Lesson: 08_basic_netlist_queries
# -------------------------------------------------------------------------
# Description: Searching and retrieving objects from the design netlist.
# -------------------------------------------------------------------------

# 1. get_cells
# Retrieves module instances, primitives, or blocks in the design.
# set my_cells [get_cells *my_module*]

# 2. get_nets
# Retrieves wires/signals connecting the cells.
# set data_nets [get_nets data_bus*]

# 3. get_pins
# Retrieves the physical connection points on cells.
# set clk_pins [get_pins -of_objects [get_cells *] -filter {NAME =~ *clk*}]

# 4. get_ports
# Retrieves the top-level I/O ports of the FPGA design.
# set inputs [get_ports -filter {DIRECTION == IN}]

# 5. get_clocks
# Retrieves the defined clock domains in the design.
# set clks [get_clocks]

# Example: Iterating through ports and printing them
# foreach p [get_ports] {
#     puts "Port Found: $p"
# }
