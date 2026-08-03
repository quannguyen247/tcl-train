# Bài tập: Biểu thức chính quy (Regex) trong EDA
# Tình huống: Phân tích các dòng báo cáo timing

set report_lines {
    "Startpoint: reg_A/CK (rising edge-triggered flip-flop clocked by clk_sys)"
    "Endpoint: reg_B/D (rising edge-triggered flip-flop clocked by clk_sys)"
    "Path Group: clk_sys"
    "Path Type: max"
    "Slack (VIOLATED)        -0.45"
    "Slack (MET)              1.20"
}

puts "--- Slack Extraction ---"
foreach line $report_lines {
    # 1. Trích xuất giá trị Slack và trạng thái (MET hoặc VIOLATED)
    # Gợi ý: Khớp mẫu "Slack (STATUS) VALUE"
    if {[regexp {Slack\s+\((MET|VIOLATED)\)\s+([-\d.]+)} $line match status value]} {
        puts "Found Slack: $value (Status: $status)"
    }
}

puts "\n--- Pin Extraction ---"
foreach line $report_lines {
    # 2. Trích xuất chân startpoint và endpoint
    if {[regexp {^(Startpoint|Endpoint):\s+(\S+)} $line match type pin]} {
        puts "$type Pin: $pin"
    }
}

puts "\n--- Report Formatting ---"
set ugly_string "delay= 1.50   slack= -0.2   cap=  0.05"
# 3. Dùng regsub để dọn dẹp nhiều khoảng trắng thành một khoảng trắng,
# và thay '=' bằng ':'
regsub -all {\s+} $ugly_string " " clean1
regsub -all {\s*=\s*} $clean1 ": " clean2
puts "Original: $ugly_string"
puts "Cleaned:  $clean2"
