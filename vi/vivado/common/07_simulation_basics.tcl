# Bài học Vivado Tcl: 07_simulation_basics
# -------------------------------------------------------------------------
# Mô tả: Khởi chạy và điều khiển bộ mô phỏng Vivado Simulator (XSim).
# -------------------------------------------------------------------------

# 1. launch_simulation
# Bắt đầu bộ mô phỏng Vivado. 
# Mặc định là mô phỏng hành vi (behavioral simulation, -step xsim).
# launch_simulation

# 2. open_wave_config
# Mở một file cấu hình dạng sóng đã lưu trước đó (.wcfg).
# open_wave_config ./sim/my_wave.wcfg

# 3. add_wave / log_wave
# Thêm tín hiệu vào trình xem sóng và cho phép lưu trữ (log) sự kiện của chúng.
# add_wave /tb_top/dut/*
# log_wave -r /tb_top/dut/*

# 4. run
# Chạy mô phỏng trong một khoảng thời gian nhất định.
# run 10 us
# run all   ; # Chạy cho đến khi gặp lệnh $finish trong testbench.

# 5. restart
# Reset thời gian mô phỏng về 0.
# restart

# 6. close_sim
# Đóng quá trình mô phỏng hiện tại.
# close_sim
