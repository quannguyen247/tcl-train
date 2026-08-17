proc score {x y} {
    set r [expr {hypot($x, $y)}]
    if {$r > 10} {
        return 0
    } elseif {$r > 5} {
        return 1
    } elseif {$r > 1} {
        return 5
    } else {
        return 10
    }
}
