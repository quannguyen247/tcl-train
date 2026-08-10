proc sublist {list1 list2} {
    set len1 [llength $list1]
    set len2 [llength $list2]

    if {$list1 eq $list2} {
        return "equal"
    }

    if {$len1 < $len2} {
        for {set i 0} {$i <= $len2 - $len1} {incr i} {
            if {[lrange $list2 $i [expr {$i + $len1 - 1}]] eq $list1} {
                return "sublist"
            }
        }
    }

    if {$len1 > $len2} {
        for {set i 0} {$i <= $len1 - $len2} {incr i} {
            if {[lrange $list1 $i [expr {$i + $len2 - 1}]] eq $list2} {
                return "superlist"
            }
        }
    }

    return "unequal"
}
