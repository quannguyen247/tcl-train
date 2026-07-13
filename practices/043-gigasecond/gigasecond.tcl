# ==============================================================================
# EXERCISM TCL PRACTICE: GIGASECOND
# ==============================================================================
# # Instructions
#
# Your task is to determine the date and time one gigasecond after a certain date.
#
# A gigasecond is one thousand million seconds.
# That is a one with nine zeros after it.
#
# If you were born on _January 24th, 2015 at 22:00 (10:00:00pm)_, then you would be a gigasecond old on _October 2nd, 2046 at 23:46:40 (11:46:40pm)_.

# ==============================================================================
# KỸ THUẬT & GIẢI THÍCH (ALGORITHM & TCL SYNTAX)
# ==============================================================================
# 1. `clock scan $datetime -timezone UTC`:
#    - Đọc chuỗi thời gian đầu vào (ví dụ: "2015-01-24T22:00:00") và đổi ra số giây (POSIX timestamp).
#    - Dùng `-timezone UTC` (hoặc `-gmt 1`) để không bị lệch múi giờ địa phương.
#
# 2. `expr {$sec + 1000000000}`:
#    - Cộng thêm đúng 1 Gigasecond (1.000.000.000 giây).
#
# 3. `clock format $future_sec -format "%Y-%m-%dT%H:%M:%S" -timezone UTC`:
#    - Đổi số giây đã cộng ngược lại thành chuỗi ngày giờ ISO 8601 chuẩn.
# ==============================================================================

proc addGigasecond {datetime} {
    # 1. Đổi chuỗi ngày giờ ban đầu sang số giây (timestamp)
    set current_seconds [clock scan $datetime -timezone UTC]
    # 2. Cộng thêm đúng 1 Gigasecond (1.000.000.000 giây)
    set future_seconds [expr {$current_seconds + 1000000000}]
    # 3. Đổi số giây đã cộng ngược lại thành chuỗi ngày giờ chuẩn
    return [clock format $future_seconds -format "%Y-%m-%dT%T" -timezone UTC]
}





