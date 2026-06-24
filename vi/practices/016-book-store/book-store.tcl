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

proc minimumCost {counts memoName} {
    upvar 1 $memoName memo
    set counts [lsort -integer -decreasing $counts]

    if {$counts eq {}} {
        return 0
    }
    if {[dict exists $memo $counts]} {
        return [dict get $memo $counts]
    }

    set prices {0 800 1520 2160 2560 3000}
    set best 0
    foreach count $counts {
        incr best [expr {$count * 800}]
    }

    # Thử mọi nhóm sách khác nhau
    set sizeCount [llength $counts]
    for {set mask 1} {$mask < (1 << $sizeCount)} {incr mask} {
        set next $counts
        set groupSize 0

        for {set i 0} {$i < $sizeCount} {incr i} {
            if {$mask & (1 << $i)} {
                lset next $i [expr {[lindex $next $i] - 1}]
                incr groupSize
            }
        }

        set next [lsearch -all -inline -not -exact $next 0]
        set total [expr {
            [lindex $prices $groupSize] + [minimumCost $next memo]
        }]
        if {$total < $best} {
            set best $total
        }
    }

    # Lưu kết quả để không tính lại
    dict set memo $counts $best
    return $best
}

proc basketCost {books} {
    # Đếm số bản của từng đầu sách
    set copies {}
    foreach book $books {
        dict incr copies $book
    }

    set memo {}
    return [minimumCost [dict values $copies] memo]
}
