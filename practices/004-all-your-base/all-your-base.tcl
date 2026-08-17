proc rebase {inputBase digits outputBase} {
    if {$inputBase < 2} { error "input base must be >= 2" }
    if {$outputBase < 2} { error "output base must be >= 2" }

    set decimal 0
    foreach digit $digits {
        if {$digit < 0 || $digit >= $inputBase} {
            error "all digits must satisfy 0 <= d < input base"
        }
        set decimal [expr {$decimal * $inputBase + $digit}]
    }

    if {$decimal == 0} {
        return {0}
    }

    set result {}
    while {$decimal > 0} {
        set remainder [expr {$decimal % $outputBase}]
        set result [linsert $result 0 $remainder]
        set decimal [expr {$decimal / $outputBase}]
    }

    return $result
}
