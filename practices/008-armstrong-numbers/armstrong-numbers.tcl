proc isArmstrongNumber {number} {
    set digits [split $number ""]
    set len [llength $digits]
    set sum 0
    foreach d $digits {
        set sum [expr {$sum + wide($d) ** $len}]
    }
    return [expr {$sum == $number}]
}
