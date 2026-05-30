# Module 06: Advanced Tcl

This module introduces `namespace`, `catch`, and how to write safer Tcl utilities for larger scripts.

---

## 📖 Core Theory

### 1. `namespace`
`namespace` groups related procedures into an isolated name scope, reducing naming collisions in larger projects.

### 2. `catch`
`catch` lets you intercept errors instead of letting the script stop abruptly. This is useful when input data or reports may be incomplete.

---

## ⚡ EDA Application

In industrial flows, `namespace` packages timing or DFT utilities, while `catch` keeps the script running even if one report or cell is missing.
