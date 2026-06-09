# ==============================================================================
# BÀI HỌC VIVADO COMMON 01: QUẢN LÝ PROJECT THỰC CHIẾN BẰNG TCL (PROJECT FLOW)
# ==============================================================================
# Trong môi trường doanh nghiệp (Enterprise), việc mở giao diện GUI bấm nút bằng chuột
# rất rủi ro và không thể tự động hóa. Tất cả mọi thứ đều được chạy bằng Tcl Script!
# ==============================================================================

# 1. TẠO HOẶC MỞ PROJECT (CREATE / OPEN PROJECT)
# ------------------------------------------------------------------------------
set proj_name "my_fpga_project"
set proj_dir "./build_output"
set target_part "xc7z020clg400-1" ;# Zynq-7000 FPGA Part Number

# Kiểm tra nếu project chưa tồn tại thì tạo mới, nếu có rồi thì reset/mở lại
if {[file exists $proj_dir]} {
    puts "--> Thư mục build đã tồn tại, đang dọn dẹp..."
    file delete -force $proj_dir
}

puts "--> Đang khởi tạo Vivado Project mới..."
create_project $proj_name $proj_dir -part $target_part -force

# Thiết lập ngôn ngữ mặc định (Verilog / SystemVerilog / VHDL)
set_property target_language Verilog [current_project]

# 2. THÊM SOURCE CODE VÀ CONSTRAINTS (ADD FILES)
# ------------------------------------------------------------------------------
puts "--> Đang add các file RTL và Constraints..."

# Thêm file Verilog/SystemVerilog
# add_files [glob ./src/*.v]
# add_files [glob ./src/*.sv]

# Thêm file Ràng buộc thời gian & chân cắm (XDC File)
# add_files -fileset constrs_1 ./constraints/top_pins.xdc

# 3. CHẠY TỔNG HỢP NGHỆ THUẬT (SYNTHESIS)
# ------------------------------------------------------------------------------
puts "--> Bắt đầu chạy Tổng hợp thiết kế (Synthesis)..."
launch_runs synth_1 -jobs 4

# Bắt buộc phải dùng wait_on_run để script dừng lại đợi Synthesis hoàn thành trước khi sang bước sau
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "ERROR: Synthesis thất bại! Vui lòng kiểm tra log synth_1."
}

# 4. CHẠY THI CÔNG MẠCH (IMPLEMENTATION - PLACE & ROUTE)
# ------------------------------------------------------------------------------
puts "--> Bắt đầu chạy Implementation (Place & Route)..."
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "ERROR: Implementation thất bại! Vui lòng kiểm tra log impl_1."
}

puts "--> HOÀN THÀNH LUỒNG TỰ ĐỘNG HÓA! Bitstream đã được tạo thành công."
