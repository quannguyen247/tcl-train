# 🗺️ Lộ trình đào tạo: Tcl/Tk cho EDA & DFT Engineer

Lộ trình này đi từ những khái niệm lập trình Tcl cơ bản nhất cho đến khi phát triển các tool/script tự động hóa hoàn chỉnh cho quy trình thiết kế vi mạch, đặc biệt tập trung vào kiểm tra DFT và xử lý kết quả kiểm tra (ATPG).

---

## 📍 Tổng quan lộ trình (Roadmap Overview)

```text
  [ Beginner ]
       │ (Cú pháp cơ bản, rẽ nhánh, vòng lặp, định nghĩa thủ tục)
       ▼
[ Intermediate ]
       │ (Xử lý chuỗi, List, Array, Dict, Đọc/ghi file log & Regex)
       ▼
  [ Advanced ]
       │ (Namespace bảo mật, Quản lý lỗi catch/try, Dynamic Eval)
       ▼
  [ EDA Scripting ]
       │ (Tương tác Design Database, get_cells, get_pins, Lọc thuộc tính)
       ▼
   [ DFT Tcl ]
         (Tự động hóa ATPG, Scan Chain Validation, Tessent Shell Automation)
```

---

## 📂 Chi tiết các Giai đoạn (Detailed Stages)

### 🚀 Giai đoạn 1: Beginner (Tcl cơ bản)
* **Mục tiêu**: Làm quen với nguyên lý hoạt động của trình thông dịch Tcl ("Everything is a string") và các cấu trúc điều khiển cơ bản.
* **Nội dung lý thuyết**:
  - Cú pháp gán biến (`set`), quy tắc gom nhóm lệnh và thay thế (`""`, `{}`, `[]`).
  - Phép toán số học với lệnh `expr`.
  - Cấu trúc rẽ nhánh `if / elseif / else`, `switch`.
  - Vòng lặp cơ bản: `while`, `for`, `foreach`.
  - Cách viết chương trình con (`proc`), phạm vi biến (`global`, `local`).
* **Kỹ năng đạt được**: Viết được script tự động hóa tính toán cơ bản và xử lý luồng logic tuần tự.
* **Liên hệ thực tế EDA**: Cấu hình các biến môi trường cho tool (ví dụ: `set CLK_PERIOD 10.0`), lặp qua danh sách tên cell/net đơn giản.

---

### 📈 Giai đoạn 2: Intermediate (Xử lý dữ liệu & File I/O)
* **Mục tiêu**: Nắm vững các cấu trúc dữ liệu nâng cao của Tcl và khả năng đọc/ghi, phân tích file log/report.
* **Nội dung lý thuyết**:
  - Làm việc với `List`: `lappend`, `lindex`, `llength`, `lsearch`, `lsort`.
  - Làm việc với `Array` (Mảng liên kết): Truy cập khóa, kiểm tra sự tồn tại (`info exists`, `array names`).
  - Làm việc với `Dict` (Từ điển lồng nhau): Xử lý cấu trúc dữ liệu dạng cây phức tạp.
  - Thao tác với File: `open`, `gets`, `puts`, `close`, kiểm tra thuộc tính file (`file exists`, `file size`).
  - Biểu thức chính quy (Regular Expressions): `regexp`, `regsub` để trích xuất dữ liệu nâng cao.
* **Kỹ năng đạt được**: Viết được script tự động phân tích (parse) các file báo cáo lỗi hoặc báo cáo timing của tool.
* **Liên hệ thực tế EDA**:
  - *List*: Danh sách các chân (pins) cần nối test.
  - *Dict*: Lưu giữ thông tin timing slack của từng đường dẫn (path) từ Startpoint đến Endpoint.
  - *File/Regex*: Parse giá trị Slack, Data Arrival Time, Data Required Time từ file report của Synopsys Design Compiler.

---

### 🛡️ Giai đoạn 3: Advanced (Scripting vững chắc)
* **Mục tiêu**: Xây dựng các thư viện script dùng chung (packages) có tính module hóa cao, kiểm soát lỗi chặt chẽ.
* **Nội dung lý thuyết**:
  - Quản lý không gian tên (`namespace`) để tránh trùng tên biến/hàm.
  - Cơ chế kiểm soát lỗi nâng cao: `catch`, `try / trap`, `error` để giữ flow chạy liên tục ngay cả khi gặp lỗi.
  - Thực thi code động (`eval`, `subst`).
  - Lệnh truy vấn trạng thái chương trình (`info`).
* **Kỹ năng đạt được**: Viết được các utilities (tiện ích bổ sung) an toàn cho dự án lớn mà không làm sập luồng chạy chính của tool.
* **Liên hệ thực tế EDA**: Tích hợp IP của bên thứ ba (Third-party) vào flow tổng thể mà không sợ xung đột hàm (conflict namespace). Khi chạy Synthesis qua đêm, nếu 1 cell bị lỗi nhỏ, script sẽ dùng `catch` để ghi nhận lỗi rồi tiếp tục chạy các cell khác thay vì dừng flow đột ngột.

---

### 🔌 Giai đoạn 4: EDA Scripting APIs (Môi trường tool thực tế)
* **Mục tiêu**: Làm quen với cách Tcl tương tác trực tiếp với Design Database trong các tool thương mại.
* **Nội dung lý thuyết**:
  - Khái niệm về Collection trong EDA (khác với List thông thường của Tcl).
  - Lệnh truy vấn database: `get_cells`, `get_ports`, `get_pins`, `get_nets`.
  - Lọc thuộc tính: `filter_collection`, `get_attribute`.
  - Định nghĩa ràng buộc thiết kế (SDC - Synopsys Design Constraints) qua Tcl.
* **Kỹ năng đạt được**: Tương tác trực tiếp với mạch thiết kế trong các tool như Design Compiler, Innovus, Vivado bằng script.
* **Liên hệ thực tế EDA**:
  - Tìm tất cả các Flip-flop có thuộc tính `is_sequential` để kiểm tra DFT.
  - Trích xuất danh sách tất cả output ports để gán ràng buộc `set_output_delay`.

---

### 🧬 Giai đoạn 5: DFT Tcl Automation (Thực hành DFT chuyên sâu)
* **Mục tiêu**: Trở thành kỹ sư DFT có khả năng tự động hóa toàn bộ quy trình chèn scan chain, chạy ATPG và kiểm tra lỗi.
* **Nội dung lý thuyết**:
  - Tessent Shell (Siemens EDA) Scripting: Thiết lập chế độ DFT, mô tả phần cứng thiết kế.
  - Phân tích ATPG Log: Tự động trích xuất tỉ lệ bao phủ lỗi (Fault Coverage), Test Coverage và số lượng test pattern.
  - Tạo script chèn Boundary Scan, Logic BIST.
  - Tạo file cấu hình pin mux phục vụ test mode.
* **Kỹ năng đạt được**: Phát triển hoàn chỉnh Capstone Project - Hệ thống tự động kiểm tra và chèn scan chain cho một khối SoC nhỏ.
