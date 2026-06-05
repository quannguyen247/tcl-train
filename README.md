# Tcl / Tk Learning & EDA / DFT Scripting Training Repository 🚀

Welcome to **tcl-train**, a comprehensive Tcl/Tk training repository compiling fundamental-to-advanced knowledge, lessons, practice exercises, and real-world Electronic Design Automation (EDA) & Design for Testability (DFT) scripting workflows.

## 📌 Overview & Purpose

This repository was created as a personal knowledge base and reference guide, aimed at mastering Tcl scripting for IC Design, RTL Development, DFT (Design for Testability), and Physical Design (PD) automation.

### Key Highlights:
- **Comprehensive Lessons**: Structured tutorials covering basic syntax, control flows, procedures, data structures (Lists, Dicts, Arrays), string manipulation, and TclOO object-oriented programming.
- **Exercism Practice Track**: Includes 140+ hands-on Tcl exercises sourced from the official [Exercism Tcl Track](https://exercism.org/tracks/tcl) to build syntax muscle memory and algorithmic problem-solving skills.
- **EDA & DFT Real-World Workflows**: Practical examples and scripting techniques tailored for semiconductor design workflows (Synopsys, Cadence, Siemens Tessent).
- **AI-Assisted Creation**: Built, curated, and structured with the assistance of AI pair-programming tools to ensure high-quality explanations, complete solutions, and automated test runners.

---

## 🌐 Dual-Language Structure (`en/` & `vi/`)

To support both local and international learners, the entire repository is organized into dual-language tracks:

```text
tcl-train/
├── en/                         # English Version
│   ├── courses/                # Core Tcl Lessons & Tutorial Modules
│   └── practices/              # Exercism Practice Exercises (001 - 140)
│
├── vi/                         # Vietnamese Version (Tiếng Việt)
│   ├── courses/                # Bài học & Kiến thức Tcl tiếng Việt
│   └── practices/              # Bài tập thực hành Exercism (001 - 140)
│
└── scripts/                    # Helper Scripts & Master Test Runners
```

- 🇬🇧 **[English Track (`./en/`)](./en/)**: Fully detailed explanations, courses, and exercise test runners in English.
- 🇻🇳 **[Vietnamese Track (`./vi/`)](./vi/)**: Full curriculum translated and formatted for Vietnamese students & engineers.

---

## 🧪 Running Tests

Each exercise includes a dedicated `.test.tcl` file using Tcl's built-in `tcltest` framework.

You can run automated master test runners using Python:

```bash
# Run all exercise test suites
python en/practices/run_all_tests.py
```

---

## 👨‍💻 Author & Acknowledgments

- **Author**: Nguyễn Đông Quân ([@quangnguyen247](https://github.com/quannguyen247)) - IC Design Talent Program at UIT-VNUHCM.
- **Exercises Source**: Practice problems sourced from the [Exercism Tcl Track](https://exercism.org/tracks/tcl).
- **AI Collaboration**: Developed and refined with the help of AI pair-programming assistants.

---

*Feel free to star ⭐️ the repository and use it as a reference for your Tcl and EDA/DFT learning journey!*
