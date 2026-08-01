# Module 01: Basic Syntax

This module introduces Tcl's basic syntax rules, variable handling, mathematical operations, and quoting mechanics.

---

## 📖 Core Theory

### 1. "Everything is a String"
Tcl parses commands as whitespace-separated lists of words. Everything is treated as a string literal initially. Datatypes are inferred and converted only when a specific command (like `expr`) evaluates the string.

### 2. Variables (`set`, `unset`) and Value Substitutions (`$`)
* Assign a value using the `set` command:
  ```tcl
  set designName "SoC_Core"
  ```
* Retrieve a variable's value using the `$` symbol:
  ```tcl
  puts "Designing: $designName"
  ```
* Remove a variable from memory using `unset`:
  ```tcl
  unset designName
  ```

### 3. Mathematical Expressions (`expr`)
Tcl does not automatically compute math like `set a 5 + 3`. You must invoke `expr`:
```tcl
set period 10
set frequency [expr {1000.0 / $period}] ;# Returns: 100.0 (MHz)
```
> [!TIP]
> **Best Practice**: Always wrap your mathematical expressions inside braces (e.g., `expr {$a + $b}`). This allows Tcl to byte-compile the expression, boosting execution speed significantly.

* **Integer vs. Float**: Tcl follows standard integer division:
  - `expr {5 / 2}` -> Returns: `2`
  - `expr {5.0 / 2}` or `expr {double(5) / 2}` -> Returns: `2.5`

### 4. Quoting Rules
Tcl uses three types of grouping boundaries:

| Boundary | Name | Action | Example |
| :--- | :--- | :--- | :--- |
| **`" "`** | Double Quotes | Groups words together, allows variable (`$`) and command (`[]`) substitutions. | `set msg "Clock is $clk"` |
| **`{ }`** | Braces | Groups words together as literal strings, disables all substitutions. | `set msg {Clock is $clk}` (prints literal `$clk`) |
| **`[ ]`** | Brackets | Executes the command inside first (Command Substitution) and inserts the result. | `set area [get_cell_area U1]` |

### 5. Escape Character (`\`)
Use `\` to neutralize the special meaning of characters (e.g., use `\$` to output a literal dollar sign).

---

## ⚡ EDA Applications

Inside tools like Synopsys Design Compiler or Cadence Innovus:
* **Configuration**:
  ```tcl
  set CLK_PIN "clk_in"
  set_clock_uncertainty 0.05 [get_clocks $CLK_PIN]
  ```
* **Hierarchical Paths**: Design buses and arrays contain brackets `[ ]` (e.g., `data_reg[0]`). If you do not escape them or wrap them in braces, Tcl tries to execute `0` or `7` as a command.
  ```tcl
  get_pins {data_reg[0]/Q}    ;# Recommended: Wrap in braces
  get_pins data_reg\[0\]/Q   ;# Alternative: Use backslashes to escape
  ```
