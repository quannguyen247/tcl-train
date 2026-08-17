package require Thread

proc calculate {input} {
    set result {}

    # Only count letters, case insensitive
    foreach text $input {
        foreach letter [split [string tolower $text] ""] {
            if {[string is alpha -strict $letter]} {
                dict incr result $letter
            }
        }
    }
    return $result
}