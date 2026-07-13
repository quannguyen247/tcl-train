<Chapter 08: Arrays & Dictionaries>
Arrays and Dictionaries provide ways to map keys to values, essential for managing collections of named attributes in scripts.

---

## Table of Contents
- [Arrays](#arrays)
- [Dictionaries](#dictionaries)
- [Arrays vs Dictionaries](#arrays-vs-dictionaries)

---

## Arrays

### Explanation
Tcl arrays are hash tables. They are collections of variables, not first-class values. You cannot pass an array to a procedure directly by value (you must pass its name and use `upvar`). Arrays are highly efficient for large datasets mapping string keys to values.

### Syntax
```tcl
set arr(key) value
array set arr {k1 v1 k2 v2}
$arr(key)
array names arr
array size arr
```

### Example
```tcl
# Setting array elements
set cell_counts(NAND2) 150
set cell_counts(NOR2) 80

# Bulk setting
array set cell_counts {
    INV 300
    DFF 50
}

# Reading
puts "NAND2 count: $cell_counts(NAND2)"
puts "Total cell types: [array size cell_counts]"

# Multi-dimensional simulation
set grid(0,0) "origin"
set grid(1,2) "node_A"
puts "Grid at 1,2: $grid(1,2)"

# Iteration
foreach cell [array names cell_counts] {
    puts "Cell: $cell, Count: $cell_counts($cell)"
}

# Debugging
parray cell_counts
```

### Output
```
NAND2 count: 150
Total cell types: 4
Grid at 1,2: node_A
Cell: DFF, Count: 50
Cell: INV, Count: 300
Cell: NAND2, Count: 150
Cell: NOR2, Count: 80
cell_counts(DFF)   = 50
cell_counts(INV)   = 300
cell_counts(NAND2) = 150
cell_counts(NOR2)  = 80
```

---

## Dictionaries

### Explanation
Dictionaries (`dict`), introduced in Tcl 8.5, are first-class values (like lists and strings). They can be passed to procedures, returned, and nested naturally. They preserve insertion order (unlike arrays).

### Syntax
```tcl
dict create key1 val1 key2 val2
dict set dictVar key value
dict get dictVal key
dict keys dictVal
dict for {k v} dictVal {body}
```

### Example
```tcl
# Creating
set timing [dict create setup 0.5 hold 0.2]

# Modifying
dict set timing transition 0.1

# Nested dictionaries
dict set cells NAND2 area 2.4
dict set cells NAND2 leakage 0.05
dict set cells INV area 1.2
dict set cells INV leakage 0.02

# Accessing nested dict
set nand_area [dict get $cells NAND2 area]
puts "NAND2 area: $nand_area"

# Iterating
dict for {cell attrs} $cells {
    puts "Cell: $cell, Area: [dict get $attrs area]"
}

# In-place operations
set stats [dict create total 10]
dict incr stats total 5
puts "Stats: $stats"
```

### Output
```
NAND2 area: 2.4
Cell: NAND2, Area: 2.4
Cell: INV, Area: 1.2
Stats: total 15
```

---

## Arrays vs Dictionaries

| Feature | Arrays | Dictionaries |
| :--- | :--- | :--- |
| **Data Type** | Collection of variables | First-class value (string) |
| **Pass to Proc** | By name (`upvar`) | By value |
| **Order** | Unordered (hash order) | Preserves insertion order |
| **Nesting** | Hard (fake it with comma keys) | Native support |
| **Performance**| Fast for huge element counts | Fast, but large values copy on write |

---

## Practice Exercises
- `01_arrays_dicts.tcl`: EDA-themed exercise managing a cell library with arrays for counts and dicts for nested timing summaries.

---

## Summary
- Use **arrays** for large, flat, global/local lookups where you modify individual elements frequently.
- Use **dictionaries** when you need to pass collections between functions, maintain order, or build complex nested data structures.
</Chapter 08: Arrays & Dictionaries>
