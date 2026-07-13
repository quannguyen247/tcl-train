<Chapter 09: Regular Expressions>
Regular expressions (regex) are powerful tools for pattern matching and text manipulation. Tcl's regex engine is advanced (ARE - Advanced Regular Expressions) and integrates seamlessly with string operations.

---

## Table of Contents
- [Basic Pattern Matching](#basic-pattern-matching)
- [Capturing Groups](#capturing-groups)
- [Character Classes & Quantifiers](#character-classes--quantifiers)
- [Search and Replace](#search-and-replace)
- [Advanced Options](#advanced-options)

---

## Basic Pattern Matching

### Explanation
The `regexp` command checks if a string matches a pattern. It returns `1` if matched, `0` otherwise.

### Syntax
```tcl
regexp ?options? pattern string
```

### Example
```tcl
set text "Warning: Timing violation on path 42"

if {[regexp {Warning|Error} $text]} {
    puts "Found an issue in log."
}

if {[regexp -nocase {^warning} $text]} {
    puts "Line starts with warning."
}
```

### Output
```
Found an issue in log.
Line starts with warning.
```

---

## Capturing Groups

### Explanation
Parentheses `()` define capturing groups. You can pass variable names to `regexp` to store the matched full string and sub-matches.

### Syntax
```tcl
regexp pattern string matchVar sub1Var sub2Var ...
```

### Example
```tcl
set line "Slack: -0.45 ns"

if {[regexp {Slack:\s+([-\d.]+)\s+(ns|ps)} $line full_match val unit]} {
    puts "Match: $full_match"
    puts "Value: $val"
    puts "Unit: $unit"
}
```

### Output
```
Match: Slack: -0.45 ns
Value: -0.45
Unit: ns
```

---

## Character Classes & Quantifiers

### Explanation
- **Classes**: `[a-z]` (lowercase), `\d` (digit), `\w` (word char), `\s` (whitespace). Uppercase inverts: `\D`, `\W`, `\S`.
- **Quantifiers**: `*` (0+), `+` (1+), `?` (0 or 1), `{n}` (exactly n), `{n,m}` (n to m). Append `?` for non-greedy (`*?`, `+?`).
- **Anchors**: `^` (start of string), `$` (end), `\b` (word boundary).

### Example
```tcl
set pin "cell_A/pin_Z"

# \w+ matches 1 or more word characters
if {[regexp {^(\w+)/(\w+)$} $pin all cell pin_name]} {
    puts "Cell: $cell, Pin: $pin_name"
}
```

### Output
```
Cell: cell_A, Pin: pin_Z
```

---

## Search and Replace

### Explanation
`regsub` searches for a pattern and replaces it. `-all` replaces every occurrence. You can use backreferences like `\1` or `&` (whole match) in the replacement string.

### Syntax
```tcl
regsub ?options? pattern string subSpec varName
# or returns the result directly in newer Tcl:
set newStr [regsub pattern string subSpec]
```

### Example
```tcl
set report "Delay: 10ps, Transition: 5ps"

# Replace 'ps' with 'ns' globally
regsub -all {ps} $report "ns" new_report
puts $new_report

# Backreference \1 and \2
set name "Doe, John"
regsub {(\w+),\s+(\w+)} $name {\2 \1} formatted_name
puts "Formatted: $formatted_name"
```

### Output
```
Delay: 10ns, Transition: 5ns
Formatted: John Doe
```

---

## Advanced Options

### Explanation
- `-all`: match all occurrences
- `-inline`: returns a list of matches instead of boolean
- Lookarounds: `(?=...)` (lookahead), `(?!...)` (negative lookahead). Note: Non-capturing groups are `(?:...)`. Always enclose patterns in `{}` to avoid Tcl variable substitution issues!

### Example
```tcl
set text "clk_1 clk_2 mem_clk"
set matches [regexp -all -inline {\w*clk\w*} $text]
puts "Clocks found: $matches"
```

### Output
```
Clocks found: clk_1 clk_2 mem_clk
```

---

## Practice Exercises
- `01_regex.tcl`: Parse timing report lines to extract slack and path info, and format the output using regex tools.

---

## Summary
- Use `regexp` to test for matches and extract substrings using `()`.
- Use `regsub` for text replacement, utilizing `-all` and backreferences (`\1`, `\2`).
- Remember to put patterns inside `{}` so Tcl does not interpret backslashes before the regex engine sees them.
</Chapter 09: Regular Expressions>
