# ==============================================================================
# EXERCISM TCL PRACTICE: CHANGE
# ==============================================================================
# # Instructions
#
# Determine the fewest number of coins to give a customer so that the sum of their values equals the correct amount of change.
#
# ## Examples
#
# - An amount of 15 with available coin values [1, 5, 10, 25, 100] should return one coin of value 5 and one coin of value 10, or [5, 10].
# - An amount of 40 with available coin values [1, 5, 10, 25, 100] should return one coin of value 5, one coin of value 10, and one coin of value 25, or [5, 10, 25].

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

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
