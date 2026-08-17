oo::class create BankAccount {
    variable isOpen bal

    constructor {} {
        set isOpen false
        set bal 0
    }

    method open {} {
        if {$isOpen} { return -code error "account already open" }
        set isOpen true
        set bal 0
    }

    method close {} {
        if {!$isOpen} { return -code error "account not open" }
        set isOpen false
    }

    method balance {} {
        if {!$isOpen} { return -code error "account not open" }
        return $bal
    }

    method deposit {amount} {
        if {!$isOpen} { return -code error "account not open" }
        if {$amount <= 0} { return -code error "amount must be greater than 0" }
        incr bal $amount
    }

    method withdraw {amount} {
        if {!$isOpen} { return -code error "account not open" }
        if {$amount <= 0} { return -code error "amount must be greater than 0" }
        if {$amount > $bal} { return -code error "amount must be less than balance" }
        incr bal -$amount
    }
}
