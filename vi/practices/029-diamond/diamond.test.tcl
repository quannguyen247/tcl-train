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
source "diamond.tcl"


test diamond-1 "Degenerate case with a single 'A' row" -body {
    diamond "A"
} -returnCodes ok -result [join {
    "A"
} \n]

skip diamond-2
test diamond-2 "Degenerate case with no row containing 3 distinct groups of spaces" -body {
    diamond "B"
} -returnCodes ok -result [join {
    " A "
    "B B"
    " A "
} \n]

skip diamond-3
test diamond-3 "Smallest non-degenerate case with odd diamond side length" -body {
    diamond "C"
} -returnCodes ok -result [join {
    "  A  "
    " B B "
    "C   C"
    " B B "
    "  A  "
} \n]

skip diamond-4
test diamond-4 "Smallest non-degenerate case with even diamond side length" -body {
    diamond "D"
} -returnCodes ok -result [join {
    "   A   "
    "  B B  "
    " C   C "
    "D     D"
    " C   C "
    "  B B  "
    "   A   "
} \n]

skip diamond-5
test diamond-5 "Largest possible diamond" -body {
    diamond "Z"
} -returnCodes ok -result [join {
    "                         A                         "
    "                        B B                        "
    "                       C   C                       "
    "                      D     D                      "
    "                     E       E                     "
    "                    F         F                    "
    "                   G           G                   "
    "                  H             H                  "
    "                 I               I                 "
    "                J                 J                "
    "               K                   K               "
    "              L                     L              "
    "             M                       M             "
    "            N                         N            "
    "           O                           O           "
    "          P                             P          "
    "         Q                               Q         "
    "        R                                 R        "
    "       S                                   S       "
    "      T                                     T      "
    "     U                                       U     "
    "    V                                         V    "
    "   W                                           W   "
    "  X                                             X  "
    " Y                                               Y "
    "Z                                                 Z"
    " Y                                               Y "
    "  X                                             X  "
    "   W                                           W   "
    "    V                                         V    "
    "     U                                       U     "
    "      T                                     T      "
    "       S                                   S       "
    "        R                                 R        "
    "         Q                               Q         "
    "          P                             P          "
    "           O                           O           "
    "            N                         N            "
    "             M                       M             "
    "              L                     L              "
    "               K                   K               "
    "                J                 J                "
    "                 I               I                 "
    "                  H             H                  "
    "                   G           G                   "
    "                    F         F                    "
    "                     E       E                     "
    "                      D     D                      "
    "                       C   C                       "
    "                        B B                        "
    "                         A                         "
} \n]


cleanupTests
