namespace eval listOps {
    proc append {listname values} {
        upvar 1 $listname list
        foreach value $values {
            lappend list $value
        }
    }

    proc concat {listOfLists} {
        set result {}
        foreach list $listOfLists {
            foreach value $list {
                lappend result $value
            }
        }
        return $result
    }

    proc filter {list func} {
        set result {}
        foreach value $list {
            if {[apply $func $value]} {
                lappend result $value
            }
        }
        return $result
    }

    proc length {list} {
        set count 0
        foreach value $list {
            incr count
        }
        return $count
    }

    proc map {list func} {
        set result {}
        foreach value $list {
            lappend result [apply $func $value]
        }
        return $result
    }

    proc foldl {list accumulator func} {
        foreach value $list {
            set accumulator [apply $func $accumulator $value]
        }
        return $accumulator
    }

    proc foldr {list accumulator func} {
        foreach value [reverse $list] {
            set accumulator [apply $func $accumulator $value]
        }
        return $accumulator
    }

    proc reverse {list} {
        set result {}
        foreach value $list {
            set result [linsert $result 0 $value]
        }
        return $result
    }
}
