proc hammingDistance {left right} {
    if {[string length $left] != [string length $right]} {
        error "strands must be of equal length"
    }

    set distance 0
    set len [string length $left]
    for {set i 0} {$i < $len} {incr i} {
        if {[string index $left $i] ne [string index $right $i]} {
            incr distance
        }
    }

    return $distance
}
