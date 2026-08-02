oo::class create LinkedList {
    variable list

    constructor {} { set list {} }

    method push {value} { lappend list $value }

    method unshift {value} { set list [linsert $list 0 $value] }

    method pop {} {
        set val [lindex $list end]
        set list [lrange $list 0 end-1]
        return $val
    }

    method shift {} {
        set val [lindex $list 0]
        set list [lrange $list 1 end]
        return $val
    }

    method length {} { return [llength $list] }

    method delete {value} {
        set idx [lsearch -exact $list $value]
        if {$idx != -1} { set list [lreplace $list $idx $idx] }
    }

    method for {varname script} {
        upvar 1 $varname var
        foreach val $list {
            set var $val
            uplevel 1 $script
        }
    }
}
