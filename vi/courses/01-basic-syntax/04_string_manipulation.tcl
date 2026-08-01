# ==============================================================================
# CHƯƠNG 01: CÚ PHÁP CĂN BẢN (BASIC SYNTAX)
# BÀI 04: XỬ LÝ CHUỖI NÂNG CAO (STRING MANIPULATION)
# ==============================================================================
# Trong Tcl, triết lý cốt lõi là "Everything Is A String" (Mọi thứ đều là chuỗi).
# Việc làm chủ nhóm lệnh [string] là kỹ năng bắt buộc cho mọi lập trình viên Tcl.
# Chạy file này bằng lệnh: tclsh 04_string_manipulation.tcl
# ==============================================================================

puts "=== HƯỚNG DẪN XỬ LÝ CHUỖI TRONG TCL (STRING COMMANDS) ==="

set text "  Hello, Tcl Programming World!  "

# 1. ĐO CHIỀU DÀI CHUỖI (STRING LENGTH)
# ------------------------------------------------------------------------------
set len [string length $text]
puts "\n1. Đo chiều dài chuỗi:"
puts "   Chuỗi: '$text'"
puts "   Chiều dài: $len ký tự"

# 2. CẮT VÀ LẤY KÝ TỰ (STRING INDEX & STRING RANGE)
# ------------------------------------------------------------------------------
set str "Microchip"

# Lấy ký tự tại chỉ số Index (Đếm từ 0)
set first_char [string index $str 0]
set last_char  [string index $str end]

# Cắt một đoạn chuỗi từ vị trí Start đến End
set sub_str [string range $str 0 4]          ;# Lấy từ vị trí 0 đến 4
set end_str [string range $str end-4 end]    ;# Lấy 5 ký tự cuối cùng

puts "\n2. Cắt chuỗi và lấy chỉ số:"
puts "   Từ gốc: $str"
puts "   Ký tự đầu (index 0): $first_char"
puts "   Ký tự cuối (index end): $last_char"
puts "   Cắt từ 0 đến 4 (string range 0 4): $sub_str"
puts "   Cắt 5 ký tự cuối (string range end-4 end): $end_str"

# 3. THAY THẾ HÀNG LOẠT BẰNG TỪ ĐIỂN (STRING MAP) - CỰC KỲ QUAN TRỌNG
# ------------------------------------------------------------------------------
# Lệnh 'string map' cho phép thay thế hàng loạt ký tự theo cặp quy tắc {cũ mới}
set dna "ACGTACGT"
set rna [string map {G C C G T A A U} $dna]

puts "\n3. Thay thế chuỗi bằng 'string map':"
puts "   Chuỗi DNA gốc: $dna"
puts "   Chuỗi RNA sau khi dịch mã (G->C, C->G, T->A, A->U): $rna"

# 4. KHỚP MẪU THEO GLOB PATTERN (STRING MATCH)
# ------------------------------------------------------------------------------
# Kiểm tra xem chuỗi có khớp với định dạng mong muốn không (Trả về 1 nếu đúng, 0 nếu sai)
set filename "top_module_v1.v"

if {[string match "*.v" $filename]} {
    puts "\n4. Khớp mẫu 'string match':"
    puts "   File '$filename' là một file Verilog hợp lệ (*.v)!"
}

# 5. BIẾN ĐỔI CHỮ HOẠT / CHỮ THƯỜNG (STRING TOUPPER / TOLOWER)
# ------------------------------------------------------------------------------
set raw_code "vhdl_design"
puts "\n5. Đổi chữ hoa / chữ thường:"
puts "   In hoa: [string toupper $raw_code]"
puts "   In thường: [string tolower "VHDL_DESIGN"]"

# 6. CẮT BỎ KÝ TỰ THỪA / KHOẢNG TRẮNG (STRING TRIM)
# ------------------------------------------------------------------------------
set dirty_str "---Vivado 2026---"
set clean_str [string trim $dirty_str "-"]

puts "\n6. Cắt bỏ khoảng trắng và ký tự thừa 'string trim':"
puts "   Chuỗi gốc: '$text'"
puts "   Đã trim khoảng trắng 2 đầu: '[string trim $text]'"
puts "   Đã trim dấu '-': '$clean_str'"

puts "\n=== HOÀN THÀNH BÀI HỌC STRING MANIPULATION ==="
