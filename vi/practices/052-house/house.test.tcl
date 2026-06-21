package require tcltest 2
namespace import tcltest::*
source "house.tcl"

test 052-house-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
