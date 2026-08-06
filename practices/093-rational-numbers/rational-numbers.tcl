oo::class create Rational {
    variable num den

    constructor {numerator denominator} {
        if {$denominator == 0} {
            return -code error "Denominator must not be zero"
        }
        set g [my gcd [expr {abs($numerator)}] [expr {abs($denominator)}]]
        set n [expr {$numerator / $g}]
        set d [expr {$denominator / $g}]
        if {$d < 0} {
            set n [expr {-$n}]
            set d [expr {-$d}]
        }
        set num $n
        set den $d
    }

    method gcd {a b} {
        while {$b != 0} {
            set t $b
            set b [expr {$a % $b}]
            set a $t
        }
        return $a
    }

    method toString {} {
        return "$num/$den"
    }

    method add {other} {
        set on [$other num]
        set od [$other den]
        Rational new [expr {$num * $od + $on * $den}] [expr {$den * $od}]
    }

    method sub {other} {
        set on [$other num]
        set od [$other den]
        Rational new [expr {$num * $od - $on * $den}] [expr {$den * $od}]
    }

    method mul {other} {
        set on [$other num]
        set od [$other den]
        Rational new [expr {$num * $on}] [expr {$den * $od}]
    }

    method div {other} {
        set on [$other num]
        set od [$other den]
        Rational new [expr {$num * $od}] [expr {$den * $on}]
    }

    method abs {} {
        Rational new [expr {abs($num)}] [expr {abs($den)}]
    }

    method pow {exp} {
        if {$exp >= 0} {
            Rational new [expr {int($num ** $exp)}] [expr {int($den ** $exp)}]
        } else {
            set p [expr {abs($exp)}]
            Rational new [expr {int($den ** $p)}] [expr {int($num ** $p)}]
        }
    }

    method exprational {base} {
        expr {pow($base, double($num) / $den)}
    }

    method num {} { return $num }
    method den {} { return $den }
}
