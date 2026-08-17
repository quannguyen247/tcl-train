proc parse_inline {line} {
    set line [regsub -all {__(.*?)__} $line {<strong>\1</strong>}]

    set line [regsub -all {_(.*?)_} $line {<em>\1</em>}]

    return $line
}

proc parse {markdownText} {
    set html ""
    set in_list false

    foreach line [split $markdownText "\n"] {
        set line [parse_inline $line]

        if {[regexp {^(#{1,6})\s+(.*)} $line -> hashes title]} {
            if {$in_list} {
                append html "</ul>"
                set in_list false
            }
            set level [string length $hashes]
            append html "<h$level>$title</h$level>"

        } elseif {[regexp {^\*\s+(.*)} $line -> item]} {
            if {!$in_list} {
                append html "<ul>"
                set in_list true
            }
            append html "<li>$item</li>"

        } else {
            if {$in_list} {
                append html "</ul>"
                set in_list false
            }
            append html "<p>$line</p>"
        }
    }

    if {$in_list} {
        append html "</ul>"
    }

    return $html
}
