# Chapter 11: Error Handling & Debugging

Robust error handling and introspection capabilities are vital for developing stable EDA scripts. Tcl provides commands for catching errors, throwing custom exceptions, and introspecting the state of variables and commands.

---

## Table of Contents
- [Catching Errors](#catching-errors)
- [Raising Errors](#raising-errors)
- [Introspection with Info](#introspection-with-info)
- [Tracing](#tracing)
- [Benchmarking](#benchmarking)

---

## Catching Errors

### Explanation
The `catch` command executes a script and traps any errors it produces, returning an integer code instead of aborting the program.

### Syntax
```tcl
catch {script} resultVar ?optionsVar?
```
Return codes include `0` (OK), `1` (Error), `2` (Return), `3` (Break), `4` (Continue).

### Example
```tcl
if {[catch {expr {1 / 0}} result]} {
    puts "An error occurred: $result"
} else {
    puts "Result: $result"
}
```

### Output
```
An error occurred: divide by zero
```

---

## Raising Errors

### Explanation
You can explicitly raise errors using the `error` command, or return from a procedure with an error code using `return -code error`.

### Syntax
```tcl
error message ?info? ?code?
return -code error "Error message"
```

---

## Introspection with Info

### Explanation
The `info` command provides numerous subcommands to inspect variables, procedures, and the runtime state.

### Syntax
```tcl
info exists varName
info vars ?pattern?
info procs ?pattern?
info args procName
```

### Example
```tcl
proc do_work {a b} { return [expr {$a + $b}] }
puts "Arguments of do_work: [info args do_work]"
```

---

## Tracing

### Explanation
The `trace` command allows you to monitor variable changes or command executions, which is useful for debugging state changes.

### Syntax
```tcl
trace add variable varName ops script
trace remove variable varName ops script
```

---

## Benchmarking

### Explanation
The `time` command measures how long it takes to execute a script, optionally repeating it to get an average.

### Syntax
```tcl
time {script} ?count?
```

---

## Practice Exercises
- `01_error_handling.tcl`: Implement safe file parsing with catch, trace variable changes, and introspect loaded procs.

---

## Summary
- Use `catch` to gracefully handle potential failures.
- Throw custom errors using `error` or `return -code error`.
- Leverage `info` and `trace` for effective script introspection and debugging.
