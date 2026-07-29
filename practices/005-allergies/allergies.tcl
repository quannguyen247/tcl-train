set ALLERGENS {
    eggs 1
    peanuts 2
    shellfish 4
    strawberries 8
    tomatoes 16
    chocolate 32
    pollen 64
    cats 128
}

proc allergicTo {allergen score} {
    global ALLERGENS
    if {![dict exists $ALLERGENS $allergen]} {
        return false
    }
    set val [dict get $ALLERGENS $allergen]
    return [expr {($score & $val) != 0}]
}

proc listAllergies {score} {
    global ALLERGENS
    set result {}
    dict for {item val} $ALLERGENS {
        if {($score & $val) != 0} {
            lappend result $item
        }
    }
    return $result
}
