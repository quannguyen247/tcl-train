# ==============================================================================
# EXERCISM TCL PRACTICE: TWO-BUCKET
# ==============================================================================
# # Instructions
#
# Given two buckets of different size and which bucket to fill first, determine how many actions are required to measure an exact number of liters by strategically transferring fluid between the buckets.
#
# There are some rules that your solution must follow:
#
# - You can only do one action at a time.
# - There are only 3 possible actions:
#   1. Pouring one bucket into the other bucket until either:
#      a) the first bucket is empty
#      b) the second bucket is full
#   2. Emptying a bucket and doing nothing to the other.
#   3. Filling a bucket and doing nothing to the other.
# - After an action, you may not arrive at a state where the initial starting bucket is empty and the other bucket is full.
#
# Your program will take as input:
#
# - the size of bucket one
# - the size of bucket two
# - the desired number of liters to reach
# - which bucket to fill first, either bucket one or bucket two
#
# Your program should determine:
#
# - the total number of actions it should take to reach the desired number of liters, including the first fill of the starting bucket
# - which bucket should end up with the desired number of liters - either bucket one or bucket two
# - how many liters are left in the other bucket
#
# Note: any time a change is made to either or both buckets counts as one (1) action.
#
# Example:
# Bucket one can hold up to 7 liters, and bucket two can hold up to 11 liters.
# Let's say at a given step, bucket one is holding 7 liters and bucket two is holding 8 liters (7,8).
# If you empty bucket one and make no change to bucket two, leaving you with 0 liters and 8 liters respectively (0,8), that counts as one action.
# Instead, if you had poured from bucket one into bucket two until bucket two was full, resulting in 4 liters in bucket one and 11 liters in bucket two (4,11), that would also only count as one action.
#
# Another Example:
# Bucket one can hold 3 liters, and bucket two can hold up to 5 liters.
# You are told you must start with bucket one.
# So your first action is to fill bucket one.
# You choose to empty bucket one for your second action.
# For your third action, you may not fill bucket two, because this violates the third rule -- you may not end up in a state after any action where the starting bucket is empty and the other bucket is full.
#
# Written with <3 at [Fullstack Academy][fullstack] by Lindsay Levine.
#
# [fullstack]: https://www.fullstackacademy.com/

# ==============================================================================
# YOUR SOLUTION CODE BELOW
# ==============================================================================

proc twoBucket {input} {
    dict with input {}

    if {$goal > $bucketOne && $goal > $bucketTwo} {
        error "impossible"
    }

    set capacities [list $bucketOne $bucketTwo]
    set start [expr {$startBucket eq "one" ? 0 : 1}]
    set other [expr {1 - $start}]
    set amounts {0 0}
    lset amounts $start [lindex $capacities $start]
    set moves 1
    set seen {}

    while {true} {
        foreach bucket {0 1} {
            if {[lindex $amounts $bucket] == $goal} {
                return [dict create \
                    moves $moves \
                    goalBucket [lindex {one two} $bucket] \
                    otherBucket [lindex $amounts [expr {1 - $bucket}]]]
            }
        }

        # Goal là dung tích bucket còn lại: đổ đầy nó luôn
        if {[lindex $amounts $other] == 0
            && [lindex $capacities $other] == $goal} {
            lset amounts $other $goal
            incr moves
            continue
        }

        # Lặp lại trạng thái thì không thể đo được goal
        if {[dict exists $seen $amounts]} {
            error "impossible"
        }
        dict set seen $amounts 1

        # Luôn ưu tiên bucket được chọn lúc đầu
        if {[lindex $amounts $start] == 0} {
            lset amounts $start [lindex $capacities $start]
        } elseif {[lindex $amounts $other] == [lindex $capacities $other]} {
            lset amounts $other 0
        } else {
            set source [lindex $amounts $start]
            set space [expr {[lindex $capacities $other] - [lindex $amounts $other]}]
            set pour [expr {min($source, $space)}]
            lset amounts $start [expr {$source - $pour}]
            lset amounts $other [expr {[lindex $amounts $other] + $pour}]
        }

        incr moves
    }
}

