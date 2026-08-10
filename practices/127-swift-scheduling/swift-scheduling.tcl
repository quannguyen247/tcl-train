proc deliveryDate {timestamp target} {
    set sec [clock scan $timestamp -format "%Y-%m-%dT%H:%M:%S"]
    lassign [clock format $sec -format "%Y %m %d %H %u"] year month day hour dow
    set year [scan $year %d]
    set month [scan $month %d]
    set hour [scan $hour %d]
    set dow [scan $dow %d]

    if {$target eq "NOW"} {
        set res_sec [clock add $sec 2 hours]
        return [clock format $res_sec -format "%Y-%m-%dT%H:%M:%S"]
    }

    if {$target eq "ASAP"} {
        if {$hour < 13} {
            set res_sec [clock scan [format "%04d-%02d-%02d 17:00:00" $year $month $day] -format "%Y-%m-%d %H:%M:%S"]
        } else {
            set tomorrow [clock add $sec 1 day]
            lassign [clock format $tomorrow -format "%Y %m %d"] ty tm td
            set res_sec [clock scan [format "%s-%s-%s 13:00:00" $ty $tm $td] -format "%Y-%m-%d %H:%M:%S"]
        }
        return [clock format $res_sec -format "%Y-%m-%dT%H:%M:%S"]
    }

    if {$target eq "EOW"} {
        if {$dow <= 3} {
            set diff [expr {5 - $dow}]
            set t_sec [clock add $sec $diff days]
            lassign [clock format $t_sec -format "%Y %m %d"] ty tm td
            set res_sec [clock scan [format "%s-%s-%s 17:00:00" $ty $tm $td] -format "%Y-%m-%d %H:%M:%S"]
        } else {
            set diff [expr {7 - $dow}]
            set t_sec [clock add $sec $diff days]
            lassign [clock format $t_sec -format "%Y %m %d"] ty tm td
            set res_sec [clock scan [format "%s-%s-%s 20:00:00" $ty $tm $td] -format "%Y-%m-%d %H:%M:%S"]
        }
        return [clock format $res_sec -format "%Y-%m-%dT%H:%M:%S"]
    }

    if {[regexp {^(\d+)M$} $target -> n]} {
        set n [scan $n %d]
        set target_year [expr {$month < $n ? $year : $year + 1}]

        set d1_sec [clock scan [format "%04d-%02d-01 08:00:00" $target_year $n] -format "%Y-%m-%d %H:%M:%S"]
        set d1_dow [clock format $d1_sec -format "%u"]

        if {$d1_dow == 6} {
            set d1_sec [clock add $d1_sec 2 days]
        } elseif {$d1_dow == 7} {
            set d1_sec [clock add $d1_sec 1 day]
        }
        return [clock format $d1_sec -format "%Y-%m-%dT%H:%M:%S"]
    }

    if {[regexp {^Q(\d+)$} $target -> q]} {
        set q [scan $q %d]
        set cur_q [expr {($month - 1) / 3 + 1}]
        set target_year [expr {$cur_q <= $q ? $year : $year + 1}]

        set last_month [expr {$q * 3}]
        set last_day [expr {$last_month in {3 12} ? 31 : 30}]

        set dl_sec [clock scan [format "%04d-%02d-%02d 08:00:00" $target_year $last_month $last_day] -format "%Y-%m-%d %H:%M:%S"]
        set dl_dow [clock format $dl_sec -format "%u"]

        if {$dl_dow == 6} {
            set dl_sec [clock add $dl_sec -1 day]
        } elseif {$dl_dow == 7} {
            set dl_sec [clock add $dl_sec -2 days]
        }
        return [clock format $dl_sec -format "%Y-%m-%dT%H:%M:%S"]
    }

    error "Invalid target"
}
