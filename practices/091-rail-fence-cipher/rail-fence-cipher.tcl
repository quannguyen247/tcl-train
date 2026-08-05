namespace eval railFenceCipher {
    namespace export encode decode
    namespace ensemble create

    proc pattern {length rails} {
        set result {}
        set rail 0
        set direction 1

        for {set i 0} {$i < $length} {incr i} {
            lappend result $rail

            if {$rail == 0} {
                set direction 1
            } elseif {$rail == $rails - 1} {
                set direction -1
            }

            incr rail $direction
        }

        return $result
    }

    proc encode {phrase num} {
        set rows [lrepeat $num ""]

        foreach char [split $phrase ""] \
                rail [pattern [string length $phrase] $num] {
            lset rows $rail "[lindex $rows $rail]$char"
        }

        return [join $rows ""]
    }

    proc decode {cipher num} {
        set route [pattern [string length $cipher] $num]
        set counts [lrepeat $num 0]

        foreach rail $route {
            lset counts $rail [expr {
                [lindex $counts $rail] + 1
            }]
        }

        set rows {}
        set start 0

        foreach count $counts {
            lappend rows [string range $cipher \
                $start [expr {$start + $count - 1}]]

            incr start $count
        }

        set positions [lrepeat $num 0]
        set result ""

        foreach rail $route {
            set index [lindex $positions $rail]
            append result [string index \
                [lindex $rows $rail] $index]

            lset positions $rail [expr {$index + 1}]
        }

        return $result
    }
}
