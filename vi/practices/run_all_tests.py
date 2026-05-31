import os
import glob
import subprocess
import sys
import shutil

# Ensure UTF-8 stdout encoding on Windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding='utf-8')

def find_tclsh():
    tclsh = shutil.which("tclsh")
    if tclsh:
        return tclsh
    common_paths = [
        r"C:\Tcl\bin\tclsh.exe",
        r"C:\Program Files\Tcl\bin\tclsh.exe",
        r"C:\Xilinx\Vivado\*\bin\tclsh.bat"
    ]
    for p in common_paths:
        matches = glob.glob(p)
        if matches:
            return matches[0]
    return "tclsh"

def main():
    tclsh_cmd = find_tclsh()
    practices_dir = os.path.dirname(os.path.abspath(__file__))
    
    test_files = sorted(glob.glob(os.path.join(practices_dir, "*", "*.test.tcl")))
    
    if not test_files:
        print(f"Không tìm thấy file test (*.test.tcl) nào trong {practices_dir}")
        sys.exit(1)
        
    print("=" * 70)
    print(" EXERCISM TCL TRACK - HỆ THỐNG CHẤM TEST TỰ ĐỘNG MASTER")
    print("=" * 70)
    print(f"Tcl Engine: {tclsh_cmd}")
    print(f"Tìm thấy tổng cộng {len(test_files)} bộ bài tập thực hành.\n")
    
    passed_count = 0
    failed_count = 0
    pending_count = 0
    
    for test_file in test_files:
        folder_name = os.path.basename(os.path.dirname(test_file))
        test_filename = os.path.basename(test_file)
        ex_dir = os.path.dirname(test_file)
        
        try:
            res = subprocess.run(
                [tclsh_cmd, test_filename],
                cwd=ex_dir,
                capture_output=True,
                text=True,
                timeout=5
            )
            stdout = res.stdout + res.stderr
            
            if "NOT_IMPLEMENTED" in stdout or "Implement this procedure" in stdout or "not implemented" in stdout.lower():
                status = "[CHƯA LÀM] "
                pending_count += 1
            elif "FAILED" in stdout or res.returncode != 0:
                status = "[THẤT BẠI] "
                failed_count += 1
            elif "Total\t" in stdout or "PASSED" in stdout or res.returncode == 0:
                if "FAILED" in stdout:
                    status = "[THẤT BẠI] "
                    failed_count += 1
                else:
                    status = "[THÀNH CÔNG]"
                    passed_count += 1
            else:
                status = "[CHƯA LÀM] "
                pending_count += 1
                
        except Exception as e:
            status = "[LỖI CODE] "
            failed_count += 1
            
        print(f"{status} {folder_name}")

    print("\n" + "=" * 70)
    print(f" TỔNG KẾT: Tất cả: {len(test_files)} | HOÀN THÀNH: {passed_count} | THẤT BẠI: {failed_count} | CHƯA LÀM: {pending_count}")
    print("=" * 70)

if __name__ == "__main__":
    main()
