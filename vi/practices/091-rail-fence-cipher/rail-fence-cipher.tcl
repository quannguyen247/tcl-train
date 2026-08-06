# ==============================================================================
# EXERCISM TCL PRACTICE: RAIL-FENCE-CIPHER
# ==============================================================================
# # Instructions
#
# Implement encoding and decoding for the rail fence cipher.
#
# The Rail Fence cipher is a form of transposition cipher that gets its name from the way in which it's encoded.
# It was already used by the ancient Greeks.
#
# In the Rail Fence cipher, the message is written downwards on successive "rails" of an imaginary fence, then moving up when we get to the bottom (like a zig-zag).
# Finally the message is then read off in rows.
#
# For example, using three "rails" and the message "WE ARE DISCOVERED FLEE AT ONCE", the cipherer writes out:
#
# ```text
# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .
# ```
#
# Then reads off:
#
# ```text
# WECRLTEERDSOEEFEAOCAIVDEN
# ```
#
# To decrypt a message you take the zig-zag shape and fill the ciphertext along the rows.
#
# ```text
# ? . . . ? . . . ? . . . ? . . . ? . . . ? . . . ?
# . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# ```
#
# The first row has seven spots that can be filled with "WECRLTE".
#
# ```text
# W . . . E . . . C . . . R . . . L . . . T . . . E
# . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# ```
#
# Now the 2nd row takes "ERDSOEEFEAOC".
#
# ```text
# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# ```
#
# Leaving "AIVDEN" for the last row.
#
# ```text
# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .
# ```
#
# If you now read along the zig-zag shape you can read the original message.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

namespace eval railFenceCipher {
    namespace export encode decode
    namespace ensemble create

    proc pattern {length rails} {
        set result {}
        set rail 0
        set direction 1

        # Tạo thứ tự rail theo đường zig-zag
        for {set i 0} {$i < $length} {incr i} {
            lappend result $rail

            if {$rail == 0} {
                set direction 1
            } elseif {$rail == $rails - 1} {
                set direction -1
            }
            incr rail $direction
        }
        return $result
    }

    proc encode {phrase num} {
        set rows [lrepeat $num ""]

        # Đưa từng ký tự vào rail tương ứng
        foreach char [split $phrase ""] rail [pattern [string length $phrase] $num] {
            lset rows $rail "[lindex $rows $rail]$char"
        }
        return [join $rows ""]
    }

    proc decode {cipher num} {
        set route [pattern [string length $cipher] $num]
        set counts [lrepeat $num 0]

        foreach rail $route {
            lset counts $rail [expr {[lindex $counts $rail] + 1}]
        }

        # Chia cipher thành nội dung của từng rail
        set rows {}
        set start 0
        foreach count $counts {
            lappend rows [string range $cipher \
                $start [expr {$start + $count - 1}]]
            incr start $count
        }

        # Đọc lại các ký tự theo đường zig-zag
        set positions [lrepeat $num 0]
        set result ""
        foreach rail $route {
            set index [lindex $positions $rail]
            append result [string index [lindex $rows $rail] $index]
            lset positions $rail [expr {$index + 1}]
        }
        return $result
    }
}

