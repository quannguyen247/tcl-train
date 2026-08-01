namespace eval DotFile {
    proc parseGraph {definition} {
        set graph [dict create nodes {} edges {} attrs {}]
        foreach line [split $definition "\n"] {
            lassign [parseLine $line] words attr
            if {$words eq {}} {
                if {$attr ne {}} {dict set graph attrs \
                    [dict merge [dict get $graph attrs] $attr]}
                continue
            }

            if {[regexp {^(//|#)} [lindex $words 0]]} {continue}

            if {[llength $words] == 1} {
                addNode graph [lindex $words 0] $attr
                continue
            }

            while {[llength $words] > 1} {
                set words [lassign $words from type to]
                if {$type ne "--" || $to eq ""} {
                    error "invalid edge"
                }

                addNode graph $from {}
                addNode graph $to {}
                set edge [lsort -dictionary [list $from $to]]

                if {![dict exists $graph edges $edge]} {
                    dict set graph edges $edge {}
                }

                dict set graph edges $edge \
                    [dict merge [dict get $graph edges $edge] $attr]
                set words [linsert $words 0 $to]
            }
        }
        return $graph
    }

    proc parseLine {line} {
        set line [string trim $line]
        regsub {;[[:space:]]*$} $line "" line
        set attr {}

        if {[regexp {^(.*)[[:space:]]*\[([^\]]*)\]$} \
            $line -> line attrText]} {
            if {![regexp {^([[:alnum:]_]+)=(.+)$} \
                $attrText -> key value]} {
                error "invalid attribute"
            }

            set value [string trim $value]
            regsub {^"(.*)"$} $value {\1} value
            set attr [list $key $value]
        } elseif {[string first "\[" $line] >= 0} {
            error "invalid attribute"
        }

        return [list [split [string trim $line]] $attr]
    }

    proc addNode {graphVar name attr} {
        upvar 1 $graphVar graph

        if {![regexp {^[[:alnum:]]+$} $name]} {
            error "node name must be alphanumeric"
        }

        if {![dict exists $graph nodes $name]} {
            dict set graph nodes $name {}
        }

        dict set graph nodes $name [dict merge \
            [dict get $graph nodes $name] $attr]
    }
}

proc processDotFile {filename} {
    if {![file readable $filename]} {
        error "cannot read file"
    }

    set file [open $filename]
    set source [read $file]
    close $file

    set safe [interp create -safe]
    $safe alias graph ::DotFile::parseGraph

    try {
        return [$safe eval $source]
    } finally {
        interp delete $safe
    }
}
