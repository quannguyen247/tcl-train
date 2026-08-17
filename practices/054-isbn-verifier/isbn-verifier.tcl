proc isValid {isbn} {
    set clean [string map {- ""} $isbn]

    if {![regexp {^[0-9]{9}[0-9X]$} $clean]} {
        return false
    }

    set sum 0
    for {set i 0} {$i < 10} {incr i} {
        set char [string index $clean $i]
        set val [expr {$char eq "X" ? 10 : $char}]
        set sum [expr {$sum + $val * (10 - $i)}]
    }

    return [expr {$sum % 11 == 0}]
}
