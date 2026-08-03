# Bài học Vivado Tcl: 07_partial_reconfiguration_dfx
# -------------------------------------------------------------------------
# Mô tả: Thiết lập tính năng Dynamic Function eXchange (DFX) / Cấu hình lại một phần.
# -------------------------------------------------------------------------

# 1. set_property HD.RECONFIGURABLE
# Đánh dấu một cell phân cấp là Phân vùng có thể cấu hình lại (Reconfigurable Partition - RP).
# set_property HD.RECONFIGURABLE true [get_cells my_reconfig_module]

# 2. create_pblock
# Tạo một khối ràng buộc vật lý (pblock) trên FPGA để chứa phần logic cấu hình lại.
# create_pblock pblock_rp1

# 3. add_cells_to_pblock
# Gán cell RP vào pblock vừa tạo.
# add_cells_to_pblock [get_pblocks pblock_rp1] [get_cells my_reconfig_module]

# 4. resize_pblock
# Xác định ranh giới vật lý (số lượng SLICE, DSP, RAM) của pblock.
# resize_pblock [get_pblocks pblock_rp1] -add {SLICE_X10Y20:SLICE_X50Y60 DSP48_X0Y10:DSP48_X1Y20}

# 5. write_bitstream (Bitstream một phần)
# Khi bật DFX, write_bitstream tự động tạo ra cả bitstream toàn bộ (full) 
# và các bitstream một phần (partial) cho các module được cấu hình lại.
# write_bitstream -force ./top_design.bit
