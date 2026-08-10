oo::class create Node {
    variable datum
    variable next

    constructor {value} {
        set datum $value
        set next ""
    }

    method datum {} { return $datum }

        method next {args} {
            if {[llength $args] == 1} { set next [lindex $args 0] }
            return $next
        }
}

oo::class create SimpleLinkedList {
    variable head

    constructor {{values {}}} {
        set head ""
        foreach v $values {
            my push [Node new $v]
        }
    }

    method push {node} {
        $node next $head
        set head $node
        return [self]
    }

    method pop {} {
        if {$head eq ""} { return "" }
        set node $head
        set head [$head next]
        return $node
    }

    method toList {} {
        set res {}
        set curr $head
        while {$curr ne ""} {
            lappend res [$curr datum]
            set curr [$curr next]
        }
        return $res
    }

    method reverse {} {
        set prev ""
        set curr $head
        while {$curr ne ""} {
            set nxt [$curr next]
            $curr next $prev
            set prev $curr
            set curr $nxt
        }
        set head $prev
        return [self]
    }

    method foreach {varName body} {
        upvar 1 $varName var
        set curr $head
        while {$curr ne ""} {
            set var $curr
            uplevel 1 $body
            set curr [$curr next]
        }
    }
}
