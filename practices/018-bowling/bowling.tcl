oo::class create Bowling {
    variable rolls

    constructor {} {
        set rolls {}
    }

    method roll {pins} {
        if {$pins < 0 || $pins > 10} {
            error "Pins must have a raw value conformant to the game rules"
        }
        if {[my isGameOver]} {
            error "Cannot roll after game is over"
        }
        set frame_rolls [my getFrameRolls]
        if {[llength $frame_rolls] == 1} {
            set prev [lindex $frame_rolls 0]
            if {$prev < 10 && [expr {$prev + $pins}] > 10} {
                error "Pin count exceeds pins on the lane"
            }
        }
        lappend rolls $pins
    }

    method getFrameRolls {} {
        set r $rolls
        set frame 1
        while {[llength $r] > 0 && $frame < 10} {
            set first [lindex $r 0]
            if {$first == 10} {
                set r [lrange $r 1 end]
            } else {
                set r [lrange $r 2 end]
            }
            incr frame
        }
        return $r
    }

    method isGameOver {} {
        set r $rolls
        set frame 1
        while {[llength $r] > 0 && $frame <= 10} {
            set first [lindex $r 0]
            if {$frame < 10} {
                if {$first == 10} {
                    set r [lrange $r 1 end]
                } else {
                    if {[llength $r] < 2} { return false }
                    set r [lrange $r 2 end]
                }
            } else {
                if {$first == 10} {
                    if {[llength $r] < 3} { return false }
                    set bonus1 [lindex $r 1]
                    set bonus2 [lindex $r 2]
                    if {$bonus1 < 10 && [expr {$bonus1 + $bonus2}] > 10} {
                        error "Pin count exceeds pins on the lane"
                    }
                    return true
                } else {
                    if {[llength $r] < 2} { return false }
                    set second [lindex $r 1]
                    if {[expr {$first + $second}] == 10} {
                        return [expr {[llength $r] >= 3}]
                    } else {
                        return true
                    }
                }
            }
            incr frame
        }
        return false
    }

    method score {} {
        if {![my isGameOver]} {
            error "Score cannot be taken until the end of the game"
        }
        set total 0
        set idx 0
        for {set frame 1} {$frame <= 10} {incr frame} {
            set first [lindex $rolls $idx]
            if {$first == 10} {
                set b1 [lindex $rolls [expr {$idx + 1}]]
                set b2 [lindex $rolls [expr {$idx + 2}]]
                set total [expr {$total + 10 + $b1 + $b2}]
                incr idx 1
            } else {
                set second [lindex $rolls [expr {$idx + 1}]]
                if {[expr {$first + $second}] == 10} {
                    set b1 [lindex $rolls [expr {$idx + 2}]]
                    set total [expr {$total + 10 + $b1}]
                } else {
                    set total [expr {$total + $first + $second}]
                }
                incr idx 2
            }
        }
        return $total
    }
}
