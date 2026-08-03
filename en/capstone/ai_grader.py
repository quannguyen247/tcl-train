import os
import sys
import textwrap
import time
try:
    import google.generativeai as genai
except ImportError:
    print("Error: google-generativeai is not installed.")
    print("Please install it using: pip install google-generativeai")
    input("Press Enter to exit...")
    sys.exit(1)

def setup_gemini():
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("\n[!] GEMINI_API_KEY environment variable not found.")
        print("Please enter your Gemini API Key below.")
        api_key = input("API Key: ").strip()
        if not api_key:
            print("API Key is required to run this tool.")
            input("Press Enter to exit...")
            sys.exit(1)
        os.environ["GEMINI_API_KEY"] = api_key
    
    genai.configure(api_key=api_key)
    # Use gemini-1.5-flash as default for faster responses
    return genai.GenerativeModel('gemini-1.5-flash')

def generate_problem(model):
    print("\n[System] Contacting Gemini AI to generate a realistic industry problem...")
    prompt = """
    You are a Senior IC/FPGA Design Engineer. Your task is to generate a realistic, industry-standard problem 
    that requires writing a Tcl script for Xilinx Vivado. 
    The problem should combine basic Tcl (loops, lists, variables, string manipulation) and Vivado Tcl commands.
    Possible topics: Netlist tracing, custom DRC rules, generating timing constraint reports, batch IP generation, 
    or Block Design automation.
    
    IMPORTANT: Provide ONLY the problem statement, clear requirements, and what the expected Tcl script should accomplish.
    Do NOT provide the solution.
    Write the response entirely in English.
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
            f.write("# Write your Tcl solution here based on problem_statement.md\n\n")
            
        print("\n[Success] Problem generated successfully!")
        print("-> Check 'workspace/problem_statement.md' for the requirements.")
        print("-> Write your code in 'workspace/solution.tcl'.")
    except Exception as e:
        print(f"\n[Error] Failed to generate problem: {e}")

def evaluate_solution(model):
    workspace_dir = "workspace"
    problem_file = os.path.join(workspace_dir, "problem_statement.md")
    solution_file = os.path.join(workspace_dir, "solution.tcl")
    
    if not os.path.exists(problem_file) or not os.path.exists(solution_file):
        print("\n[!] Error: 'problem_statement.md' or 'solution.tcl' not found in the workspace.")
        print("Please generate a problem first and write your solution.")
        return
        
    with open(problem_file, "r", encoding="utf-8") as f:
        problem_text = f.read()
        
    with open(solution_file, "r", encoding="utf-8") as f:
        solution_text = f.read()
        
    if solution_text.strip() == "# Write your Tcl solution here based on problem_statement.md" or not solution_text.strip():
        print("\n[!] Error: 'solution.tcl' is empty. Please write your code before evaluating.")
        return
        
    print("\n[System] Contacting Gemini AI to evaluate your solution...")
    prompt = f"""
    You are a Senior IC/FPGA Design Engineer reviewing a junior engineer's Tcl script for Xilinx Vivado.
    
    Here is the Problem Statement they were given:
    ---
    {problem_text}
    ---
    
    Here is their Tcl Solution:
    ---
    {solution_text}
    ---
    
    Please provide a comprehensive review in English with the following structure:
    1. **Correctness**: Does the code solve the problem? Are there any logical or syntax errors?
    2. **Best Practices**: Are they using Tcl and Vivado commands optimally? Suggest improvements (e.g., using -filter instead of foreach, avoiding catch if unnecessary).
    3. **Final Score**: Give a score out of 100 based on correctness, efficiency, and readability.
    """
    
    try:
        response = model.generate_content(prompt)
        eval_text = response.text
        
        with open(os.path.join(workspace_dir, "evaluation.md"), "w", encoding="utf-8") as f:
            f.write(eval_text)
            
        print("\n[Success] Evaluation complete!")
        print("-> Check 'workspace/evaluation.md' for detailed feedback and your score.")
    except Exception as e:
        print(f"\n[Error] Failed to evaluate solution: {e}")

def main():
    print("="*50)
    print("   AI-Powered Vivado Tcl Capstone Grader")
    print("="*50)
    
    model = setup_gemini()
    
    while True:
        print("\nMenu:")
        print("1. Generate a new realistic problem")
        print("2. Evaluate my solution")
        print("3. Exit")
        
        choice = input("\nEnter your choice (1-3): ").strip()
        
        if choice == '1':
            generate_problem(model)
        elif choice == '2':
            evaluate_solution(model)
        elif choice == '3':
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please enter 1, 2, or 3.")
            
if __name__ == "__main__":
    main()
