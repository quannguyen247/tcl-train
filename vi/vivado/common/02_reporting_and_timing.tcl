# ==============================================================================
# BÀI HỌC VIVADO COMMON 02: BÁO CÁO TÀI NGUYÊN VÀ THỜI GIAN (REPORTING & TIMING)
# ==============================================================================
# Trong thiết kế vi mạch, việc kiểm tra xem chip có vi phạm Timing (Worst Negative
# Slack - WNS) hay có ngốn quá nhiều tài nguyên (LUT/FF/BRAM/DSP) không là bắt buộc.
# ==============================================================================

# 1. BÁO CÁO THỜI GIAN (TIMING SUMMARY REPORT)
# ------------------------------------------------------------------------------
# Xuất báo cáo Timing tổng quan ra file text
puts "--> Đang tạo báo cáo Timing Summary..."
report_timing_summary -file ./build_output/reports/timing_summary.rpt -max_paths 10

# Kiểm tra xem thiết kế có bị vi phạm Setup / Hold Timing không (WNS < 0 là rớt)
set wns [get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]]
puts "Worst Negative Slack (WNS) hiện tại: $wns ns"

if {$wns < 0} {
    puts "[WARNING]: Thiết kế bị vi phạm Setup Timing! WNS = $wns ns"
} else {
    puts "[SUCCESS]: Thiết kế đạt yêu cầu Timing (MET TIMING)!"
}

# 2. BÁO CÁO TIÊU HAO TÀI NGUYÊN (UTILIZATION REPORT)
# ------------------------------------------------------------------------------
puts "--> Đang xuất báo cáo tài nguyên phần cứng (LUT, FF, BRAM, DSP)..."
report_utilization -file ./build_output/reports/utilization.rpt

# 3. BÁO CÁO NĂNG LƯỢNG TIÊU THỤ (POWER REPORT)
# ------------------------------------------------------------------------------
puts "--> Đang tính toán công suất tiêu thụ năng lượng..."
report_power -file ./build_output/reports/power_analysis.rpt

# 4. BÁO CÁO ĐĂNG KÝ VÀ ĐIỆN ÁP CHÂN CẮM (IO REPORT)
# ------------------------------------------------------------------------------
puts "--> Đang xuất báo cáo chân cắm (I/O) và điện áp..."
report_io -file ./build_output/reports/io_report.rpt

puts "--> Hoàn tất xuất toàn bộ Báo cáo thiết kế vào thư mục ./build_output/reports/"
