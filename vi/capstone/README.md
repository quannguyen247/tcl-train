# Đồ Án Cuối Khóa (Capstone): AI-Powered Grader

Thư mục này cung cấp một môi trường kiểm tra tự động, nơi bạn có thể vận dụng mọi kiến thức đã học vào thực tế.

## Cách hoạt động

Tool i_grader.exe (hoặc i_grader.py) sử dụng AI Gemini của Google để tự động tạo ra một đề bài thực tế mang tính ngẫu nhiên. Sau khi bạn viết code giải bài toán đó, AI sẽ tự động chấm điểm, nhận xét về phong cách code, và đưa ra số điểm cuối cùng.

## Cài đặt (Nếu chạy file .py)

Nếu bạn không muốn chạy file .exe có sẵn, bạn có thể tự chạy file Python:
1. Cài đặt Python 3.9 trở lên.
2. Cài đặt thư viện:
   \\\ash
   pip install -r requirements.txt
   \\\

## Hướng dẫn sử dụng

1. **Lấy API Key**: Truy cập [Google AI Studio](https://aistudio.google.com/) và tạo một API Key miễn phí.
2. **Chạy tool**:
   - Click đúp vào i_grader.exe HOẶC chạy lệnh python ai_grader.py.
   - Nhập API Key khi được yêu cầu.
3. **Sinh đề bài**: Chọn Option 1. AI sẽ tạo ra file problem_statement.md trong thư mục workspace/.
4. **Làm bài**: Mở file workspace/solution.tcl và viết code Tcl của bạn vào đó.
5. **Chấm điểm**: Chọn Option 2. AI sẽ chấm code của bạn và ghi kết quả, nhận xét cùng điểm số ra file evaluation.md.

Chúc bạn học tốt và đạt điểm cao!
