# ==============================================================================
# EXERCISM TCL PRACTICE: ROMAN-NUMERALS
# ==============================================================================
# # Introduction
#
# Your task is to convert a number from Arabic numerals to Roman numerals.
#
# For this exercise, we are only concerned about traditional Roman numerals, in which the largest number is MMMCMXCIX (or 3,999).
#
# ~~~~exercism/note
# There are lots of different ways to convert between Arabic and Roman numerals.
# We recommend taking a naive approach first to familiarise yourself with the concept of Roman numerals and then search for more efficient methods.
#
# Make sure to check out our Deep Dive video at the end to explore the different approaches you can take!
# ~~~~

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc toroman {n} {
    set roman ""
    set symbols {
        1000 M  900 CM 500 D  400 CD
        100 C   90 XC  50 L   40 XL
        10 X     9 IX   5 V    4 IV
        1 I
    }

    # Duyệt từ giá trị lớn xuống nhỏ
    foreach {value symbol} $symbols {
        set count [expr {$n / $value}]

        # Thêm ký hiệu và giữ lại phần dư
        append roman [string repeat $symbol $count]
        set n [expr {$n % $value}]
    }

    return $roman
}

