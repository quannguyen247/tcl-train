oo::class create RestAPI {
    variable users

    constructor {data} {
        set users {}

        foreach user [dict get $data users] {
            set user [my FormatUser $user]
            dict set users [dict get $user name] $user
        }
    }

    method SortDict {data} {
        set result {}
        foreach name [lsort -dictionary [dict keys $data]] {
            dict set result $name [dict get $data $name]
        }
        return $result
    }

    method FormatUser {user} {
        set owes [my SortDict [dict get $user owes]]
        set owedBy [my SortDict [dict get $user owed_by]]
        set balance 0

        dict for {name amount} $owedBy {
            set balance [expr {$balance + $amount}]
        }
        dict for {name amount} $owes {
            set balance [expr {$balance - $amount}]
        }

        return [dict create \
            name [dict get $user name] \
            owes $owes \
            owed_by $owedBy \
            balance $balance]
    }

    method get {path {payload {}}} {
        if {$path ne "/users"} {
            error "Unknown path"
        }

        if {[dict exists $payload users]} {
            set names [dict get $payload users]
        } else {
            set names [dict keys $users]
        }

        set result {}
        foreach name [lsort -dictionary $names] {
            lappend result [dict get $users $name]
        }

        return [dict create users $result]
    }

    method post {path payload} {
        if {$path eq "/add"} {
            set name [dict get $payload user]
            set user [dict create \
                name $name owes {} owed_by {} balance 0]

            dict set users $name $user
            return $user
        }

        if {$path ne "/iou"} {
            error "Unknown path"
        }

        set lender [dict get $payload lender]
        set borrower [dict get $payload borrower]
        set amount [dict get $payload amount]

        set lenderUser [dict get $users $lender]
        set borrowerUser [dict get $users $borrower]

        set forward 0
        set reverse 0

        if {[dict exists $borrowerUser owes $lender]} {
            set forward [dict get $borrowerUser owes $lender]
        }
        if {[dict exists $lenderUser owes $borrower]} {
            set reverse [dict get $lenderUser owes $borrower]
        }

        set debt [expr {$forward + $amount - $reverse}]

        dict unset borrowerUser owes $lender
        dict unset lenderUser owed_by $borrower
        dict unset lenderUser owes $borrower
        dict unset borrowerUser owed_by $lender

        if {$debt > 0} {
            dict set borrowerUser owes $lender $debt
            dict set lenderUser owed_by $borrower $debt
        } elseif {$debt < 0} {
            set debt [expr {-$debt}]
            dict set lenderUser owes $borrower $debt
            dict set borrowerUser owed_by $lender $debt
        }

        dict set users $lender [my FormatUser $lenderUser]
        dict set users $borrower [my FormatUser $borrowerUser]

        return [my get /users \
            [dict create users [list $lender $borrower]]]
    }
}
