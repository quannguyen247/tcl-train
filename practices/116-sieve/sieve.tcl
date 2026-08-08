proc primes {limit} {
    set res {}
    if {$limit < 2} { return {} }
    set is_prime [lrepeat [expr {$limit + 1}] 1]
    for {set i 2} {$i <= $limit} {incr i} {
        if {[lindex $is_prime $i]} {
            lappend res $i
            for {set j [expr {$i * $i}]} {$j <= $limit} {incr j $i} {
                lset is_prime $j 0
            }
        }
    }
    return $res
}
