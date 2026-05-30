# Module 02: Rẽ nhánh và điều kiện (Control Flow)

Module này tập trung vào cách Tcl quyết định luồng chạy bằng `if`, `elseif`, `else` và `switch`.

---

## 📖 Kiến thức cốt lõi

### 1. Rẽ nhánh với `if`
`if` dùng để kiểm tra điều kiện logic và chọn nhánh xử lý phù hợp. Trong Tcl, biểu thức điều kiện thường được đặt trong dấu ngoặc nhọn để tránh thay thế sớm:

```tcl
if {$slack_ps < 0} {
    puts "Timing violation"
} elseif {$slack_ps < 50} {
    puts "Timing margin is tight"
} else {
    puts "Timing is safe"
}
```

### 2. Chọn nhánh theo giá trị với `switch`
`switch` phù hợp khi cần chọn một trong nhiều hành vi dựa trên một giá trị cụ thể, ví dụ chế độ tối ưu hóa `timing`, `power`, hoặc `area`.

---

## ⚡ Ứng dụng thực tế trong EDA

Trong script EDA, `if` thường dùng để kiểm tra violation, còn `switch` dùng để đổi flow theo chế độ chạy:

```tcl
switch -- $mode {
    timing { puts "Run timing-driven optimization" }
    power  { puts "Run low-power optimization" }
    area   { puts "Run area-driven optimization" }
}
```
