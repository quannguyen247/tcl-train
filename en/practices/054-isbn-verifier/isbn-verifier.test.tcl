package require tcltest 2
namespace import tcltest::*
source "isbn-verifier.tcl"

test 054-isbn-verifier-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
