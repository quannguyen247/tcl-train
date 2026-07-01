# Exercise 01: Variables and Basic I/O
# 1. Khai báo biến 'design_name' với giá trị là "dft_top".
# 2. Khai báo biến 'flop_count' với giá trị là 12500 (số lượng flip-flop).
# 3. Khai báo biến 'scan_chains' với giá trị là 4 (số lượng chuỗi quét scan chain).
# 4. Sử dụng lệnh 'puts' để in thông tin thiết kế ra màn hình theo đúng định dạng:
#   "Design: dft_top | FF Count: 12500 | Scan Chains: 4"
# 5. Xóa biến 'flop_count' khỏi bộ nhớ bằng lệnh thích hợp.
# 6. Kiểm tra xem biến 'flop_count' còn tồn tại hay không bằng lệnh 'info exists' và in kết quả ra màn hình.
# Bonus: In thêm tên của User đang đăng nhập hệ thống bằng cách truy xuất biến môi trường toàn cục (env) của hệ điều hành.
# Viết code của bạn ở đây:

# 1. Khai báo biến 'design_name' với giá trị là "dft_top".
set design_name "dft_top"

# 2. Khai báo biến 'flop_count' với giá trị là 12500 (số lượng flip-flop).
set flop_count 12500

# 3. Khai báo biến 'scan_chains' với giá trị là 4 (số lượng chuỗi quét scan chain).
set scan_chains 4

# 4. Sử dụng lệnh 'puts' để in thông tin thiết kế ra màn hình theo đúng định dạng: 
# "Design: dft_top | FF Count: 12500 | Scan Chains: 4"
puts "Design: $design_name | FF Count: $flop_count | Scan Chains: $scan_chains"

# 5. Giải phóng (xóa) biến 'flop_count' khỏi bộ nhớ bằng lệnh thích hợp.
unset flop_count

# 6. Kiểm tra xem biến 'flop_count' còn tồn tại hay không bằng lệnh 'info exists' và in kết quả ra màn hình.
puts "flop_count exists: [info exists flop_count]"

# Bonus 1: In thêm tên của User đang đăng nhập hệ thống bằng cách truy xuất biến môi trường toàn cục (env) của hệ điều hành.
puts "Current user: $tcl_platform(user)"

# ==============================================================================
# 7. BIẾN DÒNG LỆNH CỦA SCRIPT EDA ($argv0, $argc, $argv) & GLOBAL SCOPE (::varName)
# ==============================================================================
# Trong EDA tools (DC, PT, Tessent), script Tcl thường chạy từ dòng lệnh:
# tclsh run_dft.tcl -design top_chip -chains 8
# - $argv0: Tên file script ("run_dft.tcl")
# - $argc : Số lượng tham số truyền vào
# - $argv : Danh sách chứa các tham số

if {[info exists argv0]} {
    puts "Script name: $argv0 | Arg count: [expr {[info exists argc] ? $argc : 0}]"
}

# Biến Toàn cục trong Namespace gốc (dùng hai dấu ::)
set ::GLOBAL_EDA_MODE "AUTOPROMOTE_SCAN"
puts "Global EDA Mode: $::GLOBAL_EDA_MODE"