oo::class create Stopwatch {
    variable status started current total previous

    constructor {} {
        set status ready
        set started 0
        set current 0
        set total 0
        set previous {}
    }

    method reset {} {
        if {$status ne "stopped"} {
            error "cannot reset a stopwatch that is not stopped"
        }

        set status ready
        set current 0
        set total 0
        set previous {}
    }

    method state {} {
        return $status
    }

    method start {} {
        if {$status eq "running"} {
            error "cannot start an already running stopwatch"
        }

        set started [clock seconds]
        set status running
    }

    method stop {} {
        if {$status ne "running"} {
            error "cannot stop a stopwatch that is not running"
        }

        set elapsed [expr {[clock seconds] - $started}]
        incr current $elapsed
        incr total $elapsed
        set status stopped
    }

    method lap {} {
        if {$status ne "running"} {
            error "cannot lap a stopwatch that is not running"
        }

        set elapsed [expr {[clock seconds] - $started}]
        incr current $elapsed
        incr total $elapsed
        lappend previous [my formatTime $current]
        set current 0
        set started [clock seconds]
    }

    method total {} {
        return [my formatTime [my elapsed $total]]
    }

    method currentLap {} {
        return [my formatTime [my elapsed $current]]
    }

    method previousLaps {} {
        return $previous
    }

    method elapsed {seconds} {
        if {$status eq "running"} {
            return [expr {$seconds + [clock seconds] - $started}]
        }
        return $seconds
    }

    method formatTime {seconds} {
        return [format "%02d:%02d:%02d" \
            [expr {$seconds / 3600}] \
            [expr {$seconds / 60 % 60}] \
            [expr {$seconds % 60}]]
    }
}
