# Module 01: Cú pháp cơ bản (Basic Syntax)

Module này tập trung vào các nguyên lý cơ bản của cú pháp Tcl, cách hoạt động của trình thông dịch (Interpreter) và cách tổ chức các khối lệnh đơn giản.

---

## 📖 Lý thuyết cốt lõi (Core Theory)

### 1. Nguyên lý "Everything is a String" (Mọi thứ đều là chuỗi)
Trình thông dịch Tcl đọc dòng lệnh dưới dạng danh sách các từ được ngăn cách bởi khoảng trắng. Tất cả các dữ liệu ban đầu đều được coi là chuỗi (string). Chỉ khi chạy qua một lệnh yêu cầu kiểu dữ liệu cụ thể (như tính toán số học `expr`), chuỗi đó mới được chuyển đổi thành số.

### 2. Định nghĩa Biến (`set`, `unset`) và Thay thế giá trị (`$`)
* Để gán giá trị cho biến, sử dụng lệnh `set`:
  ```tcl
  set designName "SoC_Core"
  ```
* Để lấy giá trị của biến, sử dụng dấu `$` trước tên biến:
  ```tcl
  puts "Designing: $designName"
  ```
* Để giải phóng (xóa) biến ra khỏi bộ nhớ, sử dụng `unset`:
  ```tcl
  unset designName
  ```

### 3. Phép toán số học (`expr`)
Tcl không tự động tính toán biểu thức toán học dạng `set a 5 + 3`. Bạn bắt buộc phải gọi lệnh `expr`:
```tcl
set period 10
set frequency [expr {1000.0 / $period}] ;# Kết quả: 100.0 (MHz)
```
> [!TIP]
> **Best Practice**: Luôn bao bọc biểu thức của `expr` trong dấu ngoặc nhọn `{}` (ví dụ: `expr {$a + $b}`). Việc này giúp trình biên dịch Tcl tối ưu hóa (byte-compile) và tăng tốc độ chạy script đáng kể.

* **Integer vs Float**: Tcl tuân thủ quy tắc chia nguyên (Integer division) giống C.
  - `expr {5 / 2}` -> Kết quả: `2`
  - `expr {5.0 / 2}` hoặc `expr {double(5) / 2}` -> Kết quả: `2.5`

### 4. Quy tắc Gom nhóm & Thay thế (Quoting Rules)
Đây là phần dễ gây lỗi nhất đối với người mới học Tcl. Có 3 quy tắc chính:

| Ký tự gom nhóm | Tên gọi | Ý nghĩa | Ví dụ |
| :--- | :--- | :--- | :--- |
| **`" "`** | Double Quotes | Cho phép thay thế biến (`$`) và thay thế lệnh (`[]`). | `set msg "Clock is $clk"` |
| **`{ }`** | Braces (Ngoặc nhọn) | Vô hiệu hóa tất cả sự thay thế. Mọi ký tự bên trong được giữ nguyên làm chuỗi literal. | `set msg {Clock is $clk}` (in ra đúng chữ `$clk`) |
| **`[ ]`** | Brackets (Ngoặc vuông) | Thực thi lệnh bên trong ngoặc trước (Command Substitution) và trả về kết quả tại vị trí đó. | `set area [get_cell_area U1]` |

### 5. Ký tự Escape (`\`)
Sử dụng dấu gạch chéo ngược `\` để vô hiệu hóa ý nghĩa đặc biệt của một ký tự kế tiếp (ví dụ: `\$` để in ra ký tự đô-la).

---

## ⚡ Ứng dụng thực tế trong EDA (EDA Applications)

Trong các công cụ như Synopsys Design Compiler hoặc Cadence Innovus:
* **Đặt cấu hình**:
  ```tcl
  set CLK_PIN "clk_in"
  set_clock_uncertainty 0.05 [get_clocks $CLK_PIN]
  ```
* **Đường dẫn phân cấp**: Các bus hoặc instance phân cấp thường chứa ký tự ngoặc vuông `[ ]`. Ví dụ: `data_reg[0]`. Để tránh Tcl hiểu nhầm đây là command substitution, ta phải dùng dấu ngoặc nhọn `{}` hoặc dấu escape `\`:
  ```tcl
  get_pins {data_reg[0]/Q}    ;# Cách khuyên dùng: Gom nhóm bằng ngoặc nhọn
  get_pins data_reg\[0\]/Q   ;# Hoặc cách dùng dấu escape
  ```
