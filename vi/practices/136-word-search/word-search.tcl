# ==============================================================================
# EXERCISM TCL PRACTICE: WORD-SEARCH
# ==============================================================================
# # Instructions
#
# In word search puzzles you get a square of letters and have to find specific words in them.
#
# For example:
#
# ```text
# jefblpepre
# camdcimgtc
# oivokprjsm
# pbwasqroua
# rixilelhrs
# wolcqlirpc
# screeaumgr
# alxhpburyi
# jalaycalmp
# clojurermt
# ```
#
# There are several programming languages hidden in the above square.
#
# Words can be hidden in all kinds of directions: left-to-right, right-to-left, vertical and diagonal.
#
# Given a puzzle and a list of words return the location of the first and last letter of each word.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc findWord {grid word} {
    set height [llength $grid]
    set width [string length [lindex $grid 0]]
    set length [string length $word]
    set directions {
         1  0  -1  0   0  1   0 -1
         1  1  -1 -1   1 -1  -1  1
    }

    # Thử từng ô và tám hướng
    for {set y 0} {$y < $height} {incr y} {
        for {set x 0} {$x < $width} {incr x} {
            if {[string index [lindex $grid $y] $x]
                ne [string index $word 0]} {
                continue
            }

            foreach {dx dy} $directions {
                set endX [expr {$x + $dx * ($length - 1)}]
                set endY [expr {$y + $dy * ($length - 1)}]

                # Điểm cuối phải nằm trong bảng
                if {$endX < 0 || $endX >= $width
                    || $endY < 0 || $endY >= $height} {
                    continue
                }

                set found true
                for {set i 1} {$i < $length} {incr i} {
                    set nx [expr {$x + $dx * $i}]
                    set ny [expr {$y + $dy * $i}]
                    if {[string index [lindex $grid $ny] $nx]
                        ne [string index $word $i]} {
                        set found false
                        break
                    }
                }

                if {$found} {
                    return [list \
                        [list [expr {$x + 1}] [expr {$y + 1}]] \
                        [list [expr {$endX + 1}] [expr {$endY + 1}]]]
                }
            }
        }
    }
    return {}
}

proc wordSearch {grid words} {
    # Tìm vị trí đầu và cuối của từng từ
    set result {}
    foreach word $words {
        dict set result $word [findWord $grid $word]
    }
    return $result
}

