proc formatTicket {name number} {

    set last2 [expr {$number % 100}]

    if {$last2 == 11 || $last2 == 12 || $last2 == 13} {
        set suffix "th"
    } else {
        set last [expr {$number % 10}]

        if {$last == 1} {
            set suffix "st"
        } elseif {$last == 2} {
            set suffix "nd"
        } elseif {$last == 3} {
            set suffix "rd"
        } else {
            set suffix "th"
        }
    }

    return "$name, you are the ${number}${suffix} customer we serve today. Thank you!"
}
