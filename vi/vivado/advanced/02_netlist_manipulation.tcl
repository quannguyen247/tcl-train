# Bài học Vivado Tcl: 02_netlist_manipulation
# -------------------------------------------------------------------------
# Mô tả: Chỉnh sửa netlist động bằng Tcl (quy trình ECO).
# -------------------------------------------------------------------------

# 1. add_cells / remove_cells
# Khởi tạo các primitive mới hoặc xóa các khối hiện có.
# add_cells -reference LUT2 my_new_lut
# remove_cells [get_cells my_buggy_logic]

# 2. create_net / create_port
# Tạo dây nối mới hoặc các cổng ở tầng top-level.
# create_net new_debug_wire
# create_port -direction OUT debug_out

# 3. connect_net / disconnect_net
# Nối một dây vào chân/cổng, hoặc ngắt một kết nối hiện tại.
# connect_net -net new_debug_wire -objects [get_pins my_new_lut/O]
# disconnect_net -net [get_nets bad_connection] -objects [get_pins my_reg/D]

# 4. set_property DONT_TOUCH
# Ngăn chặn việc tổng hợp hoặc thực thi tối ưu hóa mất đi đoạn logic cụ thể.
# set_property DONT_TOUCH true [get_cells my_keep_reg]

# 5. set_property MARK_DEBUG
# Đánh dấu một dây net để được giữ lại và có thể quan sát bằng Integrated Logic Analyzer (ILA).
# set_property MARK_DEBUG true [get_nets my_critical_state_machine_net]
