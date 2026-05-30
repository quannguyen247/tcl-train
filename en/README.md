# Tcl/Tk for EDA & DFT: Industry Training Course

Welcome to the **Tcl/Tk Scripting Course** tailored for Electronic Design Automation (EDA) and Design For Testability (DFT).

This course is structured like a production-grade industry repository, preparing you to write clean, maintainable, and high-performance scripts to automate ASIC/FPGA design and DFT verification flows.

---

## 🛠️ Environment Setup & VS Code Integration

Follow these steps to run Tcl scripts locally on your machine via VS Code:

### 1. Install Tcl Interpreter
A Tcl interpreter (typically named `tclsh`) is required to run the scripts.

* **On Windows**:
  - **Using WinGet (Recommended)**: Open PowerShell and run:
    ```powershell
    winget install ActiveState.ActiveTcl
    ```
  - **Manual Installation**: Download and install [ActiveTcl](https://www.activestate.com/products/tcl/) or [Magicsplat Tcl](https://www.magicsplat.com/tcl-installer/index.html). Make sure to check **"Add Tcl to PATH"** during installation.
* **On Linux (Ubuntu/CentOS)**:
  - Tcl is usually pre-installed on server environments. To install locally:
    ```bash
    sudo apt-get install tcl -y   # Ubuntu/Debian
    sudo yum install tcl -y       # CentOS/RHEL
    ```

### 2. Install VS Code Extensions
Open VS Code, go to the **Extensions (Ctrl+Shift+X)** tab, and install:
1. **Tcl Language Support** (by *bitwisestudio* or *Sudar*): Adds syntax highlighting and indentation.
2. **Code Runner** (by *Jun Han*): Enables one-click script execution.

### 3. Configure Code Runner for Tcl
To run `.tcl` files automatically using Code Runner:
1. Open **Settings (Ctrl+,)** and search for `Executor Map`.
2. Click **Edit in settings.json**.
3. Add or update the `"tcl"` key under `"code-runner.executorMap"`:
   ```json
   "code-runner.executorMap": {
       "tcl": "tclsh"
   }
   ```
4. Now, open any `.tcl` file and press **`Ctrl+Alt+N`** (or right-click and select **Run Code**) to execute the script in the VS Code terminal.

### 4. Verify Installation
Open a VS Code Terminal (**Ctrl+`**) and type:
```bash
tclsh
```
If the terminal switches to a `%` prompt, Tcl is ready. Type `exit` to quit.

---

## 📐 Coding Conventions

In production design environments, code readability is crucial. Please follow these guidelines:

1. **Indentation**: Use **4 spaces** instead of Tabs.
2. **Naming Conventions**:
   - Variables: Use **camelCase** (e.g., `designName`, `clockPeriod`).
   - Procedures: Use **snake_case** (e.g., `parse_log_file`, `check_scan_chains`).
   - Minimize the use of global variables.
3. **File Naming**: Use lowercase letters separated by underscores (e.g., `01_variables.tcl`).
4. **Bracing Style**: Place the open brace `{` on the same line as control keywords:
   ```tcl
   if {$condition} {
       # code...
   } else {
       # code...
   }
   ```

---

## 📂 Repository Structure

```text
.
├── README.md                        # Bilingual landing page
├── en/
│   ├── README.md                    # This document
│   ├── roadmap.md                   # English syllabus and milestones
│   ├── 01-basic-syntax/             # Variables, math, quoting rules
│   ├── 02-control-flow/             # Branching and loops
│   ├── 03-procedures/               # Proc definitions and scope
│   ├── 04-data-structures/          # Lists, Arrays, Dicts (Critical for EDA)
│   ├── 05-file-io-regex/            # Parsing logs and timing reports
│   ├── 06-advanced-tcl/             # Namespaces, try/catch, eval
│   ├── 07-eda-scripting-apis/       # Emulating Synopsys/Cadence APIs
│   ├── 08-dft-automation/           # DFT-specific scripts
│   ├── 09-mini-projects/            # Block-specific challenges
│   └── 10-capstone-project/         # Capstone: DFT Flow Automation
```

---

## 🎓 How to Practice & Get Reviews

1. Navigate to the module directory you are currently studying (e.g., `en/01-basic-syntax/`).
2. Open the exercise file (e.g., `01_variables.tcl`) and read the requirements in the header.
3. Write your code under the designated skeleton line.
4. Run the code locally using **`Ctrl+Alt+N`** or Code Runner.
5. Paste your solution in our chat. I will perform a **Code Review** and score your code based on Correctness, Style, Readability, and EDA best practices.
