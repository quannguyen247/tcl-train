proc checkJigsaw {input rows columns resultsName} {
    upvar 1 $resultsName results

    set pieces [expr {$rows * $columns}]
    set inside [expr {max(0, $rows - 2) * max(0, $columns - 2)}]
    set border [expr {$pieces - $inside}]
    set ratio [expr {double($columns) / $rows}]
    set format [expr {
        $ratio < 1 ? "portrait" : $ratio > 1 ? "landscape" : "square"
    }]

    set candidate [dict create \
        pieces $pieces border $border inside $inside \
        rows $rows columns $columns \
        aspectRatio $ratio format $format]

    dict for {key value} $input {
        if {$key eq "aspectRatio"} {
            if {abs($ratio - $value) > 1e-9} return
        } elseif {[dict get $candidate $key] ne $value} {
            return
        }
    }
    lappend results $candidate
}

proc jigsawData {input} {
    set candidates {}
    set maxRows 1000
    set maxColumns 1000

    if {[dict exists $input rows]} {
        set maxRows [dict get $input rows]
    }
    if {[dict exists $input columns]} {
        set maxColumns [dict get $input columns]
    }

    if {[dict exists $input pieces]} {
        set pieces [dict get $input pieces]

        for {set rows 1} {$rows <= $pieces} {incr rows} {
            if {$pieces % $rows == 0} {
                checkJigsaw $input $rows \
                    [expr {$pieces / $rows}] candidates
            }
            if {[llength $candidates] > 1} break
        }
    } else {
        if {[dict exists $input inside] && [dict get $input inside] > 0} {
            set limit [expr {[dict get $input inside] + 2}]
            set maxRows [expr {min($maxRows, $limit)}]
            set maxColumns [expr {min($maxColumns, $limit)}]
        }

        if {[dict exists $input border] && [dict get $input border] > 0} {
            set limit [dict get $input border]
            set maxRows [expr {min($maxRows, $limit)}]
            set maxColumns [expr {min($maxColumns, $limit)}]
        }

        for {set rows 1} {$rows <= $maxRows} {incr rows} {
            for {set columns 1} {$columns <= $maxColumns} {incr columns} {
                checkJigsaw $input $rows $columns candidates
                if {[llength $candidates] > 1} break
            }
            if {[llength $candidates] > 1} break
        }
    }

    if {[llength $candidates] == 0} {
        error "Contradictory data"
    }
    if {[llength $candidates] > 1} {
        error "Insufficient data"
    }
    return [lindex $candidates 0]
}
