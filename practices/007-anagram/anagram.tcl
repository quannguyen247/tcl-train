proc findAnagrams {subject candidates} {
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]

    set result {}

    foreach cand $candidates {
        set cand_lower [string tolower $cand]

        if {$cand_lower ne $sub_lower} {
            set cand_sorted [lsort [split $cand_lower ""]]

            if {$cand_sorted eq $sub_sorted} {
                lappend result $cand
            }
        }
    }

    return $result
}
