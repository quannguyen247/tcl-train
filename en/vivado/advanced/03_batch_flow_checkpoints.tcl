# Vivado Tcl Lesson: 03_batch_flow_checkpoints
# -------------------------------------------------------------------------
# Description: Managing intermediate design states and outputs.
# -------------------------------------------------------------------------

# 1. write_checkpoint
# Saves the exact state of the design (netlist, constraints, routing) to a DCP file.
# write_checkpoint -force ./post_synth.dcp

# 2. read_checkpoint
# Loads a previously saved DCP file back into memory.
# read_checkpoint ./post_synth.dcp

# 3. write_edif / write_verilog / write_vhdl
# Exports the netlist to standard formats for third-party tools or simulation.
# write_edif -force ./netlist.edf
# write_verilog -force -mode timesim -sdf_anno true ./netlist_sim.v

# 4. write_bitstream
# Generates the bitstream file (.bit) used to program the FPGA.
# write_bitstream -force ./output.bit

# 5. write_device_image
# Equivalent to write_bitstream but used for Versal devices (PDI format).
# write_device_image -force ./output.pdi

# 6. write_hw_platform
# Exports the hardware definition (.xsa) for software development in Vitis.
# write_hw_platform -fixed -force -file ./system.xsa
