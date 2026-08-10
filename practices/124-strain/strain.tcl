proc keep {varname list condition} {
    upvar 1 $varname v
    set res {}
    foreach v $list {
        if {[uplevel 1 $condition]} { lappend res $v }
    }
    return $res
}

proc discard {varname list condition} {
    upvar 1 $varname v
    set res {}
    foreach v $list {
        if {![uplevel 1 $condition]} { lappend res $v }
    }
    return $res
}
