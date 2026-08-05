oo::class create Queen {
    variable r c

    constructor {row col} {
        if {$row < 0} { return -code error "row not positive" }
        if {$row > 7} { return -code error "row not on board" }
        if {$col < 0} { return -code error "column not positive" }
        if {$col > 7} { return -code error "column not on board" }
        set r $row
        set c $col
    }

    method r {} { return $r }
    method c {} { return $c }

    method canAttack {other} {
        set or [$other r]
        set oc [$other c]
        expr {$r == $or || $c == $oc || abs($r - $or) == abs($c - $oc)}
    }
}
