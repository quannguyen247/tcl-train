# Chapter 06: Strings
In Tcl, "Everything Is A String". Mastery of string manipulation commands is crucial.

---

## Table of Contents
- [Length and Substrings (length, index, range)](#length-and-substrings-length-index-range)
- [String Comparison (compare, equal)](#string-comparison-compare-equal)
- [Pattern Matching (match)](#pattern-matching-match)
- [Searching (first, last)](#searching-first-last)
- [Case Conversion (tolower, toupper, totitle)](#case-conversion-tolower-toupper-totitle)
- [Trimming and Mapping (trim, map)](#trimming-and-mapping-trim-map)
- [String Formatting (format, scan)](#string-formatting-format-scan)
- [Type Checking (is)](#type-checking-is)

---

## Length and Substrings (length, index, range)

### Explanation
Use `length` for character count. Use `index` to get a character at a specific 0-based position, and `range` for substrings. The keyword `end` refers to the last index.

### Syntax
```tcl
string length string
string index string charIndex
string range string first last
```

### Example
```tcl
set s "Verilog"
puts [string length $s]
puts [string index $s 0]
puts [string range $s 0 2]
puts [string range $s end-2 end]
```

### Output
```
7
V
Ver
log
```

---

## String Comparison (compare, equal)

### Explanation
`string equal` returns 1 if identical, 0 otherwise. `string compare` returns -1, 0, or 1 based on lexicographical order. Both support `-nocase`.

### Syntax
```tcl
string equal ?-nocase? string1 string2
string compare ?-nocase? string1 string2
```

### Example
```tcl
puts [string equal -nocase "TCL" "tcl"]
puts [string compare "A" "B"]
```

### Output
```
1
-1
```

---

## Pattern Matching (match)

### Explanation
`string match` checks if a string matches a glob pattern (`*` for any sequence, `?` for one char, `[chars]` for a set).

### Syntax
```tcl
string match pattern string
```

### Example
```tcl
puts [string match "*.v" "design.v"]
```

### Output
```
1
```

---

## Searching (first, last)

### Explanation
`first` and `last` find the index of a substring. They return -1 if not found.

### Syntax
```tcl
string first subString string ?startIndex?
string last subString string ?lastIndex?
```

### Example
```tcl
set path "/user/bin/tclsh"
puts [string first "/" $path]
puts [string last "/" $path]
```

### Output
```
0
10
```

---

## Case Conversion (tolower, toupper, totitle)

### Explanation
Converts the case of the string.

### Syntax
```tcl
string tolower string
string toupper string
string totitle string
```

---

## Trimming and Mapping (trim, map)

### Explanation
`trim` removes specified characters (whitespace by default) from both ends. `map` replaces substrings based on a key-value dictionary.

### Syntax
```tcl
string trim string ?chars?
string map {old1 new1 old2 new2} string
```

### Example
```tcl
puts [string trim "--hello--" "-"]
puts [string map {G C C G} "GCAT"]
```

### Output
```
hello
CGAT
```

---

## String Formatting (format, scan)

### Explanation
`format` creates a formatted string akin to C's `sprintf`. `scan` extracts values akin to `sscanf`.

### Syntax
```tcl
format formatString ?arg arg ...?
scan string formatString ?varName ...?
```

### Example
```tcl
puts [format "Value: %04X" 255]
scan "Slack: -1.5 ns" "Slack: %f ns" slack
puts $slack
```

### Output
```
Value: 00FF
-1.5
```

---

## Type Checking (is)

### Explanation
`string is` checks if a string belongs to a certain class (integer, double, boolean, alpha, digit, alnum, space).

### Syntax
```tcl
string is class ?-strict? string
```

### Example
```tcl
puts [string is integer "123"]
puts [string is double -strict ""]
```

### Output
```
1
0
```

---

## Practice Exercises
- `01_string_operations.tcl`: Practice measuring length, indexing, mapping, case conversion, and trimming.

---

## Summary
- Use `string range` and `string index` for extraction.
- Glob matching is extremely fast and useful for file names and signal matching.
- `string map` is incredibly efficient for multiple substring replacements.
- Use `string is` for safe data validation.
