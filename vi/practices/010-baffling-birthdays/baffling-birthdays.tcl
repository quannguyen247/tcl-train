# ==============================================================================
# EXERCISM TCL PRACTICE: BAFFLING-BIRTHDAYS
# ==============================================================================
# # Instructions
#
# Your task is to estimate the birthday paradox's probabilities.
#
# To do this, you need to:
#
# - Generate random birthdates.
# - Check if a collection of randomly generated birthdates contains at least two with the same birthday.
# - Estimate the probability that at least two people in a group share the same birthday for different group sizes.
#
# ~~~~exercism/note
# A birthdate includes the full date of birth (year, month, and day), whereas a birthday refers only to the month and day, which repeat each year.
# Two birthdates with the same month and day correspond to the same birthday.
# ~~~~
#
# ~~~~exercism/caution
# The birthday paradox assumes that:
#
# - There are 365 possible birthdays (no leap years).
# - Each birthday is equally likely (uniform distribution).
#
# Your implementation must follow these assumptions.
# ~~~~

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc sharedBirthday {birthdays} {
    array set seen {}
    foreach b $birthdays {
        set md [string range $b 5 9]
        if {[info exists seen($md)]} {
            return true
        }
        set seen($md) 1
    }
    return false
}

proc randomBirthdates {count} {
    set res {}

    # Chọn đều một trong 365 ngày của năm không nhuận
    for {set i 0} {$i < $count} {incr i} {
        set year [expr {2001 + int(rand() * 3)}]
        set day [expr {int(rand() * 365) + 1}]
        lappend res [clock format \
            [clock scan "$year-$day" -format {%Y-%j}] -format %Y-%m-%d]
    }
    return $res
}

proc estimatedProbabilityOfSharedBirthday {size} {
    set distinct 1.0
    for {set i 0} {$i < $size} {incr i} {
        set distinct [expr {$distinct * (365.0 - $i) / 365.0}]
    }
    return [expr {100 * (1 - $distinct)}]
}
