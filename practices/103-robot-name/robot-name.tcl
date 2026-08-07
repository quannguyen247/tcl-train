set ::usedRobotNames [dict create]

proc resetRobotNames {} {
    set ::usedRobotNames [dict create]
}

oo::class create Robot {
    variable name

    constructor {} {
        my reset
    }

    method name {} {
        return $name
    }

    method reset {} {
        if {[dict size $::usedRobotNames] >= 676000} {
            return -code error "no more names available"
        }
        while {1} {
            set l1 [format %c [expr {65 + int(rand() * 26)}]]
            set l2 [format %c [expr {65 + int(rand() * 26)}]]
            set num [format "%03d" [expr {int(rand() * 1000)}]]
            set cand "$l1$l2$num"
            if {![dict exists $::usedRobotNames $cand]} {
                dict set ::usedRobotNames $cand 1
                set name $cand
                break
            }
        }
    }
}
