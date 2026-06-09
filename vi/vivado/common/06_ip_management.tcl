# Bài học Vivado Tcl: 06_ip_management
# -------------------------------------------------------------------------
# Mô tả: Quản lý, cấu hình và tạo ra các IP core của Xilinx.
# -------------------------------------------------------------------------

# 1. create_ip
# Tạo một IP core mới từ catalog IP của Vivado.
# -name đặt tên cho phiên bản IP. -vendor, -library, -name, -version xác định loại lõi IP.
# create_ip -name blk_mem_gen_0 -vendor xilinx.com -library ip -version 8.4 -module_name my_bram

# 2. set_property (trên IP)
# Cấu hình các thông số cho IP vừa tạo.
# set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Use_Byte_Write_Enable {true}] [get_ips my_bram]

# 3. generate_target
# Tạo các file cần thiết cho IP (template mẫu, tổng hợp, mô phỏng).
# generate_target all [get_ips my_bram]

# 4. export_ip_user_files
# Xuất các file được tạo ra vào một thư mục tập trung để quản lý phiên bản (git).
# export_ip_user_files -of_objects [get_ips my_bram] -no_script -sync -force -quiet

# 5. get_ips
# Liệt kê tất cả các IP đang có trong dự án.
# puts "Các IP của dự án: [get_ips]"

# 6. report_ip_status / upgrade_ip
# Kiểm tra xem có IP nào cần nâng cấp không (vd: khi chuyển sang bản Vivado mới) và nâng cấp chúng.
# report_ip_status -name ip_status
# upgrade_ip [get_ips]
