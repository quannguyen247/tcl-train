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
