proc meetup {year month schedule weekday} {
    set days [dict create Sunday 0 Monday 1 Tuesday 2 Wednesday 3 Thursday 4 Friday 5 Saturday 6]
    set target_wd [dict get $days $weekday]

    if {$month == 12} {
        set m2 [format "%04d-01-01" [expr {$year + 1}]]
    } else {
        set m2 [format "%04d-%02d-01" $year [expr {$month + 1}]]
    }
    set s2 [clock scan $m2 -format "%Y-%m-%d" -gmt 1]
    set last_d [scan [clock format [expr {$s2 - 86400}] -format "%d" -gmt 1] %d]

    switch -- $schedule {
        teenth { set d 13; set max_d 19 }
        first  { set d 1;  set max_d 7 }
        second { set d 8;  set max_d 14 }
        third  { set d 15; set max_d 21 }
        fourth { set d 22; set max_d 28 }
        last   { set d [expr {$last_d - 6}]; set max_d $last_d }
    }

    for {} {$d <= $max_d} {incr d} {
        set date [format "%04d-%02d-%02d" $year $month $d]
        set s [clock scan $date -format "%Y-%m-%d" -gmt 1]
        if {[clock format $s -format "%w" -gmt 1] == $target_wd} {
            return $date
        }
    }
}
