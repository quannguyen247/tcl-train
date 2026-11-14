# Exhaustive single stuck-at simulation of y = (a & b) ^ c.
# This model covers five named nets, not every fault in a real netlist.
proc circuit {a b c site stuck} {
    if {$site eq "a"} {set a $stuck}
    if {$site eq "b"} {set b $stuck}
    if {$site eq "c"} {set c $stuck}
    set n [expr {$a & $b}]
    if {$site eq "n"} {set n $stuck}
    set y [expr {$n ^ $c}]
    if {$site eq "y"} {set y $stuck}
    return $y
}

set faults [list]
foreach site {a b c n y} {
    foreach stuck {0 1} {lappend faults "$site/$stuck"}
}
set patterns [list]
set detection [dict create]
foreach a {0 1} {
    foreach b {0 1} {
        foreach c {0 1} {
            set pattern "$a$b$c"
            lappend patterns $pattern
            set golden [circuit $a $b $c none 0]
            foreach fault $faults {
                lassign [split $fault /] site stuck
                if {[circuit $a $b $c $site $stuck] != $golden} {
                    dict lappend detection $pattern $fault
                }
            }
        }
    }
}

# Greedily choose patterns covering the most currently uncovered faults.
set uncovered $faults
set selected [list]
while {[llength $uncovered]} {
    set best ""; set best_hits [list]
    foreach pattern $patterns {
        set hits [list]
        if {[dict exists $detection $pattern]} {
            foreach fault [dict get $detection $pattern] {
                if {$fault in $uncovered} {lappend hits $fault}
            }
        }
        if {[llength $hits] > [llength $best_hits]} {
            set best $pattern; set best_hits $hits
        }
    }
    if {$best eq ""} break
    lappend selected $best
    set remaining [list]
    foreach fault $uncovered {if {$fault ni $best_hits} {lappend remaining $fault}}
    set uncovered $remaining
}
set detected [expr {[llength $faults] - [llength $uncovered]}]
puts "Circuit: y = (a & b) ^ c; sites: a, b, c, n, y"
puts "All 8 input combinations evaluated; selected patterns: [join $selected {, }]"
puts [format "Detected %d/%d modeled stuck-at faults (%.2f%%)" \
    $detected [llength $faults] [expr {100.0*$detected/[llength $faults]}]]
if {[llength $uncovered]} {puts "Undetected modeled faults: $uncovered"}
puts "Coverage applies only to this explicit single-fault model."
