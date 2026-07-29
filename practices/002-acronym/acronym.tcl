proc abbreviate {phrase} {
    set clean [regsub -all {[-_]} $phrase " "]
    set words [split $clean " "]
    set result ""
    foreach word $words {
        set word [string trim $word]
        if {$word ne ""} {
            append result [string toupper [string index $word 0]]
        }
    }
    return $result
}
