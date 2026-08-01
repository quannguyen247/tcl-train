proc dominoChain {dominoes} {
    if {[llength $dominoes] == 0} { return true }
    set first [lindex $dominoes 0]
    set rest [lrange $dominoes 1 end]
    lassign $first a b
    return [expr {[solve $rest $a $b] || [solve $rest $b $a]}]
}

proc solve {dominoes head tail} {
    if {[llength $dominoes] == 0} {
        return [expr {$head == $tail}]
    }
    for {set i 0} {$i < [llength $dominoes]} {incr i} {
        lassign [lindex $dominoes $i] a b
        set rest [lreplace $dominoes $i $i]
        if {$a == $tail && [solve $rest $head $b]} { return true }
        if {$b == $tail && [solve $rest $head $a]} { return true }
    }
    return false
}
