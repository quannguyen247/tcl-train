proc addGigasecond {datetime} {
    # 1. Đổi chuỗi ngày giờ ban đầu sang số giây (timestamp)
    set current_seconds [clock scan $datetime -timezone UTC]
    # 2. Cộng thêm đúng 1 Gigasecond (1.000.000.000 giây)
    set future_seconds [expr {$current_seconds + 1000000000}]
    # 3. Đổi số giây đã cộng ngược lại thành chuỗi ngày giờ chuẩn
    return [clock format $future_seconds -format "%Y-%m-%dT%T" -timezone UTC]
}





