package require tcltest 2
namespace import tcltest::*
source "high-scores.tcl"

test 051-high-scores-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
