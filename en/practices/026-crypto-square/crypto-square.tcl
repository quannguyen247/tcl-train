# ==============================================================================
# EXERCISM TCL PRACTICE: CRYPTO-SQUARE
# ==============================================================================
# # Instructions
#
# Implement the classic method for composing secret messages called a square code.
#
# Given an English text, output the encoded version of that text.
#
# First, the input is normalized: the spaces and punctuation are removed from the English text and the message is down-cased.
#
# Then, the normalized characters are broken into rows.
# These rows can be regarded as forming a rectangle when printed with intervening newlines.
#
# For example, the sentence
#
# ```text
# "If man was meant to stay on the ground, god would have given us roots."
# ```
#
# is normalized to:
#
# ```text
# "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots"
# ```
#
# The plaintext should be organized into a rectangle as square as possible.
# The size of the rectangle should be decided by the length of the message.
#
# If `c` is the number of columns and `r` is the number of rows, then for the rectangle `r` x `c` find the smallest possible integer `c` such that:
#
# - `r * c >= length of message`,
# - and `c >= r`,
# - and `c - r <= 1`.
#
# Our normalized text is 54 characters long, dictating a rectangle with `c = 8` and `r = 7`:
#
# ```text
# "ifmanwas"
# "meanttos"
# "tayonthe"
# "groundgo"
# "dwouldha"
# "vegivenu"
# "sroots  "
# ```
#
# The coded message is obtained by reading down the columns going left to right.
#
# The message above is coded as:
#
# ```text
# "imtgdvsfearwermayoogoanouuiontnnlvtwttddesaohghnsseoau"
# ```
#
# Output the encoded text in chunks that fill perfect rectangles `(r X c)`, with `c` chunks of `r` length, separated by spaces.
# For phrases that are `n` characters short of the perfect rectangle, pad each of the last `n` chunks with a single trailing space.
#
# ```text
# "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
# ```
#
# Notice that were we to stack these, we could visually decode the ciphertext back in to the original message:
#
# ```text
# "imtgdvs"
# "fearwer"
# "mayoogo"
# "anouuio"
# "ntnnlvt"
# "wttddes"
# "aohghn "
# "sseoau "
# ```

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc encrypt {text} {
    set clean [string tolower [regsub -all {[^a-zA-Z0-9]} $text ""]]
    set len [string length $clean]
    if {$len == 0} { return "" }
    
    set r 1
    set c 1
    while {$r * $c < $len} {
        if {$c > $r} {
            incr r
        } else {
            incr c
        }
    }
    
    set target_len [expr {$r * $c}]
    set padded $clean
    while {[string length $padded] < $target_len} {
        append padded " "
    }
    
    set columns {}
    for {set col 0} {$col < $c} {incr col} {
        set col_str ""
        for {set row 0} {$row < $r} {incr row} {
            set idx [expr {$row * $c + $col}]
            append col_str [string index $padded $idx]
        }
        lappend columns $col_str
    }
    return [join $columns " "]
}
