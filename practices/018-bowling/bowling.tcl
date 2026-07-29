oo::class create Bowling {
    variable rolls

    constructor {} {
        set rolls {}
    }

    method roll {pins} {
        if {$pins < 0} {error "Negative roll is invalid"}
        if {$pins > 10} {error "Pin count exceeds pins on the lane"}
        if {[my isGameOver]} {
            error "Cannot roll after game is over"
        }

        lassign [my currentFrame] frame frameRolls
        if {([llength $frameRolls] == 1
             && [lindex $frameRolls 0] < 10
             && [expr {[lindex $frameRolls 0] + $pins}] > 10)
            || ([llength $frameRolls] == 2
                && [lindex $frameRolls 0] == 10
                && [lindex $frameRolls 1] < 10
                && [expr {[lindex $frameRolls 1] + $pins}] > 10)} {
            error "Pin count exceeds pins on the lane"
        }

        lappend rolls $pins
    }

    method currentFrame {} {
        set remaining $rolls
        set frame 1

        while {$frame < 10 && [llength $remaining] > 0} {
            set first [lindex $remaining 0]

            if {$first == 10} {
                set remaining [lrange $remaining 1 end]
            } elseif {[llength $remaining] >= 2} {
                set remaining [lrange $remaining 2 end]
            } else {
                break
            }

            incr frame
        }

        return [list $frame $remaining]
    }

    method isGameOver {} {
        lassign [my currentFrame] frame frameRolls

        if {$frame < 10 || [llength $frameRolls] < 2} {
            return false
        }

        if {[lindex $frameRolls 0] == 10} {
            return [expr {[llength $frameRolls] >= 3}]
        }

        if {[expr {[lindex $frameRolls 0] + [lindex $frameRolls 1]}] == 10} {
            return [expr {[llength $frameRolls] >= 3}]
        }

        return true
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
                incr idx
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
