# Vivado Tcl Lesson: 07_partial_reconfiguration_dfx
# -------------------------------------------------------------------------
# Description: Setting up Dynamic Function eXchange (DFX) / Partial Reconfiguration.
# -------------------------------------------------------------------------

# 1. set_property HD.RECONFIGURABLE
# Mark a hierarchical cell as a Reconfigurable Partition (RP).
# set_property HD.RECONFIGURABLE true [get_cells my_reconfig_module]

# 2. create_pblock
# Create a physical block constraint on the FPGA fabric to contain the reconfigurable logic.
# create_pblock pblock_rp1

# 3. add_cells_to_pblock
# Assign the RP cell to the newly created pblock.
# add_cells_to_pblock [get_pblocks pblock_rp1] [get_cells my_reconfig_module]

# 4. resize_pblock
# Specify the physical boundaries (slices, DSPs, RAMs) of the pblock.
# resize_pblock [get_pblocks pblock_rp1] -add {SLICE_X10Y20:SLICE_X50Y60 DSP48_X0Y10:DSP48_X1Y20}

# 5. write_bitstream (Partial bitstreams)
# When DFX is enabled, write_bitstream automatically generates both the full bitstream 
# and the partial bitstreams for the reconfigurable modules.
# write_bitstream -force ./top_design.bit
