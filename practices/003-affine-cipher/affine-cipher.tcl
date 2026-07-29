proc gcd {a b} {
    while {$b != 0} {
        set t [expr {$a % $b}]
        set a $b
        set b $t
    }
    return $a
}

proc get_mmi {a} {
    if {[gcd $a 26] != 1} {
        error "a and m must be coprime."
    }
    for {set x 1} {$x < 26} {incr x} {
        if {($a * $x) % 26 == 1} {
            return $x
        }
    }
    error "a and m must be coprime."
}

proc affine_encode {phrase a b} {
    get_mmi $a

    set result ""
    set phrase [string tolower $phrase]

    foreach char [split $phrase ""] {
        if {[regexp {[a-z]} $char]} {
            set x [expr {[scan $char %c] - 97}]
            set y [expr {($a * $x + $b) % 26}]
            append result [format %c [expr {$y + 97}]]
        } elseif {[regexp {[0-9]} $char]} {
            append result $char
        }
    }

    return [join [regexp -all -inline {.{1,5}} $result] " "]
}

proc affine_decode {phrase a b} {
    set a_inv [get_mmi $a]

    set result ""
    set phrase [string map {" " ""} [string tolower $phrase]]

    foreach char [split $phrase ""] {
        if {[regexp {[a-z]} $char]} {
            set y [expr {[scan $char %c] - 97}]
            set x [expr {(($a_inv * ($y - $b)) % 26 + 26) % 26}]
            append result [format %c [expr {$x + 97}]]
        } elseif {[regexp {[0-9]} $char]} {
            append result $char
        }
    }

    return $result
}
