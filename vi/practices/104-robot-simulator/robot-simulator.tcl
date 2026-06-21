# ==============================================================================
# EXERCISM TCL PRACTICE: ROBOT-SIMULATOR
# ==============================================================================
# # Instructions
#
# Write a robot simulator.
#
# A robot factory's test facility needs a program to verify robot movements.
#
# The robots have three possible movements:
#
# - turn right
# - turn left
# - advance
#
# Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates,
# e.g., {3,8}, with coordinates increasing to the north and east.
#
# The robot then receives a number of instructions, at which point the testing facility verifies the robot's new position, and in which direction it is pointing.
#
# - The letter-string "RAALAL" means:
#   - Turn right
#   - Advance twice
#   - Turn left
#   - Advance once
#   - Turn left yet again
# - Say a robot starts at {7, 3} facing north.
#   Then running this stream of instructions should leave it at {9, 4} facing west.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create Robot {
    variable x y direction

    constructor {args} {
        set config [dict merge \
            {x 0 y 0 direction north} {*}$args]
        set x [dict get $config x]
        set y [dict get $config y]
        set direction [dict get $config direction]
    }

    # Lấy vị trí và hướng hiện tại
    method position {} {
        return [dict create x $x y $y direction $direction]
    }

    method move {instructions} {
        set directions {north east south west}
        set steps {
            north {0 1}
            east {1 0}
            south {0 -1}
            west {-1 0}
        }

        foreach instruction [split $instructions ""] {
            set index [lsearch -exact $directions $direction]

            switch -- $instruction {
                R {
                    # Quay sang hướng bên phải
                    set direction [lindex $directions \
                        [expr {($index + 1) % 4}]]
                }
                L {
                    # Quay sang hướng bên trái
                    set direction [lindex $directions \
                        [expr {($index + 3) % 4}]]
                }
                A {
                    # Tiến một ô theo hướng hiện tại
                    lassign [dict get $steps $direction] dx dy
                    incr x $dx
                    incr y $dy
                }
                default {
                    error "invalid instruction: $instruction"
                }
            }
        }

        return [my position]
    }
}

