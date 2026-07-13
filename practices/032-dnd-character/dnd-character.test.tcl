#!/usr/bin/env tclsh
# generated: 2026-07-17T19:20:41Z
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
source "dnd-character.tcl"


test dnd-character-1 "ability modifier for score 3 is -4" -body {
    dnd modifier 3
} -returnCodes ok -result -4

skip dnd-character-2
test dnd-character-2 "ability modifier for score 4 is -3" -body {
    dnd modifier 4
} -returnCodes ok -result -3

skip dnd-character-3
test dnd-character-3 "ability modifier for score 5 is -3" -body {
    dnd modifier 5
} -returnCodes ok -result -3

skip dnd-character-4
test dnd-character-4 "ability modifier for score 6 is -2" -body {
    dnd modifier 6
} -returnCodes ok -result -2

skip dnd-character-5
test dnd-character-5 "ability modifier for score 7 is -2" -body {
    dnd modifier 7
} -returnCodes ok -result -2

skip dnd-character-6
test dnd-character-6 "ability modifier for score 8 is -1" -body {
    dnd modifier 8
} -returnCodes ok -result -1

skip dnd-character-7
test dnd-character-7 "ability modifier for score 9 is -1" -body {
    dnd modifier 9
} -returnCodes ok -result -1

skip dnd-character-8
test dnd-character-8 "ability modifier for score 10 is 0" -body {
    dnd modifier 10
} -returnCodes ok -result 0

skip dnd-character-9
test dnd-character-9 "ability modifier for score 11 is 0" -body {
    dnd modifier 11
} -returnCodes ok -result 0

skip dnd-character-10
test dnd-character-10 "ability modifier for score 12 is +1" -body {
    dnd modifier 12
} -returnCodes ok -result 1

skip dnd-character-11
test dnd-character-11 "ability modifier for score 13 is +1" -body {
    dnd modifier 13
} -returnCodes ok -result 1

skip dnd-character-12
test dnd-character-12 "ability modifier for score 14 is +2" -body {
    dnd modifier 14
} -returnCodes ok -result 2

skip dnd-character-13
test dnd-character-13 "ability modifier for score 15 is +2" -body {
    dnd modifier 15
} -returnCodes ok -result 2

skip dnd-character-14
test dnd-character-14 "ability modifier for score 16 is +3" -body {
    dnd modifier 16
} -returnCodes ok -result 3

skip dnd-character-15
test dnd-character-15 "ability modifier for score 17 is +3" -body {
    dnd modifier 17
} -returnCodes ok -result 3

skip dnd-character-16
test dnd-character-16 "ability modifier for score 18 is +4" -body {
    dnd modifier 18
} -returnCodes ok -result 4





skip dnd-character-17
test dnd-character-17 "random ability is within range" -body {
    set result true
    for {set i 0} {$i < 10000} {incr i} {
        set a [dnd ability]
        if {$a < 3 || $a > 18} {
            set result false
            break
        }
    }
    set result
} -returnCodes ok -match boolean -result true

skip dnd-character-18
test dnd-character-18 "a character is a well-formed dict" -body {
    set character [dnd character]
    expr {[string is list -strict $character] && [llength $character] % 2 == 0}
} -returnCodes ok -match boolean -result true

skip dnd-character-19
test dnd-character-19 "a character has the correct attributes" -body {
    set character [dnd character]
    lsort [dict keys $character]
} -returnCodes ok -match unorderedLists -result {charisma constitution dexterity hitpoints intelligence strength wisdom}

skip dnd-character-20
test dnd-character-20 "characteristics have the correct values" -body {
    set character [dnd character]
    dict with character {
        expr {
            3 <= $charisma && $charisma <= 18 &&
            3 <= $constitution && $constitution <= 18 &&
            3 <= $dexterity && $dexterity <= 18 &&
            3 <= $intelligence && $intelligence <= 18 &&
            3 <= $strength && $strength <= 18 &&
            3 <= $wisdom && $wisdom <= 18 &&
            $hitpoints == 10 + [dnd modifier $constitution]
        }
    }
} -returnCodes ok -match boolean -result true

cleanupTests
