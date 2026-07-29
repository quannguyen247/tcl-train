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


