proc binarySearch {haystack needle} {
    set left 0
    set right [expr {[llength $haystack] - 1}]

    while {$left <= $right} {
        set mid [expr {($left + $right) / 2}]
        set midVal [lindex $haystack $mid]

        if {$midVal == $needle} {
            return $mid
        } elseif {$midVal < $needle} {
            set left [expr {$mid + 1}]
        } else {
            set right [expr {$mid - 1}]
        }
    }

    return -1
}
