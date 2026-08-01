# Module 02: Control Flow

This module focuses on how Tcl selects execution paths using `if`, `elseif`, `else`, and `switch`.

---

## 📖 Core Theory

### 1. Branching with `if`
Use `if` to test logical conditions and choose the right action path. In Tcl, conditions are usually wrapped in braces to avoid early substitution.

### 2. Multi-way selection with `switch`
`switch` is a clean choice when one value can map to several predefined actions, such as `timing`, `power`, or `area` optimization modes.

---

## ⚡ EDA Application

In EDA scripts, `if` is often used to detect violations, while `switch` is used to route the flow depending on the selected run mode:

```tcl
switch -- $mode {
    timing { puts "Run timing-driven optimization" }
    power  { puts "Run low-power optimization" }
    area   { puts "Run area-driven optimization" }
}
```
