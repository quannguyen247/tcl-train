oo::class create GoBoard {
    variable board width height cache totals

    constructor {input} {
        set board $input
        set height [llength $board]
        set width [expr {$height ? [string length [lindex $board 0]] : 0}]
        set cache {}
        set totals [dict create black {} white {} none {}]
    }

    method territory {intersection} {
        lassign $intersection x y
        if {$x < 0 || $x >= $width || $y < 0 || $y >= $height} {
            error "Invalid coordinate"
        }

        if {[string index [lindex $board $y] $x] ne " "} {
            return [list none {}]
        }

        if {[dict exists $cache $intersection]} {
            return [dict get $cache $intersection]
        }

        set queue [list $intersection]
        set seen [dict create $intersection 1]
        set points {}
        set borders {}

        for {set i 0} {$i < [llength $queue]} {incr i} {
            lassign [lindex $queue $i] cx cy
            lappend points [list $cx $cy]

            foreach {dx dy} {-1 0 1 0 0 -1 0 1} {
                set nx [expr {$cx + $dx}]
                set ny [expr {$cy + $dy}]
                if {$nx < 0 || $nx >= $width || $ny < 0 || $ny >= $height} {
                    continue
                }

                set cell [string index [lindex $board $ny] $nx]
                set next [list $nx $ny]
                if {$cell eq " " && ![dict exists $seen $next]} {
                    dict set seen $next 1
                    lappend queue $next
                } elseif {$cell eq "B"} {
                    dict set borders black 1
                } elseif {$cell eq "W"} {
                    dict set borders white 1
                }
            }
        }

        set owner none
        if {[dict size $borders] == 1} {
            set owner [lindex [dict keys $borders] 0]
        }

        set points [lsort -dictionary $points]
        set area [list $owner $points]

        foreach point $points {
            dict set cache $point $area
        }

        dict lappend totals $owner {*}$points
        return $area
    }

    method territories {} {
        for {set y 0} {$y < $height} {incr y} {
            for {set x 0} {$x < $width} {incr x} {
                set point [list $x $y]

                if {[string index [lindex $board $y] $x] eq " "
                    && ![dict exists $cache $point]} {
                    my territory $point
                }
            }
        }
        foreach owner {black white none} {
            dict set totals $owner [lsort -dictionary [dict get $totals $owner]]
        }
        return $totals
    }
}
