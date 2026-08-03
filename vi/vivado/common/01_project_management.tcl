# Bài học Vivado Tcl: 01_project_management
# -------------------------------------------------------------------------
# Mô tả: Các lệnh thiết yếu để tạo, tải và quản lý dự án Vivado.
# -------------------------------------------------------------------------

# 1. create_project
# Tạo một dự án Vivado mới.
# -force ghi đè nếu dự án đã tồn tại.
# -part chỉ định mã linh kiện FPGA.
puts "Đang tạo dự án..."
# create_project -force my_project ./my_project_dir -part xc7a35tcpg236-1

# 2. current_project
# Trả về dự án đang hoạt động hiện tại.
# set proj [current_project]
# puts "Dự án hiện tại: $proj"

# 3. set_property / get_property
# Dùng để thiết lập và lấy các thuộc tính của dự án hoặc bất kỳ đối tượng Vivado nào.
# set_property target_language VHDL [current_project]
# set lang [get_property target_language [current_project]]
# puts "Ngôn ngữ đích được thiết lập là: $lang"

# 4. add_files / import_files / remove_files
# Thêm file mã nguồn vào dự án.
# add_files chỉ liên kết file, trong khi import_files copy file vào thư mục dự án.
# add_files ./src/top.v
# import_files ./src/top.v
# remove_files ./src/top.v

# 5. set_part / get_parts
# Dùng để truy vấn các linh kiện có sẵn hoặc đổi linh kiện cho dự án hiện tại.
# get_parts *xc7a35t* 
# set_part xc7z020clg400-1

# 6. archive_project
# Nén toàn bộ dự án thành file zip để chia sẻ hoặc sao lưu.
# archive_project ./my_project_archive.zip -force

# 7. close_project / open_project
# Đóng dự án hiện tại trên RAM, và mở một dự án đã có.
# close_project
# open_project ./my_project_dir/my_project.xpr
