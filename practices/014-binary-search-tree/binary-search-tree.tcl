oo::class create BinarySearchTree {
    variable value
    variable leftNode
    variable rightNode

    constructor {} {
        set value ""
        set leftNode ""
        set rightNode ""
    }

    method data {} {
        return $value
    }

    method insert {val} {
        if {$value eq ""} {
            set value $val
        } elseif {$val <= $value} {
            if {$leftNode eq ""} {
                set leftNode [BinarySearchTree new]
            }
            $leftNode insert $val
        } else {
            if {$rightNode eq ""} {
                set rightNode [BinarySearchTree new]
            }
            $rightNode insert $val
        }
    }

    method toDict {} {
        if {$value eq ""} {
            return {}
        }
        set ldict [expr {$leftNode eq "" ? {} : [$leftNode toDict]}]
        set rdict [expr {$rightNode eq "" ? {} : [$rightNode toDict]}]
        return [dict create data $value left $ldict right $rdict]
    }

    method sorted {} {
        if {$value eq ""} {
            return {}
        }
        set llist [expr {$leftNode eq "" ? {} : [$leftNode sorted]}]
        set rlist [expr {$rightNode eq "" ? {} : [$rightNode sorted]}]
        return [concat $llist [list $value] $rlist]
    }

    method map {varname body} {
        upvar 1 $varname var
        set res {}
        if {$leftNode ne ""} {
            set res [concat $res [$leftNode map $varname $body]]
        }
        if {$value ne ""} {
            set var [self]
            lappend res [uplevel 1 $body]
        }
        if {$rightNode ne ""} {
            set res [concat $res [$rightNode map $varname $body]]
        }
        return $res
    }
}
