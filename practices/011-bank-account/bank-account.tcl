oo::class create BankAccount {
    variable is_open
    variable acc_balance

    constructor {} {
        set is_open 0
        set acc_balance 0
    }

    method open {} {
        if {$is_open} {
            error "account already open"
        }
        set is_open 1
        set acc_balance 0
    }

    method close {} {
        if {!$is_open} {
            error "account not open"
        }
        set is_open 0
    }

    method balance {} {
        if {!$is_open} {
            error "account not open"
        }
        return $acc_balance
    }

    method deposit {amount} {
        if {!$is_open} {
            error "account not open"
        }
        if {$amount <= 0} {
            error "amount must be greater than 0"
        }
        set acc_balance [expr {$acc_balance + $amount}]
    }

    method withdraw {amount} {
        if {!$is_open} {
            error "account not open"
        }
        if {$amount <= 0} {
            error "amount must be greater than 0"
        }
        if {$amount > $acc_balance} {
            error "amount must be less than balance"
        }
        set acc_balance [expr {$acc_balance - $amount}]
    }
}
