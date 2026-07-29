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




proc steps {n} {
    if {$n <= 0} {
        error "Only positive integers are allowed"
    }
    set count 0
    while {$n > 1} {
        if {$n % 2 == 0} {
            set n [expr {$n / 2}]
        } else {
            set n [expr {3 * $n + 1}]
        }
        incr count
    }
    return $count
}
