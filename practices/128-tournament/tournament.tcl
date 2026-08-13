proc updateTeam {tableVar team field {amount 1}} {
    upvar 1 $tableVar table

    if {![dict exists $table $team]} {
        dict set table $team {mp 0 w 0 d 0 l 0 p 0}
    }

    set stats [dict get $table $team]
    dict incr stats $field $amount
    dict set table $team $stats
}

proc tournamentResults {filename} {
    set table {}
    set channel [open $filename r]

    while {[gets $channel line] >= 0} {
        if {$line eq ""} {continue}
        lassign [split $line ";"] first second result

        foreach team [list $first $second] {
            updateTeam table $team mp
        }

        switch -- $result {
            win {
                updateTeam table $first w
                updateTeam table $first p 3
                updateTeam table $second l
            }
            loss {
                updateTeam table $first l
                updateTeam table $second w
                updateTeam table $second p 3
            }
            draw {
                foreach team [list $first $second] {
                    updateTeam table $team d
                    updateTeam table $team p
                }
            }
        }
    }
    close $channel

    set rows {}
    dict for {team stats} $table {
        lappend rows [list $team [dict get $stats p]]
    }
    set rows [lsort -dictionary -index 0 $rows]
    set rows [lsort -integer -decreasing -index 1 $rows]

    set result {"Team                           | MP |  W |  D |  L |  P"}
    foreach row $rows {
        set team [lindex $row 0]
        set stats [dict get $table $team]
        lappend result [format "%-30s | %2d | %2d | %2d | %2d | %2d" $team \
            [dict get $stats mp] [dict get $stats w] [dict get $stats d] \
            [dict get $stats l] [dict get $stats p]]
    }

    return [join $result "\n"]
}
