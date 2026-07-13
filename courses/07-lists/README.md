<Chapter 07: Lists>
Lists in Tcl are fundamental data structures that store ordered collections of items. A list is essentially a string formatted with specific syntax, primarily separated by whitespace. Everything in Tcl can be treated as a list if properly formatted.

---

## Table of Contents
- [Creating and Accessing Lists](#creating-and-accessing-lists)
- [Modifying Lists](#modifying-lists)
- [Extracting and Searching Lists](#extracting-and-searching-lists)
- [Sorting Lists](#sorting-lists)
- [Converting Lists and Strings](#converting-lists-and-strings)
- [Iteration Patterns](#iteration-patterns)

---

## Creating and Accessing Lists

### Explanation
Lists can be created using the `list` command, splitting strings, or using literal braces. Accessing list elements is done with `lindex`, which is 0-indexed. You can also use `end` or `end-N` to refer to elements from the back. `llength` returns the number of elements.

### Syntax
```tcl
list arg1 arg2 ...
lindex list index
llength list
```

### Example
```tcl
# Creating lists
set clk_list [list clk_core clk_mem clk_sys]
set literal_list {pin_A pin_B pin_C}

# Accessing
puts "First clock: [lindex $clk_list 0]"
puts "Last clock: [lindex $clk_list end]"
puts "Second to last: [lindex $clk_list end-1]"

# Length
puts "Number of clocks: [llength $clk_list]"
```

### Output
```
First clock: clk_core
Last clock: clk_sys
Second to last: clk_mem
Number of clocks: 3
```

---

## Modifying Lists

### Explanation
Lists can be modified using commands like `lappend` (adds to the end of a variable), `linsert` (inserts at a specific index), `lreplace` (replaces a range), and `lset` (modifies an element in place).

### Syntax
```tcl
lappend varName arg ...
linsert list index arg ...
lreplace list first last arg ...
lset varName index newValue
```

### Example
```tcl
set paths {path1 path2 path3}

# lappend modifies the variable in place
lappend paths path4 path5
puts "After lappend: $paths"

# linsert returns a new list
set paths_new [linsert $paths 1 path_inserted]
puts "After linsert: $paths_new"

# lreplace returns a new list
set paths_replaced [lreplace $paths 0 0 path1_new]
puts "After lreplace: $paths_replaced"

# lset modifies the variable in place
lset paths 2 path3_updated
puts "After lset: $paths"
```

### Output
```
After lappend: path1 path2 path3 path4 path5
After linsert: path1 path_inserted path2 path3 path4 path5
After lreplace: path1_new path2 path3 path4 path5
After lset: path1 path2 path3_updated path4 path5
```

---

## Extracting and Searching Lists

### Explanation
`lrange` extracts a sublist based on a start and end index. `lassign` assigns list elements to multiple variables. `lsearch` searches for elements matching a pattern, supporting various matching styles (`-exact`, `-glob`, `-regexp`) and return options (`-all`, `-inline`).

### Syntax
```tcl
lrange list first last
lassign list varName ?varName ...?
lsearch ?options? list pattern
```

### Example
```tcl
set nodes {buf1 inv1 nand2 nor3 dff1 buf2}

# Extracting a range
set sub_nodes [lrange $nodes 1 3]
puts "Sub nodes: $sub_nodes"

# Assigning to variables
lassign $nodes first_node second_node
puts "First: $first_node, Second: $second_node"

# Searching
set buf_idx [lsearch -exact $nodes buf1]
puts "Index of buf1: $buf_idx"

# Search with glob, return all matching values inline
set all_bufs [lsearch -all -inline -glob $nodes buf*]
puts "All buffers: $all_bufs"
```

### Output
```
Sub nodes: inv1 nand2 nor3
First: buf1, Second: inv1
Index of buf1: 0
All buffers: buf1 buf2
```

---

## Sorting Lists

### Explanation
`lsort` sorts a list based on specified criteria. It supports data types (`-ascii`, `-dictionary`, `-integer`, `-real`), orders (`-increasing`, `-decreasing`), and options to keep unique elements (`-unique`) or sort nested lists (`-index`). You can even define a custom comparison command (`-command`).

### Syntax
```tcl
lsort ?options? list
```

### Example
```tcl
set delays {2.5 1.1 3.4 1.1 5.0}

# Sort as real numbers
set sorted_delays [lsort -real $delays]
puts "Sorted delays: $sorted_delays"

# Unique and decreasing
set unique_dec_delays [lsort -real -decreasing -unique $delays]
puts "Unique decreasing: $unique_dec_delays"

# Dictionary sort (handles numbers in strings intelligently)
set nets {net10 net2 net1}
puts "ASCII sort: [lsort -ascii $nets]"
puts "Dict sort: [lsort -dictionary $nets]"
```

### Output
```
Sorted delays: 1.1 1.1 2.5 3.4 5.0
Unique decreasing: 5.0 3.4 2.5 1.1
ASCII sort: net1 net10 net2
Dict sort: net1 net2 net10
```

---

## Converting Lists and Strings

### Explanation
`split` breaks a string into a list based on a delimiter character. `join` concatenates list elements into a single string using a specified separator. `concat` merges multiple lists into a single flat list.

### Syntax
```tcl
split string ?splitChars?
join list ?joinString?
concat ?arg arg ...?
```

### Example
```tcl
# String to list
set csv_line "clk_sys,1.5,100"
set fields [split $csv_line ","]
puts "Fields list: $fields"
puts "Period: [lindex $fields 1]"

# List to string
set new_csv [join $fields "|"]
puts "Pipe separated: $new_csv"

# Concat lists
set list1 {a b}
set list2 {c d}
puts "Concatenated: [concat $list1 $list2]"
```

### Output
```
Fields list: clk_sys 1.5 100
Period: 1.5
Pipe separated: clk_sys|1.5|100
Concatenated: a b c d
```

---

## Iteration Patterns

### Explanation
`foreach` is typically used to iterate over list elements. It can iterate over multiple variables and multiple lists simultaneously. Nested lists can be accessed by providing multiple indices to `lindex`.

### Example
```tcl
set ports {in_a in_b out_y}
foreach port $ports {
    puts "Processing port: $port"
}

# Multiple variables
set pairs {A 1 B 2 C 3}
foreach {name val} $pairs {
    puts "$name = $val"
}

# Nested list access
set nested_list {{clk1 10} {clk2 20}}
puts "clk2 period: [lindex $nested_list 1 1]"
```

### Output
```
Processing port: in_a
Processing port: in_b
Processing port: out_y
A = 1
B = 2
C = 3
clk2 period: 20
```

---

## Practice Exercises
- `01_list_operations.tcl`: EDA-themed exercise for working with lists of clock domains, pin names, and timing paths using various list commands.

---

## Summary
- Lists are ordered string sequences in Tcl.
- Use `lindex` and `llength` for basic access.
- Use `lappend` and `lset` to modify variables in place; `linsert` and `lreplace` return new lists.
- `lsearch` and `lsort` offer powerful querying and ordering capabilities.
- Convert between strings and lists using `split` and `join`.
</Chapter 07: Lists>
