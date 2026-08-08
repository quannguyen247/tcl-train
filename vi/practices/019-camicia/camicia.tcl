# ==============================================================================
# EXERCISM TCL PRACTICE: CAMICIA
# ==============================================================================
# # Instructions
#
# In this exercise, you will simulate a game very similar to the classic card game **Camicia**.
# Your program will receive the initial configuration of two players' decks and must simulate the game until it ends (or detect that it will never end).
#
# ## Rules
#
# - The deck is split between **two players**.
#   The player's cards are read from left to right, where the leftmost card is the top of the deck.
# - A round consists of both players playing at least one card.
# - Players take turns placing the **top card** of their deck onto a central pile.
# - If the card is a **number card** (2-10), play simply passes to the other player.
# - If the card is a **payment card**, a penalty must be paid:
#   - **J** → opponent must pay 1 card
#   - **Q** → opponent must pay 2 cards
#   - **K** → opponent must pay 3 cards
#   - **A** → opponent must pay 4 cards
# - If the player paying a penalty reveals another payment card, that player stops paying the penalty.
#   The other player must then pay a penalty based on the new payment card.
# - If the penalty is fully paid without interruption, the player who placed the **last payment card** collects the central pile and places it at the bottom of their deck.
#   That player then starts the next round.
# - If a player runs out of cards and is unable to play a card (either while paying a penalty or when it is their turn), the other player collects the central pile.
# - The moment when a player collects cards from the central pile is called a **trick**.
# - If a player has all the cards in their possession after a trick, the game **ends**.
# - The game **enters a loop** as soon as the decks are identical to what they were earlier during the game, **not** counting number cards!
#
# ## Examples
#
# A small example of a match that ends.
#
# | Round | Player A     | Player B                   | Pile                       | Penalty Due |
# | :---- | :----------- | :------------------------- | :------------------------- | :---------- |
# | 1     | 2 A 7 8 Q 10 | 3 4 5 6 K 9 J              |                            | -           |
# | 1     | A 7 8 Q 10   | 3 4 5 6 K 9 J              | 2                          | -           |
# | 1     | A 7 8 Q 10   | 4 5 6 K 9 J                | 2 3                        | -           |
# | 1     | 7 8 Q 10     | 4 5 6 K 9 J                | 2 3 A                      | Player B: 4 |
# | 1     | 7 8 Q 10     | 5 6 K 9 J                  | 2 3 A 4                    | Player B: 3 |
# | 1     | 7 8 Q 10     | 6 K 9 J                    | 2 3 A 4 5                  | Player B: 2 |
# | 1     | 7 8 Q 10     | K 9 J                      | 2 3 A 4 5 6                | Player B: 1 |
# | 1     | 7 8 Q 10     | 9 J                        | 2 3 A 4 5 6 K              | Player A: 3 |
# | 1     | 8 Q 10       | 9 J                        | 2 3 A 4 5 6 K 7            | Player A: 2 |
# | 1     | Q 10         | 9 J                        | 2 3 A 4 5 6 K 7 8          | Player A: 1 |
# | 1     | 10           | 9 J                        | 2 3 A 4 5 6 K 7 8 Q        | Player B: 2 |
# | 1     | 10           | J                          | 2 3 A 4 5 6 K 7 8 Q 9      | Player B: 1 |
# | 1     | 10           | -                          | 2 3 A 4 5 6 K 7 8 Q 9 J    | Player A: 1 |
# | 1     | -            | -                          | 2 3 A 4 5 6 K 7 8 Q 9 J 10 | -           |
# | 2     | -            | 2 3 A 4 5 6 K 7 8 Q 9 J 10 | -                          | -           |
#
# status: `"finished"`, cards: 13, tricks: 1
#
# This is a small example of a match that loops.
#
# | Round | Player A | Player B | Pile  | Penalty Due |
# | :---- | :------- | :------- | :---- | :---------- |
# | 1     | J 2 3    | 4 J 5    | -     | -           |
# | 1     | 2 3      | 4 J 5    | J     | Player B: 1 |
# | 1     | 2 3      | J 5      | J 4   | -           |
# | 2     | 2 3 J 4  | J 5      | -     | -           |
# | 2     | 3 J 4    | J 5      | 2     | -           |
# | 2     | 3 J 4    | 5        | 2 J   | Player A: 1 |
# | 2     | J 4      | 5        | 2 J 3 | -           |
# | 3     | J 4      | 5 2 J 3  | -     | -           |
# | 3     | J 4      | 2 J 3    | 5     | -           |
# | 3     | 4        | 2 J 3    | 5 J   | Player B: 1 |
# | 3     | 4        | J 3      | 5 J 2 | -           |
# | 4     | 4 5 J 2  | J 3      | -     | -           |
#
# The start of round 4 matches the start of round 2.
# Recall, the value of the number cards does not matter.
#
# status: `"loop"`, cards: 8, tricks: 3
#
# ## Your Task
#
# - Using the input, simulate the game following the rules above.
# - Determine the following information regarding the game:
#   - **Status**: `"finished"` or `"loop"`
#   - **Cards**: total number of cards played throughout the game
#   - **Tricks**: number of times the central pile was collected
#
# ~~~~exercism/advanced
# For those who want to take on a more exciting challenge, the hunt for other records for the longest game with an end is still open.
# There are 653,534,134,886,878,245,000 (approximately 654 quintillion) possibilities, and we haven't calculated them all yet!
# ~~~~

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc cardValue {c} {
    if {$c eq "A"} { return 4 }
    if {$c eq "K"} { return 3 }
    if {$c eq "Q"} { return 2 }
    if {$c eq "J"} { return 1 }
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
    # Giá trị cụ thể của các lá số không ảnh hưởng loop
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
        # Chỉ kiểm tra loop ở đầu mỗi round
        set state [gameState $deckA $deckB $starter]
        if {[dict exists $history $state]} {
            return [dict create status loop cards $cards tricks $tricks]
        }
        dict set history $state 1

        set pile {}
        set current $starter
        set winner ""

        while {$winner eq ""} {
            set card [drawCard $current deckA deckB]

            # Không còn bài thì đối thủ thu pile
            if {$card eq ""} {
                set winner [otherPlayer $current]
                break
            }

            lappend pile $card
            incr cards
            set penalty [cardValue $card]

            # Lá số chỉ chuyển lượt
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
                    # Lá payment mới chuyển nghĩa vụ cho đối thủ
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

        # Người thắng đặt pile xuống cuối bộ bài
        incr tricks
        if {$winner eq "A"} {
            set deckA [concat $deckA $pile]
        } else {
            set deckB [concat $deckB $pile]
        }

        if {$deckA eq {} || $deckB eq {}} {
            return [dict create status finished cards $cards tricks $tricks]
        }
        set starter $winner
    }
}
