# Chapter 03: Expressions & Math

While Tcl treats everything as strings, it includes a powerful mathematical evaluation engine. This chapter covers how to perform arithmetic, bitwise operations, logical comparisons, and use built-in math functions efficiently in your scripts.

---

## Table of Contents
- [The `expr` Command](#the-expr-command)
- [Integer vs Floating-Point Math](#integer-vs-floating-point-math)
- [Operators](#operators)
- [Built-in Math Functions](#built-in-math-functions)
- [Ternary Operator](#ternary-operator)
- [Formatting Numbers](#formatting-numbers)
- [Boolean Values](#boolean-values)
- [Practice Exercises](#practice-exercises)
- [Summary](#summary)

---

## The `expr` Command

### Explanation
To perform any math in Tcl, you must use the `expr` command. Unlike some languages where math evaluates automatically, Tcl requires you to explicitly call `expr` to interpret a string as a mathematical expression.
**Best Practice**: Always enclose your expressions in braces `{}`. E.g., `expr {$a + $b}`. This prevents double-substitution issues and provides a significant performance boost because the Tcl compiler can optimize the execution.

### Syntax
```tcl
expr {expression}
```

### Example
```tcl
set a 10
set b 5
set sum [expr {$a + $b}]
puts "Sum is: $sum"
```

### Output
```
Sum is: 15
```

---

## Integer vs Floating-Point Math

### Explanation
By default, Tcl performs integer arithmetic if both operands are integers. This means division will truncate the decimal part. To perform floating-point division, at least one of the numbers must be a float (e.g., `2.0` instead of `2` or cast via `double()`).

### Example
```tcl
set intDiv [expr {5 / 2}]
set floatDiv [expr {5.0 / 2}]
puts "Integer: $intDiv, Float: $floatDiv"
```

### Output
```
Integer: 2, Float: 2.5
```

---

## Operators

### Explanation
Tcl supports a wide array of operators similar to C:
- **Arithmetic**: `+`, `-`, `*`, `/`, `%` (modulo), `**` (exponentiation).
- **Comparison**: `==`, `!=`, `<`, `>`, `<=`, `>=`.
- **Logical**: `&&` (AND), `||` (OR), `!` (NOT).
- **Bitwise**: `&` (AND), `|` (OR), `^` (XOR), `~` (NOT), `<<` (Left Shift), `>>` (Right Shift).

### Example
```tcl
set isGreater [expr {10 > 5}]
set bitwiseAnd [expr {2 & 3}]
puts "Is 10 > 5? $isGreater"
puts "Bitwise AND of 2 and 3: $bitwiseAnd"
```

### Output
```
Is 10 > 5? 1
Bitwise AND of 2 and 3: 2
```

---

## Built-in Math Functions

### Explanation
The `expr` command has many built-in math functions. Common functions include `sqrt`, `sin`, `cos`, `tan`, `abs`, `round`, `ceil`, `floor`, `pow`, `log`, `log10`, `exp`, `rand`, `srand`, `int`, `double`, and `wide`.

### Example
```tcl
set area [expr {3.14 * pow(2.5, 2)}]
set roundedArea [expr {round($area)}]
puts "Area: $area, Rounded: $roundedArea"
```

### Output
```
Area: 19.625, Rounded: 20
```

---

## Ternary Operator

### Explanation
The ternary operator `? :` offers a concise way to write simple conditional expressions. It evaluates the condition, returning the first value if true, and the second if false.

### Syntax
```tcl
expr {condition ? trueVal : falseVal}
```

### Example
```tcl
set timingSlack -0.5
set status [expr {$timingSlack < 0 ? "VIOLATION" : "MET"}]
puts "Timing Status: $status"
```

### Output
```
Timing Status: VIOLATION
```

---

## Formatting Numbers

### Explanation
The `format` command is similar to C's `printf`. It's incredibly useful in EDA for formatting reports. You can format floating points to a specific precision (`%.2f`), pad integers with zeros (`%04d`), or convert to hexadecimal (`%x`).

### Example
```tcl
puts [format "Delay: %.2f ns" 1.2345]
puts [format "Hex Value: %04x" 255]
```

### Output
```
Delay: 1.23 ns
Hex Value: 00ff
```

---

## Boolean Values

### Explanation
Tcl recognizes multiple string representations for boolean truth values.
- **True**: `1`, `true`, `yes`, `on`
- **False**: `0`, `false`, `no`, `off`
When evaluated in `expr`, logical operations return `1` for true and `0` for false.

---

## Practice Exercises
- `01_math_expr.tcl`: Practice arithmetic, bitwise operations, math functions, and formatting in an EDA timing analysis context.

---

## Summary
- Use `expr` for all math and always enclose the expression in braces `{}` for performance and safety.
- Understand the difference between integer and floating-point division.
- Tcl supports a full set of arithmetic, comparison, logical, and bitwise operators.
- Leverage the ternary operator `? :` for inline conditionals.
- Use the `format` command to cleanly present numerical data.
- Booleans can be `1/0`, `true/false`, `yes/no`, or `on/off`.
