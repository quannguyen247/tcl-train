# Exercise 02: Mathematical Expressions
# 1. Khai báo biến 'frequency_mhz' với giá trị là 400.0.
# 2. Tính chu kỳ xung nhịp 'clock_period_ns' bằng công thức: Period (ns) = 1000.0 / Frequency (MHz).
# 3. Đổi 'clock_period_ns' sang picoseconds (ps) và lưu vào biến 'clock_period_ps' (1 ns = 1000 ps).
# 4. Khai báo các biến 'gate_delay_ps' = 850 và 'wire_delay_ps' = 450.
# 5. Tính tổng độ trễ đường dẫn 'total_delay_ps' là tổng của gate_delay_ps và wire_delay_ps.
# 6. Tính tỉ lệ phần trăm (%) của độ trễ dây dẫn so với tổng độ trễ, lưu vào biến 'wire_delay_pct'.
# 7. Tính Timing Slack (thời gian dư thừa) còn lại: Slack = clock_period_ps - total_delay_ps.
# 8. In toàn bộ thông số ra màn hình theo định dạng sau:
#    "Clock Period: <value> ns (<value> ps)"
#    "Total Path Delay: <value> ps"
#    "Wire Delay Ratio: <value>%"
#    "Timing Slack: <value> ps"
# Bonus: Đảm bảo kết quả phần trăm chứa cả phần thập phân (ví dụ: 34.62% thay vì 34%) và bọc biểu thức expr trong dấu ngoặc nhọn {}.
# Viết code của bạn ở đây:

# 1. Khai báo biến 'frequency_mhz' với giá trị là 400.0.
set frequency_mhz 400.0

# 2. Tính chu kỳ xung nhịp 'clock_period_ns' bằng công thức: Period (ns) = 1000.0 / Frequency (MHz).
set clock_period_ns [expr {1000.0 / $frequency_mhz}]

# 3. Đổi 'clock_period_ns' sang picoseconds (ps) và lưu vào biến 'clock_period_ps' (1 ns = 1000 ps).
set clock_period_ps [expr {$clock_period_ns * 1000.0}]

# 4. Khai báo các biến 'gate_delay_ps' = 850 và 'wire_delay_ps' = 450.
set gate_delay_ps 850
set wire_delay_ps 450

# 5. Tính tổng độ trễ đường dẫn 'total_delay_ps' là tổng của gate_delay_ps và wire_delay_ps.
set total_delay_ps [expr {$gate_delay_ps + $wire_delay_ps}]

# 6. Tính tỉ lệ phần trăm (%) của độ trễ dây dẫn so với tổng độ trễ, lưu vào biến 'wire_delay_pct'.
set wire_delay_pct [expr {$wire_delay_ps * 100.0 / $total_delay_ps}]

# 7. Tính Timing Slack 'timing_slack' còn lại: Slack = clock_period_ps - total_delay_ps.
set timing_slack [expr {$clock_period_ps - $total_delay_ps}]

# 8. In toàn bộ thông số ra màn hình theo định dạng yêu cầu.
puts "Clock Period: $clock_period_ns ns ($clock_period_ps ps)"
puts "Total Path Delay: $total_delay_ps ps"
puts "Wire Delay Ratio: [format "%.2f" $wire_delay_pct]%"
puts "Timing Slack: $timing_slack ps"