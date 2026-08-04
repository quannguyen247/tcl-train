proc clean {phone} {
    if {[regexp {[a-zA-Z]} $phone]} {
        return -code error "letters not permitted"
    }
    if {[regexp {[^0-9\s\.\-\+\(\)]} $phone]} {
        return -code error "punctuations not permitted"
    }
    regsub -all {[^0-9]} $phone "" phone

    set len [string length $phone]
    if {$len < 10} {
        return -code error "must not be fewer than 10 digits"
    } elseif {$len > 11} {
        return -code error "must not be greater than 11 digits"
    } elseif {$len == 11} {
        if {[string index $phone 0] ne "1"} {
            return -code error "11 digits must start with 1"
        }
        set phone [string range $phone 1 end]
    }

    if {[string index $phone 0] eq "0"} {
        return -code error "area code cannot start with zero"
    } elseif {[string index $phone 0] eq "1"} {
        return -code error "area code cannot start with one"
    }
    if {[string index $phone 3] eq "0"} {
        return -code error "exchange code cannot start with zero"
    } elseif {[string index $phone 3] eq "1"} {
        return -code error "exchange code cannot start with one"
    }

    return $phone
}
