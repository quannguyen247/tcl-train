# ==============================================================================
# EXERCISM TCL PRACTICE: REST-API
# ==============================================================================
# # Instructions
#
# Implement a RESTful API for tracking IOUs.
#
# Four roommates have a habit of borrowing money from each other frequently, and have trouble remembering who owes whom, and how much.
#
# Your task is to implement a simple [RESTful API][restful-wikipedia] that receives [IOU][iou]s as POST requests, and can deliver specified summary information via GET requests.
#
# ## API Specification
#
# ### User object
#
# ```json
# {
#   "name": "Adam",
#   "owes": {
#     "Bob": 12.0,
#     "Chuck": 4.0,
#     "Dan": 9.5
#   },
#   "owed_by": {
#     "Bob": 6.5,
#     "Dan": 2.75
#   },
#   "balance": "<(total owed by other users) - (total owed to other users)>"
# }
# ```
#
# ### Methods
#
# | Description              | HTTP Method | URL    | Payload Format                                                            | Response w/o Payload                   | Response w/ Payload                                                             |
# | ------------------------ | ----------- | ------ | ------------------------------------------------------------------------- | -------------------------------------- | ------------------------------------------------------------------------------- |
# | List of user information | GET         | /users | `{"users":["Adam","Bob"]}`                                                | `{"users":<List of all User objects>}` | `{"users":<List of User objects for <users> (sorted by name)}`                  |
# | Create user              | POST        | /add   | `{"user":<name of new user (unique)>}`                                    | N/A                                    | `<User object for new user>`                                                    |
# | Create IOU               | POST        | /iou   | `{"lender":<name of lender>,"borrower":<name of borrower>,"amount":5.25}` | N/A                                    | `{"users":<updated User objects for <lender> and <borrower> (sorted by name)>}` |
#
# ## Other Resources
#
# - [REST API Tutorial][restfulapi]
# - Example RESTful APIs
#   - [GitHub][github-rest]
#   - [Reddit][reddit-rest]
#
# [restful-wikipedia]: https://en.wikipedia.org/wiki/Representational_state_transfer
# [iou]: https://en.wikipedia.org/wiki/IOU
# [github-rest]: https://docs.github.com/en/rest
# [reddit-rest]: https://web.archive.org/web/20231202231149/https://www.reddit.com/dev/api/
# [restfulapi]: https://restfulapi.net/

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

oo::class create RestAPI {
    variable users

    constructor {data} {
        set users {}

        # Lưu user theo tên để tìm nhanh
        foreach user [dict get $data users] {
            set user [my FormatUser $user]
            dict set users [dict get $user name] $user
        }
    }

    # Sắp xếp dictionary theo tên
    method SortDict {data} {
        set result {}
        foreach name [lsort -dictionary [dict keys $data]] {
            dict set result $name [dict get $data $name]
        }
        return $result
    }

    # Sắp xếp các khoản nợ và tính lại balance
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

    # Lấy tất cả hoặc một số user
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
            # Tạo user chưa có khoản nợ
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

        # Tính khoản nợ ròng giữa hai người
        set forward 0
        set reverse 0
        if {[dict exists $borrowerUser owes $lender]} {
            set forward [dict get $borrowerUser owes $lender]
        }
        if {[dict exists $lenderUser owes $borrower]} {
            set reverse [dict get $lenderUser owes $borrower]
        }
        set debt [expr {$forward + $amount - $reverse}]

        # Xóa quan hệ cũ trước khi lưu khoản nợ mới
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
        return [my get /users [dict create users [list $lender $borrower]]]
    }
}

