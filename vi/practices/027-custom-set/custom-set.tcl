# ==============================================================================
# EXERCISM TCL PRACTICE: CUSTOM-SET
# ==============================================================================
# # Instructions
#
# Create a custom set type.
#
# Sometimes it is necessary to define a custom data structure of some type, like a set.
# In this exercise you will define your own set.
# How it works internally doesn't matter, as long as it behaves like a set of unique elements.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create CustomSet {
    variable elems

    constructor {{elements {}}} {
        set elems {}
        foreach e $elements {
            if {[lsearch -exact $elems $e] == -1} {
                lappend elems $e
            }
        }
    }

    method getElements {} {
        return $elems
    }

    method empty? {} {
        return [expr {[llength $elems] == 0}]
    }

    method contains? {element} {
        return [expr {[lsearch -exact $elems $element] != -1}]
    }

    method subset? {otherSet} {
        foreach e $elems {
            if {![$otherSet contains? $e]} {
                return false
            }
        }
        return true
    }

    method disjoint? {otherSet} {
        foreach e $elems {
            if {[$otherSet contains? $e]} {
                return false
            }
        }
        return true
    }

    method equals? {otherSet} {
        return [expr {[my subset? $otherSet] && [$otherSet subset? [self]]}]
    }

    method add {element} {
        if {![my contains? $element]} {
            lappend elems $element
        }
        return [self]
    }

    method intersection {otherSet} {
        set res {}
        foreach e $elems {
            if {[$otherSet contains? $e]} {
                lappend res $e
            }
        }
        return [CustomSet new $res]
    }

    method difference {otherSet} {
        set res {}
        foreach e $elems {
            if {![$otherSet contains? $e]} {
                lappend res $e
            }
        }
        return [CustomSet new $res]
    }

    method union {otherSet} {
        set res $elems
        foreach e [$otherSet getElements] {
            if {[lsearch -exact $res $e] == -1} {
                lappend res $e
            }
        }
        return [CustomSet new $res]
    }

    method size {} {
        return [llength $elems]
    }

    method toList {} {
        return [lsort -integer $elems]
    }
}
