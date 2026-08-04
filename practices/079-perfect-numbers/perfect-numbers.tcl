proc classify {number} {
    if {$number <= 0} {
        error "Classification is only possible for positive integers."
    }
    set sum 0
    for {set i 1} {$i <= $number / 2} {incr i} {
        if {$number % $i == 0} { incr sum $i }
    }
    if {$sum == $number} { return "perfect" }
    if {$sum > $number} { return "abundant" }
    return "deficient"
}
