proc translateWord {word} {
    if {[regexp {^([aeiou]|xr|yt)} $word]} {
        return "${word}ay"
    }
    if {[regexp {^([^aeiou]*qu)(.*)} $word match cons rest]} {
        return "${rest}${cons}ay"
    }
    if {[regexp {^([^aeiou]+)(y.*)} $word match cons rest]} {
        return "${rest}${cons}ay"
    }
    if {[regexp {^([^aeiou]+)(.*)} $word match cons rest]} {
        return "${rest}${cons}ay"
    }
    return $word
}

proc translate {sentence} {
    set out {}
    foreach w [split $sentence] {
        lappend out [translateWord $w]
    }
    return [join $out " "]
}
