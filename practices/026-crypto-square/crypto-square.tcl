proc encrypt {plaintext} {
    set cleaned_plaintext [string tolower [regsub -all {[^a-zA-Z0-9]} $plaintext ""]]
    set len [string length $cleaned_plaintext]

    if {$len == 0} {
        return ""
    }

    set r 1
    set c 1
    while {$r * $c < $len} {
        if {$c > $r} {
            incr r
        } else {
            incr c
        }
    }

    set target_len [expr {$r * $c}]
    while {[string length $cleaned_plaintext] < $target_len} {
        append cleaned_plaintext " "
    }

    set chunks {}
    for {set col 0} {$col < $c} {incr col} {
        set chunk ""
        for {set row 0} {$row < $r} {incr row} {
            set idx [expr {$row * $c + $col}]
            append chunk [string index $cleaned_plaintext $idx]
        }
        lappend chunks $chunk
    }

    return [join $chunks " "]
}
