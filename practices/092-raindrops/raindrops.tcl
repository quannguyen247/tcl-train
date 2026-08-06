proc raindrops {number} {
    set result ""

    foreach {factor sound} {3 Pling 5 Plang 7 Plong} {
        if {$number % $factor == 0} {
            append result $sound
        }
    }

    if {$result eq ""} {
        return $number
    }

    return $result
}
