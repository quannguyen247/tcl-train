proc parse {input} {
    set input [string trim $input]
    if {$input eq "" || [string index $input 0] ne "(" || [string index $input end] ne ")"} {
        error "tree missing"
    }
    
    set inner [string range $input 1 end-1]
    if {$inner eq "" || [string index $inner 0] ne ";"} {
        error "tree with no nodes"
    }

    set idx 0
    return [parseNode $inner idx]
}

proc parseNode {str idxVar} {
    upvar 1 $idxVar idx
    set len [string length $str]
    
    if {$idx >= $len || [string index $str $idx] ne ";"} {
        error "tree with no nodes"
    }
    incr idx

    set props [dict create]
    
    while {$idx < $len} {
        set c [string index $str $idx]
        if {$c eq ";" || $c eq "(" || $c eq ")"} { break }
        
        set key ""
        while {$idx < $len} {
            set c [string index $str $idx]
            if {$c eq "\[" || $c eq ";" || $c eq "(" || $c eq ")" || $c eq " "} { break }
            if {[string is lower -strict $c]} { error "property must be in uppercase" }
            if {![string is upper -strict $c]} { error "properties without delimiter" }
            append key $c
            incr idx
        }
        
        if {$key eq "" || $idx >= $len || [string index $str $idx] ne "\["} {
            error "properties without delimiter"
        }

        set values [list]
        while {$idx < $len && [string index $str $idx] eq "\["} {
            incr idx
            set val ""
            set escaped 0
            
            while {$idx < $len} {
                set c [string index $str $idx]
                incr idx
                
                if {$escaped} {
                    set escaped 0
                    if {$c eq "n"} { set c "\n" }
                    if {$c eq "t"} { set c "\t" }
                    append val $c
                } elseif {$c eq "\\"} {
                    set escaped 1
                } elseif {$c eq "\]"} {
                    break
                } else {
                    append val $c
                }
            }
            
            regsub -all "\t" $val " " val
            regsub -all {\\([tn ])} $val {\1} val
            regsub -all {\\\n} $val {} val
            
            lappend values $val
        }
        dict set props $key $values
    }

    set children [list]
    if {$idx < $len} {
        set c [string index $str $idx]
        if {$c eq ";"} {
            lappend children [parseNode $str idx]
        } elseif {$c eq "("} {
            while {$idx < $len && [string index $str $idx] eq "("} {
                incr idx
                lappend children [parseNode $str idx]
                if {$idx < $len && [string index $str $idx] eq ")"} {
                    incr idx
                }
            }
        }
    }
    return [dict create properties $props children $children]
}
