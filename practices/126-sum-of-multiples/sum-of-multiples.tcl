proc sumOfMultiples {factors limit} {
    set total 0

    for {set i 1} {$i < $limit} {incr i} {
        foreach f $factors {
            if {$f > 0 && $i % $f == 0} {
                incr total $i
                break
            }
        }
    }

    return $total
}
