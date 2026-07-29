proc parseBoard {boardLines} {
    set grid {}
    foreach line $boardLines {
        set row {}
        set trimmed [string trim $line]
        foreach char [split $trimmed " "] {
            if {$char ne ""} {
                lappend row $char
            }
        }
        if {[llength $row] > 0} {
            lappend grid $row
        }
    }
    return $grid
}

proc checkWinner {grid startNodes player rows cols is_o} {
    if {[llength $startNodes] == 0} { return false }
    set queue $startNodes
    array set visited {}
    foreach node $startNodes {
        set visited([lindex $node 0],[lindex $node 1]) 1
    }
    
    set dirs {{-1 0} {-1 1} {0 -1} {0 1} {1 -1} {1 0}}
    
    while {[llength $queue] > 0} {
        set curr [lindex $queue 0]
        set queue [lrange $queue 1 end]
        lassign $curr r c
        
        if {$is_o && $r == [expr {$rows - 1}]} { return true }
        if {!$is_o && $c == [expr {$cols - 1}]} { return true }
        
        foreach dir $dirs {
            lassign $dir dr dc
            set nr [expr {$r + $dr}]
            set nc [expr {$c + $dc}]
            if {$nr >= 0 && $nr < $rows && $nc >= 0 && $nc < $cols} {
                if {![info exists visited($nr,$nc)] && [lindex $grid $nr $nc] eq $player} {
                    set visited($nr,$nc) 1
                    lappend queue [list $nr $nc]
                }
            }
        }
    }
    return false
}

proc winner {board} {
    set grid [parseBoard $board]
    set rows [llength $grid]
    if {$rows == 0} { return "" }
    set cols [llength [lindex $grid 0]]
    
    set start_o {}
    for {set c 0} {$c < $cols} {incr c} {
        if {[lindex $grid 0 $c] eq "O"} {
            lappend start_o [list 0 $c]
        }
    }
    if {[checkWinner $grid $start_o "O" $rows $cols 1]} {
        return "O"
    }
    
    set start_x {}
    for {set r 0} {$r < $rows} {incr r} {
        if {[lindex $grid $r 0] eq "X"} {
            lappend start_x [list $r 0]
        }
    }
    if {[checkWinner $grid $start_x "X" $rows $cols 0]} {
        return "X"
    }
    
    return ""
}
