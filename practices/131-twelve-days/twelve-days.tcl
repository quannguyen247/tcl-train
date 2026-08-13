proc verse {n} {
    set days {
        first second third fourth fifth sixth
        seventh eighth ninth tenth eleventh twelfth
    }

    set gifts {
        {a Partridge in a Pear Tree.}
        {two Turtle Doves}
        {three French Hens}
        {four Calling Birds}
        {five Gold Rings}
        {six Geese-a-Laying}
        {seven Swans-a-Swimming}
        {eight Maids-a-Milking}
        {nine Ladies Dancing}
        {ten Lords-a-Leaping}
        {eleven Pipers Piping}
        {twelve Drummers Drumming}
    }

    set lines {}
    for {set i [expr {$n - 1}]} {$i >= 0} {incr i -1} {
        set line [lindex $gifts $i]

        if {$i > 0} {
            append line ,
        } elseif {$n > 1} {
            set line "and $line"
        }

        lappend lines $line
    }

    return "On the [lindex $days [expr {$n - 1}]] day of Christmas my true love gave to me: [join $lines " "]"
}

proc sing {from to} {
    set song {}

    for {set day $from} {$day <= $to} {incr day} {
        lappend song [verse $day]
    }

    return [join $song \n]
}
