# Exercise 03: Quoting Rules ("", {}, []) and Special Characters in EDA
# 1. Khai báo biến 'module_name' với giá trị là "core_dft" và 'net_name' với giá trị là "scan_enable".
# 2. Tạo một biến 'path_double_quotes' sử dụng dấu ngoặc kép "" để lưu giá trị:
#    "Path for core_dft is /top/core_dft/scan_enable" (trong đó core_dft và scan_enable được thay thế tự động từ biến).
# 3. Tạo một biến 'path_braces' sử dụng dấu ngoặc nhọn {} để lưu giá trị:
#    "Path for $module_name is /top/$module_name/$net_name" (in ra đúng ký tự $, không thay thế).
# 4. Trong EDA, các bus thường được biểu diễn dạng: `data_in[7]`. Giả sử ta muốn truy xuất chân `core_dft/data_in[7]`.
#    Hãy gán chuỗi `core_dft/data_in[7]` vào các biến 'bus_pin_1' và 'bus_pin_2' bằng 2 cách:
#      a. Cách 1: Sử dụng dấu ngoặc nhọn `{}` (An toàn, khuyên dùng).
#      b. Cách 2: Sử dụng dấu ngoặc kép `""` nhưng phải dùng ký tự escape `\` để Tcl không hiểu lầm `[7]` là lệnh chạy command substitution.
# 5. In toàn bộ các biến trên ra màn hình để kiểm chứng sự khác biệt.
# Bonus: Giải thích ngắn gọn bằng comment vì sao việc dùng dấu escape `\` hoặc ngoặc nhọn `{}` lại cực kỳ quan trọng khi làm việc với bus index (ví dụ: `reg[15]`) trong môi trường EDA Tcl.
# Viết code của bạn ở đây:

# 1. Khai báo biến 'module_name' với giá trị là "core_dft" và 'net_name' với giá trị là "scan_enable".
set module_name "core_dft"
set net_name "scan_enable"

# 2. Tạo một biến 'path_double_quotes' sử dụng dấu ngoặc kép "" để lưu giá trị: "Path for core_dft is /top/core_dft/scan_enable".
set path_double_quotes "Path for $module_name is /top/$module_name/$net_name"

# 3. Tạo một biến 'path_braces' sử dụng dấu ngoặc nhọn {} để lưu giá trị: "Path for $module_name is /top/$module_name/$net_name".
set path_braces {Path for $module_name is /top/$module_name/$net_name}

# 4. Gán chuỗi `core_dft/data_in[7]` vào các biến 'bus_pin_1' và 'bus_pin_2' bằng 2 cách:
# Cách 1: Sử dụng dấu ngoặc nhọn {}
set bus_pin_1 {core_dft/data_in[7]}

# Cách 2: Sử dụng dấu ngoặc kép "" nhưng phải escape dấu ngoặc vuông bằng ký tự \.
set bus_pin_2 "core_dft/data_in\[7\]"

# 5. In toàn bộ các biến trên ra màn hình để kiểm chứng sự khác biệt.
puts "Double quotes: $path_double_quotes"
puts "Braces       : $path_braces"
puts "Bus pin (1)  : $bus_pin_1"
puts "Bus pin (2)  : $bus_pin_2"

# Bonus: Giải thích ngắn gọn bằng comment vì sao việc dùng dấu escape \ hoặc ngoặc nhọn {} lại cực kỳ quan trọng khi làm việc với bus index (ví dụ: reg[15]) trong môi trường EDA Tcl.
# Dấu ngoặc vuông [] trong Tcl biểu thị "Thực thi lệnh lồng" (Command Substitution).
# Nếu chúng ta viết "core_dft/data_in[7]" mà không có dấu escape \ hoặc không bọc trong ngoặc nhọn {},
# Tcl sẽ cố gắng thực thi một lệnh tên là "7" và chèn kết quả trả về của lệnh "7" vào chuỗi.
# Do không có lệnh nào tên là "7", trình thông dịch sẽ báo lỗi "invalid command name '7'" và crash script.
# Do đó, việc escape hoặc dùng ngoặc nhọn là bắt buộc khi làm việc với bus index trong EDA.
