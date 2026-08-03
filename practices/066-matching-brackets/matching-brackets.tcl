proc bracketsMatch {input} {
    set opens "\(\[\{"
    set closes "\)\]\}"
    set stack {}

    foreach char [split $input ""] {
        set index [string first $char $opens]

        if {$index >= 0} {
            lappend stack $char
            continue
        }

        set index [string first $char $closes]

        if {$index < 0} {
            continue
        }

        set lastOpen [lindex $stack end]
        set expectedOpen [string index $opens $index]

        if {$stack eq {} || $lastOpen ne $expectedOpen} {
            return false
        }

        set stack [lrange $stack 0 end-1]
    }

    return [expr {$stack eq {}}]
}
