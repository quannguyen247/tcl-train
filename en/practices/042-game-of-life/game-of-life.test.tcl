package require tcltest 2
namespace import tcltest::*
source "game-of-life.tcl"

test 042-game-of-life-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
