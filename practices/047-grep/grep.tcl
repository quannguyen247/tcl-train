proc grep {args} {
    set flags [dict create n 0 l 0 i 0 v 0 x 0]
    set options $args

    while {[string match -* [lindex $options 0]]} {
        foreach flag [split [string range [lindex $options 0] 1 end] ""] {
            if {[dict exists $flags $flag]} {
                dict set flags $flag 1
            }
        }
        set options [lrange $options 1 end]
    }

    set pattern [lindex $options 0]
    set files [lrange $options 1 end]
    set showName [expr {[llength $files] > 1}]
    set result {}

    foreach fileName $files {
        set channel [open $fileName r]
        set lines [split [read $channel] "\n"]
        close $channel

        if {[lindex $lines end] eq {}} {
            set lines [lrange $lines 0 end-1]
        }

        set fileMatch false
        set lineNumber 0

        foreach line $lines {
            incr lineNumber

            if {[dict get $flags x]} {
                if {[dict get $flags i]} {
                    set match [string equal -nocase $pattern $line]
                } else {
                    set match [string equal $pattern $line]
                }
            } else {
                if {[dict get $flags i]} {
                    set match [expr {
                        [string first [string tolower $pattern] \
                            [string tolower $line]] >= 0
                    }]
                } else {
                    set match [expr {[string first $pattern $line] >= 0}]
                }
            }

            if {[dict get $flags v]} {
                set match [expr {!$match}]
            }

            if {!$match} {
                continue
            }

            set fileMatch true
            if {[dict get $flags l]} {
                continue
            }

            set prefix ""
            if {$showName} {
                append prefix "$fileName:"
            }
            if {[dict get $flags n]} {
                append prefix "$lineNumber:"
            }

            lappend result "$prefix$line"
        }

        if {$fileMatch && [dict get $flags l]} {
            lappend result $fileName
        }
    }

    return [join $result "\n"]
}
