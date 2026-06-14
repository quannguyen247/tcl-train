package require tcltest 2
namespace import tcltest::*
source "error-handling.tcl"

test 036-error-handling-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
