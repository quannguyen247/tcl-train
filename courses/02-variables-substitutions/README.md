# Chapter 02: Variables & Substitutions

In Tcl, everything is a string, and mastering how strings are stored and evaluated is key to writing effective scripts. This chapter covers variable assignment, quoting mechanisms, and the various substitution rules that Tcl applies when parsing commands.

---

## Table of Contents
- [Variable Assignment and Reading](#variable-assignment-and-reading)
- [Quoting Rules](#quoting-rules)
- [Escape Sequences](#escape-sequences)
- [Command Substitution](#command-substitution)
- [Variable Management](#variable-management)
- [Practice Exercises](#practice-exercises)
- [Summary](#summary)

---

## Variable Assignment and Reading

### Explanation
You create or update a variable using the `set` command. Unlike many languages, Tcl requires a distinct syntax to read a variable: you use the `$` (dollar sign) prefix to substitute a variable's value into a command. If the variable name is complex or ambiguous, you can enclose it in braces `${varName}`.

### Syntax
```tcl
set varName value
puts $varName
```

### Example
```tcl
set moduleName "ALU_core"
puts "Synthesizing module: $moduleName"
```

### Output
```
Synthesizing module: ALU_core
```

---

## Quoting Rules

### Explanation
Tcl uses two main quoting characters to group words together, but they handle substitutions differently:
- **Double quotes `""`**: Groups text while still allowing variable (`$`) and command (`[]`) substitutions.
- **Braces `{}`**: Groups text but disables all substitutions. The text inside is treated as a literal string. This is especially useful in EDA when dealing with bus pins like `data_in[7]`, where the `[]` might otherwise be interpreted as a command substitution.

### Example
```tcl
set width 32
puts "Bus width is $width"
puts {Bus width is $width}

# EDA Context
set pin {data_in[7]}
puts "Connecting pin: $pin"
```

### Output
```
Bus width is 32
Bus width is $width
Connecting pin: data_in[7]
```

---

## Escape Sequences

### Explanation
The backslash `\` is used to escape special characters, ensuring they are treated as literal characters rather than being interpreted by Tcl (e.g., `\$`, `\[`, `\\`). It also allows the insertion of special formatting characters like newlines (`\n`) and tabs (`\t`), or specifying characters by hex (`\xHH`) or unicode (`\uHHHH`). A backslash at the end of a line acts as a line continuation character, letting you break long commands across multiple lines.

### Example
```tcl
puts "Cost is \$100"
puts "Line1\nLine2\tTabbed"
set very_long_command \
    "This is a single line string."
```

### Output
```
Cost is $100
Line1
Line2	Tabbed
```

---

## Command Substitution

### Explanation
Command substitution allows you to evaluate a Tcl command and use its result as an argument to another command. You enclose the nested command in square brackets `[]`. Tcl evaluates the bracketed command first, and replaces the brackets with the command's return value.

### Syntax
```tcl
[command arg ...]
```

### Example
```tcl
set length [string length "chip_design"]
puts "Length is: $length"
```

### Output
```
Length is: 11
```

---

## Variable Management

### Explanation
Sometimes you need to remove a variable from memory or check if it has been defined before using it.
- `unset`: Deletes a variable.
- `info exists`: Returns 1 if the variable exists, and 0 otherwise.

### Example
```tcl
set tempVar 42
puts "Exists? [info exists tempVar]"
unset tempVar
puts "Exists after unset? [info exists tempVar]"
```

### Output
```
Exists? 1
Exists after unset? 0
```

---

## Practice Exercises
- `01_variables.tcl`: Practice variable declaration, basic substitution, and deletion.
- `02_quoting_rules.tcl`: Explore quoting mechanics, including handling EDA bus pins and escape characters.

---

## Summary
- Use `set` to define variables and `$` to read their values.
- Double quotes `""` allow substitutions; braces `{}` prevent substitutions (literal string).
- Backslash `\` escapes special characters and allows for line continuation.
- Square brackets `[]` are used for command substitution, evaluating nested commands.
- Manage variables with `unset` and check their presence with `info exists`.
