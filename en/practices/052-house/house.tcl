# ==============================================================================
# EXERCISM TCL PRACTICE: HOUSE
# ==============================================================================
# # Instructions
#
# Recite the nursery rhyme 'This is the House that Jack Built'.
#
# > [The] process of placing a phrase of clause within another phrase of clause is called embedding.
# > It is through the processes of recursion and embedding that we are able to take a finite number of forms (words and phrases) and construct an infinite number of expressions.
# > Furthermore, embedding also allows us to construct an infinitely long structure, in theory anyway.
#
# - [papyr.com][papyr]
#
# The nursery rhyme reads as follows:
#
# ```text
# This is the house that Jack built.
#
# This is the malt
# that lay in the house that Jack built.
#
# This is the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the farmer sowing his corn
# that kept the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
#
# This is the horse and the hound and the horn
# that belonged to the farmer sowing his corn
# that kept the rooster that crowed in the morn
# that woke the priest all shaven and shorn
# that married the man all tattered and torn
# that kissed the maiden all forlorn
# that milked the cow with the crumpled horn
# that tossed the dog
# that worried the cat
# that killed the rat
# that ate the malt
# that lay in the house that Jack built.
# ```
#
# [papyr]: https://papyr.com/hypertextbooks/grammar/ph_noun.htm

# ==============================================================================
# ALGORITHM & TCL SYNTAX NOTES
# ==============================================================================
# 1. SENTENCE PATTERN & LIST MANIPULATION:
#    - Each clause is structured as "the [noun] [verb]" (e.g. "the malt that lay in").
#    - Slice sublist from 0 to i-1 using `[lrange $s 0 $i-1]`.
#    - Reverse the sublist using `lreverse` to match recursive embedding order.
#
# 2. TCL MINIMALIST TRICKS:
#    - `lappend res ...`: Automatically initializes `res` to empty list if undefined.
#    - `join [lreverse ...]`: Defaults to single space `" "` separation if 2nd arg omitted.
#    - `join $res \n`: Last command result in proc automatically acts as return value.
# ==============================================================================

proc recite {from to} {
    set s {
        "the house that Jack built."
        "the malt that lay in"
        "the rat that ate"
        "the cat that killed"
        "the dog that worried"
        "the cow with the crumpled horn that tossed"
        "the maiden all forlorn that milked"
        "the man all tattered and torn that kissed"
        "the priest all shaven and shorn that married"
        "the rooster that crowed in the morn that woke"
        "the farmer sowing his corn that kept"
        "the horse and the hound and the horn that belonged to"
    }

    # Iterate from verse $from to $to
    for {set i $from} {$i <= $to} {incr i} {
        # [lrange $s 0 $i-1]: Slice list from 0 to i-1
        # [lreverse ...]: Reverse clause list
        # [join ...]: Join clauses with default space
        # lappend auto-initializes res
        lappend res "This is [join [lreverse [lrange $s 0 $i-1]]]"
    }

    # Join verses with newline
    return [join $res "\n"]
}







