# Bài học Vivado Tcl: 02_synthesis_and_implementation
# -------------------------------------------------------------------------
# Mô tả: Chạy các bước biên dịch trong Vivado (Tổng hợp, Thực thi).
# -------------------------------------------------------------------------

# 1. synth_design
# Dùng trong quy trình non-project (batch flow) để chạy tổng hợp trực tiếp.
# synth_design -top my_top_module -part xc7a35tcpg236-1

# 2. launch_runs
# Dùng trong quy trình project-based để bắt đầu quá trình tổng hợp/thực thi chạy ngầm.
# 'synth_1' và 'impl_1' là các tên run mặc định do Vivado tạo ra.
puts "Đang khởi chạy quá trình tổng hợp..."
# launch_runs synth_1 -jobs 4

# 3. wait_on_run
# Dừng script Tcl cho đến khi run chỉ định hoàn tất. 
# Cực kỳ quan trọng trong tự động hóa script để tránh chạy implementation khi synthesis chưa xong.
# wait_on_run synth_1
# puts "Tổng hợp hoàn tất."

# 4. current_run / get_runs
# Lấy run đang hoạt động, hoặc liệt kê tất cả các run có sẵn.
# set my_run [current_run -synthesis]
# puts "Run tổng hợp hiện tại: $my_run"

# 5. open_run
# Mở bản thiết kế đã tổng hợp/thực thi vào bộ nhớ để phân tích (Netlist).
# open_run synth_1 -name netlist_1

# 6. reset_runs
# Xóa kết quả của một run để có thể chạy lại từ đầu.
# reset_runs synth_1
