oo::class create SimpleCipher {
    variable cipherKey

    constructor {args} {
        if {[llength $args] == 0} {
            set k ""
            for {set i 0} {$i < 100} {incr i} {
                append k [format %c [expr {97 + int(rand() * 26)}]]
            }
            set cipherKey $k
        } else {
            set cipherKey [lindex $args 0]
        }
    }

    method key {} {
        return $cipherKey
    }

    method encode {phrase} {
        set res ""
        set klen [string length $cipherKey]
        for {set i 0} {$i < [string length $phrase]} {incr i} {
            scan [string index $phrase $i] %c p
            scan [string index $cipherKey [expr {$i % $klen}]] %c k
            set shift [expr {$k - 97}]
            set c [expr {97 + ($p - 97 + $shift) % 26}]
            append res [format %c $c]
        }
        return $res
    }

    method decode {phrase} {
        set res ""
        set klen [string length $cipherKey]
        for {set i 0} {$i < [string length $phrase]} {incr i} {
            scan [string index $phrase $i] %c c
            scan [string index $cipherKey [expr {$i % $klen}]] %c k
            set shift [expr {$k - 97}]
            set p [expr {97 + ($c - 97 - $shift + 26) % 26}]
            append res [format %c $p]
        }
        return $res
    }
}
