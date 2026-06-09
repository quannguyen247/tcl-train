# Module 02: Control Flow & Loops

This module covers control flow structures in Tcl: conditional branching (`if`, `switch`), loop iteration (`for`, `while`, `foreach`), and critical Tcl syntax rules.

---

## 📖 Core Concepts

### 1. Conditional Branching (`if` and `switch`)
Expressions should be wrapped in braces `{}` to enable Tcl bytecode compilation:

```tcl
if {$slack_ps < 0} {
    puts "Timing violation"
} elseif {$slack_ps < 50} {
    puts "Timing margin is tight"
} else {
    puts "Timing is safe"
}
```

⚠️ **Syntax Pitfall:**
The `else` and `elseif` keywords **MUST stay on the SAME LINE** as the preceding closing brace `}`:
- ✅ **CORRECT:** `} else {`
- ❌ **INCORRECT:**
  ```tcl
  }
  else {  ;# Raises "invalid command name else" error
  ```

---

### 2. `for` Loop Structure

The `for` loop consists of 4 braced blocks:

```tcl
for {initializer} {condition} {step} { body }
```

**Example:** Calculating Hamming distance by comparing characters:

```tcl
for {set i 0} {$i < $len} {incr i} {
    set char1 [string index $left $i]
    set char2 [string index $right $i]
    if {$char1 ne $char2} {
        incr distance
    }
}
```

- `{set i 0}`: Initializer block (runs once at start).
- `{$i < $len}`: Continuation condition (checked before each iteration).
- `{incr i}`: Step expression (increments counter `i` at loop end).
- `{ ... }`: Body executing loop commands.

---

### 3. `while` Loop Structure

Executes as long as the condition evaluates to true:

```tcl
while {$number > 1} {
    incr count
    if {$number % 2 == 0} {
        set number [expr {$number / 2}]
    } else {
        set number [expr {$number * 3 + 1}]
    }
}
```

- **Termination Condition:** `while {$number > 1}` stops immediately when `$number == 1`. 
- ⚠️ Do NOT use `$number >= 1` as it causes an infinite loop!

---

### 4. Key Algorithms & Tricks

- **Canonical Form for Anagrams:**
  Sort characters alphabetically to normalize permutations:
  `set canonical [lsort [split [string tolower $word] ""]]`

- **$O(1)$ Mathematical Optimization:**
  - Sum $1 \rightarrow n$: $S = \frac{n(n+1)}{2}$
  - Sum of Squares $1^2 + ... + n^2$: $S = \frac{n(n+1)(2n+1)}{6}$
