proc slices {series length} {
    set str_len [string length $series]

    if {$series eq ""} {
        error "series cannot be empty"
    }
    if {$length > $str_len} {
        error "slice length cannot be greater than series length"
    }
    if {$length == 0} {
        error "slice length cannot be zero"
    }
    if {$length < 0} {
        error "slice length cannot be negative"
    }

    set result {}
    for {set i 0} {$i <= [expr {$str_len - $length}]} {incr i} {
        lappend result [string range $series $i [expr {$i + $length - 1}]]
    }

    return $result
}
