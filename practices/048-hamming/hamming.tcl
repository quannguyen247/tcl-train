# ==============================================================================
# EXERCISM TCL PRACTICE: HAMMING
# ==============================================================================
# # Instructions
#
# Calculate the Hamming distance between two DNA strands.
#
# We read DNA using the letters C, A, G and T.
# Two strands might look like this:
#
#     GAGCCTACTAACGGGAT
#     CATCGTAATGACGGCCT
#     ^ ^ ^  ^ ^    ^^
#
# They have 7 differences, and therefore the Hamming distance is 7.
#
# ## Implementation notes
#
# The Hamming distance is only defined for sequences of equal length, so an attempt to calculate it between sequences of different lengths should not work.

# ==============================================================================
# KỸ THUẬT & GIẢI THÍCH (ALGORITHM & TCL SYNTAX)
# ==============================================================================
# 1. BẢNG TRA CỨU ĐẦY ĐỦ CÁC LỆNH CON PHỔ BIẾN CỦA `string`:
#    - `string length $str`: Lấy số ký tự của chuỗi.
#    - `string index $str $idx`: Lấy 1 ký tự tại chỉ số $idx (bắt đầu từ 0).
#    - `string range $str $start $end`: Trích xuất chuỗi con từ $start đến $end.
#    - `string map {$from $to} $str`: Thay thế ký tự/chuỗi (Replace).
#    - `string tolower $str` / `string toupper $str`: Chuyển sang chữ thường / chữ hoa.
#    - `string trim $str` / `string trimleft` / `string trimright`: Cắt bỏ khoảng trắng thừa.
#    - `string match $pattern $str`: So khớp mẫu glob (ví dụ: `string match "a*" $str`).
#    - `string is <type> $str`: Kiểm tra kiểu (ví dụ: `string is integer -strict $str`).
#    - `string repeat $str $count`: Lặp lại chuỗi $count lần.
#    - `string replace $str $first $last ?new?: Thay thế đoạn ký tự từ $first đến $last.
#
# 2. ÁP DỤNG TRONG BÀI TOÁN NÀY:
#    - Dùng `string length $left` để kiểm tra 2 chuỗi có bằng độ dài không.
#    - Dùng `string index $left $i` để lấy từng ký tự tại vị trí $i để so sánh (`ne`).
# ==============================================================================


proc hammingDistance {left right} {
    # 1. Kiểm tra 2 chuỗi phải có cùng độ dài
    if {[string length $left] != [string length $right]} {
        error "strands must be of equal length"
    }

    # 2. Đếm các vị trí ký tự khác nhau
    set distance 0
    set len [string length $left]

    for {set i 0} {$i < $len} {incr i} {
        if {[string index $left $i] ne [string index $right $i]} {
            incr distance
        }
    }

    return $distance
}


