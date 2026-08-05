proc nextPrism {x y angle prisms} {
    set radians [expr {$angle * acos(-1) / 180.0}]
    set dx [expr {cos($radians)}]
    set dy [expr {sin($radians)}]
    set nearest {}
    set bestDistance Inf

    foreach prism $prisms {
        set vx [expr {[dict get $prism x] - $x}]
        set vy [expr {[dict get $prism y] - $y}]

        set distance [expr {$vx * $dx + $vy * $dy}]
        set offset [expr {abs($vx * $dy - $vy * $dx)}]

        if {$distance > 1e-9 && $offset < 1e-2
            && $distance < $bestDistance} {
            set nearest $prism
            set bestDistance $distance
        }
    }

    return $nearest
}

proc findSequence {input} {
    set start [dict get $input start]
    set prisms [dict get $input prisms]

    set x [dict get $start x]
    set y [dict get $start y]
    set angle [dict get $start angle]
    set sequence {}

    while {true} {
        set prism [nextPrism $x $y $angle $prisms]
        if {$prism eq {}} {
            break
        }

        lappend sequence [dict get $prism id]
        set x [dict get $prism x]
        set y [dict get $prism y]

        set angle [expr {
            fmod($angle + [dict get $prism angle], 360.0)
        }]
    }

    return $sequence
}
