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

#! tclsh

oo::class create HighScores {

    method addScores {args} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method scores {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method latest {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
    
    method personalBest {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }

    method topThree {} {
        throw {NOT_IMPLEMENTED} "Implement this method."
    }
}

