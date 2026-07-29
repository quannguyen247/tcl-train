proc encode {key phrase} {
    lassign $key a b
    if {[coprime $a 26] != 1} {
        error "a and m must be coprime."
    }
    set text [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set text [string tolower $text]
    set cipher ""
    set count 0
    foreach char [split $text ""] {
        if {[string is digit $char]} {
            set c $char
        } else {
            set x [expr {[scan $char %c] - 97}]
            set y [expr {($a * $x + $b) % 26}]
            set c [format %c [expr {$y + 97}]]
        }
        if {$count > 0 && $count % 5 == 0} {
            append cipher " "
        }
        append cipher $c
        incr count
    }
    return $cipher
}

proc decode {key phrase} {
    lassign $key a b
    if {[coprime $a 26] != 1} {
        error "a and m must be coprime."
    }
    set m_inv [mod_inverse $a 26]
    set text [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set text [string tolower $text]
    set plain ""
    foreach char [split $text ""] {
        if {[string is digit $char]} {
            append plain $char
        } else {
            set y [expr {[scan $char %c] - 97}]
            set x [expr {($m_inv * ($y - $b)) % 26}]
            if {$x < 0} { set x [expr {$x + 26}] }
            append plain [format %c [expr {$x + 97}]]
        }
    }
    return $plain
}

proc coprime {a b} {
    while {$b != 0} {
        set t $b
        set b [expr {$a % $b}]
        set a $t
    }
    return $a
}

proc mod_inverse {a m} {
    for {set x 1} {$x < $m} {incr x} {
        if {[expr {($a * $x) % $m}] == 1} {
            return $x
        }
    }
    return 1
}
