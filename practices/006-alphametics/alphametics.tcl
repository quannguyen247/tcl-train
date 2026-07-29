proc solve {puzzle} {
    set words [regexp -all -inline {[A-Z]+} $puzzle]
    set result [lindex $words end]
    set addends [lrange $words 0 end-1]

    if {[llength [lsort -unique [regexp -all -inline {[A-Z]} $puzzle]]] > 10} {
        return {}
    }

    set leading {}
    set width 0
    foreach word $words {
        if {[string length $word] > 1} {
            dict set leading [string index $word 0] 1
        }
        set width [expr {max($width, [string length $word])}]
    }

    set columns {}
    for {set pos 0} {$pos < $width} {incr pos} {
        set terms {}
        foreach word $addends {
            if {$pos < [string length $word]} {
                dict incr terms [string index $word end-$pos]
            }
        }
        set target [expr {$pos < [string length $result]
            ? [string index $result end-$pos] : ""}]
        lappend columns [list $terms $target]
    }

    return [::alphametics::column $columns 0 0 {} {} $leading]
}

namespace eval ::alphametics {
    proc column {columns pos carry mapping used leading} {
        if {$pos == [llength $columns]} {
            return [expr {$carry == 0 ? $mapping : {}}]
        }

        lassign [lindex $columns $pos] terms target
        return [assign $columns $pos $carry $terms [dict keys $terms] 0 \
            $carry $target $mapping $used $leading]
    }

    proc assign {columns col carry terms letters index sum target mapping used leading} {
        if {$index == [llength $letters]} {
            set digit [expr {$sum % 10}]
            set nextCarry [expr {$sum / 10}]

            if {$target eq ""} {
                if {$digit != 0} { return {} }
                return [column $columns [expr {$col + 1}] $nextCarry \
                    $mapping $used $leading]
            }

            if {[dict exists $mapping $target]} {
                if {[dict get $mapping $target] != $digit} { return {} }
                return [column $columns [expr {$col + 1}] $nextCarry \
                    $mapping $used $leading]
            }

            if {[dict exists $used $digit]
                || ($digit == 0 && [dict exists $leading $target])} {
                return {}
            }

            dict set mapping $target $digit
            dict set used $digit 1
            return [column $columns [expr {$col + 1}] $nextCarry \
                $mapping $used $leading]
        }

        set letter [lindex $letters $index]
        set count [dict get $terms $letter]

        if {[dict exists $mapping $letter]} {
            return [assign $columns $col $carry $terms $letters \
                [expr {$index + 1}] [expr {$sum + $count * [dict get $mapping $letter]}] \
                $target $mapping $used $leading]
        }

        for {set digit 0} {$digit <= 9} {incr digit} {
            if {[dict exists $used $digit]
                || ($digit == 0 && [dict exists $leading $letter])} {
                continue
            }

            set nextMap $mapping
            set nextUsed $used
            dict set nextMap $letter $digit
            dict set nextUsed $digit 1

            set answer [assign $columns $col $carry $terms $letters \
                [expr {$index + 1}] [expr {$sum + $count * $digit}] \
                $target $nextMap $nextUsed $leading]
            if {$answer ne {}} { return $answer }
        }

        return {}
    }
}
