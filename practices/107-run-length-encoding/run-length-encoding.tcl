proc encode {text} {
    set res ""
    set count 0; set current ""
    foreach char [split $text ""] {
        if {$char eq $current} {
            incr count
        } else {
            if {$count > 1} { append res $count }
            if {$count > 0} { append res $current }
            set current $char; set count 1
        }
    }
    if {$count > 1} { append res $count }
    if {$count > 0} { append res $current }
    return $res
}

proc decode {text} {
    set res ""
    set count ""
    foreach char [split $text ""] {
        if {[string is integer $char]} {
            append count $char
        } else {
            if {$count eq ""} { set count 1 }
            append res [string repeat $char $count]
            set count ""
        }
    }
    return $res
}
