proc nucleotideCounts {strand} {
    if {[regexp {[^ACGT]} $strand]} {
        error "Invalid nucleotide in strand"
    }

    set counts [dict create A 0 C 0 G 0 T 0]

    foreach char [split $strand ""] {
        dict incr counts $char
    }

    return $counts
}
