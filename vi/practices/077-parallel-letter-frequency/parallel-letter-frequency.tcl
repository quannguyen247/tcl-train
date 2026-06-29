# ==============================================================================
# EXERCISM TCL PRACTICE: PARALLEL-LETTER-FREQUENCY
# ==============================================================================
# # Instructions
#
# Count the frequency of letters in texts using parallel computation.
#
# Parallelism is about doing things in parallel that can also be done sequentially.
# A common example is counting the frequency of letters.
# Employ parallelism to calculate the total frequency of each letter in a list of texts.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc calculate {input} {
    set result {}

    # Chỉ đếm chữ cái, không phân biệt hoa thường
    foreach text $input {
        foreach letter [split [string tolower $text] ""] {
            if {[string is alpha -strict $letter]} {
                dict incr result $letter
            }
        }
    }
    return $result
}

