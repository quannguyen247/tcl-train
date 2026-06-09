# Chương 01: Giới thiệu & Bắt đầu

Chào mừng bạn đến với thế giới của Tcl (Tool Command Language)! Tcl là một ngôn ngữ lập trình động đơn giản nhưng vô cùng mạnh mẽ, được sử dụng rộng rãi trong ngành EDA (Electronic Design Automation), kiểm thử mạng và hệ thống nhúng. Chương này bao gồm các khái niệm nền tảng bạn cần để viết và hiểu các tập lệnh Tcl cơ bản.

---

## Mục lục
- [Triết lý Tcl](#triết-lý-tcl)
- [Lịch sử](#lịch-sử)
- [Chạy Tcl](#chạy-tcl)
- [Cấu trúc Script](#cấu-trúc-script)
- [Lệnh `puts`](#lệnh-puts)
- [Biến toàn cục](#biến-toàn-cục)
- [Bài tập thực hành](#bài-tập-thực-hành)
- [Tổng kết](#tổng-kết)

---

## Triết lý Tcl

### Giải thích
Về cốt lõi, Tcl được định hướng bởi hai nguyên tắc chính:
1. **"Mọi thứ đều là chuỗi" (Everything is a string)**: Các kiểu dữ liệu như số, danh sách hoặc boolean đều được biểu diễn dưới dạng chuỗi ẩn bên dưới. Tcl diễn dịch các chuỗi này dựa trên ngữ cảnh của lệnh.
2. **Dựa trên lệnh (Command-based)**: Mọi thao tác bạn làm trong Tcl đều là thực thi lệnh. Một tập lệnh Tcl về cơ bản là một chuỗi các lệnh cách nhau bởi dấu xuống dòng hoặc dấu chấm phẩy.

### Cú pháp
```tcl
command arg1 arg2 ...
```

---

## Lịch sử

### Giải thích
Tcl được tạo ra vào năm 1988 bởi **John Ousterhout** tại Đại học California, Berkeley. Ban đầu, nó được thiết kế như một ngôn ngữ kịch bản có thể tái sử dụng và nhúng vào các công cụ, để các nhà phát triển không phải phát minh ra một ngôn ngữ mới cho mỗi ứng dụng họ xây dựng. Ngày nay, nó vẫn là ngôn ngữ kịch bản tiêu chuẩn cho các công cụ tổng hợp, layout và mô phỏng trong thiết kế chip công nghiệp.

---

## Chạy Tcl

### Giải thích
Có hai môi trường chính để chạy Tcl:
- **`tclsh`**: Giao diện dòng lệnh (CLI) tiêu chuẩn để thực thi các tập lệnh Tcl thuần túy.
- **`wish`**: Windowing Shell, được sử dụng cho các tập lệnh có giao diện đồ họa (GUI) xây dựng bằng Tk.

Trên các hệ thống Unix, bạn có thể biến một tập lệnh Tcl thành tệp có thể thực thi trực tiếp bằng cách thêm dòng **shebang** ở trên cùng.

### Cú pháp
```tcl
#!/usr/bin/env tclsh
```

---

## Cấu trúc Script

### Giải thích
Một tập lệnh Tcl bao gồm các lệnh cách nhau bởi dấu xuống dòng hoặc dấu chấm phẩy (`;`). Có thể thêm chú thích bằng ký tự `#`, nhưng với một quy tắc cụ thể: dấu `#` phải xuất hiện ở vị trí mà Tcl mong đợi ký tự đầu tiên của một lệnh.

### Ví dụ
```tcl
# This is a comment
set a 10 ; # This is another comment after a command
```

---

## Lệnh `puts`

### Giải thích
Lệnh `puts` được dùng để in đầu ra. Theo mặc định, nó in ra kênh chuẩn (`stdout`) và thêm một ký tự xuống dòng ở cuối. Bạn có thể loại bỏ dấu xuống dòng này bằng cờ `-nonewline`, hoặc chuyển hướng đầu ra đến kênh báo lỗi (`stderr`).

### Cú pháp
```tcl
puts ?-nonewline? ?channelId? string
```

### Ví dụ
```tcl
puts "Hello, World!"
puts -nonewline "This is on "
puts "the same line."
puts stderr "This is an error message."
```

### Kết quả
```
Hello, World!
This is on the same line.
This is an error message.
```

---

## Biến toàn cục

### Giải thích
Khi bạn chạy một tập lệnh Tcl, trình thông dịch sẽ tự động cung cấp một số biến toàn cục chứa thông tin hữu ích về môi trường thực thi của kịch bản.
- `argc`: Số lượng đối số dòng lệnh truyền vào tập lệnh.
- `argv`: Một danh sách chứa các đối số dòng lệnh.
- `argv0`: Tên của tập lệnh đang được thực thi.
- `tcl_version`: Phiên bản của trình thông dịch Tcl đang chạy.

### Ví dụ
```tcl
puts "Running script: $argv0"
puts "Tcl version: $tcl_version"
```

---

## Bài tập thực hành
- `01_hello_tcl.tcl`: Tập lệnh dành cho người mới bắt đầu để thực hành in dữ liệu cơ bản, sử dụng các kênh (channels) và đọc các biến toàn cục tích hợp. Hãy chạy nó với nhiều đối số dòng lệnh khác nhau để xem `argc` và `argv` thay đổi như thế nào.

---

## Tổng kết
- Tcl coi tất cả dữ liệu là chuỗi và hoạt động thông qua các lệnh.
- Sử dụng `tclsh` để chạy tập lệnh và bắt đầu các tập lệnh Unix bằng `#!/usr/bin/env tclsh`.
- Lệnh `puts` xử lý đầu ra tới `stdout` và `stderr`.
- Sử dụng `#` cho chú thích, đảm bảo nó bắt đầu ở nơi một lệnh được mong đợi.
- Các biến toàn cục như `argv` và `tcl_version` cung cấp thông tin ngữ cảnh của kịch bản.
