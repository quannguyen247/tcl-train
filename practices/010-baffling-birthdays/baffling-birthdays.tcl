proc sharedBirthday {birthdays} {
    set seen {}

    foreach birthday $birthdays {
        set monthDay [string range $birthday 5 9]

        if {[dict exists $seen $monthDay]} {
            return true
        }

        dict set seen $monthDay 1
    }

    return false
}

proc randomBirthdates {count} {
    set birthdates {}

    for {set i 0} {$i < $count} {incr i} {
        set year [expr {2001 + int(rand() * 3)}]
        set day [expr {int(rand() * 365) + 1}]

        lappend birthdates [clock format \
            [clock scan "$year-$day" -format {%Y-%j}] -format %Y-%m-%d]
    }

    return $birthdates
}

proc estimatedProbabilityOfSharedBirthday {size} {
    set allDifferent 1.0

    for {set i 0} {$i < $size} {incr i} {
        set allDifferent [expr {
            $allDifferent * (365.0 - $i) / 365.0
        }]
    }

    return [expr {100 * (1 - $allDifferent)}]
}
