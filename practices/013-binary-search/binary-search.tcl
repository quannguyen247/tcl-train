proc binarySearch {list target} {
    set low 0
    set high [expr {[llength $list] - 1}]
    while {$low <= $high} {
        set mid [expr {($low + $high) / 2}]
        set val [lindex $list $mid]
        if {$val == $target} {
            return $mid
        } elseif {$val < $target} {
            set low [expr {$mid + 1}]
        } else {
            set high [expr {$mid - 1}]
        }
    }
    error "value not in list"
}
