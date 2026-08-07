package require tcltest 2
namespace import tcltest::*
source "intergalactic-transmission.tcl"

test 053-intergalactic-transmission-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
