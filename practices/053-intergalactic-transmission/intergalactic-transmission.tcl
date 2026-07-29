proc transmitSequence {message} {
    set bits {}

    # Tách mỗi byte thành 8 bit
    foreach byte $message {
        for {set bit 7} {$bit >= 0} {incr bit -1} {
            lappend bits [expr {($byte >> $bit) & 1}]
        }
    }

    set result {}
    for {set i 0} {$i < [llength $bits]} {incr i 7} {
        set data [lrange $bits $i [expr {$i + 6}]]
        set value 0
        set ones 0

        foreach bit $data {
            set value [expr {$value * 2 + $bit}]
            incr ones $bit
        }
        while {[llength $data] < 7} {
            set value [expr {$value * 2}]
            lappend data 0
        }

        # Parity là bit cuối, giúp tổng số bit 1 luôn chẵn
        lappend result [expr {($value << 1) | ($ones % 2)}]
    }
    return $result
}

proc decodeMessage {transmission} {
    set bits {}

    foreach byte $transmission {
        set ones 0
        for {set bit 0} {$bit < 8} {incr bit} {
            incr ones [expr {($byte >> $bit) & 1}]
        }
        if {$ones % 2} {
            error "wrong parity"
        }

        for {set bit 7} {$bit > 0} {incr bit -1} {
            lappend bits [expr {($byte >> $bit) & 1}]
        }
    }

    set message {}
    for {set i 0} {$i + 7 < [llength $bits]} {incr i 8} {
        set byte 0
        foreach bit [lrange $bits $i [expr {$i + 7}]] {
            set byte [expr {$byte * 2 + $bit}]
        }
        lappend message $byte
    }
    return $message
}

