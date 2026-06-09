# Chương 05: Thủ tục và Phạm vi
Các thủ tục trong Tcl cho phép bạn tạo các khối mã có thể tái sử dụng. Các biến trong các thủ tục có phạm vi cục bộ.

---

## Mục lục
- [Định nghĩa thủ tục (proc)](#defining-procedures-proc)
- [Giá trị trả về](#return-values)
- [Đối số mặc định](#default-arguments)
- [Đối số biến đổi (args)](#variable-arguments-args)
- [Phạm vi biến và global](#variable-scope-and-global)
- [Truyền tham chiếu (upvar)](#pass-by-reference-upvar)
- [Thực thi trong phạm vi gọi (uplevel)](#execute-in-caller-scope-uplevel)

---

## Định nghĩa thủ tục (proc)

### Giải thích
Sử dụng lệnh `proc` để định nghĩa một thủ tục. Nó nhận ba đối số: tên, danh sách các tham số và thân thủ tục.

### Cú pháp
```tcl
proc name {args} {
    # body
}
```

### Ví dụ
```tcl
proc greet {name} {
    puts "Hello, $name!"
}
greet "EDA Engineer"
```

### Đầu ra
```
Hello, EDA Engineer!
```

---

## Giá trị trả về

### Giải thích
Theo mặc định, một thủ tục trả về kết quả của lệnh được thực thi cuối cùng. Bạn có thể trả về một giá trị một cách rõ ràng bằng cách sử dụng `return`.

### Cú pháp
```tcl
return ?value?
```

### Ví dụ
```tcl
proc multiply {a b} {
    return [expr {$a * $b}]
}
puts [multiply 4 5]
```

### Đầu ra
```
20
```

---

## Đối số mặc định

### Giải thích
Bạn có thể cung cấp các giá trị mặc định cho các tham số bằng cách nhóm tên tham số và giá trị mặc định của nó trong một danh sách.

### Cú pháp
```tcl
proc name {{param default}} {
    # body
}
```

### Ví dụ
```tcl
proc connect_pin {pin_name {net_name "VDD"}} {
    puts "Connected $pin_name to $net_name"
}
connect_pin "A"
connect_pin "B" "GND"
```

### Đầu ra
```
Connected A to VDD
Connected B to GND
```

---

## Đối số biến đổi (args)

### Giải thích
Nếu tham số cuối cùng có tên chính xác là `args`, thủ tục sẽ chấp nhận bất kỳ số lượng đối số bổ sung nào, được truyền dưới dạng một danh sách.

### Cú pháp
```tcl
proc name {param1 args} {
    # body
}
```

### Ví dụ
```tcl
proc summarize {name args} {
    puts "$name has [llength $args] additional items: $args"
}
summarize "Route1" A B C
```

### Đầu ra
```
Route1 has 3 additional items: A B C
```

---

## Phạm vi biến và global

### Giải thích
Các biến được tạo bên trong một proc là cục bộ. Để truy cập hoặc sửa đổi các biến được định nghĩa bên ngoài proc trong phạm vi toàn cục, hãy sử dụng lệnh `global`.

### Cú pháp
```tcl
global varName
```

### Ví dụ
```tcl
set error_count 0
proc log_error {msg} {
    global error_count
    incr error_count
    puts "Error: $msg"
}
log_error "DRC Violation"
puts "Total errors: $error_count"
```

### Đầu ra
```
Error: DRC Violation
Total errors: 1
```

---

## Truyền tham chiếu (upvar)

### Giải thích
Lệnh `upvar` liên kết một biến cục bộ với một biến trong phạm vi của người gọi, cho phép bạn truyền các biến theo tham chiếu và sửa đổi chúng trực tiếp.

### Cú pháp
```tcl
upvar level otherVar localVar
```

### Ví dụ
```tcl
proc scale_power {pwr_var factor} {
    upvar 1 $pwr_var local_pwr
    set local_pwr [expr {$local_pwr * $factor}]
}
set pwr 10.0
scale_power pwr 1.5
puts $pwr
```

### Đầu ra
```
15.0
```

---

## Thực thi trong phạm vi gọi (uplevel)

### Giải thích
`uplevel` đánh giá một tập lệnh trong một khung ngăn xếp (stack frame) khác, thường là phạm vi của người gọi. Nó hữu ích để tạo các cấu trúc điều khiển tùy chỉnh.

### Cú pháp
```tcl
uplevel level script
```

### Ví dụ
```tcl
proc do_twice {script} {
    uplevel 1 $script
    uplevel 1 $script
}
set x 0
do_twice {incr x}
puts $x
```

### Đầu ra
```
2
```

---

## Bài tập thực hành
- `01_procedures.tcl`: Cấu trúc lại các hoạt động thành các thủ tục, thực hành các đối số mặc định, truyền tham chiếu và trạng thái toàn cục.

---

## Tổng kết
- Các proc cung cấp tính đóng gói và tính mô-đun.
- Các đối số mặc định cung cấp sự linh hoạt.
- Sử dụng `global` một cách hạn chế; ưu tiên `upvar` để sửa đổi các biến của người gọi.
- `args` cho phép tạo các hàm có số lượng đối số thay đổi (variadic).
