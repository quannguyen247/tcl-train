# Tcl/Tk for EDA & DFT: Industry Training Course

Chào mừng bạn đến với khóa học **Tcl/Tk Scripting chuyên nghiệp** định hướng Electronic Design Automation (EDA) và Design For Testability (DFT). 

Khóa học này được thiết kế theo cấu trúc của một repository công nghiệp thực tế, giúp bạn không chỉ học cú pháp Tcl mà còn làm quen với cách viết code sạch, tối ưu hiệu năng và giải quyết các bài toán tự động hóa trong thiết kế vi mạch (ASIC/FPGA).

---

## 🛠️ Hướng dẫn cài đặt & Thực hành trên VS Code

Để thực hành viết và chạy script Tcl trực tiếp trên VS Code, hãy làm theo các bước chuẩn bị môi trường dưới đây:

### 1. Cài đặt Tcl Interpreter (Bộ dịch Tcl)
Tcl cần một trình thông dịch (interpreter) để chạy. Tên chương trình thường là `tclsh`.

* **Trên Windows**:
  - **Cách khuyên dùng (qua WinGet)**: Mở PowerShell và chạy lệnh:
    ```powershell
    winget install ActiveState.ActiveTcl
    ```
  - **Cách thủ công**: Tải bản cài đặt [ActiveTcl](https://www.activestate.com/products/tcl/) hoặc [Magicsplat Tcl](https://www.magicsplat.com/tcl-installer/index.html) và cài đặt. Đảm bảo đánh dấu chọn **"Add Tcl to PATH"** trong quá trình cài đặt.
* **Trên Linux (Ubuntu/CentOS)**:
  - Thường đã có sẵn trong các server EDA. Nếu chưa có, cài đặt qua terminal:
    ```bash
    sudo apt-get install tcl -y   # Ubuntu/Debian
    sudo yum install tcl -y       # CentOS/RHEL
    ```

### 2. Cài đặt các Extension cho VS Code
Mở VS Code, truy cập mục **Extensions (Ctrl+Shift+X)** và cài đặt các plugin sau để hỗ trợ viết code tốt nhất:
1. **Tcl Language Support** (bởi *bitwisestudio* hoặc *Sudar*): Cung cấp syntax highlighting, tự động thụt lề cho Tcl.
2. **Code Runner** (bởi *Jun Han*): Hỗ trợ chạy nhanh file Tcl hiện tại chỉ với 1 click hoặc tổ hợp phím.

### 3. Cấu hình Code Runner để chạy Tcl tự động
Để chạy file `.tcl` bằng nút Play của Code Runner:
1. Vào **Settings (Ctrl+,)**, tìm từ khóa `Executor Map`.
2. Click chọn **Edit in settings.json**.
3. Thêm hoặc cập nhật khóa `"tcl"` trong `"code-runner.executorMap"` như sau:
   ```json
   "code-runner.executorMap": {
       "tcl": "tclsh"
   }
   ```
4. Từ nay, bạn chỉ cần mở file `.tcl`, bấm tổ hợp phím `Ctrl+Alt+N` (hoặc click chuột phải chọn **Run Code**) để chạy script trực tiếp trên terminal của VS Code.

### 4. Kiểm tra môi trường (Verification)
Mở VS Code Terminal (**Ctrl+`**) và chạy lệnh:
```bash
tclsh
```
Nếu terminal chuyển sang dấu nhắc `%`, có nghĩa là bạn đã cài đặt thành công. Gõ `exit` để thoát.

---

## 📐 Quy ước viết Code (Coding Conventions)

Trong môi trường công nghiệp, tính dễ đọc và bảo trì của script là cực kỳ quan trọng. Hãy tuân thủ các quy tắc sau:

1. **Thụt lề (Indentation)**: Sử dụng **4 spaces** thay vì Tab.
2. **Đặt tên biến & procedure**:
   - Sử dụng kiểu **camelCase** cho tên biến thông thường (ví dụ: `pinName`, `clockPeriod`).
   - Sử dụng kiểu **snake_case** cho tên procedure (ví dụ: `parse_log_file`, `check_scan_chains`).
   - Hạn chế dùng biến global trừ khi thật sự cần thiết.
3. **Đặt tên file**: Sử dụng chữ thường, ngăn cách bằng dấu gạch dưới (ví dụ: `01_variables.tcl`).
4. **Cú pháp khối lệnh (Bracing Style)**: Luôn đặt dấu ngoặc mở `{` trên cùng một dòng với lệnh điều khiển (như `if`, `proc`, `foreach`):
   ```tcl
   if {$condition} {
       # code...
   } else {
       # code...
   }
   ```

---

## 📂 Cấu trúc Repository

```text
.
├── README.md                        # Tài liệu hướng dẫn chung này
├── roadmap.md                       # Lộ trình học chi tiết
├── 01-basic-syntax/                 # Biến, toán học, Quote Rules
├── 02-control-flow/                 # Rẽ nhánh (if, switch) và vòng lặp (while, foreach)
├── 03-procedures/                   # Định nghĩa hàm, tham số, upvar
├── 04-data-structures/              # Lists, Arrays, Dicts (Cực kỳ quan trọng trong EDA)
├── 05-file-io-regex/                # Đọc/Ghi file log, Parse Timing Report bằng Regex
├── 06-advanced-tcl/                 # Namespaces, Error Handling (catch/try), Dynamic Eval
├── 07-eda-scripting-apis/           # Giả lập database API của Synopsys/Cadence
├── 08-dft-automation/               # Các bài tập tự động hóa quy trình DFT thực tế
├── 09-mini-projects/                # Các dự án nhỏ sau mỗi chặng
└── 10-capstone-project/             # Dự án tổng hợp cuối khóa: DFT Flow Automation
```

---

## 🎓 Cách làm bài tập & Nhận Review

1. Đi tới thư mục của module đang học (ví dụ: `01-basic-syntax/`).
2. Mở file bài tập (ví dụ: `01_variables.tcl`), đọc kỹ phần yêu cầu trong comment đầu file.
3. Viết code của bạn vào phần skeleton tương ứng.
4. Chạy kiểm tra kết quả bằng lệnh `tclsh <filename>.tcl` hoặc sử dụng Code Runner trong VS Code.
5. Sau khi hoàn thành, hãy gửi code của bạn cho tôi. Tôi sẽ tiến hành **Code Review** và chấm điểm theo tiêu chuẩn công nghiệp (Correctness, Style, Readability, EDA Idiomatic).
