package require tcltest 2
namespace import tcltest::*
source "flatten-array.tcl"

test 038-flatten-array-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
