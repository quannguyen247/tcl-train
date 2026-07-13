package require tcltest 2
namespace import tcltest::*
source "hello-world.tcl"

test 050-hello-world-1 "Dummy test to pass" -body {
    expr {1}
} -returnCodes 0 -result 1

cleanupTests
