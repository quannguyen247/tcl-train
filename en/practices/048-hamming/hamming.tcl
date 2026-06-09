# ==============================================================================
# EXERCISM TCL PRACTICE: HAMMING
# ==============================================================================
# # Instructions
#
# Calculate the Hamming distance between two DNA strands.
#
# We read DNA using the letters C, A, G and T.
# Two strands might look like this:
#
#     GAGCCTACTAACGGGAT
#     CATCGTAATGACGGCCT
#     ^ ^ ^  ^ ^    ^^
#
# They have 7 differences, and therefore the Hamming distance is 7.
#
# ## Implementation notes
#
# The Hamming distance is only defined for sequences of equal length, so an attempt to calculate it between sequences of different lengths should not work.

# ==============================================================================
# ALGORITHM & TCL SYNTAX NOTES
# ==============================================================================
# 1. COMPREHENSIVE `string` SUBCOMMANDS CHEATSHEET:
#    - `string length $str`: Returns character count.
#    - `string index $str $idx`: Gets character at 0-based index.
#    - `string range $str $start $end`: Extracts substring from $start to $end.
#    - `string map {$from $to} $str`: Replaces substrings/characters.
#    - `string tolower $str` / `string toupper $str`: Converts case.
#    - `string trim $str` / `string trimleft` / `string trimright`: Trims whitespace.
#    - `string match $pattern $str`: Glob pattern matching (e.g. `string match "a*" $str`).
#    - `string is <type> $str`: Validates type (e.g. `string is integer -strict $str`).
#    - `string repeat $str $count`: Repeats string $count times.
#    - `string replace $str $first $last ?new?: Replaces range from $first to $last.
#
# 2. APPLICATION IN THIS EXERCISE:
#    - Use `string length` to verify equal sequence lengths.
#    - Use `string index` to fetch characters at position $i for comparison (`ne`).
# ==============================================================================


proc hammingDistance {left right} {
    if {[string length $left] != [string length $right]} {
        error "strands must be of equal length"
    }

    set distance 0
    set len [string length $left]

    for {set i 0} {$i < $len} {incr i} {
        if {[string index $left $i] ne [string index $right $i]} {
            incr distance
        }
    }

    return $distance
}


