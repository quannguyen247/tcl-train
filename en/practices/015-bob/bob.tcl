# ==============================================================================
# EXERCISM TCL PRACTICE: BOB
# ==============================================================================
# # Instructions
#
# Your task is to determine what Bob will reply to someone when they say something to him or ask him a question.
#
# Bob only ever answers one of five things:
#
# - **"Sure."**
#   This is his response if you ask him a question, such as "How are you?"
#   The convention used for questions is that it ends with a question mark.
# - **"Whoa, chill out!"**
#   This is his answer if you YELL AT HIM.
#   The convention used for yelling is ALL CAPITAL LETTERS.
# - **"Calm down, I know what I'm doing!"**
#   This is what he says if you yell a question at him.
# - **"Fine. Be that way!"**
#   This is how he responds to silence.
#   The convention used for silence is nothing, or various combinations of whitespace characters.
# - **"Whatever."**
#   This is what he answers to anything else.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc heyBob {stimulus} {
    set s [string trim $stimulus]
    if {$s eq ""} {
        return "Fine. Be that way!"
    }
    set is_yelling [expr {[regexp {[A-Z]} $s] && ![regexp {[a-z]} $s]}]
    set is_question [expr {[string match "*\?" $s]}]
    if {$is_yelling && $is_question} {
        return "Calm down, I know what I'm doing!"
    }
    if {$is_yelling} {
        return "Whoa, chill out!"
    }
    if {$is_question} {
        return "Sure."
    }
    return "Whatever."
}
