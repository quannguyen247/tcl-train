# Bài học Vivado Tcl: 06_advanced_timing_and_cdc
# -------------------------------------------------------------------------
# Mô tả: Ràng buộc thời gian nâng cao, nhóm đường dẫn, và phân tích Clock Domain Crossing.
# -------------------------------------------------------------------------

# 1. group_path / get_path_groups
# Nhóm các đường dẫn timing cụ thể để gán cho chúng mức ưu tiên hoặc trọng số khác nhau khi thực thi.
# group_path -name my_critical_paths -weight 2.0 -from [get_cells *critical*]

# 2. report_exceptions
# Xem toàn bộ các ngoại lệ timing (false path, multicycle, max delay) đã được áp dụng vào thiết kế.
# report_exceptions -file ./timing_exceptions.rpt

# 3. report_cdc
# Phân tích toàn diện việc giao tiếp chéo vùng xung nhịp (CDC) để tìm các bộ đồng bộ hóa không an toàn.
# report_cdc -details -file ./cdc_report.rpt

# 4. report_methodology
# Kiểm tra phương pháp luận theo các khuyến nghị của Xilinx (về timing, CDC, thực hành reset).
# report_methodology -file ./methodology.rpt

# 5. set_clock_uncertainty
# Thêm jitter hoặc khoảng dự phòng (margin) vào xung nhịp để phân tích timing bi quan (chặt chẽ) hơn.
# set_clock_uncertainty -setup 0.5 [get_clocks sys_clk]
