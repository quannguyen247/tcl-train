# Chapter 04: Control Flow
Control flow commands in Tcl allow you to make decisions and execute loops. 

---

## Table of Contents
- [Conditional Branching (if, elseif, else)](#conditional-branching-if-elseif-else)
- [Switch Statements](#switch-statements)
- [While Loops](#while-loops)
- [For Loops](#for-loops)
- [Foreach Loops](#foreach-loops)
- [Loop Control (break, continue)](#loop-control-break-continue)
- [Incrementing Variables (incr)](#incrementing-variables-incr)

---

## Conditional Branching (if, elseif, else)

### Explanation
The `if` command evaluates a boolean expression and executes the corresponding body if it is true. The most critical syntax rule in Tcl is the placement of braces: `} else {` MUST be on the same line.

### Syntax
```tcl
if {condition} {
    # code
} elseif {condition} {
    # code
} else {
    # code
}
```

### Example
```tcl
set slack -15.5
if {$slack < 0} {
    puts "Timing Violation!"
} else {
    puts "Timing Met."
}
```

### Output
```
Timing Violation!
```

---

## Switch Statements

### Explanation
The `switch` command matches a value against a set of patterns. By default it uses exact matching (`-exact`), but it supports glob (`-glob`) and regular expressions (`-regexp`). Use `--` to signal the end of options. The `-` character allows fall-through to the next body.

### Syntax
```tcl
switch ?options? string {
    pattern1 body1
    pattern2 body2
    default bodyDefault
}
```

### Example
```tcl
set corner "ss"
switch -exact -- $corner {
    ff { puts "Fast Fast" }
    ss -
    slow { puts "Slow Corner" }
    default { puts "Typical" }
}
```

### Output
```
Slow Corner
```

---

## While Loops

### Explanation
The `while` loop executes its body as long as the condition is true. The condition is re-evaluated before each iteration. Avoid infinite loops by ensuring the condition will eventually evaluate to false.

### Syntax
```tcl
while {condition} {
    # code
}
```

### Example
```tcl
set i 0
while {$i < 3} {
    puts "Index $i"
    set i [expr {$i + 1}]
}
```

### Output
```
Index 0
Index 1
Index 2
```

---

## For Loops

### Explanation
The `for` loop consists of 4 blocks: initialization, condition, step, and body. It's similar to C-style for loops.

### Syntax
```tcl
for {init} {cond} {step} {body}
```

### Example
```tcl
for {set i 0} {$i < 3} {incr i} {
    puts "Iteration $i"
}
```

### Output
```
Iteration 0
Iteration 1
Iteration 2
```

---

## Foreach Loops

### Explanation
The `foreach` loop iterates over one or more lists. It can assign multiple variables per iteration, or iterate over multiple lists in parallel.

### Syntax
```tcl
foreach varName list body
foreach {var1 var2} list body
```

### Example
```tcl
set gates {AND OR XOR}
foreach gate $gates {
    puts "Gate: $gate"
}
```

### Output
```
Gate: AND
Gate: OR
Gate: XOR
```

---

## Loop Control (break, continue)

### Explanation
Use `break` to exit a loop entirely, and `continue` to skip the remainder of the current iteration and move to the next one.

### Syntax
```tcl
break
continue
```

### Example
```tcl
for {set i 0} {$i < 5} {incr i} {
    if {$i == 2} { continue }
    if {$i == 4} { break }
    puts $i
}
```

### Output
```
0
1
3
```

---

## Incrementing Variables (incr)

### Explanation
The `incr` command increments (or decrements) an integer variable by a specified amount (default is 1).

### Syntax
```tcl
incr varName ?increment?
```

### Example
```tcl
set count 5
incr count
incr count -2
puts $count
```

### Output
```
4
```

---

## Practice Exercises
- `01_if_switch.tcl`: Practice conditional branching and switch statements for timing status classification.
- `02_loops.tcl`: Work with for and while loops for sequence and numerical computations.

---

## Summary
- Always brace expressions in `if` and `while`.
- Keep `} else {` on the same line.
- Use `switch` for multiple exact or pattern matches.
- `foreach` is the most common and robust way to iterate over lists.
- Control loops precisely with `break` and `continue`.
