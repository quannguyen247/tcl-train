proc toroman {n} {
    set roman ""
    set symbols {
        1000 M 900 CM 500 D 400 CD
        100 C 90 XC 50 L 40 XL
        10 X 9 IX 5 V 4 IV 1 I
    }

    foreach {value symbol} $symbols {
        set count [expr {$n / $value}]

        append roman [string repeat $symbol $count]
        set n [expr {$n % $value}]
    }

    return $roman
}
