proc reverse {input} {
    set res ""
    # Split the string into characters and iterate
    foreach char [split $input ""] {
        set res "$char$res"
    }
    return $res
}