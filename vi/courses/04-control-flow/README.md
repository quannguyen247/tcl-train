# Chương 04: Luồng điều khiển
Các lệnh luồng điều khiển trong Tcl cho phép bạn đưa ra các quyết định và thực thi các vòng lặp. 

---

## Mục lục
- [Rẽ nhánh có điều kiện (if, elseif, else)](#conditional-branching-if-elseif-else)
- [Câu lệnh Switch](#switch-statements)
- [Vòng lặp While](#while-loops)
- [Vòng lặp For](#for-loops)
- [Vòng lặp Foreach](#foreach-loops)
- [Điều khiển vòng lặp (break, continue)](#loop-control-break-continue)
- [Tăng giảm biến (incr)](#incrementing-variables-incr)

---

## Rẽ nhánh có điều kiện (if, elseif, else)

### Giải thích
Lệnh `if` đánh giá một biểu thức boolean và thực thi khối mã tương ứng nếu nó đúng. Quy tắc cú pháp quan trọng nhất trong Tcl là vị trí của các dấu ngoặc nhọn: `} else {` PHẢI nằm trên cùng một dòng.

### Cú pháp
```tcl
if {condition} {
    # code
} elseif {condition} {
    # code
} else {
    # code
}
```

### Ví dụ
```tcl
set slack -15.5
if {$slack < 0} {
    puts "Timing Violation!"
} else {
    puts "Timing Met."
}
```

### Đầu ra
```
Timing Violation!
```

---

## Câu lệnh Switch

### Giải thích
Lệnh `switch` so khớp một giá trị với một tập hợp các mẫu. Theo mặc định, nó sử dụng so khớp chính xác (`-exact`), nhưng nó hỗ trợ glob (`-glob`) và biểu thức chính quy (`-regexp`). Sử dụng `--` để báo hiệu kết thúc các tùy chọn. Ký tự `-` cho phép chuyển tiếp (fall-through) sang khối lệnh tiếp theo.

### Cú pháp
```tcl
switch ?options? string {
    pattern1 body1
    pattern2 body2
    default bodyDefault
}
```

### Ví dụ
```tcl
set corner "ss"
switch -exact -- $corner {
    ff { puts "Fast Fast" }
    ss -
    slow { puts "Slow Corner" }
    default { puts "Typical" }
}
```

### Đầu ra
```
Slow Corner
```

---

## Vòng lặp While

### Giải thích
Vòng lặp `while` thực thi khối lệnh của nó miễn là điều kiện là đúng. Điều kiện được đánh giá lại trước mỗi vòng lặp. Tránh các vòng lặp vô hạn bằng cách đảm bảo điều kiện cuối cùng sẽ đánh giá là sai.

### Cú pháp
```tcl
while {condition} {
    # code
}
```

### Ví dụ
```tcl
set i 0
while {$i < 3} {
    puts "Index $i"
    set i [expr {$i + 1}]
}
```

### Đầu ra
```
Index 0
Index 1
Index 2
```

---

## Vòng lặp For

### Giải thích
Vòng lặp `for` bao gồm 4 khối: khởi tạo, điều kiện, bước nhảy và thân vòng lặp. Nó tương tự như vòng lặp for kiểu C.

### Cú pháp
```tcl
for {init} {cond} {step} {body}
```

### Ví dụ
```tcl
for {set i 0} {$i < 3} {incr i} {
    puts "Iteration $i"
}
```

### Đầu ra
```
Iteration 0
Iteration 1
Iteration 2
```

---

## Vòng lặp Foreach

### Giải thích
Vòng lặp `foreach` lặp qua một hoặc nhiều danh sách. Nó có thể gán nhiều biến cho mỗi lần lặp hoặc lặp qua nhiều danh sách song song.

### Cú pháp
```tcl
foreach varName list body
foreach {var1 var2} list body
```

### Ví dụ
```tcl
set gates {AND OR XOR}
foreach gate $gates {
    puts "Gate: $gate"
}
```

### Đầu ra
```
Gate: AND
Gate: OR
Gate: XOR
```

---

## Điều khiển vòng lặp (break, continue)

### Giải thích
Sử dụng `break` để thoát hoàn toàn khỏi vòng lặp và `continue` để bỏ qua phần còn lại của lần lặp hiện tại và chuyển sang lần lặp tiếp theo.

### Cú pháp
```tcl
break
continue
```

### Ví dụ
```tcl
for {set i 0} {$i < 5} {incr i} {
    if {$i == 2} { continue }
    if {$i == 4} { break }
    puts $i
}
```

### Đầu ra
```
0
1
3
```

---

## Tăng giảm biến (incr)

### Giải thích
Lệnh `incr` tăng (hoặc giảm) một biến số nguyên theo một lượng đã chỉ định (mặc định là 1).

### Cú pháp
```tcl
incr varName ?increment?
```

### Ví dụ
```tcl
set count 5
incr count
incr count -2
puts $count
```

### Đầu ra
```
4
```

---

## Bài tập thực hành
- `01_if_switch.tcl`: Thực hành rẽ nhánh có điều kiện và câu lệnh switch để phân loại trạng thái timing.
- `02_loops.tcl`: Làm việc với các vòng lặp for và while cho chuỗi và các tính toán số học.

---

## Tổng kết
- Luôn bao các biểu thức trong `if` và `while` bằng dấu ngoặc nhọn.
- Giữ `} else {` trên cùng một dòng.
- Sử dụng `switch` cho nhiều trường hợp so khớp chính xác hoặc theo mẫu.
- `foreach` là cách phổ biến và mạnh mẽ nhất để lặp qua các danh sách.
- Điều khiển các vòng lặp một cách chính xác với `break` và `continue`.
