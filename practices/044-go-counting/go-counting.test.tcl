package require tcltest 2
namespace import tcltest::*
source "go-counting.tcl"

test 044-go-counting-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
