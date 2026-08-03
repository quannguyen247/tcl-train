# ==============================================================================
# EXERCISM TCL PRACTICE: COLLATZ-CONJECTURE
# ==============================================================================
# # Instructions
#
# Given a positive integer, return the number of steps it takes to reach 1 according to the rules of the Collatz Conjecture.

# ==============================================================================
# KỸ THUẬT & LƯU Ý CÚ PHÁP (ALGORITHM & TCL SYNTAX NOTES)
# ==============================================================================
# 1. KIỂM TRA ĐẦU VÀO & BÁO LỖI:
#    - Đề bài yêu cầu ném ra lỗi nếu number <= 0.
#    - Dùng `error "Only positive integers are allowed"` (Đơn giản & chuẩn nhất trong Tcl).
#    - Lưu ý: Dùng `throw` phải kèm mã lỗi không rỗng (ví dụ `throw {ERR} "..."`), 
#      nếu dùng `throw {} "..."` sẽ bị lỗi "type must be non-empty list".
#
# 2. BẪY XUỐNG DÒNG VỚI `else`:
#    - Trong Tcl, xuống dòng là KẾT THÚC câu lệnh.
#    - Cú pháp `if` ... `else` bắt buộc phải viết `} else {` trên CÙNG 1 DÒNG.
#    - Nếu viết `}` rồi xuống dòng `else {` sẽ bị lỗi "invalid command name else".
#
# 3. GÁN BẮT BUỘC DÙNG `set` VÀ `expr`:
#    - Tcl không có toán tử `$x = $x / 2`.
#    - Phải dùng: `set number [expr {$number / 2}]`.
#    - Luôn bọc biểu thức trong `{}` (`expr {$n / 2}`) để Tcl biên dịch Bytecode tối ưu tốc độ.
# ==============================================================================

proc steps {number} {
    # 1. Kiểm tra điều kiện số nguyên dương (> 0)
    if {$number <= 0} {
        error "Only positive integers are allowed"
    }

    set count 0

    # 2. Lặp biến đổi số về 1
    while {$number > 1} {
        incr count

        if {$number % 2 == 0} {
            set number [expr {$number / 2}]
        } else {
            set number [expr {$number * 3 + 1}]
        }
    }

    return $count
}




proc steps {n} {
    if {$n <= 0} {
        error "Only positive integers are allowed"
    }
    set count 0
    while {$n > 1} {
        if {$n % 2 == 0} {
            set n [expr {$n / 2}]
        } else {
            set n [expr {3 * $n + 1}]
        }
        incr count
    }
    return $count
}
