proc flatten {input} {
    set result {}

    foreach item $input {
        if {$item eq ""} {
            continue
        }

        set size [llength $item]

        if {$size > 1 || ($size == 1 && [lindex $item 0] ne $item)} {
            lappend result {*}[flatten $item]
        } else {
            lappend result $item
        }
    }

    return $result
}
