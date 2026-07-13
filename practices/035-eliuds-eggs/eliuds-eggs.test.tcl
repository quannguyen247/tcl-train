package require tcltest 2
namespace import tcltest::*
source "eliuds-eggs.tcl"

test 035-eliuds-eggs-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
