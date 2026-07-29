proc encode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set cipher ""
    set count 0
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        if {$count > 0 && $count % 5 == 0} {
            append cipher " "
        }
        append cipher $c
        incr count
    }
    return $cipher
}

proc decode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set plain ""
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        append plain $c
    }
    return $plain
}
