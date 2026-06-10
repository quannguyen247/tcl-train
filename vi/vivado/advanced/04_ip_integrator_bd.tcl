# Bài học Vivado Tcl: 04_ip_integrator_bd
# -------------------------------------------------------------------------
# Mô tả: Tự động hóa thiết kế dạng khối (IPI) bằng Tcl.
# -------------------------------------------------------------------------

# 1. create_bd_design
# Tạo một block design trống mới.
# create_bd_design "my_system"

# 2. create_bd_cell
# Khởi tạo một IP vào bên trong block design.
# create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ps

# 3. connect_bd_net / connect_bd_intf_net
# Kết nối các dây mạng tiêu chuẩn (wires) hoặc các giao diện nhóm (như AXI).
# connect_bd_net [get_bd_pins zynq_ps/pl_clk0] [get_bd_pins my_ip/clk]
# connect_bd_intf_net [get_bd_intf_pins zynq_ps/M_AXI_HPM0_FPD] [get_bd_intf_pins axi_interconnect/S00_AXI]

# 4. create_bd_port / create_bd_intf_port
# Tạo các cổng ngoại vi ở ranh giới của block design.
# create_bd_port -dir I -type clk sys_clock

# 5. apply_bd_automation
# Yêu cầu Vivado tự động kết nối xung nhịp, reset, hoặc các giao diện AXI.
# apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/zynq_ps/M_AXI_HPM0_FPD"}  [get_bd_intf_pins my_ip/s_axi]

# 6. validate_bd_design / save_bd_design / make_wrapper
# Xác nhận luật thiết kế, lưu, và tạo file HDL bọc (wrapper) cho tầng cao nhất.
# validate_bd_design
# save_bd_design
# make_wrapper -files [get_files my_system.bd] -top
