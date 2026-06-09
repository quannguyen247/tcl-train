# Bài tập: Mảng và Từ điển trong EDA
# Tình huống: Quản lý thống kê cell và đường dẫn timing

# 1. ARRAYS: Số lượng sử dụng cell (instantiation counts)
# Tạo một mảng 'instances' và thiết lập số lượng
array set instances {
    BUF_X1 1500
    INV_X2 3200
    DFF_X1 450
}

# Cập nhật số lượng cho DFF_X1 thành 460
set instances(DFF_X1) 460

# Thêm một loại cell mới NAND2_X1 với số lượng 800
set instances(NAND2_X1) 800

# In ra tất cả các loại cell và số lượng của chúng
puts "--- Instance Counts ---"
foreach cell [array names instances] {
    puts "$cell: $instances($cell)"
}

# 2. DICTIONARIES: Tóm tắt timing path
# Tạo một từ điển lồng nhau cho các đường dẫn
set paths [dict create]
dict set paths Path1 from FF1/CK
dict set paths Path1 to FF2/D
dict set paths Path1 slack -0.15

dict set paths Path2 from IN_A
dict set paths Path2 to FF3/D
dict set paths Path2 slack 0.20

puts "\n--- Timing Paths ---"
# Lặp qua từ điển và in các path có slack âm (vi phạm)
dict for {path_name info} $paths {
    set slack [dict get $info slack]
    if {$slack < 0.0} {
        puts "VIOLATION: $path_name (Slack: $slack)"
        puts "  From: [dict get $info from]"
        puts "  To:   [dict get $info to]"
    }
}
