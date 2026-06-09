# ==============================================================================
# EXERCISM TCL PRACTICE: ISBN-VERIFIER
# ==============================================================================
# # Instructions
#
# The [ISBN-10 verification process][isbn-verification] is used to validate book identification numbers.
# These normally contain dashes and look like: `3-598-21508-8`
#
# ## ISBN
#
# The ISBN-10 format is 9 digits (0 to 9) plus one check character (either a digit or an X only).
# In the case the check character is an X, this represents the value '10'.
# These may be communicated with or without hyphens, and can be checked for their validity by the following formula:
#
# ```text
# (d₁ * 10 + d₂ * 9 + d₃ * 8 + d₄ * 7 + d₅ * 6 + d₆ * 5 + d₇ * 4 + d₈ * 3 + d₉ * 2 + d₁₀ * 1) mod 11 == 0
# ```
#
# If the result is 0, then it is a valid ISBN-10, otherwise it is invalid.
#
# ## Example
#
# Let's take the ISBN-10 `3-598-21508-8`.
# We plug it in to the formula, and get:
#
# ```text
# (3 * 10 + 5 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 1 * 5 + 5 * 4 + 0 * 3 + 8 * 2 + 8 * 1) mod 11 == 0
# ```
#
# Since the result is 0, this proves that our ISBN is valid.
#
# ## Task
#
# Given a string the program should check if the provided string is a valid ISBN-10.
# Putting this into place requires some thinking about preprocessing/parsing of the string prior to calculating the check digit for the ISBN.
#
# The program should be able to verify ISBN-10 both with and without separating dashes.
#
# ## Caveats
#
# Converting from strings to numbers can be tricky in certain languages.
# Now, it's even trickier since the check digit of an ISBN-10 may be 'X' (representing '10').
# For instance `3-598-21507-X` is a valid ISBN-10.
#
# [isbn-verification]: https://en.wikipedia.org/wiki/International_Standard_Book_Number

# ==============================================================================
# ALGORITHM & TCL SYNTAX NOTES
# ==============================================================================
# 1. STRING PREPROCESSING:
#    - Strip all hyphens using `string map {- ""} $isbn`.
#
# 2. PATTERN VALIDATION VIA REGEXP:
#    - `{^[0-9]{9}[0-9X]$}`: Exactly 9 digits followed by 1 digit or 'X' at the end.
#    - Returns `false` if format does not match.
#
# 3. CHECKSUM & MODULO 11:
#    - Convert 'X' to 10.
#    - Calculate weighted sum: `sum += val * (10 - i)`.
#    - Return `expr {$sum % 11 == 0}`.
# ==============================================================================

proc isValid {isbn} {
    set clean [string map {- ""} $isbn]
    if {![regexp {^\d{9}[\dX]$} $clean]} { return false }

    set sum 0
    set weight 10
    foreach char [split $clean ""] {
        set val [expr {$char eq "X" ? 10 : $char}]
        incr sum [expr {$val * $weight}]
        incr weight -1
    }
    return [expr {$sum % 11 == 0}]
}



