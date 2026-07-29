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




proc score {x y} {
    set dist [expr {hypot($x, $y)}]
    if {$dist <= 1.0} {
        return 10
    } elseif {$dist <= 5.0} {
        return 5
    } elseif {$dist <= 10.0} {
        return 1
    } else {
        return 0
    }
}
