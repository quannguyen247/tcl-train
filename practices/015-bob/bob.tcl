proc heyBob {stimulus} {
    set s [string trim $stimulus]
    if {$s eq ""} {
        return "Fine. Be that way!"
    }
    set is_yelling [expr {[regexp {[A-Z]} $s] && ![regexp {[a-z]} $s]}]
    set is_question [expr {[string match "*\?" $s]}]
    if {$is_yelling && $is_question} {
        return "Calm down, I know what I'm doing!"
    }
    if {$is_yelling} {
        return "Whoa, chill out!"
    }
    if {$is_question} {
        return "Sure."
    }
    return "Whatever."
}
