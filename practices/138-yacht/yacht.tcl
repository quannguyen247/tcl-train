proc score {dice category} {
    set sorted [lsort -integer $dice]

    set counts {}
    foreach d $dice { dict incr counts $d }

    switch -exact -- $category {
        "ones"   { return [expr {1 * ([dict exists $counts 1] ? [dict get $counts 1] : 0)}] }
        "twos"   { return [expr {2 * ([dict exists $counts 2] ? [dict get $counts 2] : 0)}] }
        "threes" { return [expr {3 * ([dict exists $counts 3] ? [dict get $counts 3] : 0)}] }
        "fours"  { return [expr {4 * ([dict exists $counts 4] ? [dict get $counts 4] : 0)}] }
        "fives"  { return [expr {5 * ([dict exists $counts 5] ? [dict get $counts 5] : 0)}] }
        "sixes"  { return [expr {6 * ([dict exists $counts 6] ? [dict get $counts 6] : 0)}] }

        "full house" {
            set freq [lsort -integer [dict values $counts]]
            if {$freq eq {2 3}} {
                return [tcl::mathop::+ {*}$dice]
            }
            return 0
        }

        "four of a kind" {
            dict for {val cnt} $counts {
                if {$cnt >= 4} { return [expr {4 * $val}] }
            }
            return 0
        }

        "little straight" { return [expr {$sorted eq {1 2 3 4 5} ? 30 : 0}] }
        "big straight"    { return [expr {$sorted eq {2 3 4 5 6} ? 30 : 0}] }
        "choice"          { return [tcl::mathop::+ {*}$dice] }
        "yacht"           { return [expr {[llength [dict keys $counts]] == 1 ? 50 : 0}] }

        default { return 0 }
    }
}
