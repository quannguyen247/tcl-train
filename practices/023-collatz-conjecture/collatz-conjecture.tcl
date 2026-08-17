proc steps {number} {
    if {$number <= 0} {
        error "Only positive integers are allowed"
    }

    set count 0
    while {$number > 1} {
        incr count
        if {$number % 2 == 0} {
            set number [expr {$number / 2}]
        } else {
            set number [expr {$number * 3 + 1}]
        }
    }

    return $count
}
