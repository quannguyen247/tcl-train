# Chương 03: Biểu thức & Toán học

Mặc dù Tcl coi mọi thứ là chuỗi, nó vẫn bao gồm một công cụ đánh giá toán học mạnh mẽ. Chương này đề cập đến cách thực hiện các phép toán số học, phép toán bit, so sánh logic và cách sử dụng các hàm toán học tích hợp một cách hiệu quả trong tập lệnh của bạn.

---

## Mục lục
- [Lệnh `expr`](#lệnh-expr)
- [Toán học số nguyên và số thực](#toán-học-số-nguyên-và-số-thực)
- [Các toán tử](#các-toán-tử)
- [Các hàm toán học tích hợp](#các-hàm-toán-học-tích-hợp)
- [Toán tử ba ngôi (Ternary Operator)](#toán-tử-ba-ngôi-ternary-operator)
- [Định dạng số](#định-dạng-số)
- [Giá trị Boolean](#giá-trị-boolean)
- [Bài tập thực hành](#bài-tập-thực-hành)
- [Tổng kết](#tổng-kết)

---

## Lệnh `expr`

### Giải thích
Để thực hiện bất kỳ phép toán nào trong Tcl, bạn phải sử dụng lệnh `expr`. Không giống như một số ngôn ngữ tự động đánh giá toán học, Tcl yêu cầu bạn gọi rõ ràng `expr` để diễn dịch một chuỗi thành một biểu thức toán học.
**Khuyến nghị (Best Practice)**: Luôn đặt biểu thức của bạn trong dấu ngoặc nhọn `{}`. Ví dụ: `expr {$a + $b}`. Điều này giúp ngăn chặn các vấn đề do thay thế kép (double-substitution) và mang lại sự cải thiện hiệu suất đáng kể vì trình biên dịch Tcl có thể tối ưu hóa việc thực thi.

### Cú pháp
```tcl
expr {expression}
```

### Ví dụ
```tcl
set a 10
set b 5
set sum [expr {$a + $b}]
puts "Sum is: $sum"
```

### Kết quả
```
Sum is: 15
```

---

## Toán học số nguyên và số thực

### Giải thích
Theo mặc định, Tcl thực hiện số học nguyên nếu cả hai toán hạng đều là số nguyên. Điều này có nghĩa là phép chia sẽ cắt bỏ phần thập phân. Để thực hiện phép chia số thực, ít nhất một trong các số phải là số thực (ví dụ: `2.0` thay vì `2` hoặc ép kiểu qua hàm `double()`).

### Ví dụ
```tcl
set intDiv [expr {5 / 2}]
set floatDiv [expr {5.0 / 2}]
puts "Integer: $intDiv, Float: $floatDiv"
```

### Kết quả
```
Integer: 2, Float: 2.5
```

---

## Các toán tử

### Giải thích
Tcl hỗ trợ một mảng lớn các toán tử tương tự như ngôn ngữ C:
- **Số học**: `+`, `-`, `*`, `/`, `%` (chia lấy dư), `**` (lũy thừa).
- **So sánh**: `==`, `!=`, `<`, `>`, `<=`, `>=`.
- **Logic**: `&&` (AND), `||` (OR), `!` (NOT).
- **Phép toán Bit (Bitwise)**: `&` (AND), `|` (OR), `^` (XOR), `~` (NOT), `<<` (Dịch trái), `>>` (Dịch phải).

### Ví dụ
```tcl
set isGreater [expr {10 > 5}]
set bitwiseAnd [expr {2 & 3}]
puts "Is 10 > 5? $isGreater"
puts "Bitwise AND of 2 and 3: $bitwiseAnd"
```

### Kết quả
```
Is 10 > 5? 1
Bitwise AND of 2 and 3: 2
```

---

## Các hàm toán học tích hợp

### Giải thích
Lệnh `expr` có nhiều hàm toán học tích hợp sẵn. Các hàm phổ biến bao gồm `sqrt`, `sin`, `cos`, `tan`, `abs`, `round`, `ceil`, `floor`, `pow`, `log`, `log10`, `exp`, `rand`, `srand`, `int`, `double` và `wide`.

### Ví dụ
```tcl
set area [expr {3.14 * pow(2.5, 2)}]
set roundedArea [expr {round($area)}]
puts "Area: $area, Rounded: $roundedArea"
```

### Kết quả
```
Area: 19.625, Rounded: 20
```

---

## Toán tử ba ngôi (Ternary Operator)

### Giải thích
Toán tử ba ngôi `? :` cung cấp một cách ngắn gọn để viết các biểu thức điều kiện đơn giản. Nó đánh giá điều kiện, trả về giá trị đầu tiên nếu đúng và giá trị thứ hai nếu sai.

### Cú pháp
```tcl
expr {condition ? trueVal : falseVal}
```

### Ví dụ
```tcl
set timingSlack -0.5
set status [expr {$timingSlack < 0 ? "VIOLATION" : "MET"}]
puts "Timing Status: $status"
```

### Kết quả
```
Timing Status: VIOLATION
```

---

## Định dạng số

### Giải thích
Lệnh `format` tương tự như `printf` của ngôn ngữ C. Nó cực kỳ hữu ích trong EDA cho việc định dạng các báo cáo. Bạn có thể định dạng số thực theo độ chính xác cụ thể (`%.2f`), đệm các số nguyên bằng số 0 (`%04d`), hoặc chuyển đổi thành hệ cơ số 16 (hexadecimal) (`%x`).

### Ví dụ
```tcl
puts [format "Delay: %.2f ns" 1.2345]
puts [format "Hex Value: %04x" 255]
```

### Kết quả
```
Delay: 1.23 ns
Hex Value: 00ff
```

---

## Giá trị Boolean

### Giải thích
Tcl nhận diện nhiều dạng biểu diễn chuỗi cho các giá trị đúng/sai (boolean).
- **True (Đúng)**: `1`, `true`, `yes`, `on`
- **False (Sai)**: `0`, `false`, `no`, `off`
Khi được đánh giá trong `expr`, các phép toán logic luôn trả về `1` cho đúng và `0` cho sai.

---

## Bài tập thực hành
- `01_math_expr.tcl`: Thực hành các phép toán số học, phép toán bit, các hàm toán học và định dạng số trong bối cảnh phân tích thời gian (timing analysis) của EDA.

---

## Tổng kết
- Sử dụng `expr` cho tất cả các phép toán và luôn đặt biểu thức trong dấu ngoặc nhọn `{}` để đảm bảo hiệu suất và an toàn.
- Hiểu sự khác biệt giữa phép chia số nguyên và số thực.
- Tcl hỗ trợ đầy đủ bộ các toán tử số học, so sánh, logic và phép toán bit.
- Tận dụng toán tử ba ngôi `? :` cho các điều kiện nội tuyến (inline).
- Sử dụng lệnh `format` để trình bày dữ liệu số một cách rõ ràng.
- Các giá trị boolean có thể là `1/0`, `true/false`, `yes/no` hoặc `on/off`.
