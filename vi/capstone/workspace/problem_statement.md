### ĐỀ BÀI: TỰ ĐỘNG HÓA KIỂM TRA ĐỒNG BỘ HÓA CLOCK DOMAIN CROSSING (CDC) VÀ XUẤT BÁO CÁO TIMING TÙY CHỈNH

**Vai trò:** Senior EDA Engineer  
**Công cụ áp dụng:** Xilinx Vivado (Design Suite)  
**Môi trường chạy:** Vivado Tcl Console (Sau khi đã hoàn thành Synthesis hoặc Implementation)

---

### 1. BỐI CẢNH THỰC TẾ (CONTEXT)
Trong các thiết kế FPGA lớn, việc truyền tín hiệu giữa các miền clock khác nhau (Clock Domain Crossing - CDC) mà không có mạch đồng bộ (Synchronizer) là nguyên nhân hàng đầu gây ra lỗi bất ổn định trạng thái (Metastability). 

Theo chuẩn thiết kế của công nghiệp, các mạch đồng bộ 2-stage flip-flop (được sử dụng cho các tín hiệu điều khiển đơn bit) bắt buộc phải tuân thủ hai điều kiện sau:
1. **Thuộc tính Netlist:** Cả hai Flip-Flop (FF) trong chuỗi đồng bộ phải được set thuộc tính `ASYNC_REG = TRUE` để bộ công cụ đặt (place) chúng gần nhau nhất có thể, giảm thiểu tối đa cửa sổ metastability.
2. **Timing Constraint:** Đường truyền từ miền clock nguồn đến FF đầu tiên của bộ đồng bộ phải được áp dụng luật timing thích hợp (thường là `set_max_delay` bằng chu kỳ của clock đích, hoặc `set_false_path` nếu đã có phân tích kỹ lưỡng) để tránh phân tích timing không thực tế (false violations) nhưng vẫn đảm bảo kiểm soát được skew.

**Vấn đề:** Các kỹ sư thiết kế thường quên gán thuộc tính `ASYNC_REG` trong RTL hoặc quên viết ràng buộc (constraints) cho các đường CDC này. Bạn cần viết một script Tcl chạy tự động trong Vivado để quét toàn bộ Netlist, phát hiện các điểm CDC đơn bit, kiểm tra tính đúng đắn của mạch đồng bộ và xuất báo cáo chất lượng.

---

### 2. MỤC TIÊU CỦA SCRIPT
Tạo một script Tcl độc lập (ví dụ: `audit_cdc_synchronizers.tcl`) có khả năng:
* Tự động quét và phân tích netlist để tìm các đường truyền CDC.
* Kiểm tra sự hiện diện và tính hợp lệ của cấu trúc mạch đồng bộ (2-stage register).
* Kiểm tra thuộc tính `ASYNC_REG`.
* Truy vấn thông tin Timing (Slack, Source Clock, Destination Clock) của các đường truyền này.
* Xuất báo cáo trực quan dưới dạng bảng ra Vivado Tcl Console và lưu lại thành file báo cáo CSV/Markdown để tích hợp vào luồng CI/CD (Continuous Integration).

---

### 3. YÊU CẦU KỸ THUẬT CHI TIẾT (REQUIREMENTS)

#### Yêu cầu 1: Phân tích Netlist và Lọc Tín hiệu CDC (Tcl cơ bản & Vivado Query)
* Script phải tìm tất cả các chân dữ liệu (`D` pin) của các Sequential Cells (Flip-Flops) trong thiết kế có clock của pin nguồn (Source Clock) khác với clock của pin đích (Destination Clock).
* Sử dụng các lệnh Vivado Tcl như `get_cells`, `get_pins`, `get_clocks`, `get_nets` để truy vết.
* Sử dụng cấu trúc danh sách (list) và vòng lặp (`foreach`, `for`) trong Tcl để duyệt qua các đối tượng này một cách tối ưu, tránh bị treo Vivado đối với các project lớn.

#### Yêu cầu 2: Kiểm tra Thuộc tính Đồng bộ (Property Verification)
Với mỗi FF đích (gọi là $FF_1$) nhận tín hiệu từ miền clock khác:
* **Kiểm tra Stage 1:** Kiểm tra xem $FF_1$ có thuộc tính `ASYNC_REG` được set là `TRUE` hay không.
* **Kiểm tra Stage 2:** Truy vết tiếp pin đầu ra `Q` của $FF_1$ xem nó có nối trực tiếp đến đầu vào `D` của một FF khác (gọi là $FF_2$) cùng miền clock hay không. Nếu có, kiểm tra xem $FF_2$ có được set `ASYNC_REG = TRUE` hay không.
* **Phân loại kết quả (Categorization):** Phân loại các đường CDC tìm được vào một trong các nhóm sau sử dụng cấu trúc điều kiện (`if-else` hoặc `switch` trong Tcl):
  * `SAFE`: Đủ 2 stage FF và cả 2 đều có `ASYNC_REG = TRUE`.
  * `WARNING_MISSING_PROP`: Có 2 stage FF nhưng một hoặc cả hai thiếu thuộc tính `ASYNC_REG`.
  * `UNSAFE_SINGLE_STAGE`: Chỉ có 1 stage FF duy nhất trước khi tín hiệu đi vào logic tổ hợp của miền clock đích.

#### Yêu cầu 3: Truy vấn thông tin Timing (Timing Path Query)
* Với mỗi đường CDC phát hiện được, sử dụng lệnh `get_timing_paths` để lấy thông tin:
  * Tên Clock nguồn (Source Clock).
  * Tên Clock đích (Destination Clock).
  * Giá trị Slack hiện tại.
  * Trạng thái ràng buộc (Constraint State): Đường truyền có được áp dụng `set_max_delay`, `set_false_path` hay đang chạy mặc định (Default Setup/Hold)?

#### Yêu cầu 4: Xử lý chuỗi và Xuất báo cáo (String Manipulation & File I/O)
* **Tcl Console Output:** Hiển thị một bảng tóm tắt kết quả được căn lề đẹp mắt bằng cách sử dụng các hàm xử lý chuỗi (`format`, `string length`) trong Tcl.
* **File Output:** Xuất ra một file báo cáo định dạng CSV (`cdc_audit_report.csv`) chứa các cột:
  ```text
  No., Source_Cell, Dest_Cell_Stage1, Dest_Cell_Stage2, Src_Clock, Dest_Clock, Status, Slack, Constraint_Type
  ```
* Sử dụng các lệnh thao tác file của Tcl (`open`, `puts`, `close`) và xử lý ngoại lệ (`catch`) để đảm bảo script không bị crash nếu không ghi được file.

---

### 4. ĐẦU RA MONG MUỐN (EXPECTED OUTPUT FORMAT)

Khi chạy script bằng lệnh `source audit_cdc_synchronizers.tcl`, kết quả hiển thị trên Tcl Console phải có dạng tương tự như sau:

```text
====================================================================================
                       CDC SYNCHRONIZER AUDIT REPORT
====================================================================================
ID  | Source Clock | Dest Clock | Dest Cell (Stage 1)       | Status       | Slack
------------------------------------------------------------------------------------
1   | clk_tx       | clk_rx     | inst_rx/reg_meta_reg[0]   | SAFE         | 3.421ns
2   | clk_core     | clk_axi    | inst_axi/ctrl_sync_reg[0] | WARN_NO_PROP | -0.124ns
3   | clk_spi      | clk_core   | inst_core/data_reg[0]     | UNSAFE_1STG  | No Path
====================================================================================
[INFO] Audit completed. Found 3 CDC paths. 
[INFO] Detailed report written to: /path/to/project/cdc_audit_report.csv
```

---

### 5. THỬ THÁCH CHO KỸ SƯ (CHALLENGE LEVEL UP)
* **Tối ưu hiệu năng (Runtime Optimization):** Làm thế nào để lọc nhanh các chân CDC mà không cần phải gọi lệnh `get_timing_paths` trên toàn bộ hàng vạn thanh ghi trong thiết kế (vì lệnh này cực kỳ tốn thời gian)? *Gợi ý: Sử dụng thuộc tính `CLASS`, `IS_SEQUENTIAL` và phân tích quan hệ clock trước khi query timing.*
* **Xử lý Bus (Bus Matching):** Làm thế nào để nhóm các đường CDC đơn lẻ thuộc cùng một Bus (ví dụ: `data_in[0]`, `data_in[1]`, ...) lại với nhau trong báo cáo để tránh làm loãng thông tin?