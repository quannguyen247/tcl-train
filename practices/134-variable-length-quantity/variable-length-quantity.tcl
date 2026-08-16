proc encode {numbers} {
    set result {}

    foreach number $numbers {
        set groups {}

        if {$number == 0} {
            lappend result 0
            continue
        }

        while {$number > 0} {
            set groups [linsert $groups 0 [expr {$number & 0x7f}]]
            set number [expr {$number >> 7}]
        }

        set last [expr {[llength $groups] - 1}]
        for {set i 0} {$i <= $last} {incr i} {
            set byte [lindex $groups $i]

            if {$i < $last} {
                incr byte 0x80
            }

            lappend result $byte
        }
    }

    return $result
}

proc decode {bytes} {
    set result {}
    set value 0
    set incomplete false

    foreach byte $bytes {
        set value [expr {($value << 7) | ($byte & 0x7f)}]

        if {$byte & 0x80} {
            set incomplete true
        } else {
            lappend result $value
            set value 0
            set incomplete false
        }
    }

    if {$incomplete} {
        error "incomplete sequence"
    }

    return $result
}
