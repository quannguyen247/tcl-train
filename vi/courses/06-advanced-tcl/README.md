# Module 06: Tcl nâng cao (Advanced Tcl)

Module này giới thiệu `namespace`, `catch`, và cách viết các tiện ích Tcl an toàn hơn cho script lớn.

---

## 📖 Kiến thức cốt lõi

### 1. `namespace`
`namespace` giúp gom các thủ tục liên quan vào một vùng tên riêng, giảm xung đột tên trong dự án lớn.

### 2. `catch`
`catch` cho phép bắt lỗi thay vì để script dừng đột ngột. Điều này rất hữu ích khi xử lý dữ liệu đầu vào không ổn định hoặc report thiếu trường.

---

## ⚡ Ứng dụng thực tế trong EDA

Trong flow công nghiệp, `namespace` giúp đóng gói các utility cho timing/DFT, còn `catch` giúp script chạy tiếp ngay cả khi một report hoặc cell cụ thể bị thiếu.
