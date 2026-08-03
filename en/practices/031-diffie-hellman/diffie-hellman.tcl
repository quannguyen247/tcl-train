# ==============================================================================
# EXERCISM TCL PRACTICE: DIFFIE-HELLMAN
# ==============================================================================
# # Instructions
#
# Diffie-Hellman key exchange.
#
# Alice and Bob use Diffie-Hellman key exchange to share secrets.
# They start with prime numbers, pick private keys, generate and share public keys, and then generate a shared secret key.
#
# ## Step 0
#
# The test program supplies prime numbers p and g.
#
# ## Step 1
#
# Alice picks a private key, a, greater than 1 and less than p.
# Bob does the same to pick a private key b.
#
# ## Step 2
#
# Alice calculates a public key A.
#
#     A = gᵃ mod p
#
# Using the same p and g, Bob similarly calculates a public key B from his private key b.
#
# ## Step 3
#
# Alice and Bob exchange public keys.
# Alice calculates secret key s.
#
#     s = Bᵃ mod p
#
# Bob calculates
#
#     s = Aᵇ mod p
#
# The calculations produce the same result!
# Alice and Bob now share secret s.

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

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
