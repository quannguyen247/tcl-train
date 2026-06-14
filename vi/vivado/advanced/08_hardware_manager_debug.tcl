# Bài học Vivado Tcl: 08_hardware_manager_debug
# -------------------------------------------------------------------------
# Mô tả: Nạp chương trình cho FPGA và phân tích logic trên chip bằng Hardware Manager.
# -------------------------------------------------------------------------

# 1. open_hw_manager / connect_hw_server
# Mở trình quản lý phần cứng và kết nối tới máy chủ JTAG (cục bộ hoặc từ xa).
# open_hw_manager
# connect_hw_server -url localhost:3121

# 2. open_hw_target / current_hw_device
# Kết nối với cáp nạp cụ thể và chọn thiết bị FPGA.
# current_hw_target [get_hw_targets */xilinx_tcf/Digilent/*]
# open_hw_target
# set device [current_hw_device [get_hw_devices xc7z020_1]]

# 3. set_property PROGRAM.FILE / program_hw_devices
# Chỉ định file bitstream và nạp vào FPGA.
# set_property PROGRAM.FILE {./output.bit} $device
# set_property PROBES.FILE {./debug_nets.ltx} $device
# program_hw_devices $device

# 4. create_hw_ila / create_hw_vio
# Tương tác với các lõi Integrated Logic Analyzer (ILA) và Virtual I/O (VIO) trên FPGA.
# Thông thường, Vivado tự phát hiện ILA khi file LTX được cung cấp.
# set ila [get_hw_ilas hw_ila_1]

# 5. run_hw_ila / display_hw_ila_data
# Kích hoạt ILA để bắt dữ liệu, và hiển thị nó trong trình xem sóng.
# run_hw_ila $ila
# wait_on_hw_ila $ila
# display_hw_ila_data [upload_hw_ila_data $ila]
