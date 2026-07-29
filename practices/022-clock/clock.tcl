oo::class create Clock {
    variable minutes

    constructor {h m} {
        set total [expr {($h * 60 + $m) % 1440}]
        if {$total < 0} {
            set total [expr {$total + 1440}]
        }
        set minutes $total
    }

    method getMinutes {} {
        return $minutes
    }

    method toString {} {
        set h [expr {$minutes / 60}]
        set m [expr {$minutes % 60}]
        return [format "%02d:%02d" $h $m]
    }

    method add {m} {
        return [Clock new 0 [expr {$minutes + $m}]]
    }

    method subtract {m} {
        return [Clock new 0 [expr {$minutes - $m}]]
    }

    method equals {other} {
        return [expr {$minutes == [$other getMinutes]}]
    }

    method == {other} {
        return [my equals $other]
    }

    export ==
}
