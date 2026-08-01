import os
import glob
import subprocess
import sys
import shutil

def find_tclsh():
    # Try tclsh in PATH
    tclsh = shutil.which("tclsh")
    if tclsh:
        return tclsh
    # Common Windows paths for Tcl / Vivado / ActiveTcl / MSYS2
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
        print(f"No test files (*.test.tcl) found in {practices_dir}")
        sys.exit(1)
        
    print("=" * 70)
    print(" EXERCISM TCL TRACK - AUTOMATED MASTER TEST RUNNER")
    print("=" * 70)
    print(f"Using Tcl Engine: {tclsh_cmd}")
    print(f"Found {len(test_files)} exercise test suites.\n")
    
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
                status = "[PENDING]"
                pending_count += 1
            elif "FAILED" in stdout or res.returncode != 0:
                status = "[FAILED] "
                failed_count += 1
            elif "Total\t" in stdout or "PASSED" in stdout or res.returncode == 0:
                if "FAILED" in stdout:
                    status = "[FAILED] "
                    failed_count += 1
                else:
                    status = "[PASSED] "
                    passed_count += 1
            else:
                status = "[PENDING]"
                pending_count += 1
                
        except Exception as e:
            status = "[ERROR]  "
            failed_count += 1
            
        print(f"{status} {folder_name}")

    print("\n" + "=" * 70)
    print(f" SUMMARY: Total: {len(test_files)} | PASSED: {passed_count} | FAILED: {failed_count} | PENDING: {pending_count}")
    print("=" * 70)

if __name__ == "__main__":
    main()
