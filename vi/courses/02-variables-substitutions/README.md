# Chương 02: Biến & Cơ chế thay thế (Substitutions)

Trong Tcl, mọi thứ đều là chuỗi, và việc nắm vững cách các chuỗi được lưu trữ và đánh giá là chìa khóa để viết tập lệnh hiệu quả. Chương này bao gồm cách gán biến, các quy tắc trích dẫn (quoting), và các quy tắc thay thế (substitutions) khác nhau mà Tcl áp dụng khi phân tích cú pháp các lệnh.

---

## Mục lục
- [Gán và đọc biến](#gán-và-đọc-biến)
- [Quy tắc trích dẫn (Quoting Rules)](#quy-tắc-trích-dẫn-quoting-rules)
- [Ký tự thoát (Escape Sequences)](#ký-tự-thoát-escape-sequences)
- [Thay thế lệnh (Command Substitution)](#thay-thế-lệnh-command-substitution)
- [Quản lý biến](#quản-lý-biến)
- [Bài tập thực hành](#bài-tập-thực-hành)
- [Tổng kết](#tổng-kết)

---

## Gán và đọc biến

### Giải thích
Bạn tạo hoặc cập nhật một biến bằng lệnh `set`. Không giống như nhiều ngôn ngữ khác, Tcl yêu cầu một cú pháp riêng biệt để đọc biến: bạn sử dụng tiền tố `$` (dấu đô la) để thay thế giá trị của một biến vào lệnh. Nếu tên biến phức tạp hoặc dễ gây nhầm lẫn, bạn có thể đặt nó trong dấu ngoặc nhọn `${varName}`.

### Cú pháp
```tcl
set varName value
puts $varName
```

### Ví dụ
```tcl
set moduleName "ALU_core"
puts "Synthesizing module: $moduleName"
```

### Kết quả
```
Synthesizing module: ALU_core
```

---

## Quy tắc trích dẫn (Quoting Rules)

### Giải thích
Tcl sử dụng hai ký tự trích dẫn chính để nhóm các từ lại với nhau, nhưng chúng xử lý sự thay thế (substitution) một cách khác nhau:
- **Dấu ngoặc kép `""`**: Nhóm văn bản nhưng vẫn cho phép thay thế biến (`$`) và lệnh (`[]`).
- **Dấu ngoặc nhọn `{}`**: Nhóm văn bản nhưng vô hiệu hóa mọi sự thay thế. Văn bản bên trong được coi là một chuỗi nguyên bản (literal string). Điều này đặc biệt hữu ích trong EDA khi xử lý các chân bus (bus pins) như `data_in[7]`, nơi mà `[]` có thể bị hiểu nhầm là một sự thay thế lệnh.

### Ví dụ
```tcl
set width 32
puts "Bus width is $width"
puts {Bus width is $width}

# EDA Context
set pin {data_in[7]}
puts "Connecting pin: $pin"
```

### Kết quả
```
Bus width is 32
Bus width is $width
Connecting pin: data_in[7]
```

---

## Ký tự thoát (Escape Sequences)

### Giải thích
Dấu gạch chéo ngược `\` được sử dụng để thoát (escape) các ký tự đặc biệt, đảm bảo chúng được coi là các ký tự nguyên bản thay vì bị Tcl diễn dịch (ví dụ: `\$`, `\[`, `\\`). Nó cũng cho phép chèn các định dạng đặc biệt như dòng mới (`\n`) và tab (`\t`), hoặc chỉ định ký tự bằng mã hex (`\xHH`) hoặc unicode (`\uHHHH`). Một dấu gạch chéo ngược ở cuối dòng đóng vai trò là ký tự nối dòng, cho phép bạn ngắt các lệnh dài qua nhiều dòng.

### Ví dụ
```tcl
puts "Cost is \$100"
puts "Line1\nLine2\tTabbed"
set very_long_command \
    "This is a single line string."
```

### Kết quả
```
Cost is $100
Line1
Line2	Tabbed
```

---

## Thay thế lệnh (Command Substitution)

### Giải thích
Thay thế lệnh cho phép bạn đánh giá một lệnh Tcl và sử dụng kết quả của nó làm đối số cho một lệnh khác. Bạn đặt lệnh lồng nhau trong ngoặc vuông `[]`. Tcl sẽ đánh giá lệnh trong ngoặc trước và thay thế toàn bộ dấu ngoặc bằng giá trị trả về của lệnh đó.

### Cú pháp
```tcl
[command arg ...]
```

### Ví dụ
```tcl
set length [string length "chip_design"]
puts "Length is: $length"
```

### Kết quả
```
Length is: 11
```

---

## Quản lý biến

### Giải thích
Đôi khi bạn cần xóa một biến khỏi bộ nhớ hoặc kiểm tra xem nó đã được định nghĩa chưa trước khi sử dụng.
- `unset`: Xóa một biến.
- `info exists`: Trả về 1 nếu biến tồn tại và 0 nếu ngược lại.

### Ví dụ
```tcl
set tempVar 42
puts "Exists? [info exists tempVar]"
unset tempVar
puts "Exists after unset? [info exists tempVar]"
```

### Kết quả
```
Exists? 1
Exists after unset? 0
```

---

## Bài tập thực hành
- `01_variables.tcl`: Thực hành khai báo biến, thay thế cơ bản và xóa biến.
- `02_quoting_rules.tcl`: Khám phá cơ chế trích dẫn (quoting), bao gồm cách xử lý các chân bus EDA và các ký tự thoát.

---

## Tổng kết
- Sử dụng `set` để định nghĩa biến và `$` để đọc giá trị của chúng.
- Dấu ngoặc kép `""` cho phép thay thế; dấu ngoặc nhọn `{}` ngăn chặn sự thay thế (chuỗi nguyên bản).
- Dấu gạch chéo ngược `\` dùng để thoát các ký tự đặc biệt và cho phép ngắt lệnh trên nhiều dòng.
- Ngoặc vuông `[]` được sử dụng để thay thế lệnh, đánh giá các lệnh lồng nhau.
- Quản lý biến bằng `unset` và kiểm tra sự tồn tại bằng `info exists`.
