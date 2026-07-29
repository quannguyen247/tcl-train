proc solve {puzzle} {
    set puzzle [string map {"=" "=="} $puzzle]
    regexp -all {[A-Z]} $puzzle letters
    set unique_letters [lsort -unique $letters]
    if {[llength $unique_letters] > 10} { return {} }
    
    regexp -all {\b[A-Z]} $puzzle leading_list
    set leading [lsort -unique $leading_list]

    set digits {0 1 2 3 4 5 6 7 8 9}
    set n [llength $unique_letters]
    
    foreach perm [permutations $digits $n] {
        set map {}
        set valid 1
        for {set i 0} {$i < $n} {incr i} {
            set char [lindex $unique_letters $i]
            set val [lindex $perm $i]
            if {$val == 0 && [lsearch -exact $leading $char] != -1} {
                set valid 0
                break
            }
            lappend map $char $val
        }
        if {!$valid} continue
        set expr_str [string map $map $puzzle]
        if {[expr $expr_str]} {
            return $map
        }
    }
    return {}
}

proc permutations {items k} {
    if {$k == 0} { return {{}} }
    if {[llength $items] == 0} { return {} }
    set result {}
    for {set i 0} {$i < [llength $items]} {incr i} {
        set item [lindex $items $i]
        set rest [lreplace $items $i $i]
        foreach p [permutations $rest [expr {$k - 1}]] {
            lappend result [linsert $p 0 $item]
        }
    }
    return $result
}
