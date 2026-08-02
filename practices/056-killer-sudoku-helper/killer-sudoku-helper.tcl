proc cageSearch {sum size exclude start chosen} {
    if {$size == 0} {
        return [expr {$sum == 0 ? [list $chosen] : {}}]
    }

    set result {}
    for {set digit $start} {$digit <= 9} {incr digit} {
        if {$digit in $exclude || $digit > $sum} {
            continue
        }
        lappend result {*}[cageSearch [expr {$sum - $digit}] \
            [expr {$size - 1}] $exclude [expr {$digit + 1}] \
            [concat $chosen $digit]]
    }
    return $result
}

proc combinations {sum size exclude} {
    return [cageSearch $sum $size $exclude 1 {}]
}
