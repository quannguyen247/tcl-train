# Bài học Vivado Tcl: 05_reports_and_analysis
# -------------------------------------------------------------------------
# Mô tả: Tạo các báo cáo về timing, tài nguyên (utilization), công suất và DRC.
# -------------------------------------------------------------------------

# 1. report_timing_summary
# Tạo báo cáo timing toàn diện cho toàn bộ thiết kế.
# -file để lưu vào file.
# report_timing_summary -file ./reports/timing_summary.rpt -delay_type min_max

# 2. report_timing
# Báo cáo timing cho các đường dẫn cụ thể, thường dùng để gỡ lỗi khi timing bị lỗi.
# report_timing -from [get_ports data_in] -to [get_cells my_reg] -max_paths 10 -file ./reports/path_timing.rpt

# 3. report_utilization
# Hiển thị mức sử dụng tài nguyên FPGA (LUT, FF, BRAM, DSP, v.v.).
# report_utilization -file ./reports/utilization.rpt -hierarchical

# 4. report_power
# Ước tính công suất tiêu thụ dựa trên thiết kế và tần suất hoạt động.
# report_power -file ./reports/power.rpt

# 5. report_drc
# Chạy bộ Kiểm tra Luật Thiết kế (DRC) để phát hiện các lỗi phần cứng tiềm ẩn.
# report_drc -file ./reports/drc.rpt

# 6. report_design_analysis
# Cung cấp phân tích nâng cao về độ sâu logic, fanout, và tắc nghẽn định tuyến.
# report_design_analysis -complexity -timing -file ./reports/design_analysis.rpt
