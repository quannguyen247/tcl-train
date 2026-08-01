namespace eval school {
    namespace export reset add roster grade
    namespace ensemble create

    variable students {}

    proc reset {} {
        variable students {}
    }

    proc add {list_of_students} {
        variable students
        set res {}
        foreach item $list_of_students {
            lassign $item name g
            set exists 0
            foreach s $students {
                if {[lindex $s 0] eq $name} { set exists 1; break }
            }
            if {$exists} {
                lappend res false
            } else {
                lappend students [list $name $g]
                lappend res true
            }
        }
        return $res
    }

    proc roster {} {
        variable students
        set sorted [lsort -command ::school::compare $students]
        set res {}
        foreach s $sorted { lappend res [lindex $s 0] }
        return $res
    }

    proc grade {g} {
        variable students
        set filtered {}
        foreach s $students {
            if {[lindex $s 1] == $g} { lappend filtered [lindex $s 0] }
        }
        return [lsort $filtered]
    }

    proc compare {a b} {
        set g1 [lindex $a 1]; set g2 [lindex $b 1]
        if {$g1 != $g2} { return [expr {$g1 - $g2}] }
        return [string compare [lindex $a 0] [lindex $b 0]]
    }
}
