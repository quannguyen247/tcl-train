proc isPangram {text} {
    set text [string tolower $text]
    foreach c [split "abcdefghijklmnopqrstuvwxyz" ""] {
        if {[string first $c $text] == -1} {
            return false
        }
    }
    return true
}
