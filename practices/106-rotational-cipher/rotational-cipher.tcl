proc rotate {text shift} {
    set shift [expr {$shift % 26}]
    set mapping {}

    foreach alphabet {
        abcdefghijklmnopqrstuvwxyz
        ABCDEFGHIJKLMNOPQRSTUVWXYZ
    } {
        set rotated [string range "$alphabet$alphabet" \
            $shift [expr {$shift + 25}]]

        foreach old [split $alphabet ""] new [split $rotated ""] {
            lappend mapping $old $new
        }
    }

    return [string map $mapping $text]
}
