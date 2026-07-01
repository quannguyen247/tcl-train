# ==============================================================================
# EXERCISM TCL PRACTICE: VARIABLE-LENGTH-QUANTITY
# ==============================================================================
# # Instructions
#
# Implement variable length quantity encoding and decoding.
#
# The goal of this exercise is to implement [VLQ][vlq] encoding/decoding.
#
# In short, the goal of this encoding is to encode integer values in a way that would save bytes.
# Only the first 7 bits of each byte are significant (right-justified; sort of like an ASCII byte).
# So, if you have a 32-bit value, you have to unpack it into a series of 7-bit bytes.
# Of course, you will have a variable number of bytes depending upon your integer.
# To indicate which is the last byte of the series, you leave bit #7 clear.
# In all of the preceding bytes, you set bit #7.
#
# So, if an integer is between `0-127`, it can be represented as one byte.
# Although VLQ can deal with numbers of arbitrary sizes, for this exercise we will restrict ourselves to only numbers that fit in a 32-bit unsigned integer.
# Here are examples of integers as 32-bit values, and the variable length quantities that they translate to:
#
# ```text
#  NUMBER        VARIABLE QUANTITY
# 00000000              00
# 00000040              40
# 0000007F              7F
# 00000080             81 00
# 00002000             C0 00
# 00003FFF             FF 7F
# 00004000           81 80 00
# 00100000           C0 80 00
# 001FFFFF           FF FF 7F
# 00200000          81 80 80 00
# 08000000          C0 80 80 00
# 0FFFFFFF          FF FF FF 7F
# ```
#
# [vlq]: https://en.wikipedia.org/wiki/Variable-length_quantity

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc encode {numbers} {
    set result {}

    foreach number $numbers {
        set groups {}
        if {$number == 0} {
            lappend result 0
            continue
        }

        # Tách số thành các nhóm 7 bit
        while {$number > 0} {
            set groups [linsert $groups 0 [expr {$number & 0x7f}]]
            set number [expr {$number >> 7}]
        }

        set last [expr {[llength $groups] - 1}]
        for {set i 0} {$i <= $last} {incr i} {
            set byte [lindex $groups $i]
            if {$i < $last} {
                incr byte 0x80
            }
            lappend result $byte
        }
    }
    return $result
}

proc decode {bytes} {
    set result {}
    set value 0
    set incomplete false

    # Ghép từng nhóm 7 bit thành số ban đầu
    foreach byte $bytes {
        set value [expr {($value << 7) | ($byte & 0x7f)}]
        if {$byte & 0x80} {
            set incomplete true
        } else {
            lappend result $value
            set value 0
            set incomplete false
        }
    }

    if {$incomplete} {
        error "incomplete sequence"
    }
    return $result
}

