# Vivado Tcl Lesson: 02_netlist_manipulation
# -------------------------------------------------------------------------
# Description: Modifying the netlist dynamically via Tcl (ECO flow).
# -------------------------------------------------------------------------

# 1. add_cells / remove_cells
# Instantiate new primitives or remove existing ones.
# add_cells -reference LUT2 my_new_lut
# remove_cells [get_cells my_buggy_logic]

# 2. create_net / create_port
# Create new wires or top-level ports.
# create_net new_debug_wire
# create_port -direction OUT debug_out

# 3. connect_net / disconnect_net
# Connect a net to a pin/port, or break an existing connection.
# connect_net -net new_debug_wire -objects [get_pins my_new_lut/O]
# disconnect_net -net [get_nets bad_connection] -objects [get_pins my_reg/D]

# 4. set_property DONT_TOUCH
# Prevent synthesis or implementation from optimizing away specific logic.
# set_property DONT_TOUCH true [get_cells my_keep_reg]

# 5. set_property MARK_DEBUG
# Tag a net to be preserved and made visible to the Integrated Logic Analyzer (ILA).
# set_property MARK_DEBUG true [get_nets my_critical_state_machine_net]
