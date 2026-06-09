# Chương 12: Modular hóa & Namespaces

Các dự án Tcl lớn đòi hỏi phải tổ chức mã code thành các phần quản lý được. Namespaces và tính năng modular đảm bảo khả năng tái sử dụng, ngăn xung đột tên và tạo ra kiến trúc API sạch sẽ.

---

## Mục lục
- [Scripts và Sourcing](#scripts-và-sourcing)
- [Namespaces](#namespaces)
- [Packages](#packages)
- [Thực thi Động](#thực-thi-động)

---

## Scripts và Sourcing

### Giải thích
Bạn có thể thực thi một script khác trong môi trường Tcl hiện tại bằng lệnh `source`. Để lấy thư mục tương đối của script hiện tại, dùng `info script`.

### Cú pháp
```tcl
source filename
set dir [file dirname [info script]]
```

---

## Namespaces

### Giải thích
Namespaces nhóm các lệnh và biến để tránh trùng lặp. Bạn có thể `export` các lệnh từ namespace và `import` chúng ở nơi khác.

### Cú pháp
```tcl
namespace eval name {
    variable varName
    namespace export pattern
}
namespace current
namespace import name::pattern
```

### Ví dụ
```tcl
namespace eval MathUtils {
    namespace export add
    proc add {a b} { return [expr {$a + $b}] }
}
namespace import MathUtils::add
puts [add 2 3]
```

### Kết quả
```
5
```

---

## Packages

### Giải thích
Packages đóng gói các chức năng liên quan với một số phiên bản (version). Tcl dùng biến `auto_path` để tìm packages. Lệnh `package require` sẽ tải một package.

### Cú pháp
```tcl
package provide name version
package require name ?version?
```

---

## Thực thi Động

### Giải thích
Tcl cho phép tạo các lệnh trong thời gian thực (runtime) bằng `eval` và thực hiện thay thế phức tạp qua `subst`.

### Cú pháp
```tcl
eval command
subst ?-nocommands? string
```

---

## Bài tập thực hành
- `01_namespaces.tcl`: Tạo một namespace phân tích timing xuất các lệnh và thử nghiệm tính độc lập.

---

## Tóm tắt
- Dùng `source` để chia logic ra nhiều file.
- Namespaces cung cấp khả năng đóng gói cho các script lớn.
- Packages giúp phân phối mã ổn định.
