# ==============================================================================
# EXERCISM TCL PRACTICE: BANK-ACCOUNT
# ==============================================================================
# # Instructions
#
# Your task is to implement bank accounts supporting opening/closing, withdrawals, and deposits of money.
#
# As bank accounts can be accessed in many different ways (internet, mobile phones, automatic charges), your bank software must allow accounts to be safely accessed from multiple threads/processes (terminology depends on your programming language) in parallel.
# For example, there may be many deposits and withdrawals occurring in parallel; you need to ensure there are no [race conditions][wikipedia] between when you read the account balance and set the new balance.
#
# It should be possible to close an account; operations against a closed account must fail.
#
# [wikipedia]: https://en.wikipedia.org/wiki/Race_condition#In_software

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

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
