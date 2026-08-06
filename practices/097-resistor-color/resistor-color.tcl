namespace eval resistorColor {

    variable colorList {black brown red orange yellow green blue violet grey white}

    proc colorCode {color} {
        variable colorList

        set index [lsearch -exact $colorList $color]

        if {$index == -1} {
            error "Invalid color: $color"
        }

        return $index
    }

    proc colors {} {
        variable colorList

        return $colorList
    }
}
