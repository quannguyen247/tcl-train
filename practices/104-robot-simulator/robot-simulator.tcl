oo::class create Robot {
    variable x y direction

    constructor {args} {
        set config [dict merge \
            {x 0 y 0 direction north} {*}$args]

        set x [dict get $config x]
        set y [dict get $config y]
        set direction [dict get $config direction]
    }

    method position {} {
        return [dict create \
            x $x y $y direction $direction]
    }

    method move {instructions} {
        set directions {north east south west}
        set steps {
            north {0 1}
            east {1 0}
            south {0 -1}
            west {-1 0}
        }

        foreach instruction [split $instructions ""] {
            set index [lsearch -exact \
                $directions $direction]

            switch -- $instruction {
                R {
                    set direction [lindex $directions \
                        [expr {($index + 1) % 4}]]
                }

                L {
                    set direction [lindex $directions \
                        [expr {($index + 3) % 4}]]
                }

                A {
                    lassign [dict get \
                        $steps $direction] dx dy

                    incr x $dx
                    incr y $dy
                }

                default {
                    error "invalid instruction: $instruction"
                }
            }
        }

        return [my position]
    }
}
