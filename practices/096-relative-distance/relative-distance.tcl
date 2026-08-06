proc degreeOfSeparation {personA personB familyTree} {
    if {$personA eq $personB} {
        return 0
    }

    set graph {}
    dict for {parent children} $familyTree {
        foreach child $children {
            dict lappend graph $parent $child
            dict lappend graph $child $parent
        }

        for {set i 0} {$i < [llength $children]} {incr i} {
            for {set j [expr {$i + 1}]} {$j < [llength $children]} {incr j} {
                set first [lindex $children $i]
                set second [lindex $children $j]
                dict lappend graph $first $second
                dict lappend graph $second $first
            }
        }
    }

    set queue [list [list $personA 0]]
    set seen [dict create $personA 1]

    for {set i 0} {$i < [llength $queue]} {incr i} {
        lassign [lindex $queue $i] person distance

        if {![dict exists $graph $person]} {
            continue
        }

        foreach relative [dict get $graph $person] {
            if {$relative eq $personB} {
                return [expr {$distance + 1}]
            }

            if {![dict exists $seen $relative]} {
                dict set seen $relative 1
                lappend queue [list $relative [expr {$distance + 1}]]
            }
        }
    }

    return -1
}
