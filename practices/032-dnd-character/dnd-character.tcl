# ==============================================================================
# EXERCISM TCL PRACTICE: DND-CHARACTER
# ==============================================================================

# YOUR SOLUTION CODE BELOW
# ==============================================================================

namespace eval dnd {
    namespace export modifier ability character
    namespace ensemble create

    proc modifier {score} {
        return [expr {int(floor(($score - 10) / 2.0))}]
    }

    proc ability {} {
        set rolls {}
        for {set i 0} {$i < 4} {incr i} {
            lappend rolls [expr {int(rand() * 6) + 1}]
        }
        set sorted [lsort -integer $rolls]
        return [expr {[lindex $sorted 1] + [lindex $sorted 2] + [lindex $sorted 3]}]
    }

    proc character {} {
        set str [ability]
        set dex [ability]
        set con [ability]
        set intel [ability]
        set wis [ability]
        set cha [ability]
        set hp [expr {10 + [modifier $con]}]
        return [dict create strength $str dexterity $dex constitution $con intelligence $intel wisdom $wis charisma $cha hitpoints $hp]
    }
}
