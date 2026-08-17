lappend auto_path lib
package require permutations

interp alias {} permutations {} ::permutations::permutationsOfSize {1 2 3 4 5} 5

oo::class create ZebraPuzzle {
    variable waterDrinker zebraOwner

    constructor {args} {
        set perms [permutations]

        foreach color_perm $perms {
            lassign $color_perm red green ivory yellow blue
            if {$green != $ivory + 1 || $blue != 2} continue

            foreach nat_perm $perms {
                lassign $nat_perm englishman spaniard ukrainian norwegian japanese
                if {$norwegian != 1 || $englishman != $red} continue

                foreach drink_perm $perms {
                    lassign $drink_perm coffee tea milk orangeJuice water
                    if {$milk != 3 || $coffee != $green || $ukrainian != $tea} continue

                    foreach hobby_perm $perms {
                        lassign $hobby_perm dancing painter football chess reading
                        if {$painter != $yellow || $football != $orangeJuice || $japanese != $chess} continue

                        foreach pet_perm $perms {
                            lassign $pet_perm dog snails fox horse zebra
                            if {$spaniard != $dog || $snails != $dancing} continue
                            if {abs($reading - $fox) != 1} continue
                            if {abs($painter - $horse) != 1} continue

                            set natMap [list $norwegian Norwegian $japanese Japanese $englishman Englishman $spaniard Spaniard $ukrainian Ukrainian]
                            set waterDrinker [dict get $natMap $water]
                            set zebraOwner [dict get $natMap $zebra]
                            return
                        }
                    }
                }
            }
        }
    }

    method drinksWater {} {
        return $waterDrinker
    }

    method ownsZebra {} {
        return $zebraOwner
    }
}
