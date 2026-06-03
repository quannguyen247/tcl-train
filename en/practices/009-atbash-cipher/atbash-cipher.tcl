# ==============================================================================
# EXERCISM TCL PRACTICE: ATBASH-CIPHER
# ==============================================================================
# # Instructions
#
# Create an implementation of the Atbash cipher, an ancient encryption system created in the Middle East.
#
# The Atbash cipher is a simple substitution cipher that relies on transposing all the letters in the alphabet such that the resulting alphabet is backwards.
# The first letter is replaced with the last letter, the second with the second-last, and so on.
#
# An Atbash cipher for the Latin alphabet would be as follows:
#
# ```text
# Plain:  abcdefghijklmnopqrstuvwxyz
# Cipher: zyxwvutsrqponmlkjihgfedcba
# ```
#
# It is a very weak cipher because it only has one possible key, and it is a simple mono-alphabetic substitution cipher.
# However, this may not have been an issue in the cipher's time.
#
# Ciphertext is written out in groups of fixed length, the traditional group size being 5 letters, leaving numbers unchanged, and punctuation is excluded.
# This is to make it harder to guess things based on word boundaries.
# All text will be encoded as lowercase letters.
#
# ## Examples
#
# - Encoding `test` gives `gvhg`
# - Encoding `x123 yes` gives `c123b vh`
# - Decoding `gvhg` gives `test`
# - Decoding `gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt` gives `thequickbrownfoxjumpsoverthelazydog`

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc encode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set cipher ""
    set count 0
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        if {$count > 0 && $count % 5 == 0} {
            append cipher " "
        }
        append cipher $c
        incr count
    }
    return $cipher
}

proc decode {phrase} {
    set clean [regsub -all {[^a-zA-Z0-9]} $phrase ""]
    set clean [string tolower $clean]
    set plain ""
    foreach char [split $clean ""] {
        if {[string is alpha $char]} {
            set c [format %c [expr {219 - [scan $char %c]}]]
        } else {
            set c $char
        }
        append plain $c
    }
    return $plain
}
