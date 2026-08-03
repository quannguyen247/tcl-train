# Vivado Tcl Lesson: 04_ip_integrator_bd
# -------------------------------------------------------------------------
# Description: Automating block designs (IPI) using Tcl.
# -------------------------------------------------------------------------

# 1. create_bd_design
# Creates a new empty block design.
# create_bd_design "my_system"

# 2. create_bd_cell
# Instantiates an IP into the block design.
# create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ps

# 3. connect_bd_net / connect_bd_intf_net
# Connects standard nets (wires) or grouped interfaces (like AXI).
# connect_bd_net [get_bd_pins zynq_ps/pl_clk0] [get_bd_pins my_ip/clk]
# connect_bd_intf_net [get_bd_intf_pins zynq_ps/M_AXI_HPM0_FPD] [get_bd_intf_pins axi_interconnect/S00_AXI]

# 4. create_bd_port / create_bd_intf_port
# Creates external ports on the block design boundary.
# create_bd_port -dir I -type clk sys_clock

# 5. apply_bd_automation
# Asks Vivado to automatically connect clocks, resets, or AXI interfaces.
# apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/zynq_ps/M_AXI_HPM0_FPD"}  [get_bd_intf_pins my_ip/s_axi]

# 6. validate_bd_design / save_bd_design / make_wrapper
# Validates the design rules, saves it, and generates the top-level HDL wrapper.
# validate_bd_design
# save_bd_design
# make_wrapper -files [get_files my_system.bd] -top
