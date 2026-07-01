if {"Tree" in [info commands]} {
    return
}

oo::class create Tree {
    variable nodeValue leftTree rightTree

    constructor {input} {
        set nodeValue [dict get $input value]
        set leftTree ""
        set rightTree ""

        if {[dict exists $input left]} {
            set leftTree [Tree new [dict get $input left]]
        }
        if {[dict exists $input right]} {
            set rightTree [Tree new [dict get $input right]]
        }
    }

    method value {} {return $nodeValue}
    method left {} {return $leftTree}
    method right {} {return $rightTree}

    method setValue {value} {set nodeValue $value}
    method setLeft {tree} {set leftTree $tree}
    method setRight {tree} {set rightTree $tree}

    method toDict {} {
        set result [dict create value $nodeValue]
        if {$leftTree ne ""} {
            dict set result left [$leftTree toDict]
        }
        if {$rightTree ne ""} {
            dict set result right [$rightTree toDict]
        }
        return $result
    }

    method equals {other} {
        return [expr {[my toDict] eq [$other toDict]}]
    }
}
