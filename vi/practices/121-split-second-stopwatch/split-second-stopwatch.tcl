# ==============================================================================
# EXERCISM TCL PRACTICE: SPLIT-SECOND-STOPWATCH
# ==============================================================================
# # Instructions
#
# Your task is to build a stopwatch to keep precise track of lap times.
#
# The stopwatch uses four commands (start, stop, lap, and reset) to keep track of:
#
# 1. The current lap's tracked time
# 2. Previously recorded lap times
#
# What commands can be used depends on which state the stopwatch is in:
#
# 1. Ready: initial state
# 2. Running: tracking time
# 3. Stopped: not tracking time
#
# | Command | Begin state | End state | Effect                                                   |
# | ------- | ----------- | --------- | -------------------------------------------------------- |
# | Start   | Ready       | Running   | Start tracking time                                      |
# | Start   | Stopped     | Running   | Resume tracking time                                     |
# | Stop    | Running     | Stopped   | Stop tracking time                                       |
# | Lap     | Running     | Running   | Add current lap to previous laps, then reset current lap |
# | Reset   | Stopped     | Ready     | Reset current lap and clear previous laps                |

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create Stopwatch {
    variable status started current total previous

    constructor {} {
        # current và total lưu số giây đã chốt
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

        # Chốt lap hiện tại rồi bắt đầu lap mới
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
        # Khi đang chạy, cộng phần thời gian chưa chốt
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

