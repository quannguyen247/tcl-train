namespace eval grains {
    namespace export square total

    namespace ensemble create

    proc square {square} {
        if {$square < 1 || $square > 64} {
            error "square must be between 1 and 64"
        }

        return [expr {1 << ($square - 1)}]
    }

    proc total {} {
        return [expr {(1 << 64) - 1}]
    }
}
