# Module 03: Loops and Procedures

This module introduces `foreach`, `proc`, and the habit of splitting logic into reusable helper procedures.

---

## 📖 Core Theory

### 1. `foreach`
`foreach` walks through each element of a list one by one. It is one of the most common Tcl patterns when handling pins, cells, or report lines.

### 2. `proc`
`proc` packages a block of logic into a named reusable function, making scripts easier to read and maintain.

---

## ⚡ EDA Application

Production scripts often use `proc` to compute timing metrics and `foreach` to scan through a list of paths or instances.
