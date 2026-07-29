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

    method empty {} {
        return [my empty?]
    }

    method isEmpty {} {
        return [my empty?]
    }

    method contains? {element} {
        return [expr {[lsearch -exact $elems $element] != -1}]
    }

    method contains {element} {
        return [my contains? $element]
    }

    method subset? {otherSet} {
        foreach e $elems {
            if {![$otherSet contains? $e]} {
                return false
            }
        }
        return true
    }

    method subset {otherSet} {
        return [my subset? $otherSet]
    }

    method subsetOf {otherSet} {
        return [my subset? $otherSet]
    }

    method disjoint? {otherSet} {
        foreach e $elems {
            if {[$otherSet contains? $e]} {
                return false
            }
        }
        return true
    }

    method disjoint {otherSet} {
        return [my disjoint? $otherSet]
    }

    method equals? {otherSet} {
        return [expr {[my subset? $otherSet] && [$otherSet subset? [self]]}]
    }

    method equals {otherSet} {
        return [my equals? $otherSet]
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

interp alias {} Set {} CustomSet
