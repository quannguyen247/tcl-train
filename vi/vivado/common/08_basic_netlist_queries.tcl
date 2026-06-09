# Bài học Vivado Tcl: 08_basic_netlist_queries
# -------------------------------------------------------------------------
# Mô tả: Tìm kiếm và trích xuất các đối tượng từ bản vẽ netlist của thiết kế.
# -------------------------------------------------------------------------

# 1. get_cells
# Lấy các khối module, primitives, hoặc block trong thiết kế.
# set my_cells [get_cells *my_module*]

# 2. get_nets
# Lấy các đường dây/tín hiệu (wires) kết nối giữa các khối.
# set data_nets [get_nets data_bus*]

# 3. get_pins
# Lấy các điểm kết nối vật lý (chân) trên các khối cell.
# set clk_pins [get_pins -of_objects [get_cells *] -filter {NAME =~ *clk*}]

# 4. get_ports
# Lấy các cổng I/O ở tầng cao nhất (top-level) của FPGA.
# set inputs [get_ports -filter {DIRECTION == IN}]

# 5. get_clocks
# Lấy các vùng xung nhịp (clock domains) đã được định nghĩa.
# set clks [get_clocks]

# Ví dụ: Duyệt qua tất cả các cổng và in ra
# foreach p [get_ports] {
#     puts "Đã tìm thấy Port: $p"
# }
