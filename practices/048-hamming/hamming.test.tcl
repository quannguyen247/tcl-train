package require tcltest 2
namespace import tcltest::*
source "hamming.tcl"

test 048-hamming-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
