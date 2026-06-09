# Bài học Vivado Tcl: 03_timing_constraints
# -------------------------------------------------------------------------
# Mô tả: Định nghĩa xung nhịp và các yêu cầu về thời gian (XDC).
# -------------------------------------------------------------------------

# 1. create_clock
# Định nghĩa xung nhịp chính (primary clock) đi vào FPGA.
# Ví dụ: Xung nhịp 100 MHz trên cổng 'clk_in'
# create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports clk_in]

# 2. create_generated_clock
# Định nghĩa xung nhịp được tạo ra từ xung nhịp chính (vd: PLL hoặc bộ chia tần).
# create_generated_clock -name clk_div2 -source [get_pins my_pll/clk_in] -divide_by 2 [get_pins my_pll/clk_out]

# 3. set_clock_groups
# Chỉ định các xung nhịp bất đồng bộ (asynchronous) hoặc độc quyền (exclusive) với nhau.
# set_clock_groups -asynchronous -group [get_clocks sys_clk] -group [get_clocks pcie_clk]

# 4. set_input_delay / set_output_delay
# Ràng buộc thời gian cho giao tiếp I/O so với một xung nhịp.
# set_input_delay -clock [get_clocks sys_clk] 2.0 [get_ports data_in]
# set_output_delay -clock [get_clocks sys_clk] 1.5 [get_ports data_out]

# 5. set_false_path
# Chỉ thị cho bộ phân tích timing bỏ qua phân tích thời gian trên các đường (paths) cụ thể.
# set_false_path -from [get_ports reset_n] -to [all_registers]

# 6. set_max_delay / set_multicycle_path
# Các ràng buộc timing nâng cao để ghi đè yêu cầu setup/hold mặc định.
# set_max_delay -from [get_cells reg_A] -to [get_cells reg_B] 5.0
# set_multicycle_path -setup -from [get_clocks clk1] -to [get_clocks clk2] 2

# 7. read_xdc / write_xdc
# Đọc ràng buộc từ một file, hoặc xuất các ràng buộc hiện tại trong RAM ra file.
# read_xdc ./constraints/timing.xdc
# write_xdc ./out/exported_constraints.xdc
