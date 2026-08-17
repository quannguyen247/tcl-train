# Vivado Tcl Lesson: 04_physical_constraints
# -------------------------------------------------------------------------
# Description: Mapping ports to FPGA pins and setting electrical properties.
# -------------------------------------------------------------------------

# 1. set_property PACKAGE_PIN
# Assigns a logical port in your RTL to a physical pin on the FPGA package.
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property PACKAGE_PIN V17 [get_ports {sw[0]}]

# 2. set_property IOSTANDARD
# Defines the electrical standard for the I/O pin (e.g., LVCMOS33, LVDS).
# set_property IOSTANDARD LVCMOS33 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

# 3. set_property SLEW
# Sets the slew rate (transition speed) of an output pin to SLOW or FAST.
# Using SLOW reduces signal noise and EMI for non-critical signals.
# set_property SLEW SLOW [get_ports led]

# 4. set_property DRIVE
# Sets the drive strength in mA for an output pin.
# set_property DRIVE 12 [get_ports led]

# 5. set_property PULLUP / PULLDOWN
# Enables internal pull-up or pull-down resistors on input pins.
# set_property PULLUP true [get_ports btnC]

# Note: Physical constraints can also be defined in an XDC file directly using the same syntax:
# set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]
