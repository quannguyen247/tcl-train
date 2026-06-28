# ==============================================================================
# EXERCISM TCL PRACTICE: HIGH-SCORES
# ==============================================================================
# # Instructions
#
# Manage a game player's High Score list.
#
# Your task is to build a high-score component of the classic Frogger game, one of the highest selling and most addictive games of all time, and a classic of the arcade era.
# Your task is to write methods that return the highest score from the list, the last added score and the three highest scores.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create HighScores {
    variable history

    constructor {} {
        set history {}
    }

    method addScores {args} {
        # Thêm điểm mới, giữ nguyên thứ tự
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
        # Sắp xếp giảm dần rồi lấy tối đa ba điểm
        return [lrange [lsort -integer -decreasing $history] 0 2]
    }
}

