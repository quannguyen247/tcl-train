# Bài tập: Thao tác với Danh sách trong EDA
# Tình huống: Bạn đang phân tích một báo cáo timing.
# Bạn có dữ liệu thô về các miền xung nhịp (clock domains) và đường dẫn timing.

# 1. Tạo một danh sách các tên clock: clk_sys, clk_mem, clk_io
set clocks [list clk_sys clk_mem clk_io]
puts "Initial clocks: $clocks"

# 2. Thêm (append) một clock mới 'clk_cpu' vào danh sách
lappend clocks clk_cpu
puts "After append: $clocks"

# 3. Sắp xếp các clock theo thứ tự từ điển (dictionary sort)
set sorted_clocks [lsort -dictionary $clocks]
puts "Sorted clocks: $sorted_clocks"

# 4. Tìm bất kỳ clock nào bắt đầu bằng 'clk_m' và in nó ra
set mem_clk [lsearch -inline -glob $clocks clk_m*]
puts "Found memory clock: $mem_clk"

# 5. Bạn có một danh sách các độ trễ (delay) của timing path
set delays {1.2 0.8 2.5 1.1 0.9 3.0}

# Sắp xếp các delay theo thứ tự giảm dần (dạng số thực)
set sorted_delays [lsort -real -decreasing $delays]
puts "Sorted delays: $sorted_delays"

# 6. Trích xuất 3 delay tệ nhất (giá trị cao nhất) bằng lrange
set worst_delays [lrange $sorted_delays 0 2]
puts "Top 3 worst delays: $worst_delays"

# 7. Bạn có một chuỗi CSV các tên chân (pin). Chuyển thành danh sách, rồi nối bằng " -> "
set pin_csv "FF1/Q,U1/A,U1/Y,FF2/D"
set pin_list [split $pin_csv ","]
set path_string [join $pin_list " -> "]
puts "Timing path: $path_string"

# ==============================================================================
# 8. KỸ THUẬT DUYỆT SONG SONG N HÀNG VỚI FOREACH TRONG EDA
# ==============================================================================
# Trong EDA, ta thường có cặp danh sách song song: {cell_name} và {pin_name}
set cells {U_INV_01 U_NAND_02 U_FF_03}
set pins  {Y        OUT       Q}

# Duyệt song song 2 danh sách trong 1 vòng lặp foreach duy nhất
foreach cell $cells pin $pins {
    puts "Connecting Cell: $cell -> Output Pin: $pin"
}

