# Module 03: Vòng lặp và thủ tục (Loops & Procedures)

Module này giới thiệu `foreach`, cách viết `proc`, và cách tách một bài toán thành các hàm nhỏ có thể tái sử dụng.

---

## 📖 Kiến thức cốt lõi

### 1. Vòng lặp `foreach`
`foreach` duyệt lần lượt qua từng phần tử trong danh sách. Đây là cấu trúc rất phổ biến khi xử lý danh sách cell, pin, net hoặc report lines.

### 2. Thủ tục `proc`
`proc` dùng để đóng gói logic thành một hàm có tên rõ ràng, giúp script sạch hơn và dễ bảo trì hơn.

---

## ⚡ Ứng dụng thực tế trong EDA

Khi làm script tổng hợp, bạn thường tạo `proc` để tính các chỉ số timing rồi dùng `foreach` để duyệt qua danh sách path hoặc instance.
