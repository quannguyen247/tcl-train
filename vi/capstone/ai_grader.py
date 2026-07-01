import os
import sys
import textwrap
import time
try:
    import google.generativeai as genai
except ImportError:
    print("Lỗi: thư viện google-generativeai chưa được cài đặt.")
    print("Vui lòng cài đặt bằng lệnh: pip install google-generativeai")
    input("Nhấn Enter để thoát...")
    sys.exit(1)

def setup_gemini():
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("\n[!] Không tìm thấy biến môi trường GEMINI_API_KEY.")
        print("Vui lòng nhập Gemini API Key của bạn vào bên dưới.")
        api_key = input("API Key: ").strip()
        if not api_key:
            print("Bắt buộc phải có API Key để chạy công cụ này.")
            input("Nhấn Enter để thoát...")
            sys.exit(1)
        os.environ["GEMINI_API_KEY"] = api_key
    
    genai.configure(api_key=api_key)
    # Sử dụng gemini-3.5-flash làm mặc định để phản hồi nhanh
    return genai.GenerativeModel('gemini-3.5-flash')

def generate_problem(model):
    print("\n[Hệ thống] Đang kết nối tới Gemini AI để tạo một đề bài thực tế...")
    prompt = """
    Bạn là một kỹ sư EDA Senior. Hãy tạo một yêu cầu viết script Tcl Vivado thực tế chuẩn công nghiệp.
    Đề bài phải kết hợp giữa Tcl cơ bản (vòng lặp, danh sách, biến, xử lý chuỗi) và các lệnh Vivado Tcl.
    Các chủ đề có thể là: Truy vết netlist, tạo luật DRC tùy chỉnh, xuất báo cáo timing, tự động hóa Block Design.
    
    QUAN TRỌNG: CHỈ đưa ra đề bài, các yêu cầu rõ ràng và mục tiêu của script Tcl. 
    KHÔNG cung cấp code giải.
    Toàn bộ phản hồi phải được viết bằng Tiếng Việt một cách chuyên nghiệp.
    """
    
    try:
        response = model.generate_content(prompt)
        problem_text = response.text
        
        workspace_dir = "workspace"
        if not os.path.exists(workspace_dir):
            os.makedirs(workspace_dir)
            
        with open(os.path.join(workspace_dir, "problem_statement.md"), "w", encoding="utf-8") as f:
            f.write(problem_text)
            
        with open(os.path.join(workspace_dir, "solution.tcl"), "w", encoding="utf-8") as f:
            f.write("# Viết code Tcl giải quyết bài toán trong problem_statement.md vào đây\n\n")
            
        print("\n[Thành công] Đã tạo đề bài thành công!")
        print("-> Hãy đọc file 'workspace/problem_statement.md' để xem yêu cầu.")
        print("-> Viết code giải của bạn vào file 'workspace/solution.tcl'.")
    except Exception as e:
        print(f"\n[Lỗi] Không thể tạo đề bài: {e}")

def evaluate_solution(model):
    workspace_dir = "workspace"
    problem_file = os.path.join(workspace_dir, "problem_statement.md")
    solution_file = os.path.join(workspace_dir, "solution.tcl")
    
    if not os.path.exists(problem_file) or not os.path.exists(solution_file):
        print("\n[!] Lỗi: Không tìm thấy 'problem_statement.md' hoặc 'solution.tcl' trong workspace.")
        print("Vui lòng Generate đề bài trước và viết code giải của bạn.")
        return
        
    with open(problem_file, "r", encoding="utf-8") as f:
        problem_text = f.read()
        
    with open(solution_file, "r", encoding="utf-8") as f:
        solution_text = f.read()
        
    if solution_text.strip() == "# Viết code Tcl giải quyết bài toán trong problem_statement.md vào đây" or not solution_text.strip():
        print("\n[!] Lỗi: 'solution.tcl' đang trống. Vui lòng viết code của bạn trước khi chấm điểm.")
        return
        
    print("\n[Hệ thống] Đang kết nối tới Gemini AI để chấm điểm code của bạn...")
    prompt = f"""
    Bạn là một kỹ sư EDA Senior đang đánh giá script Tcl Vivado của một kỹ sư junior.
    
    Đây là Đề bài được giao:
    ---
    {problem_text}
    ---
    
    Đây là Code Tcl của học viên:
    ---
    {solution_text}
    ---
    
    Hãy viết một bài đánh giá toàn diện bằng Tiếng Việt với cấu trúc sau:
    1. **Tính đúng đắn (Correctness)**: Đoạn code có giải quyết đúng bài toán không? Có lỗi logic hoặc cú pháp nào không?
    2. **Thực hành tốt nhất (Best Practices)**: Học viên có sử dụng Tcl và Vivado tối ưu không? Gợi ý cách cải thiện (ví dụ: dùng -filter thay vì foreach, tránh dùng catch nếu không cần thiết).
    3. **Điểm số cuối cùng**: Chấm một số điểm trên thang 100 dựa trên sự chính xác, hiệu năng và độ dễ đọc.
    """
    
    try:
        response = model.generate_content(prompt)
        eval_text = response.text
        
        with open(os.path.join(workspace_dir, "evaluation.md"), "w", encoding="utf-8") as f:
            f.write(eval_text)
            
        print("\n[Thành công] Quá trình chấm điểm hoàn tất!")
        print("-> Hãy mở file 'workspace/evaluation.md' để xem nhận xét chi tiết và điểm số của bạn.")
    except Exception as e:
        print(f"\n[Lỗi] Không thể chấm điểm giải pháp: {e}")

def main():
    print("="*50)
    print("   AI-Powered Vivado Tcl Capstone Grader")
    print("="*50)
    
    model = setup_gemini()
    
    while True:
        print("\nMenu:")
        print("1. Tạo một đề bài thực tế mới (Generate)")
        print("2. Chấm điểm bài làm của tôi (Evaluate)")
        print("3. Thoát (Exit)")
        
        choice = input("\nNhập lựa chọn của bạn (1-3): ").strip()
        
        if choice == '1':
            generate_problem(model)
        elif choice == '2':
            evaluate_solution(model)
        elif choice == '3':
            print("Đang thoát...")
            break
        else:
            print("Lựa chọn không hợp lệ. Vui lòng nhập 1, 2, hoặc 3.")
            
if __name__ == "__main__":
    main()
