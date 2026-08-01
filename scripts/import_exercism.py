import os
import shutil
import subprocess
import glob
import stat

REPO_URL = "https://github.com/exercism/tcl.git"
TEMP_DIR = "temp_exercism"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

EN_PRACTICES = os.path.join(BASE_DIR, "en", "practices")
VI_PRACTICES = os.path.join(BASE_DIR, "vi", "practices")

def remove_readonly(func, path, exc_info):
    os.chmod(path, stat.S_IWRITE)
    func(path)

def safe_remove_dir(path):
    if os.path.exists(path):
        shutil.rmtree(path, onerror=remove_readonly)

def clone_repo():
    safe_remove_dir(TEMP_DIR)
    print(f"--> Cloning {REPO_URL}...")
    subprocess.run(["git", "clone", "--depth", "1", REPO_URL, TEMP_DIR], check=True)

def process_exercise(ex_dir, ex_type, index):
    slug = os.path.basename(ex_dir)
    folder_name = f"{index:03d}-{slug}"
    
    # Locate instructions
    instructions_file = os.path.join(ex_dir, ".docs", "instructions.md")
    if not os.path.exists(instructions_file):
        instructions_file = os.path.join(ex_dir, "README.md")
        
    instructions = ""
    if os.path.exists(instructions_file):
        with open(instructions_file, "r", encoding="utf-8") as f:
            instructions = f.read()
            
    # Find all .tcl files in ex_dir
    all_tcl_files = glob.glob(os.path.join(ex_dir, "*.tcl"))
    
    test_file = None
    stub_file = None
    
    for f in all_tcl_files:
        filename = os.path.basename(f)
        if "test" in filename.lower():
            test_file = f
        else:
            stub_file = f
            
    if not test_file:
        # Check subdirectories or .test files
        for root, dirs, files in os.walk(ex_dir):
            for file in files:
                if "test" in file.lower() and file.endswith(".tcl"):
                    test_file = os.path.join(root, file)
                    break
                    
    stub_content = ""
    if stub_file and os.path.exists(stub_file):
        with open(stub_file, "r", encoding="utf-8") as f:
            stub_content = f.read()
            
    test_content = ""
    if test_file and os.path.exists(test_file):
        with open(test_file, "r", encoding="utf-8") as f:
            test_content = f.read()
            
    # Build unified Tcl file content (Instructions as Comments + Stub Code)
    commented_instructions = "\n".join([f"# {line}" if line.strip() else "#" for line in instructions.splitlines()])
    
    header = f"# ==============================================================================\n"
    header += f"# EXERCISM TCL PRACTICE: {slug.upper()}\n"
    header += f"# ==============================================================================\n"
    
    unified_tcl_content = f"{header}{commented_instructions}\n\n# ==============================================================================\n# YOUR SOLUTION CODE BELOW\n# ==============================================================================\n\n{stub_content}\n"
    
    # Save into en/practices and vi/practices
    for base_target in [EN_PRACTICES, VI_PRACTICES]:
        target_dir = os.path.join(base_target, folder_name)
        os.makedirs(target_dir, exist_ok=True)
        
        # Write <slug>.tcl
        with open(os.path.join(target_dir, f"{slug}.tcl"), "w", encoding="utf-8") as f:
            f.write(unified_tcl_content)
            
        # Write <slug>.test.tcl
        if test_content:
            test_target_name = f"{slug}.test.tcl"
            with open(os.path.join(target_dir, test_target_name), "w", encoding="utf-8") as f:
                f.write(test_content)

def main():
    clone_repo()
    
    practice_dir = os.path.join(TEMP_DIR, "exercises", "practice")
    concept_dir = os.path.join(TEMP_DIR, "exercises", "concept")
    
    all_exercises = []
    
    if os.path.exists(concept_dir):
        for d in sorted(os.listdir(concept_dir)):
            full_path = os.path.join(concept_dir, d)
            if os.path.isdir(full_path):
                all_exercises.append((full_path, "concept"))
                
    if os.path.exists(practice_dir):
        for d in sorted(os.listdir(practice_dir)):
            full_path = os.path.join(practice_dir, d)
            if os.path.isdir(full_path):
                all_exercises.append((full_path, "practice"))
                
    print(f"--> Found total {len(all_exercises)} exercises.")
    
    for idx, (ex_dir, ex_type) in enumerate(all_exercises, 1):
        process_exercise(ex_dir, ex_type, idx)
        
    print(f"--> Successfully processed {len(all_exercises)} exercises into en/practices and vi/practices!")
    safe_remove_dir(TEMP_DIR)

if __name__ == "__main__":
    main()
