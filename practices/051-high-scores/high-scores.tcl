oo::class create HighScores {
    variable history

    constructor {} {
        set history {}
    }

    method addScores {args} {
        lappend history {*}$args
    }

    method scores {} {
        return $history
    }

    method latest {} {
        return [lindex $history end]
    }

    method personalBest {} {
        return [lindex [lsort -integer $history] end]
    }

    method topThree {} {
        return [lrange [lsort -integer -decreasing $history] 0 2]
    }
}
