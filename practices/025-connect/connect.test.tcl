#!/usr/bin/env tclsh
# generated: 2026-07-24T19:22:54Z
package require tcltest
namespace import ::tcltest::*
#############################################################
# Override some tcltest procs with additional functionality

# Allow an environment variable to override `skip`
proc skip {args} {
    if {!( [info exists ::env(RUN_ALL)] && 
           [string is boolean -strict $::env(RUN_ALL)] &&
           $::env(RUN_ALL)
    )} {
        uplevel 1 [list ::tcltest::skip {*}$args]
    }
}

# Exit non-zero if any tests fail.
# The cleanupTests resets the numTests array, so capture it first.
proc cleanupTests {} {
    set failed [expr {$::tcltest::numTests(Failed) > 0}]
    uplevel 1 ::tcltest::cleanupTests
    if {$failed} then {exit 1}
}

#############################################################
# Some procs that are handy for Tcl test custom matching.
# ref http://www.tcl-lang.org/man/tcl8.6/TclCmd/tcltest.htm#M20

# Copy the needed procs into your test file.  Use it like this:
#
#    customMatch dictionary dictionaryMatch
#    test name "description" -body {
#        code that returns a dictionary
#    } -match dictionary -result {expected dictionary value here}


# Compare two dictionaries for the same keys and same values
proc dictionaryMatch {expected actual} {
    if {[dict size $expected] != [dict size $actual]} {
        return false
    }
    dict for {key value} $expected {
        if {![dict exists $actual $key]} {
            return false
        }
        set actualValue [dict get $actual $key]

        # if this value is a dict then recurse, 
        # else just check for string equality
        if {[string is list -strict $value] &&
            [llength $value] > 1 && 
            [llength $value] % 2 == 0
        } {
            set procname [lindex [info level 0] 0]
            if {![$procname $value $actualValue]} {
                return false
            }
        } elseif {$actualValue ne $value} {
            return false
        }
    }
    return true
}
customMatch dictionary dictionaryMatch


# Since Tcl boolean values can be more than just 0/1...
#   set a yes; set b true
#   expr  {$a == $b}     ;# => 0
#   expr  {$a && $b}     ;# => 1
#   expr  {!!$a == !!$b} ;# => 1
#   set a off; set b no
#   expr {$a == $b}      ;# => 0
#   expr {$a && $b}      ;# => 0
#   expr {!!$a == !!$b}  ;# => 1
#
proc booleanMatch {expected actual} {
    return [expr {
        [string is boolean -strict $expected] &&
        [string is boolean -strict $actual] &&
        !!$expected == !!$actual
    }]
}
customMatch boolean booleanMatch


# Compare two ordered lists without comparing the lists themselves 
# as strings.
# e.g.
#     set first {
#         a  b  c
#     }
#     set second [list a b c]
#     expr {$first eq $second}           ;# 0
#     expr {$first == $second}           ;# 0
#     orderedListsMatch $first $second   ;# true
#
proc orderedListsMatch {expected actual} {
    if {[llength $expected] != [llength $actual]} {
        return false
    }
    foreach e $expected a $actual {
        if {$e != $a} {
            return false
        }
    }
    return true
}
customMatch orderedLists orderedListsMatch


# two lists have the same elements, in no particular order
proc unorderedListsMatch {expected actual} {
    if {[llength $expected] != [llength $actual]} {
        return false
    }
    foreach elem $expected {
        if {[lsearch -exact $actual $elem] == -1} {
            return false
        }
    }
    return true
}
customMatch unorderedLists unorderedListsMatch


# Compare two ordered lists without comparing the lists themselves 
# as strings. Calls itself recursively.
proc listOfListsMatch {expected actual} {
    set procname [lindex [info level 0] 0]
    if {[llength $expected] != [llength $actual]} {
        return false
    }
    foreach e $expected a $actual {
        if {[llength $e] > 1 ? (![$procname $e $a]) : ($e != $a)} {
            return false
        }
    }
    return true
}
customMatch listOfLists listOfListsMatch


# The expected value is one of a list of values.
proc inListMatch {expectedList actual} {
    return [expr {$actual in $expectedList}]
}
customMatch inList inListMatch


# Compare  numbers: for example 5.0 == 5
proc numberMatch {expected actual} {
    return [expr {$expected == $actual}]
}
customMatch numbers numberMatch


# Compare floating point numbers 
proc floatMatch {expected actual {epsilon 1e-6}} {
    return [expr {abs($expected - $actual) <= $epsilon}]
}
customMatch float floatMatch


# Compare floating point numbers 
proc closeEnough {expected actual {epsilon 1.1}} {
    return [expr {abs($expected - $actual) <= $epsilon}]
}
customMatch approxEqual closeEnough


# Compare a list of floating point numbers 
proc listOfFloatsMatch {expected actual} {
    foreach e $expected a $actual {
        if {![floatMatch $e $a]} {
            return false
        }
    }
    return true
}

#############################################################
# Convenience function to set the precision of a real number.
proc roundTo {precision number} {
    return [format {%.*f} $precision $number]
}


# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "connect.tcl"


test connect-1 "an empty board has no winner" -body {
    winner {
        ". . . . ."
        " . . . . ."
        "  . . . . ."
        "   . . . . ."
        "    . . . . ."
    }
} -returnCodes ok -result ""

skip connect-2
test connect-2 "X can win on a 1x1 board" -body {
    winner {
        "X"
    }
} -returnCodes ok -result "X"

skip connect-3
test connect-3 "O can win on a 1x1 board" -body {
    winner {
        "O"
    }
} -returnCodes ok -result "O"

skip connect-4
test connect-4 "only edges does not make a winner" -body {
    winner {
        "O O O X"
        " X . . X"
        "  X . . X"
        "   X O O O"
    }
} -returnCodes ok -result ""

skip connect-5
test connect-5 "illegal diagonal does not make a winner" -body {
    winner {
        "X O . ."
        " O X X X"
        "  O X O ."
        "   . O X ."
        "    X X O O"
    }
} -returnCodes ok -result ""

skip connect-6
test connect-6 "nobody wins crossing adjacent angles" -body {
    winner {
        "X . . ."
        " . X O ."
        "  O . X O"
        "   . O . X"
        "    . . O ."
    }
} -returnCodes ok -result ""

skip connect-7
test connect-7 "X wins crossing from left to right" -body {
    winner {
        ". O . ."
        " O X X X"
        "  O X O ."
        "   X X O X"
        "    . O X ."
    }
} -returnCodes ok -result "X"

skip connect-8
test connect-8 "X wins with left-hand dead end fork" -body {
    winner {
        ". . X ."
        " X X . ."
        "  . X X X"
        "   O O O O"
    }
} -returnCodes ok -result "X"

skip connect-9
test connect-9 "X wins with right-hand dead end fork" -body {
    winner {
        ". . X X"
        " X X . ."
        "  . X X ."
        "   O O O O"
    }
} -returnCodes ok -result "X"

skip connect-10
test connect-10 "O wins crossing from top to bottom" -body {
    winner {
        ". O . ."
        " O X X X"
        "  O O O ."
        "   X X O X"
        "    . O X ."
    }
} -returnCodes ok -result "O"

skip connect-11
test connect-11 "X wins using a convoluted path" -body {
    winner {
        ". X X . ."
        " X . X . X"
        "  . X . X ."
        "   . X X . ."
        "    O O O O O"
    }
} -returnCodes ok -result "X"

skip connect-12
test connect-12 "X wins using a spiral path" -body {
    winner {
        "O X X X X X X X X"
        " O X O O O O O O O"
        "  O X O X X X X X O"
        "   O X O X O O O X O"
        "    O X O X X X O X O"
        "     O X O O O X O X O"
        "      O X X X X X O X O"
        "       O O O O O O O X O"
        "        X X X X X X X X O"
    }
} -returnCodes ok -result "X"


cleanupTests
