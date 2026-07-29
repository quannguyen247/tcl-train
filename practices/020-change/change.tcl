proc findMinimumCoins {target coins} {
    if {$target == 0} { return {} }
    if {$target < 0} { error "target can't be negative" }
    
    array set dp {}
    set dp(0) {}
    set queue {0}
    
    while {[llength $queue] > 0} {
        set curr [lindex $queue 0]
        set queue [lrange $queue 1 end]
        set curr_coins $dp($curr)
        
        foreach coin $coins {
            set next [expr {$curr + $coin}]
            if {$next > $target} continue
            if {![info exists dp($next)]} {
                set dp($next) [lsort -integer [concat $curr_coins [list $coin]]]
                if {$next == $target} {
                    return $dp($next)
                }
                lappend queue $next
            }
        }
    }
    
    error "can't make target with given coins"
}
