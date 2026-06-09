# ==============================================================================
# EXERCISM TCL PRACTICE: GIGASECOND
# ==============================================================================
# # Instructions
#
# Your task is to determine the date and time one gigasecond after a certain date.
#
# A gigasecond is one thousand million seconds.
# That is a one with nine zeros after it.
#
# If you were born on _January 24th, 2015 at 22:00 (10:00:00pm)_, then you would be a gigasecond old on _October 2nd, 2046 at 23:46:40 (11:46:40pm)_.

# ==============================================================================
# ALGORITHM & TCL SYNTAX NOTES
# ==============================================================================
# 1. `clock scan $datetime -timezone UTC`:
#    - Parses the input datetime ISO string into POSIX seconds.
#
# 2. `expr {$seconds + 1000000000}`:
#    - Adds exactly 1 Gigasecond (1,000,000,000 seconds).
#
# 3. `clock format $future_seconds -format "%Y-%m-%dT%H:%M:%S" -timezone UTC`:
#    - Formats the target timestamp back to ISO 8601 string representation.
# ==============================================================================

proc addGigasecond {datetime} {
    set current_seconds [clock scan $datetime -timezone UTC]
    set future_seconds [expr {$current_seconds + 1000000000}]
    return [clock format $future_seconds -format "%Y-%m-%dT%T" -timezone UTC]
}
