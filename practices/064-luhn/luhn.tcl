proc luhn {digits} {
    set cleaned_digits [string map {" " ""} $digits]

    if {[string length $cleaned_digits] <= 1 || ![regexp {^[0-9]+$} $cleaned_digits]} {
        return false
    }

    set rev [string reverse $cleaned_digits]
    set sum 0

    for {set i 0} {$i < [string length $rev]} {incr i} {
        set d [string index $rev $i]

        if {$i % 2 == 1} {
            set d [expr {$d * 2}]
            if {$d > 9} {
                set d [expr {$d - 9}]
            }
        }

        incr sum $d
    }

    return [expr {$sum % 10 == 0}]
}
