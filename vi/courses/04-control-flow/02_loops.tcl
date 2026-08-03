# ==============================================================================
# MODULE 02: CONTROL FLOW
# LESSON 02: FOR AND WHILE LOOPS IN TCL
# ==============================================================================
# In Tcl, [for] and [while] are the core iteration constructs.
# Run this script using: tclsh 02_loops_for_while.tcl
# ==============================================================================

puts "=== TCL FOR AND WHILE LOOPS GUIDE ==="

# ------------------------------------------------------------------------------
# 1. FOR LOOP STRUCTURE
# ------------------------------------------------------------------------------
# Syntax: for {init} {condition} {next} { body }
#
# Breakdown of the 4 braced blocks:
#   - Block 1 {set i 0}: Initializer (runs once at the start).
#   - Block 2 {$i < $len}: Continuation condition (checked before each iteration).
#   - Block 3 {incr i}: Step expression (runs at the end of each iteration).
#   - Block 4 { ... }: Loop body containing execution commands.

set left  "GAGCCTACTAACGGGAT"
set right "CATCGTAATGACGGCCT"
set len [string length $left]
set distance 0

puts "\n1. FOR Loop Example (Hamming Distance Calculation):"
puts "   Strand 1: $left"
puts "   Strand 2: $right"

for {set i 0} {$i < $len} {incr i} {
    set char1 [string index $left $i]
    set char2 [string index $right $i]
    if {$char1 ne $char2} {
        incr distance
    }
}

puts "   -> Hamming distance (differing positions): $distance"


# ------------------------------------------------------------------------------
# 2. WHILE LOOP STRUCTURE
# ------------------------------------------------------------------------------
# Syntax: while {condition} { body }
#
# Explanation:
#   - As long as {condition} remains TRUE, Tcl repeatedly executes the body.
#   - As soon as {condition} becomes FALSE, the loop terminates immediately.

set number 12
set count 0

puts "\n2. WHILE Loop Example (Collatz Conjecture for number $number):"

while {$number > 1} {
    incr count
    if {$number % 2 == 0} {
        set number [expr {$number / 2}]
    } else {
        set number [expr {$number * 3 + 1}]
    }
}

puts "   -> Steps to reach 1 for number 12: $count steps"


# ------------------------------------------------------------------------------
# 3. CRITICAL SYNTAX RULES & PITFALLS
# ------------------------------------------------------------------------------
# ⚠️ Rule 1: Always wrap conditions in braces {} for bytecode compilation optimization.
# ⚠️ Rule 2: Keep `} else {` on the SAME LINE:
#          CORRECT:   } else {
#          INCORRECT: }
#                     else {  --> Raises "invalid command name else" error

puts "\n=== FOR AND WHILE LOOPS LESSON COMPLETE ==="
