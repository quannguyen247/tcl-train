source "tree.tcl"

oo::class create Zipper {
    variable focus parent side

    constructor {aTree {aParent ""} {aSide ""}} {
        set focus $aTree
        set parent $aParent
        set side $aSide
    }

    method tree {} {
        if {$parent eq ""} {
            return $focus
        }
        return [$parent tree]
    }

    method value {} {
        return [$focus value]
    }

    method left {} {
        set child [$focus left]
        if {$child eq ""} {
            return ""
        }
        return [Zipper new $child [self] left]
    }

    method right {} {
        set child [$focus right]
        if {$child eq ""} {
            return ""
        }
        return [Zipper new $child [self] right]
    }

    method up {} {
        return $parent
    }

    method setValue {value} {
        $focus setValue $value
        return [self]
    }

    method setLeft {tree} {
        $focus setLeft $tree
        return [self]
    }

    method setRight {tree} {
        $focus setRight $tree
        return [self]
    }

    method path {} {
        if {$parent eq ""} {
            return {}
        }
        return [concat [$parent path] $side]
    }

    method equals {other} {
        return [expr {
            [my path] eq [$other path]
            && [[my tree] toDict] eq [[$other tree] toDict]
        }]
    }
}
