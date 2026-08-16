proc answer {question} {
    if {![regexp {^What is} $question] || ![regexp {\?$} $question]} {
        error "unknown operation"
    }

    regexp {^What is\s*(.*?)\?$} $question -> text
    set text [string trim $text]

    if {$text eq ""} {
        error "syntax error"
    }

    set text [string map {"multiplied by" "multiplied_by" "divided by" "divided_by"} $text]
    set tokens [split $text " "]

    set first [lindex $tokens 0]
    if {![regexp {^-?\d+$} $first]} {
        error "syntax error"
    }

    set result $first
    set len [llength $tokens]
    set idx 1

    while {$idx < $len} {
        set op [lindex $tokens $idx]

        if {$op in {plus minus multiplied_by divided_by}} {
            if {$idx + 1 >= $len} {
                error "syntax error"
            }
            set next [lindex $tokens $idx+1]
            if {![regexp {^-?\d+$} $next]} {
                error "syntax error"
            }

            switch -- $op {
                "plus"          { set result [expr {$result + $next}] }
                "minus"         { set result [expr {$result - $next}] }
                "multiplied_by" { set result [expr {$result * $next}] }
                "divided_by"    { set result [expr {$result / $next}] }
            }
            incr idx 2
        } elseif {[regexp {^-?\d+$} $op]} {
            error "syntax error"
        } else {
            error "unknown operation"
        }
    }

    return $result
}
