proc squareRoot {radicand} {
    set x $radicand
    set y 1
    while {$x > $y} {
        set x [expr {($x + $y) / 2}]
        set y [expr {$radicand / $x}]
    }
    return $x
}
