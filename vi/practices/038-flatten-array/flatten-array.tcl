# ==============================================================================
# EXERCISM TCL PRACTICE: FLATTEN-ARRAY
# ==============================================================================
# # Instructions
#
# Take a nested array of any depth and return a fully flattened array.
#
# Note that some language tracks may include null-like values in the input array, and the way these values are represented varies by track.
# Such values should be excluded from the flattened array.
#
# Additionally, the input may be of a different data type and contain different types, depending on the track.
#
# Check the test suite for details.
#
# ## Example
#
# input: `[1, [2, 6, null], [[null, [4]], 5]]`
#
# output: `[1, 2, 6, 4, 5]`

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc flatten {input} {
    set result {}

    foreach item $input {
        # Bỏ qua giá trị rỗng
        if {$item eq ""} {
            continue
        }

        set size [llength $item]

        # Nếu còn list lồng nhau thì mở tiếp
        if {$size > 1 || ($size == 1 && [lindex $item 0] ne $item)} {
            lappend result {*}[flatten $item]
        } else {
            lappend result $item
        }
    }

    return $result
}

