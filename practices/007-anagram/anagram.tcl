proc findAnagrams {subject candidates} {
    # 1. Normalize target word to its Canonical Form
    set sub_lower [string tolower $subject]
    set sub_sorted [lsort [split $sub_lower ""]]

    # 2. Initialize empty result list
    set result {}
    
    # 3. Iterate over each candidate word
    foreach cand $candidates {
        set cand_lower [string tolower $cand]
        
        # Candidate must not be identical to the subject word
        if {$cand_lower ne $sub_lower} {
            # Convert candidate to Canonical Form
            set cand_sorted [lsort [split $cand_lower ""]]
            
            # Compare Canonical Forms
            if {$cand_sorted eq $sub_sorted} {
                # Append original candidate word (preserving original case)
                lappend result $cand
            }
        }
    }
    
    return $result
}

