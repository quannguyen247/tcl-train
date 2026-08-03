# Module 02: Rẽ nhánh và Vòng lặp (Control Flow & Loops)

Module này hướng dẫn chi tiết các cấu trúc điều khiển luồng trong Tcl: điều kiện (`if`, `switch`), các vòng lặp (`for`, `while`, `foreach`), và các bẫy cú pháp phổ biến trong lập trình Tcl.

---

## 📖 Kiến thức cốt lõi

### 1. Rẽ nhánh với `if` và `switch`
`if` dùng để kiểm tra điều kiện logic. Trong Tcl, biểu thức điều kiện bắt buộc nên đặt trong ngoặc nhọn `{}` để Tcl biên dịch Bytecode tối ưu tốc độ.

```tcl
if {$slack_ps < 0} {
    puts "Timing violation"
} elseif {$slack_ps < 50} {
    puts "Timing margin is tight"
} else {
    puts "Timing is safe"
}
```

⚠️ **Bẫy cú pháp cần tránh:**
Từ khóa `else` và `elseif` **bắt buộc phải nằm trên CÙNG 1 DÒNG** với dấu ngoặc đóng `}` trước đó:
- ✅ **ĐÚNG:** `} else {`
- ❌ **SAI:** 
  ```tcl
  }
  else {  ;# Báo lỗi "invalid command name else"
  ```

---

### 2. Vòng lặp `for` (For Loop)

Cấu trúc lệnh `for` trong Tcl gồm 4 khối trong ngoặc nhọn `{}`:

```tcl
for {khởi_tạo} {điều_kiện_lặp} {bước_nhảy} { thân_vòng_lặp }
```

**Ví dụ:** Duyệt qua 2 chuỗi để tính khoảng cách Hamming:

```tcl
for {set i 0} {$i < $len} {incr i} {
    set char1 [string index $left $i]
    set char2 [string index $right $i]
    if {$char1 ne $char2} {
        incr distance
    }
}
```

- `{set i 0}`: Khối khởi tạo biến đếm `i` (chạy 1 lần duy nhất ban đầu).
- `{$i < $len}`: Điều kiện lặp (kiểm tra trước mỗi vòng lặp).
- `{incr i}`: Bước nhảy (tăng biến `i` thêm 1 ở cuối mỗi vòng).
- `{ ... }`: Thân vòng lặp thực thi các câu lệnh.

---

### 3. Vòng lặp `while` (While Loop)

Cấu trúc lệnh `while` kiểm tra điều kiện trước khi thực thi thân lặp:

```tcl
while {điều_kiện_lặp} { thân_vòng_lặp }
```

**Ví dụ:** Bài toán Giả thuyết Collatz:

```tcl
while {$number > 1} {
    incr count
    if {$number % 2 == 0} {
        set number [expr {$number / 2}]
    } else {
        set number [expr {$number * 3 + 1}]
    }
}
```

- **Điều kiện dừng:** `while {$number > 1}` dừng lại ngay khi `$number == 1`. 
- ⚠️ Không dùng `$number >= 1` vì sẽ gây ra lặp vô tận (Infinite Loop)!

---

### 4. Mẹo & Thuật toán quan trọng (Tricks & Canonical Form)

- **Dạng chính tắc (Canonical Form) cho bài toán Anagram:**
  Tách ký tự và sắp xếp alphabet để đưa các từ xáo trộn về cùng 1 dạng chuẩn:
  `set canonical [lsort [split [string tolower $word] ""]]`

- **Tối ưu Toán học $O(1)$ thay cho vòng lặp:**
  - Tổng các số $1 \rightarrow n$: $S = \frac{n(n+1)}{2}$
  - Tổng bình phương $1^2 + ... + n^2$: $S = \frac{n(n+1)(2n+1)}{6}$

---

## ⚡ Ứng dụng thực tế trong EDA / Vi mạch

Trong script tổng hợp và mô phỏng vi mạch (Vivado, Design Compiler, Tessent):
- `for` dùng để duyệt qua các đường bus, các chân pin `data[0]` đến `data[31]`.
- `while` dùng để chờ phản hồi từ tín hiệu reset hoặc trạng thái handshake của phần cứng.
