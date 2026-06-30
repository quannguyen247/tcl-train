proc parse {input} {
    set input [string trim $input]

    if {$input eq "" || [string index $input 0] ne "(" || [string index $input end] ne ")"} {
        error "tree missing"
    }

    set inner [string range $input 1 end-1]
    if {$inner eq "" || [string index $inner 0] ne ";"} {
        error "tree with no nodes"
    }

    set index 0
    return [parseNode $inner index]
}

proc parseNode {str indexVar} {
    upvar 1 $indexVar index
    set len [string length $str]

    if {$index >= $len || [string index $str $index] ne ";"} {
        error "tree with no nodes"
    }
    
    incr index

    set properties [dict create]

    while {$index < $len} {
        set char [string index $str $index]

        if {$char eq ";" || $char eq "(" || $char eq ")"} {
            break
        }

        set key ""
        while {$index < $len} {
            set c [string index $str $index]

            if {$c eq "\[" || $c eq ";" || $c eq "(" || $c eq ")" || $c eq " "} {
                break
            }

            if {[string is lower -strict $c]} {
                error "property must be in uppercase"
            }

            if {![string is upper -strict $c]} {
                error "properties without delimiter"
            }

            append key $c
            incr index
        }

        if {$key eq ""} {
            error "properties without delimiter"
        }

        if {$index >= $len || [string index $str $index] ne "\["} {
            error "properties without delimiter"
        }

        set values [list]
        while {$index < $len && [string index $str $index] eq "\["} {
            incr index ;# Bỏ qua '['

            set val ""
            set isEscaped 0

            while {$index < $len} {
                set c [string index $str $index]
                incr index

                if {$isEscaped} {
                    set isEscaped 0
                    switch -exact -- $c {
                        "n" { append val "\n" }
                        "t" { append val " " }
                        "\n" { continue }
                        "\t" { append val " " }
                        default { append val $c }
                    }
                } elseif {$c eq "\\"} {
                    set isEscaped 1
                } elseif {$c eq "\]"} {
                    break
                } else {
                    if {$c ne "\n" && [string is space $c]} {
                        set c " "
                    }
                    append val $c
                }
            }

            lappend values $val
        }

        dict set properties $key $values
    }

    set children [list]
    if {$index < $len} {
        set char [string index $str $index]

        if {$char eq ";"} {
            lappend children [parseNode $str index]
        } elseif {$char eq "("} {
            while {$index < $len && [string index $str $index] eq "("} {
                incr index
                lappend children [parseNode $str index]
                if {$index < $len && [string index $str $index] eq ")"} {
                    incr index
                }
            }
        }
    }

    return [dict create properties $properties children $children]
}
