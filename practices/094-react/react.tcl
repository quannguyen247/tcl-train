oo::class create InputCell {
    variable value

    constructor {val} {
        set value $val
    }

    method setValue {aValue} {
        set value $aValue
    }

    method value {} {
        return $value
    }
}

oo::class create ComputeCell {
    variable dependentCells computeFunction

    constructor {cells func} {

        set dependentCells $cells
        set computeFunction $func
    }

    method value {} {
        apply $computeFunction [lmap cell $dependentCells {$cell value}]
    }

    method addCallback {func} {
        Callback new $func [self]
    }

    method removeCallback {callback} {
        $callback disable
    }
}

oo::class create Callback {
    variable callbackFunc targetCell previousValue lastReportedValue isActive

    constructor {args} {
        lassign $args func cell
        set callbackFunc $func
        set targetCell $cell

        set previousValue [apply $callbackFunc $targetCell]
        set lastReportedValue {}

        set isActive 1
    }

    method value {} {
        if {!$isActive} {
            return $lastReportedValue
        }

        set currentValue [apply $callbackFunc $targetCell]

        if {$currentValue ne $previousValue} {
            set previousValue $currentValue
            set lastReportedValue $currentValue
            return $currentValue
        }
    }

    method disable {} {
        set isActive 0
    }
}
