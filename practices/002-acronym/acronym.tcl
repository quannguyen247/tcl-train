# ==============================================================================
# EXERCISM TCL PRACTICE: ACRONYM
# ==============================================================================
# # Instructions
#
# Convert a phrase to its acronym.
#
# Techies love their TLA (Three Letter Acronyms)!
#
# Help generate some jargon by writing a program that converts a long name like Portable Network Graphics to its acronym (PNG).
#
# Punctuation is handled as follows: hyphens are word separators (like whitespace); all other punctuation can be removed from the input.
#
# For example:
#
# | Input                     | Output |
# | ------------------------- | ------ |
# | As Soon As Possible       | ASAP   |
# | Liquid-crystal display    | LCD    |
# | Thank George It's Friday! | TGIF   |

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc abbreviate {phrase} {
    set clean [regsub -all {[-_]} $phrase " "]
    set words [split $clean " "]
    set result ""
    foreach word $words {
        set word [string trim $word]
        if {$word ne ""} {
            append result [string toupper [string index $word 0]]
        }
    }
    return $result
}
