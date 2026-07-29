proc sharedBirthday {birthdays} {
    array set seen {}
    foreach b $birthdays {
        set md [string range $b 5 9]
        if {[info exists seen($md)]} {
            return true
        }
        set seen($md) 1
    }
    return false
}

proc randomBirthdates {count} {
    set res {}
    set days_in_month {31 28 31 30 31 30 31 31 30 31 30 31}
    for {set i 0} {$i < $count} {incr i} {
        set month [expr {int(rand() * 12) + 1}]
        set max_day [lindex $days_in_month [expr {$month - 1}]]
        set day [expr {int(rand() * $max_day) + 1}]
        set year [expr {int(rand() * 50) + 1970}]
        lappend res [format "%04d-%02d-%02d" $year $month $day]
    }
    return $res
}

proc estimatedProbabilityOfSharedBirthday {size} {
    set trials 1000
    set shared 0
    for {set i 0} {$i < $trials} {incr i} {
        set dates [randomBirthdates $size]
        if {[sharedBirthday $dates]} {
            incr shared
        }
    }
    return [expr {double($shared) / $trials}]
}
