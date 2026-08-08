proc secretHandshake {code} {
    set res {}
    if {$code & 1} { lappend res "wink" }
    if {$code & 2} { lappend res "double blink" }
    if {$code & 4} { lappend res "close your eyes" }
    if {$code & 8} { lappend res "jump" }
    if {$code & 16} { set res [lreverse $res] }
    return $res
}
