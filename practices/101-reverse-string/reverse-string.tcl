proc reverse {input} {
    set res ""
    foreach char [split $input ""] {
        set res "$char$res"
    }
    return $res
}
