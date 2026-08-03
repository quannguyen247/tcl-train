# ==============================================================================
# EXERCISM TCL PRACTICE: DIFFIE-HELLMAN
# ==============================================================================

# YOUR SOLUTION CODE BELOW
# ==============================================================================

namespace eval diffieHellman {
    namespace export privateKey publicKey secret
    namespace ensemble create

    proc modPow {base exp mod} {
        set res 1
        set b [expr {$base % $mod}]
        set e $exp
        while {$e > 0} {
            if {$e % 2 == 1} {
                set res [expr {wide($res) * $b % $mod}]
            }
            set e [expr {$e / 2}]
            set b [expr {wide($b) * $b % $mod}]
        }
        return $res
    }

    proc privateKey {p} {
        return [expr {int(rand() * ($p - 2)) + 2}]
    }

    proc publicKey {p g privateKey} {
        return [modPow $g $privateKey $p]
    }

    proc secret {p publicKey privateKey} {
        return [modPow $publicKey $privateKey $p]
    }
}
