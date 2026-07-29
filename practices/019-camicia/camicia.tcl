proc cardValue {card} {
    if {$card eq "A"} { return 4 }
    if {$card eq "K"} { return 3 }
    if {$card eq "Q"} { return 2 }
    if {$card eq "J"} { return 1 }
    return 0
}

proc otherPlayer {player} {
    return [expr {$player eq "A" ? "B" : "A"}]
}

proc drawCard {player deckAName deckBName} {
    upvar 1 $deckAName deckA $deckBName deckB

    if {$player eq "A"} {
        if {$deckA eq {}} {
            return ""
        }
        set card [lindex $deckA 0]
        set deckA [lrange $deckA 1 end]
    } else {
        if {$deckB eq {}} {
            return ""
        }
        set card [lindex $deckB 0]
        set deckB [lrange $deckB 1 end]
    }

    return $card
}

proc gameState {deckA deckB starter} {
    set normalA [lmap card $deckA {
        expr {[cardValue $card] == 0 ? "N" : $card}
    }]
    set normalB [lmap card $deckB {
        expr {[cardValue $card] == 0 ? "N" : $card}
    }]

    return [list $normalA $normalB $starter]
}

proc simulateGame {playerA playerB} {
    set deckA $playerA
    set deckB $playerB
    set starter A
    set cards 0
    set tricks 0
    set history {}

    while {true} {
        set state [gameState $deckA $deckB $starter]
        if {[dict exists $history $state]} {
            return [dict create \
                status loop cards $cards tricks $tricks]
        }
        dict set history $state 1

        set pile {}
        set current $starter
        set winner ""

        while {$winner eq ""} {
            set card [drawCard $current deckA deckB]

            if {$card eq ""} {
                set winner [otherPlayer $current]
                break
            }

            lappend pile $card
            incr cards
            set penalty [cardValue $card]

            if {$penalty == 0} {
                set current [otherPlayer $current]
                continue
            }

            set lastPayment $current
            set payer [otherPlayer $current]

            while {$penalty > 0} {
                set card [drawCard $payer deckA deckB]

                if {$card eq ""} {
                    set winner $lastPayment
                    break
                }

                lappend pile $card
                incr cards
                set value [cardValue $card]

                if {$value > 0} {
                    set lastPayment $payer
                    set payer [otherPlayer $payer]
                    set penalty $value
                } else {
                    incr penalty -1
                }
            }

            if {$winner eq "" && $penalty == 0} {
                set winner $lastPayment
            }
        }

        incr tricks
        if {$winner eq "A"} {
            set deckA [concat $deckA $pile]
        } else {
            set deckB [concat $deckB $pile]
        }

        if {$deckA eq {} || $deckB eq {}} {
            return [dict create \
                status finished cards $cards tricks $tricks]
        }

        set starter $winner
    }
}
