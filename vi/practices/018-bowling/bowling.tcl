# ==============================================================================
# EXERCISM TCL PRACTICE: BOWLING
# ==============================================================================
# # Instructions
#
# Score a bowling game.
#
# Bowling is a game where players roll a heavy ball to knock down pins arranged in a triangle.
# Write code to keep track of the score of a game of bowling.
#
# ## Scoring Bowling
#
# The game consists of 10 frames.
# A frame is composed of one or two ball throws with 10 pins standing at frame initialization.
# There are three cases for the tabulation of a frame.
#
# - An open frame is where a score of less than 10 is recorded for the frame.
#   In this case the score for the frame is the number of pins knocked down.
#
# - A spare is where all ten pins are knocked down by the second throw.
#   The total value of a spare is 10 plus the number of pins knocked down in their next throw.
#
# - A strike is where all ten pins are knocked down by the first throw.
#   The total value of a strike is 10 plus the number of pins knocked down in the next two throws.
#   If a strike is immediately followed by a second strike, then the value of the first strike cannot be determined until the ball is thrown one more time.
#
# Here is a three frame example:
#
# |  Frame 1   |  Frame 2   |     Frame 3      |
# | :--------: | :--------: | :--------------: |
# | X (strike) | 5/ (spare) | 9 0 (open frame) |
#
# Frame 1 is (10 + 5 + 5) = 20
#
# Frame 2 is (5 + 5 + 9) = 19
#
# Frame 3 is (9 + 0) = 9
#
# This means the current running total is 48.
#
# The tenth frame in the game is a special case.
# If someone throws a spare or a strike then they get one or two fill balls respectively.
# Fill balls exist to calculate the total of the 10th frame.
# Scoring a strike or spare on the fill ball does not give the player more fill balls.
# The total value of the 10th frame is the total number of pins knocked down.
#
# For a tenth frame of X1/ (strike and a spare), the total value is 20.
#
# For a tenth frame of XXX (three strikes), the total value is 30.
#
# ## Requirements
#
# Write code to keep track of the score of a game of bowling.
# It should support two operations:
#
# - `roll(pins : int)` is called each time the player rolls a ball.
#   The argument is the number of pins knocked down.
# - `score() : int` is called only at the very end of the game.
#   It returns the total score for that game.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create Bowling {
    variable rolls

    constructor {} {
        set rolls {}
    }

    # Nhận một lượt ném
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

    # Tìm frame hiện tại
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

    # Kiểm tra game đã đủ 10 frame
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

    # Tính điểm và cộng bonus
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
