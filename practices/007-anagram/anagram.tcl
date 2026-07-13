# ==============================================================================
# EXERCISM TCL PRACTICE: ANAGRAM
# ==============================================================================
# # Instructions
#
# Given a target word and one or more candidate words, your task is to find the candidates that are anagrams of the target.
#
# An anagram is a rearrangement of letters to form a new word: for example `"owns"` is an anagram of `"snow"`.
# A word is _not_ its own anagram: for example, `"stop"` is not an anagram of `"stop"`.
#
# The target word and candidate words are made up of one or more ASCII alphabetic characters (`A`-`Z` and `a`-`z`).
# Lowercase and uppercase characters are equivalent: for example, `"PoTS"` is an anagram of `"sTOp"`, but `"StoP"` is not an anagram of `"sTOp"`.
# The words you need to find should be taken from the candidate words, using the same letter case.
#
# Given the target `"stone"` and the candidate words `"stone"`, `"tones"`, `"banana"`, `"tons"`, `"notes"`, and `"Seton"`, the anagram words you need to find are `"tones"`, `"notes"`, and `"Seton"`.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

# ==============================================================================
# ALGORITHM & CORE STRATEGY
# ==============================================================================
# 1. CANONICAL FORM TRICK:
#    - An anagram is a permutation of letters.
#    - We bring words into a "Canonical Form" by:
#      a. Converting to lowercase (`string tolower`).
#      b. Splitting into a list of characters (`split $word ""`).
#      c. Sorting characters alphabetically (`lsort`).
#    - Example: "stone", "tones", and "Seton" all normalize to {e n o s t}.
#    - Checking for anagrams becomes a simple equality check: `cand_sorted eq sub_sorted`.
#
# 2. EXCLUSION RULE:
#    - A candidate cannot be identical to the target word (`cand_lower ne sub_lower`).
# ==============================================================================

proc findAnagrams {subject candidates} {
    # 1. Normalize target word to its Canonical Form
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]

    # 2. Initialize empty result list
    set result {}
    
    # 3. Iterate over each candidate word
    foreach cand $candidates {
        set cand_lower [string tolower $cand]
        
        # Candidate must not be identical to the subject word
        if {$cand_lower ne $sub_lower} {
            # Convert candidate to Canonical Form
            set cand_sorted [lsort [split $cand_lower ""]]
            
            # Compare Canonical Forms
            if {$cand_sorted eq $sub_sorted} {
                # Append original candidate word (preserving original case)
                lappend result $cand
            }
        }
    }
    
    return $result
}

