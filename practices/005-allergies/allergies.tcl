namespace eval Allergies {
    namespace export allergicTo listAllergies

    variable allergen_dict {
        eggs 1 peanuts 2 shellfish 4 strawberries 8
        tomatoes 16 chocolate 32 pollen 64 cats 128
    }

    proc allergicTo {allergen score} {
        variable allergen_dict
        if {![dict exists $allergen_dict $allergen]} {
            return false
        }
        set val [dict get $allergen_dict $allergen]
        return [expr {($score & $val) != 0}]
    }

    proc listAllergies {score} {
        variable allergen_dict
        set result {}
        dict for {item val} $allergen_dict {
            if {($score & $val) != 0} {
                lappend result $item
            }
        }
        return $result
    }
}

namespace import Allergies::*
