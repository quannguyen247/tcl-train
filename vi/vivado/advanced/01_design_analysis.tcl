# ==============================================================================
# BÀI HỌC VIVADO ADVANCED 01: PHÂN TÍCH VÀ TRUY VẤN MẠCH NETLIST NÂNG CAO
# ==============================================================================
# Trong Vivado, toàn bộ thiết kế được coi là một cơ sở dữ liệu Netlist chứa các đối tượng:
# Cells (Logic Gates/LUTs), Nets (Dây nối), Pins (Chân linh kiện), Ports (Cổng I/O).
# Kỹ sư cao cấp xài Tcl để lọc và truy vấn các vùng mạch bị lỗi hoặc cồng kềnh.
# ==============================================================================

# 1. TRUY VẤN CELL LOGIC VÀ LỌC THEO THUỘC TÍNH (GET_CELLS & -FILTER)
# ------------------------------------------------------------------------------
# Lấy tất cả các Cell là Flip-Flop (FF) trong thiết kế
set all_ffs [get_cells -hierarchical -filter {PRIMITIVE_SUBGROUP == flop}]
puts "--> Tổng số lượng Flip-Flops trong thiết kế: [llength $all_ffs]"

# Tìm các LUT6 có số lượng tín hiệu vào lớn hơn 4
set complex_luts [get_cells -hierarchical -filter {REF_NAME == LUT6 && NUM_INPUTS > 4}]
puts "--> Số lượng LUT6 phức tạp: [llength $complex_luts]"

# 2. TRUY VẤN DÂY NỐI VÀ QUẢN LÝ FANOUT (GET_NETS)
# ------------------------------------------------------------------------------
# Tìm các dây nối (Nets) có Fanout (số lượng tải đầu ra) cực lớn (> 500)
# Các dây này rất dễ gây ra nghẽn mạch (Congestion) và vi phạm Timing!
set high_fanout_nets [get_nets -hierarchical -filter {FLAT_PIN_COUNT > 500}]
puts "--> Số lượng Nets có High Fanout (>500): [llength $high_fanout_nets]"

foreach net $high_fanout_nets {
    set driver [get_pins -of_objects $net -filter {DIRECTION == OUT}]
    puts "    Net: $net | Driver Pin: $driver | Fanout Count: [get_property FLAT_PIN_COUNT $net]"
}

# 3. TRUY VẤN CHÂN PIN VÀ CỔNG I/O (GET_PINS & GET_PORTS)
# ------------------------------------------------------------------------------
# Tìm tất cả các chân Clock Pins được nối vào một khối IP nhất định
set clock_pins [get_pins -hierarchical -filter {TYPE == CLK || NAME =~ *clk*}]
puts "--> Tìm thấy [llength $clock_pins] chân Clock trong toàn bộ Netlist."

# Lấy danh sách các cổng Output của chip có điện áp chuẩn LVCMOS33
set lvcmos33_ports [get_ports -filter {DIRECTION == OUT && IOSTANDARD == LVCMOS33}]
puts "--> Số cổng Output chuẩn LVCMOS33: [llength $lvcmos33_ports]"

# 4. THAO TÁC DUYỆT VÀ ĐỔI THUỘC TÍNH NẠNG CAO (SET_PROPERTY)
# ------------------------------------------------------------------------------
# Ép buộc Vivado không được tự ý xóa (DONT_TOUCH) một số khối Cell quan trọng
puts "--> Đang gắn thuộc tính DONT_TOUCH cho các cell quan trọng..."
set_property DONT_TOUCH true [get_cells -hierarchical -filter {NAME =~ *security_core*}]

puts "--> Hoàn tất bài học Phân tích Netlist Nâng cao!"
