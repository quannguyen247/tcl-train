proc cardValue {c} {
    if {$c eq "A"} { return 4 }
    if {$c eq "K"} { return 3 }
    if {$c eq "Q"} { return 2 }
    if {$c eq "J"} { return 1 }
    return 0
}

proc simulateGame {deckA deckB} {
    set pA $deckA
    set pB $deckB
    set pile {}
    set total_cards 0
    set total_tricks 0
    array set history {}
    
    set current_player A
    
    while {1} {
        set key "$pA-$pB-$pile-$current_player"
        if {[info exists history($key)]} {
            return [dict create status loop cards $total_cards tricks $total_tricks]
        }
        set history($key) 1
        
        if {$current_player eq "A"} {
            if {[llength $pA] == 0} {
                return [dict create status finished cards $total_cards tricks $total_tricks]
            }
            set card [lindex $pA 0]
            set pA [lrange $pA 1 end]
        } else {
            if {[llength $pB] == 0} {
                return [dict create status finished cards $total_cards tricks $total_tricks]
            }
            set card [lindex $pB 0]
            set pB [lrange $pB 1 end]
        }
        
        lappend pile $card
        incr total_cards
        
        set val [cardValue $card]
        if {$val > 0} {
            set payment_required $val
            set paying_player [expr {$current_player eq "A" ? "B" : "A"}]
            set trick_won 0
            
            while {$payment_required > 0} {
                if {$paying_player eq "A"} {
                    if {[llength $pA] == 0} {
                        return [dict create status finished cards $total_cards tricks $total_tricks]
                    }
                    set p_card [lindex $pA 0]
                    set pA [lrange $pA 1 end]
                } else {
                    if {[llength $pB] == 0} {
                        return [dict create status finished cards $total_cards tricks $total_tricks]
                    }
                    set p_card [lindex $pB 0]
                    set pB [lrange $pB 1 end]
                }
                
                lappend pile $p_card
                incr total_cards
                
                set p_val [cardValue $p_card]
                if {$p_val > 0} {
                    set current_player $paying_player
                    set payment_required $p_val
                    set paying_player [expr {$current_player eq "A" ? "B" : "A"}]
                } else {
                    incr payment_required -1
                    if {$payment_required == 0} {
                        set trick_won 1
                    }
                }
            }
            
            if {$trick_won} {
                incr total_tricks
                if {$current_player eq "A"} {
                    set pA [concat $pA $pile]
                } else {
                    set pB [concat $pB $pile]
                }
                set pile {}
            }
        } else {
            set current_player [expr {$current_player eq "A" ? "B" : "A"}]
        }
    }
}
