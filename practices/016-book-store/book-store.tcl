proc minimumCost {counts memoName} {
    upvar 1 $memoName memo
    set counts [lsort -integer -decreasing $counts]

    if {$counts eq {}} {
        return 0
    }
    if {[dict exists $memo $counts]} {
        return [dict get $memo $counts]
    }

    set prices {0 800 1520 2160 2560 3000}
    set best 0
    foreach count $counts {
        incr best [expr {$count * 800}]
    }

    set sizeCount [llength $counts]
    for {set mask 1} {$mask < (1 << $sizeCount)} {incr mask} {
        set next $counts
        set groupSize 0

        for {set i 0} {$i < $sizeCount} {incr i} {
            if {$mask & (1 << $i)} {
                lset next $i [expr {[lindex $next $i] - 1}]
                incr groupSize
            }
        }

        set next [lsearch -all -inline -not -exact $next 0]
        set total [expr {
            [lindex $prices $groupSize] + [minimumCost $next memo]
        }]
        if {$total < $best} {
            set best $total
        }
    }

    dict set memo $counts $best
    return $best
}

proc basketCost {books} {
    set copies {}
    foreach book $books {
        dict incr copies $book
    }

    set memo {}
    return [minimumCost [dict values $copies] memo]
}
