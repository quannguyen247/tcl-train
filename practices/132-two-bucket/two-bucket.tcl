proc twoBucket {input} {
    dict with input {}

    if {$goal > $bucketOne && $goal > $bucketTwo} {
        error "impossible"
    }

    set capacities [list $bucketOne $bucketTwo]
    set start [expr {$startBucket eq "one" ? 0 : 1}]
    set other [expr {1 - $start}]
    set amounts {0 0}
    lset amounts $start [lindex $capacities $start]
    set moves 1
    set seen {}

    while {true} {
        foreach bucket {0 1} {
            if {[lindex $amounts $bucket] == $goal} {
                return [dict create \
                    moves $moves \
                    goalBucket [lindex {one two} $bucket] \
                    otherBucket [lindex $amounts [expr {1 - $bucket}]]]
            }
        }

        if {[lindex $amounts $other] == 0
            && [lindex $capacities $other] == $goal} {
            lset amounts $other $goal
            incr moves
            continue
        }

        if {[dict exists $seen $amounts]} {
            error "impossible"
        }
        dict set seen $amounts 1

        if {[lindex $amounts $start] == 0} {
            lset amounts $start [lindex $capacities $start]
        } elseif {[lindex $amounts $other] == [lindex $capacities $other]} {
            lset amounts $other 0
        } else {
            set source [lindex $amounts $start]
            set space [expr {[lindex $capacities $other] - [lindex $amounts $other]}]
            set pour [expr {min($source, $space)}]
            lset amounts $start [expr {$source - $pour}]
            lset amounts $other [expr {[lindex $amounts $other] + $pour}]
        }

        incr moves
    }
}
