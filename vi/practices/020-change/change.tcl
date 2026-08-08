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
    if {$target < 0} {
        error "target can't be negative"
    }
    if {$target == 0} {
        return {}
    }

    # best[số tiền] là cách đổi với ít coin nhất
    array set best {0 {}}

    for {set value 1} {$value <= $target} {incr value} {
        foreach coin $coins {
            # Bỏ qua coin lớn hơn số tiền đang xét
            if {$coin > $value || ![info exists best([expr {$value - $coin}])]} {
                continue
            }

            set candidate [lsort -integer \
                [concat $best([expr {$value - $coin}]) $coin]]

            # Chỉ giữ cách dùng ít coin hơn
            if {![info exists best($value)]
                || [llength $candidate] < [llength $best($value)]} {
                set best($value) $candidate
            }
        }
    }

    # Không có tổ hợp coin nào đúng target
    if {![info exists best($target)]} {
        error "can't make target with given coins"
    }
    return $best($target)
}
