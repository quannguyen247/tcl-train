# Chapter 12: Modularization & Namespaces

Large Tcl projects require organizing code into manageable units. Namespaces and modularization features ensure code reuse, prevent name collisions, and provide a clean API architecture.

---

## Table of Contents
- [Scripts and Sourcing](#scripts-and-sourcing)
- [Namespaces](#namespaces)
- [Packages](#packages)
- [Dynamic Evaluation](#dynamic-evaluation)

---

## Scripts and Sourcing

### Explanation
You can execute another script within your current Tcl environment using `source`. To locate files relative to the current script, use `info script`.

### Syntax
```tcl
source filename
set dir [file dirname [info script]]
```

---

## Namespaces

### Explanation
Namespaces group commands and variables to avoid clashes. You can `export` commands from a namespace and `import` them elsewhere.

### Syntax
```tcl
namespace eval name {
    variable varName
    namespace export pattern
}
namespace current
namespace import name::pattern
```

### Example
```tcl
namespace eval MathUtils {
    namespace export add
    proc add {a b} { return [expr {$a + $b}] }
}
namespace import MathUtils::add
puts [add 2 3]
```

### Output
```
5
```

---

## Packages

### Explanation
Packages bundle related functionality with a version number. Tcl uses `auto_path` to find packages. `package require` loads a package.

### Syntax
```tcl
package provide name version
package require name ?version?
```

---

## Dynamic Evaluation

### Explanation
Tcl allows constructing commands at runtime via `eval` and performing complex interpolations via `subst`.

### Syntax
```tcl
eval command
subst ?-nocommands? string
```

---

## Practice Exercises
- `01_namespaces.tcl`: Create a namespace for timing analysis with exported commands and test isolation.

---

## Summary
- Use `source` to divide logic across multiple files.
- Namespaces provide crucial encapsulation for large scripts.
- Packages help distribute code robustly.
