# Chương 11: Xử lý Lỗi & Debugging

Khả năng xử lý lỗi mạnh mẽ và quan sát trạng thái hệ thống là rất quan trọng để phát triển các script EDA ổn định. Tcl cung cấp các lệnh để bắt lỗi, ném ngoại lệ tùy chỉnh, và soi trạng thái của biến cũng như lệnh.

---

## Mục lục
- [Bắt lỗi](#bắt-lỗi)
- [Tạo Lỗi](#tạo-lỗi)
- [Khám phá với Info](#khám-phá-với-info)
- [Theo dõi biến và lệnh](#theo-dõi-biến-và-lệnh)
- [Đo lường hiệu suất](#đo-lường-hiệu-suất)

---

## Bắt lỗi

### Giải thích
Lệnh `catch` thực thi một kịch bản và chặn lại bất kỳ lỗi nào được sinh ra, trả về một mã số nguyên thay vì làm sập chương trình.

### Cú pháp
```tcl
catch {script} resultVar ?optionsVar?
```
Các mã trả về bao gồm `0` (OK), `1` (Lỗi), `2` (Return), `3` (Break), `4` (Continue).

### Ví dụ
```tcl
if {[catch {expr {1 / 0}} result]} {
    puts "An error occurred: $result"
} else {
    puts "Result: $result"
}
```

### Kết quả
```
An error occurred: divide by zero
```

---

## Tạo Lỗi

### Giải thích
Bạn có thể chủ động gây lỗi bằng lệnh `error`, hoặc thoát khỏi thủ tục với một mã lỗi bằng `return -code error`.

### Cú pháp
```tcl
error message ?info? ?code?
return -code error "Error message"
```

---

## Khám phá với Info

### Giải thích
Lệnh `info` có rất nhiều lệnh con để kiểm tra biến, thủ tục, và trạng thái lúc chạy (runtime).

### Cú pháp
```tcl
info exists varName
info vars ?pattern?
info procs ?pattern?
info args procName
```

### Ví dụ
```tcl
proc do_work {a b} { return [expr {$a + $b}] }
puts "Arguments of do_work: [info args do_work]"
```

---

## Theo dõi biến và lệnh

### Giải thích
Lệnh `trace` cho phép giám sát sự thay đổi của biến hoặc việc thực thi của lệnh, rất hữu ích khi cần gỡ lỗi.

### Cú pháp
```tcl
trace add variable varName ops script
trace remove variable varName ops script
```

---

## Đo lường hiệu suất

### Giải thích
Lệnh `time` đo đếm thời gian cần để thực thi một script, có thể lặp lại nhiều lần để lấy trung bình.

### Cú pháp
```tcl
time {script} ?count?
```

---

## Bài tập thực hành
- `01_error_handling.tcl`: Viết script bắt lỗi an toàn khi đọc file, theo dõi sự thay đổi biến, và khám phá các proc đã load.

---

## Tóm tắt
- Sử dụng `catch` để xử lý lỗi một cách tinh tế.
- Tạo lỗi bằng `error` hoặc `return -code error`.
- Tận dụng `info` và `trace` để debug và introspect kịch bản hiệu quả.
