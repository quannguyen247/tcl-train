proc rebase {inputBase digits outputBase} {
    if {$inputBase < 2} { error "input base must be >= 2" }
    if {$outputBase < 2} { error "output base must be >= 2" }
    set decimal 0
    foreach d $digits {
        if {$d < 0 || $d >= $inputBase} { error "all digits must satisfy 0 <= d < input base" }
        set decimal [expr {$decimal * $inputBase + $d}]
    }
    if {$decimal == 0} { return {0} }
    set res {}
    while {$decimal > 0} {
        set rem [expr {$decimal % $outputBase}]
        set res [linsert $res 0 $rem]
        set decimal [expr {$decimal / $outputBase}]
    }
    return $res
}
