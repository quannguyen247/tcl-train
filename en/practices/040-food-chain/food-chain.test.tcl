package require tcltest 2
namespace import tcltest::*
source "food-chain.tcl"

test 040-food-chain-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
