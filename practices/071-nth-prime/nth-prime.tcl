proc nthPrime {n} {
    if {$n <= 0} { return -code error "there is no zeroth prime" }
    set primes {}
    set i 2
    while {[llength $primes] < $n} {
        set isPrime 1
        foreach p $primes {
            if {$p * $p > $i} break
            if {$i % $p == 0} { set isPrime 0; break }
        }
        if {$isPrime} { lappend primes $i }
        incr i
    }
    return [lindex $primes end]
}
