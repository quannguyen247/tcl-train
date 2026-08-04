proc convert {rows} {
    if {[llength $rows] % 4 != 0} {
        return -code error "Number of input lines is not a multiple of four"
    }
    set result {}
    set first 1
    foreach {r1 r2 r3 r4} $rows {
        if {[string length $r1] % 3 != 0} {
            return -code error "Number of input columns is not a multiple of three"
        }
        if {!$first} { append result "," }
        set first 0
        set cols [string length $r1]
        for {set c 0} {$c < $cols} {incr c 3} {
            set digit [string range $r1 $c $c+2]
            append digit [string range $r2 $c $c+2]
            append digit [string range $r3 $c $c+2]
            append digit [string range $r4 $c $c+2]

            switch -exact -- $digit {
                " _ | ||_|   " { append result "0" }
                "     |  |   " { append result "1" }
                " _  _||_    " { append result "2" }
                " _  _| _|   " { append result "3" }
                "   |_|  |   " { append result "4" }
                " _ |_  _|   " { append result "5" }
                " _ |_ |_|   " { append result "6" }
                " _   |  |   " { append result "7" }
                " _ |_||_|   " { append result "8" }
                " _ |_| _|   " { append result "9" }
                default { append result "?" }
            }
        }
    }
    return $result
}
