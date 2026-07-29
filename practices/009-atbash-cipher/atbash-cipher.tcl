namespace eval atbash {
    namespace export encode decode
    namespace ensemble create

    proc encode {phrase} {
        set result ""
        foreach char [split [string tolower $phrase] ""] {
            if {[string is alpha $char]} {
                append result [format %c [expr {219 - [scan $char %c]}]]
            } elseif {[string is digit $char]} {
                append result $char
            }
        }
        return [join [regexp -all -inline {.{1,5}} $result] " "]
    }

    proc decode {cipher} {
        set result ""
        foreach char [split [string tolower $cipher] ""] {
            if {[string is alpha $char]} {
                append result [format %c [expr {219 - [scan $char %c]}]]
            } elseif {[string is digit $char]} {
                append result $char
            }
        }
        return $result
    }
}
