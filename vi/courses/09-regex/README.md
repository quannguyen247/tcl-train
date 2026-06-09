<Chương 09: Regular Expressions (Biểu thức chính quy)>
Biểu thức chính quy (regex) là công cụ mạnh mẽ để khớp mẫu và xử lý văn bản. Engine regex của Tcl (ARE - Advanced Regular Expressions) rất tiên tiến và tích hợp hoàn hảo với các thao tác chuỗi.

---

## Mục lục
- [Khớp mẫu cơ bản](#khớp-mẫu-cơ-bản)
- [Nhóm chụp (Capturing Groups)](#nhóm-chụp-capturing-groups)
- [Lớp ký tự & Bộ định lượng](#lớp-ký-tự--bộ-định-lượng)
- [Tìm kiếm và Thay thế](#tìm-kiếm-và-thay-thế)
- [Tùy chọn nâng cao](#tùy-chọn-nâng-cao)

---

## Khớp mẫu cơ bản

### Giải thích
Lệnh `regexp` kiểm tra xem một chuỗi có khớp với mẫu không. Trả về `1` nếu khớp, `0` nếu không.

### Cú pháp
```tcl
regexp ?options? pattern string
```

### Ví dụ
```tcl
set text "Warning: Timing violation on path 42"

if {[regexp {Warning|Error} $text]} {
    puts "Found an issue in log."
}

if {[regexp -nocase {^warning} $text]} {
    puts "Line starts with warning."
}
```

### Kết quả
```
Found an issue in log.
Line starts with warning.
```

---

## Nhóm chụp (Capturing Groups)

### Giải thích
Dấu ngoặc đơn `()` định nghĩa nhóm chụp. Có thể truyền tên biến vào `regexp` để lưu chuỗi khớp toàn bộ và các chuỗi con.

### Cú pháp
```tcl
regexp pattern string matchVar sub1Var sub2Var ...
```

### Ví dụ
```tcl
set line "Slack: -0.45 ns"

if {[regexp {Slack:\s+([-\d.]+)\s+(ns|ps)} $line full_match val unit]} {
    puts "Match: $full_match"
    puts "Value: $val"
    puts "Unit: $unit"
}
```

### Kết quả
```
Match: Slack: -0.45 ns
Value: -0.45
Unit: ns
```

---

## Lớp ký tự & Bộ định lượng

### Giải thích
- **Lớp**: `[a-z]` (chữ thường), `\d` (số), `\w` (chữ+số), `\s` (khoảng trắng). Viết hoa để đảo ngược: `\D`, `\W`, `\S`.
- **Bộ định lượng**: `*` (0+), `+` (1+), `?` (0/1), `{n}` (đúng n), `{n,m}` (n đến m). Thêm `?` để không tham lam (non-greedy: `*?`, `+?`).
- **Neo (Anchors)**: `^` (đầu chuỗi), `$` (cuối), `\b` (ranh giới từ).

### Ví dụ
```tcl
set pin "cell_A/pin_Z"

# \w+ matches 1 or more word characters
if {[regexp {^(\w+)/(\w+)$} $pin all cell pin_name]} {
    puts "Cell: $cell, Pin: $pin_name"
}
```

### Kết quả
```
Cell: cell_A, Pin: pin_Z
```

---

## Tìm kiếm và Thay thế

### Giải thích
`regsub` tìm mẫu và thay thế nó. `-all` thay thế mọi lần xuất hiện. Có thể dùng tham chiếu ngược (backreferences) như `\1` hoặc `&` (toàn bộ khớp) trong chuỗi thay thế.

### Cú pháp
```tcl
regsub ?options? pattern string subSpec varName
# Hoặc trả về kết quả trực tiếp ở Tcl mới hơn:
set newStr [regsub pattern string subSpec]
```

### Ví dụ
```tcl
set report "Delay: 10ps, Transition: 5ps"

# Replace 'ps' with 'ns' globally
regsub -all {ps} $report "ns" new_report
puts $new_report

# Backreference \1 and \2
set name "Doe, John"
regsub {(\w+),\s+(\w+)} $name {\2 \1} formatted_name
puts "Formatted: $formatted_name"
```

### Kết quả
```
Delay: 10ns, Transition: 5ns
Formatted: John Doe
```

---

## Tùy chọn nâng cao

### Giải thích
- `-all`: khớp tất cả
- `-inline`: trả về danh sách các kết quả khớp thay vì boolean
- Lookarounds: `(?=...)` (lookahead), `(?!...)` (negative lookahead). Nhóm không chụp: `(?:...)`. Luôn bao mẫu bằng `{}` để tránh Tcl tự thay thế biến!

### Ví dụ
```tcl
set text "clk_1 clk_2 mem_clk"
set matches [regexp -all -inline {\w*clk\w*} $text]
puts "Clocks found: $matches"
```

### Kết quả
```
Clocks found: clk_1 clk_2 mem_clk
```

---

## Bài tập thực hành
- `01_regex.tcl`: Phân tích các dòng báo cáo timing để trích xuất thông tin slack và path, sau đó định dạng lại đầu ra bằng các công cụ regex.

---

## Tóm tắt
- Dùng `regexp` để kiểm tra khớp và trích xuất chuỗi con bằng `()`.
- Dùng `regsub` để thay thế văn bản, tận dụng `-all` và tham chiếu ngược (`\1`, `\2`).
- Nhớ đặt mẫu regex trong cặp `{}` để Tcl không diễn giải các dấu gạch chéo ngược (backslash) trước khi engine regex nhận được chúng.
</Chương 09: Regular Expressions (Biểu thức chính quy)>
