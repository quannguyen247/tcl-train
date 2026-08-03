# Bài học Vivado Tcl: 01_advanced_netlist_querying
# -------------------------------------------------------------------------
# Mô tả: Lọc và truy vết các đường dẫn phức tạp trong netlist.
# -------------------------------------------------------------------------

# 1. -filter và -regexp
# Sử dụng regex mạnh mẽ và bộ lọc thuộc tính để thu hẹp kết quả tìm kiếm.
# set my_brams [get_cells -filter {PRIMITIVE_TYPE =~ BLOCKRAM.*.*}]
# set fast_clks [get_clocks -regexp {clk_(high|fast)_.*}]

# 2. -hierarchical
# Tìm kiếm xuyên suốt tất cả các tầng của cấu trúc thiết kế thay vì chỉ tầng hiện tại.
# set all_dsp_blocks [get_cells -hierarchical -filter {PRIMITIVE_TYPE =~ DSP.*.*}]

# 3. -of_objects
# Lấy các đối tượng có liên quan (ví dụ: tìm các chân được kết nối với một dây cụ thể).
# set my_net [get_nets my_critical_path_net]
# set connected_pins [get_pins -of_objects $my_net]

# 4. all_fanin / all_fanout
# Truy vết logic đi tới (fanout) hoặc đi lùi (fanin) từ một điểm cụ thể.
# set endpoints [all_fanout -from [get_pins my_reg/Q] -endpoints_only]
# set startpoints [all_fanin -to [get_pins my_comb/I0] -startpoints_only]

# 5. get_timing_paths
# Truy vấn trực tiếp bộ phân tích timing để tìm các đường dẫn xấu nhất.
# set worst_path [get_timing_paths -max_paths 1 -setup]
# report_property $worst_path
