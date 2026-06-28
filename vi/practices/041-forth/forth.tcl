# ==============================================================================
# EXERCISM TCL PRACTICE: FORTH
# ==============================================================================
# # Instructions
#
# Implement an evaluator for a very simple subset of Forth.
#
# [Forth][forth]
# is a stack-based programming language.
# Implement a very basic evaluator for a small subset of Forth.
#
# Your evaluator has to support the following words:
#
# - `+`, `-`, `*`, `/` (integer arithmetic)
# - `DUP`, `DROP`, `SWAP`, `OVER` (stack manipulation)
#
# Your evaluator also has to support defining new words using the customary syntax: `: word-name definition ;`.
#
# To keep things simple the only data type you need to support is signed integers of at least 16 bits size.
#
# You should use the following rules for the syntax: a number is a sequence of one or more (ASCII) digits, a word is a sequence of one or more letters, digits, symbols or punctuation that is not a number.
# (Forth probably uses slightly different rules, but this is close enough.)
#
# Words are case-insensitive.
#
# [forth]: https://en.wikipedia.org/wiki/Forth_%28programming_language%29

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

# Mở rộng từ theo định nghĩa hiện tại
proc forthExpand {word definitionsVar} {
    upvar 1 $definitionsVar definitions

    if {![dict exists $definitions $word]} {
        return [list $word]
    }

    set result {}
    foreach token [dict get $definitions $word] {
        lappend result {*}[forthExpand $token definitions]
    }
    return $result
}

# Thực thi một từ trên stack
proc forthRun {word stackVar definitionsVar} {
    upvar 1 $stackVar stack
    upvar 1 $definitionsVar definitions

    if {[regexp {^-?[0-9]+$} $word]} {
        lappend stack $word
        return
    }

    if {[dict exists $definitions $word]} {
        foreach token [dict get $definitions $word] {
            forthRun $token stack definitions
        }
        return
    }

    if {$word in {+ - * /}} {
        if {$stack eq {}} {
            error "empty stack"
        }
        if {[llength $stack] == 1} {
            error "only one value on the stack"
        }

        set right [lindex $stack end]
        set left [lindex $stack end-1]
        set stack [lrange $stack 0 end-2]

        if {$word eq "/" && $right == 0} {
            error "divide by zero"
        }

        switch -- $word {
            + {set value [expr {$left + $right}]}
            - {set value [expr {$left - $right}]}
            * {set value [expr {$left * $right}]}
            / {set value [expr {$left / $right}]}
        }
        lappend stack $value
        return
    }

    switch -- $word {
        dup {
            if {$stack eq {}} {error "empty stack"}
            lappend stack [lindex $stack end]
        }
        drop {
            if {$stack eq {}} {error "empty stack"}
            set stack [lrange $stack 0 end-1]
        }
        swap {
            if {$stack eq {}} {error "empty stack"}
            if {[llength $stack] == 1} {
                error "only one value on the stack"
            }
            set right [lindex $stack end]
            set left [lindex $stack end-1]
            set stack [lrange $stack 0 end-2]
            lappend stack $right $left
        }
        over {
            if {$stack eq {}} {error "empty stack"}
            if {[llength $stack] == 1} {
                error "only one value on the stack"
            }
            lappend stack [lindex $stack end-1]
        }
        default {
            error "undefined operation"
        }
    }
}

# Đọc input và xử lý từng token
proc evalForth {input} {
    set tokens {}
    foreach token [regexp -all -inline {\S+} $input] {
        lappend tokens [string tolower $token]
    }

    set stack {}
    set definitions {}

    for {set i 0} {$i < [llength $tokens]} {incr i} {
        set token [lindex $tokens $i]
        if {$token ne ":"} {
            forthRun $token stack definitions
            continue
        }

        incr i
        if {$i >= [llength $tokens]
            || [regexp {^-?[0-9]+$} [lindex $tokens $i]]} {
            error "illegal operation"
        }

        set name [lindex $tokens $i]
        set body {}
        incr i
        while {$i < [llength $tokens]
               && [lindex $tokens $i] ne ";"} {
            lappend body [lindex $tokens $i]
            incr i
        }
        if {$i >= [llength $tokens]} {
            error "illegal operation"
        }

        set expanded {}
        foreach word $body {
            lappend expanded {*}[forthExpand $word definitions]
        }
        dict set definitions $name $expanded
    }

    return $stack
}

