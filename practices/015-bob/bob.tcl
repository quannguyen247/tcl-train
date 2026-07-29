proc heyBob {stimulus} {
    set s [string trim $stimulus]
    if {$s eq ""} { return "Fine. Be that way!" }
    set question [string match {*\?} $s]
    set hasAlpha [regexp {[[:alpha:]]} $s]
    set yelling [expr {$hasAlpha && $s eq [string toupper $s]}]
    if {$yelling && $question} { return "Calm down, I know what I'm doing!" }
    if {$yelling} { return "Whoa, chill out!" }
    if {$question} { return "Sure." }
    return "Whatever."
}
