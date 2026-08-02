proc isIsogram {input} {
    set seen {}

    foreach char [split [string tolower $input] ""] {

        if {$char eq " " || $char eq "-"} {
            continue
        }

        if {[dict exists $seen $char]} {
            return false
        }

        dict set seen $char 1
    }

    return true
}
