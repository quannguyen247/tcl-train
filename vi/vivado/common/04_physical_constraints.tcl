# Bài học Vivado Tcl: 04_physical_constraints
# -------------------------------------------------------------------------
# Mô tả: Ánh xạ cổng (port) vào chân (pin) FPGA và thiết lập thuộc tính điện.
# -------------------------------------------------------------------------

# 1. set_property PACKAGE_PIN
# Gán một cổng logic trong RTL vào một chân vật lý trên vỏ FPGA.
# set_property PACKAGE_PIN W5 [get_ports clk]
# set_property PACKAGE_PIN V17 [get_ports {sw[0]}]

# 2. set_property IOSTANDARD
# Định nghĩa chuẩn điện áp cho chân I/O (vd: LVCMOS33, LVDS).
# set_property IOSTANDARD LVCMOS33 [get_ports clk]
# set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]

# 3. set_property SLEW
# Đặt tốc độ thay đổi biên độ (slew rate) của chân đầu ra là SLOW hoặc FAST.
# Sử dụng SLOW giúp giảm nhiễu tín hiệu và EMI cho các tín hiệu không quan trọng.
# set_property SLEW SLOW [get_ports led]

# 4. set_property DRIVE
# Thiết lập cường độ dòng kéo (drive strength) tính bằng mA cho chân đầu ra.
# set_property DRIVE 12 [get_ports led]

# 5. set_property PULLUP / PULLDOWN
# Bật điện trở kéo lên hoặc kéo xuống tích hợp bên trong FPGA cho các chân đầu vào.
# set_property PULLUP true [get_ports btnC]

# Lưu ý: Các ràng buộc vật lý cũng có thể được định nghĩa trực tiếp trong file XDC bằng cùng cú pháp:
# set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]
