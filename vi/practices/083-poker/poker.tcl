# ==============================================================================
# EXERCISM TCL PRACTICE: POKER
# ==============================================================================
# # Instructions
#
# Pick the best hand(s) from a list of poker hands.
#
# See [Wikipedia][poker-hands] for an overview of poker hands.
#
# [poker-hands]: https://en.wikipedia.org/wiki/List_of_poker_hands

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc bestHands {hands} {
    set winners {}
    set best {}

    foreach hand $hands {
        set score [::poker::score $hand]

        if {$winners eq {}} {
            set winners [list $hand]
            set best $score
            continue
        }

        set compare [::poker::compare $score $best]
        if {$compare > 0} {
            set winners [list $hand]
            set best $score
        } elseif {$compare == 0} {
            lappend winners $hand
        }
    }

    return $winners
}

namespace eval ::poker {
    variable ranks {2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 J 11 Q 12 K 13 A 14}

    proc score {hand} {
        variable ranks
        set values {}
        set suits {}
        set counts {}

        foreach card $hand {
            set value [dict get $ranks [string range $card 0 end-1]]
            lappend values $value
            lappend suits [string index $card end]
            dict incr counts $value
        }

        set values [lsort -integer -decreasing $values]
        set unique [lsort -integer -unique $values]
        set flush [expr {[llength [lsort -unique $suits]] == 1}]
        set straight 0
        set high 0

        # A có thể đứng trước 2 trong sảnh A-2-3-4-5
        if {$unique eq {2 3 4 5 14}} {
            set straight 1
            set high 5
        } elseif {[llength $unique] == 5
            && [lindex $unique end] - [lindex $unique 0] == 4} {
            set straight 1
            set high [lindex $unique end]
        }

        set groups {}
        dict for {value count} $counts {
            lappend groups [list $count $value]
        }

        # Nhóm theo số lá giống nhau, rồi theo giá trị lá
        set groups [lsort -integer -decreasing -index 1 $groups]
        set groups [lsort -integer -decreasing -index 0 $groups]

        if {$straight && $flush} {
            return [list 8 $high]
        }
        if {[lindex $groups 0 0] == 4} {
            return [list 7 [lindex $groups 0 1] [lindex $groups 1 1]]
        }
        if {[lindex $groups 0 0] == 3 && [lindex $groups 1 0] == 2} {
            return [list 6 [lindex $groups 0 1] [lindex $groups 1 1]]
        }
        if {$flush} {
            return [linsert $values 0 5]
        }
        if {$straight} {
            return [list 4 $high]
        }
        if {[lindex $groups 0 0] == 3} {
            return [list 3 [lindex $groups 0 1] \
                [lindex $groups 1 1] [lindex $groups 2 1]]
        }
        if {[lindex $groups 0 0] == 2 && [lindex $groups 1 0] == 2} {
            return [list 2 [lindex $groups 0 1] \
                [lindex $groups 1 1] [lindex $groups 2 1]]
        }
        if {[lindex $groups 0 0] == 2} {
            return [list 1 [lindex $groups 0 1] \
                [lindex $groups 1 1] [lindex $groups 2 1] [lindex $groups 3 1]]
        }

        return [linsert $values 0 0]
    }

    proc compare {first second} {
        # Score đứng trước quyết định loại bài mạnh hơn
        foreach left $first right $second {
            if {$left != $right} {
                return [expr {$left > $right ? 1 : -1}]
            }
        }
        return 0
    }
}

