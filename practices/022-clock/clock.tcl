oo::class create Clock {
    variable minutes

    constructor {hour minute} {
        set total [expr {($hour * 60 + $minute) % 1440}]
        if {$total < 0} {
            incr total 1440
        }
        set minutes $total
    }

    method toString {} {
        format "%02d:%02d" [expr {$minutes / 60}] [expr {$minutes % 60}]
    }

    method add {mins} {
        return [Clock new 0 [expr {$minutes + $mins}]]
    }

    method subtract {mins} {
        return [Clock new 0 [expr {$minutes - $mins}]]
    }

    method equals {other} {
        expr {[my toString] eq [$other toString]}
    }

    method == {other} {
        my equals $other
    }
    export ==
}
