proc recite {from to} {
    set animals {fly spider bird cat dog goat cow horse}
    set actions {
        ""
        "It wriggled and jiggled and tickled inside her."
        "How absurd to swallow a bird!"
        "Imagine that, to swallow a cat!"
        "What a hog, to swallow a dog!"
        "Just opened her throat and swallowed a goat!"
        "I don't know how she swallowed a cow!"
        "She's dead, of course!"
    }
    set res {}
    for {set i $from} {$i <= $to} {incr i} {
        set idx [expr {$i - 1}]
        set animal [lindex $animals $idx]
        set verse "I know an old lady who swallowed a $animal.\n"
        if {$idx == 7} {
            append verse [lindex $actions $idx] "\n"
        } else {
            if {$idx > 0} {
                append verse [lindex $actions $idx] "\n"
                for {set j $idx} {$j > 0} {incr j -1} {
                    set curr [lindex $animals $j]
                    set prev [lindex $animals [expr {$j - 1}]]
                    append verse "She swallowed the $curr to catch the $prev"
                    if {$prev eq "spider"} {
                        append verse " that wriggled and jiggled and tickled inside her.\n"
                    } else {
                        append verse ".\n"
                    }
                }
            }
            append verse "I don't know why she swallowed the fly. Perhaps she'll die.\n"
        }
        lappend res [string trimright $verse \n]
    }
    return [join $res "\n\n"]
}
