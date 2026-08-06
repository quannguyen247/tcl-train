proc hasHorizontal {row left right} {
    for {set x [expr {$left + 1}]} {$x < $right} {incr x} {
        set char [string index $row $x]
        if {$char ne "-" && $char ne "+"} {
            return false
        }
    }
    return true
}

proc hasVertical {input column top bottom} {
    for {set y [expr {$top + 1}]} {$y < $bottom} {incr y} {
        set char [string index [lindex $input $y] $column]
        if {$char ne "|" && $char ne "+"} {
            return false
        }
    }
    return true
}

proc rectangles {input} {
    set height [llength $input]
    if {$height == 0} {
        return 0
    }

    set width [string length [lindex $input 0]]
    set count 0

    for {set top 0} {$top < $height - 1} {incr top} {
        set topRow [lindex $input $top]

        for {set left 0} {$left < $width - 1} {incr left} {
            if {[string index $topRow $left] ne "+"} {
                continue
            }

            for {set right [expr {$left + 1}]} {$right < $width} {incr right} {
                if {[string index $topRow $right] ne "+"
                    || ![hasHorizontal $topRow $left $right]} {
                    continue
                }

                for {set bottom [expr {$top + 1}]} {
                    $bottom < $height
                } {incr bottom} {
                    set bottomRow [lindex $input $bottom]

                    if {[string index $bottomRow $left] eq "+"
                        && [string index $bottomRow $right] eq "+"
                        && [hasHorizontal $bottomRow $left $right]
                        && [hasVertical $input $left $top $bottom]
                        && [hasVertical $input $right $top $bottom]} {
                        incr count
                    }
                }
            }
        }
    }

    return $count
}
