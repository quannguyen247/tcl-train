# Chapter 01: Introduction & Getting Started

Welcome to the world of Tcl (Tool Command Language)! Tcl is a simple, yet highly powerful dynamic programming language widely used in the EDA (Electronic Design Automation) industry, network testing, and embedded systems. This chapter covers the foundational concepts you need to write and understand basic Tcl scripts.

---

## Table of Contents
- [Tcl Philosophy](#tcl-philosophy)
- [History](#history)
- [Running Tcl](#running-tcl)
- [Script Structure](#script-structure)
- [The `puts` Command](#the-puts-command)
- [Global Variables](#global-variables)
- [Practice Exercises](#practice-exercises)
- [Summary](#summary)

---

## Tcl Philosophy

### Explanation
At its core, Tcl is driven by two main principles:
1. **"Everything is a string"**: Data types like numbers, lists, or booleans are all represented as strings under the hood. Tcl interprets these strings based on the context of the command.
2. **Command-based**: Everything you do in Tcl is a command execution. A Tcl script is essentially a sequence of commands separated by newlines or semicolons.

### Syntax
```tcl
command arg1 arg2 ...
```

---

## History

### Explanation
Tcl was created in 1988 by **John Ousterhout** at the University of California, Berkeley. It was originally designed to be a reusable, embeddable command language for tools, so developers wouldn't have to invent a new language for every application they built. Today, it remains the standard scripting language for synthesis, layout, and simulation tools in industrial chip design.

---

## Running Tcl

### Explanation
There are two primary environments for running Tcl:
- **`tclsh`**: The standard command-line interface (CLI) for executing pure Tcl scripts.
- **`wish`**: The Windowing Shell, used for scripts that include GUI elements built with Tk (Tcl's graphical toolkit).

On Unix-like systems, you can make a Tcl script directly executable by adding a **shebang** line at the top.

### Syntax
```tcl
#!/usr/bin/env tclsh
```

---

## Script Structure

### Explanation
A Tcl script consists of commands separated by newlines or semicolons (`;`). Comments can be added using the `#` character, but with a specific rule: the `#` must appear where Tcl expects the first character of a command.

### Example
```tcl
# This is a comment
set a 10 ; # This is another comment after a command
```

---

## The `puts` Command

### Explanation
The `puts` command is used to write output. By default, it writes to the standard output (`stdout`) and appends a newline character. You can suppress the newline using the `-nonewline` flag, or redirect the output to the standard error channel (`stderr`).

### Syntax
```tcl
puts ?-nonewline? ?channelId? string
```

### Example
```tcl
puts "Hello, World!"
puts -nonewline "This is on "
puts "the same line."
puts stderr "This is an error message."
```

### Output
```
Hello, World!
This is on the same line.
This is an error message.
```

---

## Global Variables

### Explanation
When you run a Tcl script, the interpreter automatically provides several built-in global variables that contain useful information about the script's execution environment.
- `argc`: Number of command-line arguments passed to the script.
- `argv`: A list containing the command-line arguments.
- `argv0`: The name of the script being executed.
- `tcl_version`: The version of the Tcl interpreter currently running.

### Example
```tcl
puts "Running script: $argv0"
puts "Tcl version: $tcl_version"
```

---

## Practice Exercises
- `01_hello_tcl.tcl`: A beginner script to practice basic output, channels, and reading built-in global variables. Run it with various command-line arguments to see how `argc` and `argv` change.

---

## Summary
- Tcl treats all data as strings and operates via commands.
- Use `tclsh` to run scripts, and start Unix scripts with `#!/usr/bin/env tclsh`.
- The `puts` command handles output to `stdout` and `stderr`.
- Use `#` for comments, ensuring it starts where a command is expected.
- Global variables like `argv` and `tcl_version` provide script context.
