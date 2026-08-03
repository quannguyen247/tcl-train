# Bài học Vivado Tcl: 03_batch_flow_checkpoints
# -------------------------------------------------------------------------
# Mô tả: Quản lý các trạng thái thiết kế trung gian và xuất file.
# -------------------------------------------------------------------------

# 1. write_checkpoint
# Lưu trạng thái chính xác của thiết kế (netlist, constraints, định tuyến) ra file DCP.
# write_checkpoint -force ./post_synth.dcp

# 2. read_checkpoint
# Nạp lại file DCP đã lưu trước đó vào bộ nhớ.
# read_checkpoint ./post_synth.dcp

# 3. write_edif / write_verilog / write_vhdl
# Xuất netlist ra các định dạng chuẩn để dùng cho phần mềm bên thứ 3 hoặc mô phỏng.
# write_edif -force ./netlist.edf
# write_verilog -force -mode timesim -sdf_anno true ./netlist_sim.v

# 4. write_bitstream
# Tạo file bitstream (.bit) dùng để nạp cho FPGA.
# write_bitstream -force ./output.bit

# 5. write_device_image
# Tương tự như write_bitstream nhưng dùng cho các thiết bị dòng Versal (định dạng PDI).
# write_device_image -force ./output.pdi

# 6. write_hw_platform
# Xuất định nghĩa phần cứng (.xsa) phục vụ cho việc phát triển phần mềm trong Vitis.
# write_hw_platform -fixed -force -file ./system.xsa
