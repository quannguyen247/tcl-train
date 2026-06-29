# ==============================================================================
# EXERCISM TCL PRACTICE: KNAPSACK
# ==============================================================================
# # Instructions
#
# Your task is to determine which items to take so that the total value of her selection is maximized, taking into account the knapsack's carrying capacity.
#
# Items will be represented as a list of items.
# Each item will have a weight and value.
# All values given will be strictly positive.
# Lhakpa can take only one of each item.
#
# For example:
#
# ```text
# Items: [
#   { "weight": 5, "value": 10 },
#   { "weight": 4, "value": 40 },
#   { "weight": 6, "value": 30 },
#   { "weight": 4, "value": 50 }
# ]
#
# Knapsack Maximum Weight: 10
# ```
#
# For the above, the first item has weight 5 and value 10, the second item has weight 4 and value 40, and so on.
# In this example, Lhakpa should take the second and fourth item to maximize her value, which, in this case, is 90.
# She cannot get more than 90 as her knapsack has a weight limit of 10.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc maximumValue {maxWeight items} {
    # best[w] là giá trị lớn nhất với sức chứa w
    set best [lrepeat [expr {$maxWeight + 1}] 0]

    foreach item $items {
        dict with item {}

        # Duyệt ngược để mỗi món chỉ được lấy một lần
        for {set w $maxWeight} {$w >= $weight} {incr w -1} {
            set total [expr {[lindex $best [expr {$w - $weight}]] + $value}]
            if {$total > [lindex $best $w]} {
                lset best $w $total
            }
        }
    }

    return [lindex $best end]
}

