# Chapter 05: Procedures & Scope
Procedures in Tcl allow you to create reusable blocks of code. Variables within procedures have local scope.

---

## Table of Contents
- [Defining Procedures (proc)](#defining-procedures-proc)
- [Return Values](#return-values)
- [Default Arguments](#default-arguments)
- [Variable Arguments (args)](#variable-arguments-args)
- [Variable Scope and global](#variable-scope-and-global)
- [Pass by Reference (upvar)](#pass-by-reference-upvar)
- [Execute in Caller Scope (uplevel)](#execute-in-caller-scope-uplevel)

---

## Defining Procedures (proc)

### Explanation
Use the `proc` command to define a procedure. It takes three arguments: the name, a list of parameters, and the body.

### Syntax
```tcl
proc name {args} {
    # body
}
```

### Example
```tcl
proc greet {name} {
    puts "Hello, $name!"
}
greet "EDA Engineer"
```

### Output
```
Hello, EDA Engineer!
```

---

## Return Values

### Explanation
By default, a proc returns the result of the last executed command. You can explicitly return a value using `return`.

### Syntax
```tcl
return ?value?
```

### Example
```tcl
proc multiply {a b} {
    return [expr {$a * $b}]
}
puts [multiply 4 5]
```

### Output
```
20
```

---

## Default Arguments

### Explanation
You can provide default values for parameters by grouping the parameter name and its default value in a list.

### Syntax
```tcl
proc name {{param default}} {
    # body
}
```

### Example
```tcl
proc connect_pin {pin_name {net_name "VDD"}} {
    puts "Connected $pin_name to $net_name"
}
connect_pin "A"
connect_pin "B" "GND"
```

### Output
```
Connected A to VDD
Connected B to GND
```

---

## Variable Arguments (args)

### Explanation
If the last parameter is exactly named `args`, the procedure will accept any number of additional arguments, passed as a list.

### Syntax
```tcl
proc name {param1 args} {
    # body
}
```

### Example
```tcl
proc summarize {name args} {
    puts "$name has [llength $args] additional items: $args"
}
summarize "Route1" A B C
```

### Output
```
Route1 has 3 additional items: A B C
```

---

## Variable Scope and global

### Explanation
Variables created inside a proc are local. To access or modify variables defined outside the proc in the global scope, use the `global` command.

### Syntax
```tcl
global varName
```

### Example
```tcl
set error_count 0
proc log_error {msg} {
    global error_count
    incr error_count
    puts "Error: $msg"
}
log_error "DRC Violation"
puts "Total errors: $error_count"
```

### Output
```
Error: DRC Violation
Total errors: 1
```

---

## Pass by Reference (upvar)

### Explanation
The `upvar` command ties a local variable to a variable in the caller's scope, allowing you to pass variables by reference and modify them directly.

### Syntax
```tcl
upvar level otherVar localVar
```

### Example
```tcl
proc scale_power {pwr_var factor} {
    upvar 1 $pwr_var local_pwr
    set local_pwr [expr {$local_pwr * $factor}]
}
set pwr 10.0
scale_power pwr 1.5
puts $pwr
```

### Output
```
15.0
```

---

## Execute in Caller Scope (uplevel)

### Explanation
`uplevel` evaluates a script in a different stack frame, typically the caller's scope. It is useful for creating custom control structures.

### Syntax
```tcl
uplevel level script
```

### Example
```tcl
proc do_twice {script} {
    uplevel 1 $script
    uplevel 1 $script
}
set x 0
do_twice {incr x}
puts $x
```

### Output
```
2
```

---

## Practice Exercises
- `01_procedures.tcl`: Refactor operations into procedures, practice default arguments, pass-by-reference, and global state.

---

## Summary
- Procs provide encapsulation and modularity.
- Default arguments provide flexibility.
- Use `global` sparingly; prefer `upvar` for modifying caller variables.
- `args` allows for variadic functions.
