# ==============================================================================
# EXERCISM TCL PRACTICE: GRAINS
# ==============================================================================
# # Instructions
#
# Calculate the number of grains of wheat on a chessboard.
#
# A chessboard has 64 squares.
# Square 1 has one grain, square 2 has two grains, square 3 has four grains, and so on, doubling each time.
#
# Write code that calculates:
#
# - the number of grains on a given square
# - the total number of grains on the chessboard

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

namespace eval grains {
    namespace export square total

    # This turns the namespace name "grains" into
    # the _command_ "grains", with subcommands
    # "square" and "total":
    namespace ensemble create

    proc square {square} {
        return {}
    }

    proc total {} {
        return {}
    }
}

