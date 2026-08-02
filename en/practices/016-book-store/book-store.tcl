# ==============================================================================
# EXERCISM TCL PRACTICE: BOOK-STORE
# ==============================================================================
# # Instructions
#
# To try and encourage more sales of different books from a popular 5 book series, a bookshop has decided to offer discounts on multiple book purchases.
#
# One copy of any of the five books costs $8.
#
# If, however, you buy two different books, you get a 5% discount on those two books.
#
# If you buy 3 different books, you get a 10% discount.
#
# If you buy 4 different books, you get a 20% discount.
#
# If you buy all 5, you get a 25% discount.
#
# Note that if you buy four books, of which 3 are different titles, you get a 10% discount on the 3 that form part of a set, but the fourth book still costs $8.
#
# Your mission is to write code to calculate the price of any conceivable shopping basket (containing only books of the same series), giving as big a discount as possible.
#
# For example, how much does this basket of books cost?
#
# - 2 copies of the first book
# - 2 copies of the second book
# - 2 copies of the third book
# - 1 copy of the fourth book
# - 1 copy of the fifth book
#
# One way of grouping these 8 books is:
#
# - 1 group of 5 (1st, 2nd,3rd, 4th, 5th)
# - 1 group of 3 (1st, 2nd, 3rd)
#
# This would give a total of:
#
# - 5 books at a 25% discount
# - 3 books at a 10% discount
#
# Resulting in:
#
# - 5 × (100% - 25%) × $8 = 5 × $6.00 = $30.00, plus
# - 3 × (100% - 10%) × $8 = 3 × $7.20 = $21.60
#
# Which equals $51.60.
#
# However, a different way to group these 8 books is:
#
# - 1 group of 4 books (1st, 2nd, 3rd, 4th)
# - 1 group of 4 books (1st, 2nd, 3rd, 5th)
#
# This would give a total of:
#
# - 4 books at a 20% discount
# - 4 books at a 20% discount
#
# Resulting in:
#
# - 4 × (100% - 20%) × $8 = 4 × $6.40 = $25.60, plus
# - 4 × (100% - 20%) × $8 = 4 × $6.40 = $25.60
#
# Which equals $51.20.
#
# And $51.20 is the price with the biggest discount.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc basketCost {basket} {
    array set counts {1 0 2 0 3 0 4 0 5 0}
    foreach item $basket {
        incr counts($item)
    }
    set groups {}
    while 1 {
        set num_distinct 0
        for {set b 1} {$b <= 5} {incr b} {
            if {$counts($b) > 0} {
                incr num_distinct
            }
        }
        if {$num_distinct == 0} break
        for {set b 1} {$b <= 5} {incr b} {
            if {$counts($b) > 0} {
                incr counts($b) -1
            }
        }
        lappend groups $num_distinct
    }
    set count5 0
    set count4 0
    set count3 0
    set count2 0
    set count1 0
    foreach g $groups {
        if {$g == 5} { incr count5 }
        if {$g == 4} { incr count4 }
        if {$g == 3} { incr count3 }
        if {$g == 2} { incr count2 }
        if {$g == 1} { incr count1 }
    }
    while {$count5 > 0 && $count3 > 0} {
        incr count5 -1
        incr count3 -1
        incr count4 2
    }
    set total [expr {$count1 * 800 + $count2 * 1520 + $count3 * 2160 + $count4 * 2560 + $count5 * 3000}]
    return $total
}
