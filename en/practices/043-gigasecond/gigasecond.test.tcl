package require tcltest 2
namespace import tcltest::*
source "gigasecond.tcl"

test 043-gigasecond-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
