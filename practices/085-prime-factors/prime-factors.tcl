proc factors {n} {
    set res {}
    set f 2
    while {$n > 1} {
        while {$n % $f == 0} {
            lappend res $f
            set n [expr {$n / $f}]
        }
        incr f
        if {$f * $f > $n && $n > 1} {
            lappend res $n
            break
        }
    }
    return $res
}
