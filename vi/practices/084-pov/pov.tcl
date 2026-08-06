proc findNodePath {tree label} {
    # Tìm đường từ gốc đến nút cần tìm
    if {[dict get $tree label] eq $label} {
        return [list $tree]
    }

    if {[dict exists $tree children]} {
        foreach child [dict get $tree children] {
            set found [findNodePath $child $label]
            if {$found ne {}} {
                return [linsert $found 0 $tree]
            }
        }
    }
    return {}
}

proc fromPov {treeInput label} {
    set nodes [findNodePath $treeInput $label]
    if {$nodes eq {}} {
        error "no such target"
    }

    # Đảo quan hệ cha con trên đường đến gốc mới
    set result {}
    for {set i 0} {$i < [llength $nodes]} {incr i} {
        set node [lindex $nodes $i]

        if {$i < [llength $nodes] - 1} {
            set nextLabel [dict get [lindex $nodes [expr {$i + 1}]] label]
            set children {}

            foreach child [dict get $node children] {
                if {[dict get $child label] ne $nextLabel} {
                    lappend children $child
                }
            }

            if {$children eq {}} {
                dict unset node children
            } else {
                dict set node children $children
            }
        }

        # Đưa nút cha cũ xuống làm con
        if {$result ne {}} {
            dict lappend node children $result
        }
        set result $node
    }
    return $result
}

proc path {treeInput fromLabel toLabel} {
    # Đưa điểm bắt đầu lên gốc rồi tìm điểm đích
    if {[catch {set tree [fromPov $treeInput $fromLabel]}]} {
        error "no such label"
    }

    set nodes [findNodePath $tree $toLabel]
    if {$nodes eq {}} {
        error "no such label"
    }
    return [lmap node $nodes {dict get $node label}]
}
