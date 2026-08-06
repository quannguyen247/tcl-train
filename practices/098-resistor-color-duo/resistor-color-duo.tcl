namespace eval ::resistorColor {
    variable colors {
        black brown red orange yellow
        green blue violet grey white
    }

    proc value {first second args} {
        variable colors

        set firstValue [lsearch -exact $colors $first]
        set secondValue [lsearch -exact $colors $second]

        if {$firstValue < 0 || $secondValue < 0} {
            error "Invalid color"
        }

        return [expr {$firstValue * 10 + $secondValue}]
    }
}
