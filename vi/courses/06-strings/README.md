# Chương 06: Chuỗi
Trong Tcl, "Mọi thứ đều là chuỗi". Việc thành thạo các lệnh thao tác chuỗi là rất quan trọng.

---

## Mục lục
- [Độ dài và Chuỗi con (length, index, range)](#length-and-substrings-length-index-range)
- [So sánh chuỗi (compare, equal)](#string-comparison-compare-equal)
- [So khớp mẫu (match)](#pattern-matching-match)
- [Tìm kiếm (first, last)](#searching-first-last)
- [Chuyển đổi kiểu chữ (tolower, toupper, totitle)](#case-conversion-tolower-toupper-totitle)
- [Cắt tỉa và Ánh xạ (trim, map)](#trimming-and-mapping-trim-map)
- [Định dạng chuỗi (format, scan)](#string-formatting-format-scan)
- [Kiểm tra kiểu (is)](#type-checking-is)

---

## Độ dài và Chuỗi con (length, index, range)

### Giải thích
Sử dụng `length` để đếm số ký tự. Sử dụng `index` để lấy một ký tự ở một vị trí cụ thể (bắt đầu từ 0) và `range` cho các chuỗi con. Từ khóa `end` chỉ số index cuối cùng.

### Cú pháp
```tcl
string length string
string index string charIndex
string range string first last
```

### Ví dụ
```tcl
set s "Verilog"
puts [string length $s]
puts [string index $s 0]
puts [string range $s 0 2]
puts [string range $s end-2 end]
```

### Đầu ra
```
7
V
Ver
log
```

---

## So sánh chuỗi (compare, equal)

### Giải thích
`string equal` trả về 1 nếu giống hệt nhau, ngược lại trả về 0. `string compare` trả về -1, 0 hoặc 1 dựa trên thứ tự từ điển. Cả hai đều hỗ trợ `-nocase`.

### Cú pháp
```tcl
string equal ?-nocase? string1 string2
string compare ?-nocase? string1 string2
```

### Ví dụ
```tcl
puts [string equal -nocase "TCL" "tcl"]
puts [string compare "A" "B"]
```

### Đầu ra
```
1
-1
```

---

## So khớp mẫu (match)

### Giải thích
`string match` kiểm tra xem một chuỗi có khớp với một mẫu glob hay không (`*` cho bất kỳ chuỗi nào, `?` cho một ký tự, `[chars]` cho một tập hợp).

### Cú pháp
```tcl
string match pattern string
```

### Ví dụ
```tcl
puts [string match "*.v" "design.v"]
```

### Đầu ra
```
1
```

---

## Tìm kiếm (first, last)

### Giải thích
`first` và `last` tìm chỉ số index của một chuỗi con. Chúng trả về -1 nếu không tìm thấy.

### Cú pháp
```tcl
string first subString string ?startIndex?
string last subString string ?lastIndex?
```

### Ví dụ
```tcl
set path "/user/bin/tclsh"
puts [string first "/" $path]
puts [string last "/" $path]
```

### Đầu ra
```
0
10
```

---

## Chuyển đổi kiểu chữ (tolower, toupper, totitle)

### Giải thích
Chuyển đổi kiểu chữ của chuỗi.

### Cú pháp
```tcl
string tolower string
string toupper string
string totitle string
```

---

## Cắt tỉa và Ánh xạ (trim, map)

### Giải thích
`trim` loại bỏ các ký tự được chỉ định (mặc định là khoảng trắng) khỏi cả hai đầu. `map` thay thế các chuỗi con dựa trên từ điển khóa-giá trị.

### Cú pháp
```tcl
string trim string ?chars?
string map {old1 new1 old2 new2} string
```

### Ví dụ
```tcl
puts [string trim "--hello--" "-"]
puts [string map {G C C G} "GCAT"]
```

### Đầu ra
```
hello
CGAT
```

---

## Định dạng chuỗi (format, scan)

### Giải thích
`format` tạo ra một chuỗi được định dạng giống như `sprintf` của C. `scan` trích xuất các giá trị giống như `sscanf`.

### Cú pháp
```tcl
format formatString ?arg arg ...?
scan string formatString ?varName ...?
```

### Ví dụ
```tcl
puts [format "Value: %04X" 255]
scan "Slack: -1.5 ns" "Slack: %f ns" slack
puts $slack
```

### Đầu ra
```
Value: 00FF
-1.5
```

---

## Kiểm tra kiểu (is)

### Giải thích
`string is` kiểm tra xem một chuỗi có thuộc một lớp nhất định hay không (integer, double, boolean, alpha, digit, alnum, space).

### Cú pháp
```tcl
string is class ?-strict? string
```

### Ví dụ
```tcl
puts [string is integer "123"]
puts [string is double -strict ""]
```

### Đầu ra
```
1
0
```

---

## Bài tập thực hành
- `01_string_operations.tcl`: Thực hành đo độ dài, chỉ mục, ánh xạ, chuyển đổi kiểu chữ và cắt tỉa.

---

## Tổng kết
- Sử dụng `string range` và `string index` để trích xuất.
- So khớp Glob cực kỳ nhanh và hữu ích cho tên tệp và so khớp tín hiệu.
- `string map` vô cùng hiệu quả cho nhiều lần thay thế chuỗi con.
- Sử dụng `string is` để xác thực dữ liệu an toàn.
