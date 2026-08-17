# Tcl Training: EDA Automation

`tcl-train` is a comprehensive Tcl learning and reference repository tailored for semiconductor engineering and IC design automation.

Tcl (Tool Command Language) is the industry-standard scripting interface across electronic design automation (EDA) software suites—including RTL design, Logic Synthesis, Static Timing Analysis (STA), Physical Design (PD), and Design for Testability (DFT).

This repository provides structured lessons, 135 algorithm practice suites, Vivado tool scripts, and real-world EDA automation workflows.

---

## Repository Structure

```text
tcl-train/
├── courses/          # Core Tcl syntax and language fundamentals
├── practices/        # 135 algorithm practice suites
├── vivado/           # Xilinx Vivado automation scripts
├── capstone/         # Applied EDA workflow project
├── NOTE.md           # Reusable Tcl patterns, idioms, and techniques
├── LICENSE           # MIT License
└── README.md
```

---

## Practices Overview

The `practices/` directory contains 135 standalone practice exercises. The directory numbering extends up to `140` to maintain stable historical references, skipping 5 deprecated upstream track items (`accumulate`, `beer-song`, `diffie-hellman`, `minesweeper`, `scale-generator`).

### Technical Compatibility
- **`paasio`**: Enforces LF line endings for deterministic cross-platform byte counts on Windows and Linux.
- **`zebra-puzzle`**: Bundles the required upstream `lib/permutations` package for standalone local execution.

---

## Getting Started

### Prerequisites
- **Tcl**: 9.0+ (Tested on Tcl 9.0.4)
- **Thread Extension**: 3.0+ (Tested on Thread 3.0.6)

### Running Tests Locally

Run an individual test suite using `tclsh90`:

```powershell
$env:RUN_ALL = "1"
cd practices/002-acronym
tclsh90 acronym.test.tcl -verbose p
```

### Continuous Integration (CI)

GitHub Actions runs automated testing via a **Matrix Strategy** (135 parallel jobs), ensuring every exercise suite is independently validated on every push.

---

## License

This project is licensed under the [MIT License](LICENSE).
