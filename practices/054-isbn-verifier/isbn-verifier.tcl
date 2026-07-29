proc isValid {isbn} {
    set clean [string map {- ""} $isbn]
    if {![regexp {^\d{9}[\dX]$} $clean]} { return false }

    set sum 0
    set weight 10
    foreach char [split $clean ""] {
        set val [expr {$char eq "X" ? 10 : $char}]
        incr sum [expr {$val * $weight}]
        incr weight -1
    }
    return [expr {$sum % 11 == 0}]
}



