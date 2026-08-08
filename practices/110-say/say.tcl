proc say {n} {
    if {$n < 0 || $n > 999999999999} {
        error "input out of range"
    }

    if {$n == 0} {
        return "zero"
    }

    return [say_recursive $n]
}

proc say_recursive {n} {
    set ones {1 one 2 two 3 three 4 four 5 five 6 six 7 seven 8 eight 9 nine 10 ten
    11 eleven 12 twelve 13 thirteen 14 fourteen 15 fifteen 16 sixteen 17 seventeen 18 eighteen 19 nineteen}

    set tens {2 twenty 3 thirty 4 forty 5 fifty 6 sixty 7 seventy 8 eighty 9 ninety}

    if {$n < 20} {
        return [dict get $ones $n]
    }

    if {$n < 100} {
        set t [dict get $tens [expr {$n / 10}]]
        set r [expr {$n % 10}]
        if {$r == 0} {
            return $t
        }
        return "$t-[dict get $ones $r]"
    }

    if {$n < 1000} {
        set r [expr {$n % 100}]
        set out "[dict get $ones [expr {$n / 100}]] hundred"
        if {$r > 0} {
            append out " [say_recursive $r]"
        }
        return $out
    }

    foreach {limit name} {1000000000 billion 1000000 million 1000 thousand} {
        if {$n >= $limit} {
            set r [expr {$n % $limit}]
            set out "[say_recursive [expr {$n / $limit}]] $name"
            if {$r > 0} {
                append out " [say_recursive $r]"
            }
            return $out
        }
    }
}
